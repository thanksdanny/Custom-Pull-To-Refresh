//
//  TableViewController.m
//  CustomPullToRefresh
//
//  Created by Danny Ho on 3/30/16.
//  Copyright © 2016 thanksdanny. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *newtableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl_1;
@property (nonatomic, strong) UIView *customView;
@property (nonatomic, strong) NSMutableArray *labelArray;

@end

@implementation TableViewController

- (UIRefreshControl *)refreshControl_1 {
    if (!_refreshControl_1) {
        _refreshControl_1 = [[UIRefreshControl alloc] init];
    }
    return _refreshControl_1;
}

- (NSMutableArray *)labelArray {
    if (_labelArray) {
        _labelArray = [[NSMutableArray alloc] init];
    }
    return _labelArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // tableView
    self.newtableView.rowHeight = UITableViewAutomaticDimension;
    self.newtableView.estimatedRowHeight = 60.0;
    self.newtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.newtableView.delegate = self;
    self.newtableView.dataSource = self;
    
    // refresh
    self.refreshControl_1.backgroundColor = [UIColor clearColor];
    self.refreshControl_1.tintColor = [UIColor clearColor];
    [self.newtableView addSubview:self.refreshControl_1];
    
    [self loadCustomRefreshContents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)data {
    return @[@"😂", @"🤗", @"😳", @"😌", @"😊"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [[self data] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [self data][indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:50];
    
    return cell;
}

#pragma mark - refresh
- (void)loadCustomRefreshContents {
    NSArray *refreshContents = [[NSBundle mainBundle] loadNibNamed:@"RefreshContents" owner:self options:nil];
    self.customView = refreshContents[0];
    self.customView.frame = self.refreshControl_1.bounds;
    for (int i = 0; i < self.customView.subviews.count; i++) {
        [self.labelArray addObject:[self.customView viewWithTag:i + 1]];
    }
    [self.refreshControl_1 addSubview:self.customView];
}

//- (void)animateRefreshStep1 {
//    BOOL isAnimating = YES;
//    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
//        nil;
//    } completion:^(BOOL finished) {
//        nil;
//    }];
//}
//
//- (void)animateRefreshStep2 {
//    
//}
@end

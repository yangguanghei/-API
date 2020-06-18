//
//  ViewController.m
//  私有的API
//
//  Created by 梁森 on 2020/6/18.
//  Copyright © 2020 梁森. All rights reserved.
//

#import "ViewController.h"

#import <MobileCoreServices/MobileCoreServices.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    Class LSApplicationWorkspace_Class = NSClassFromString(@"LSApplicationWorkspace");
    NSObject *workspace = [LSApplicationWorkspace_Class performSelector:NSSelectorFromString(@"defaultWorkspace")];
    NSArray *appList = [workspace performSelector:NSSelectorFromString(@"allApplications")];
    for (id app in appList) {
        NSString * Id = [app performSelector:NSSelectorFromString(@"applicationIdentifier")];
        if ([Id isEqualToString:@"com.ls.ls.---API"]) {
            NSLog(@"安装了此App ");
        }
//       NSLog(@"%@", [app performSelector:NSSelectorFromString(@"applicationIdentifier")]);
    }
    
    
    NSBundle *container = [NSBundle bundleWithPath:@"/System/Library/PrivateFrameworks/MobileContainerManager.framework"];
    if ([container load]) {
        Class appContainer = NSClassFromString(@"MCMAppContainer");
        id test = [appContainer performSelector:@selector(containerWithIdentifier:error:) withObject:@"com.ls.ls.---API" withObject:nil];
        if (test) {
            NSLog(@"存在该应用");
        }else{
            NSLog(@"该应用不存在...");
        }
    }
}

//base64编码
- (NSString *)encodeString:(NSString *)string
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSString *encodedStr = [data base64EncodedStringWithOptions:0];
    return encodedStr;
}
//base64解码
- (NSString *)decodeString:(NSString *)string
{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:string options:0];
    NSString *decodedStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return decodedStr;
}
//调用私有api
- (void)testPrivateApi
{
    NSString *path = [self decodeString:@"L1N5c3RlbS9MaWJyYXJ5L1ByaXZhdGVGcmFtZXdvcmtzL01vYmlsZUNvbnRhaW5lck1hbmFnZXIuZnJhbWV3b3Jr"];
    NSBundle *container = [NSBundle bundleWithPath:path];
    if ([container load]) {
        Class appContainer = NSClassFromString([self decodeString:@"TUNNQXBwQ29udGFpbmVy"]);
        NSString *sel = [self decodeString:@"Y29udGFpbmVyV2l0aElkZW50aWZpZXI6ZXJyb3I6"];
        id test = [appContainer performSelector:NSSelectorFromString(sel) withObject:@"com.tencent.xin" withObject:nil];
        if (test) {
            NSLog(@"存在该应用");
        }
    }
}

@end

From: lkp@intel.com (kbuild test robot)
Date: Fri, 23 Nov 2018 04:40:43 +0800
Subject: [PATCH] mmc: mediatek: add MT8183 SDIO driver support
In-Reply-To: <1542870318-10731-1-git-send-email-jjian.zhou@mediatek.com>
References: <1542870318-10731-1-git-send-email-jjian.zhou@mediatek.com>
Message-ID: <201811230433.SOYb61N9%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi jjian,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on ulf.hansson-mmc/next]
[also build test ERROR on v4.20-rc3 next-20181122]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jjian-Zhou/mmc-mediatek-add-MT8183-SDIO-driver-support/20181123-025850
base:   git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git next
config: i386-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   drivers/mmc/host/mtk-sd.c: In function 'msdc_drv_probe':
   drivers/mmc/host/mtk-sd.c:2263:12: error: invalid storage class for function 'msdc_drv_remove'
    static int msdc_drv_remove(struct platform_device *pdev)
               ^~~~~~~~~~~~~~~
   drivers/mmc/host/mtk-sd.c:2263:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    static int msdc_drv_remove(struct platform_device *pdev)
    ^~~~~~
   drivers/mmc/host/mtk-sd.c:2292:13: error: invalid storage class for function 'msdc_save_reg'
    static void msdc_save_reg(struct msdc_host *host)
                ^~~~~~~~~~~~~
   drivers/mmc/host/mtk-sd.c:2319:13: error: invalid storage class for function 'msdc_restore_reg'
    static void msdc_restore_reg(struct msdc_host *host)
                ^~~~~~~~~~~~~~~~
   drivers/mmc/host/mtk-sd.c:2346:12: error: invalid storage class for function 'msdc_runtime_suspend'
    static int msdc_runtime_suspend(struct device *dev)
               ^~~~~~~~~~~~~~~~~~~~
   drivers/mmc/host/mtk-sd.c:2356:12: error: invalid storage class for function 'msdc_runtime_resume'
    static int msdc_runtime_resume(struct device *dev)
               ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/device.h:23:0,
                    from include/linux/dma-mapping.h:7,
                    from drivers/mmc/host/mtk-sd.c:18:
   drivers/mmc/host/mtk-sd.c:2370:21: error: initializer element is not constant
     SET_RUNTIME_PM_OPS(msdc_runtime_suspend, msdc_runtime_resume, NULL)
                        ^
   include/linux/pm.h:354:21: note: in definition of macro 'SET_RUNTIME_PM_OPS'
     .runtime_suspend = suspend_fn, \
                        ^~~~~~~~~~
   drivers/mmc/host/mtk-sd.c:2370:21: note: (near initialization for 'msdc_dev_pm_ops.runtime_suspend')
     SET_RUNTIME_PM_OPS(msdc_runtime_suspend, msdc_runtime_resume, NULL)
                        ^
   include/linux/pm.h:354:21: note: in definition of macro 'SET_RUNTIME_PM_OPS'
     .runtime_suspend = suspend_fn, \
                        ^~~~~~~~~~
   drivers/mmc/host/mtk-sd.c:2370:43: error: initializer element is not constant
     SET_RUNTIME_PM_OPS(msdc_runtime_suspend, msdc_runtime_resume, NULL)
                                              ^
   include/linux/pm.h:355:20: note: in definition of macro 'SET_RUNTIME_PM_OPS'
     .runtime_resume = resume_fn, \
                       ^~~~~~~~~
   drivers/mmc/host/mtk-sd.c:2370:43: note: (near initialization for 'msdc_dev_pm_ops.runtime_resume')
     SET_RUNTIME_PM_OPS(msdc_runtime_suspend, msdc_runtime_resume, NULL)
                                              ^
   include/linux/pm.h:355:20: note: in definition of macro 'SET_RUNTIME_PM_OPS'
     .runtime_resume = resume_fn, \
                       ^~~~~~~~~
   drivers/mmc/host/mtk-sd.c:2375:12: error: initializer element is not constant
     .remove = msdc_drv_remove,
               ^~~~~~~~~~~~~~~
   drivers/mmc/host/mtk-sd.c:2375:12: note: (near initialization for 'mt_msdc_driver.remove')
   In file included from include/linux/dma-mapping.h:7:0,
                    from drivers/mmc/host/mtk-sd.c:18:
   drivers/mmc/host/mtk-sd.c:2383:24: error: invalid storage class for function 'mt_msdc_driver_init'
    module_platform_driver(mt_msdc_driver);
                           ^
   include/linux/device.h:1611:19: note: in definition of macro 'module_driver'
    static int __init __driver##_init(void) \
                      ^~~~~~~~
   drivers/mmc/host/mtk-sd.c:2383:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(mt_msdc_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/mmc/host/mtk-sd.c:15:0:
>> include/linux/module.h:130:42: error: invalid storage class for function '__inittest'
     static inline initcall_t __maybe_unused __inittest(void)  \
                                             ^
   include/linux/device.h:1615:1: note: in expansion of macro 'module_init'
    module_init(__driver##_init); \
    ^~~~~~~~~~~
   include/linux/platform_device.h:229:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^~~~~~~~~~~~~
   drivers/mmc/host/mtk-sd.c:2383:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(mt_msdc_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/mmc/host/mtk-sd.c:2383:1: warning: 'alias' attribute ignored [-Wattributes]
   In file included from include/linux/dma-mapping.h:7:0,
                    from drivers/mmc/host/mtk-sd.c:18:
   drivers/mmc/host/mtk-sd.c:2383:24: error: invalid storage class for function 'mt_msdc_driver_exit'
    module_platform_driver(mt_msdc_driver);
                           ^
   include/linux/device.h:1616:20: note: in definition of macro 'module_driver'
    static void __exit __driver##_exit(void) \
                       ^~~~~~~~
   drivers/mmc/host/mtk-sd.c:2383:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(mt_msdc_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/device.h:1616:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    static void __exit __driver##_exit(void) \
    ^
   include/linux/platform_device.h:229:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^~~~~~~~~~~~~
   drivers/mmc/host/mtk-sd.c:2383:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(mt_msdc_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/mmc/host/mtk-sd.c:15:0:
>> include/linux/module.h:136:42: error: invalid storage class for function '__exittest'
     static inline exitcall_t __maybe_unused __exittest(void)  \
                                             ^
   include/linux/device.h:1620:1: note: in expansion of macro 'module_exit'
    module_exit(__driver##_exit);
    ^~~~~~~~~~~
   include/linux/platform_device.h:229:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^~~~~~~~~~~~~
   drivers/mmc/host/mtk-sd.c:2383:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(mt_msdc_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/mmc/host/mtk-sd.c:2383:1: warning: 'alias' attribute ignored [-Wattributes]
   In file included from include/linux/module.h:18:0,
                    from drivers/mmc/host/mtk-sd.c:15:
   include/linux/moduleparam.h:22:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    static const char __UNIQUE_ID(name)[]       \
    ^
   include/linux/module.h:161:32: note: in expansion of macro '__MODULE_INFO'
    #define MODULE_INFO(tag, info) __MODULE_INFO(tag, tag, info)
                                   ^~~~~~~~~~~~~
   include/linux/module.h:199:34: note: in expansion of macro 'MODULE_INFO'
    #define MODULE_LICENSE(_license) MODULE_INFO(license, _license)
                                     ^~~~~~~~~~~
   drivers/mmc/host/mtk-sd.c:2384:1: note: in expansion of macro 'MODULE_LICENSE'
    MODULE_LICENSE("GPL v2");
    ^~~~~~~~~~~~~~
>> drivers/mmc/host/mtk-sd.c:2385:1: error: expected declaration or statement at end of input
    MODULE_DESCRIPTION("MediaTek SD/MMC Card Driver");
    ^~~~~~~~~~~~~~~~~~
   At top level:
   drivers/mmc/host/mtk-sd.c:2094:12: warning: 'msdc_drv_probe' defined but not used [-Wunused-function]
    static int msdc_drv_probe(struct platform_device *pdev)
               ^~~~~~~~~~~~~~

vim +2385 drivers/mmc/host/mtk-sd.c

20848903 Chaotian Jing 2015-06-15  2382  
20848903 Chaotian Jing 2015-06-15 @2383  module_platform_driver(mt_msdc_driver);
20848903 Chaotian Jing 2015-06-15 @2384  MODULE_LICENSE("GPL v2");
20848903 Chaotian Jing 2015-06-15 @2385  MODULE_DESCRIPTION("MediaTek SD/MMC Card Driver");

:::::: The code at line 2385 was first introduced by commit
:::::: 208489032bdd8d4a7de50f3057c175058f271956 mmc: mediatek: Add Mediatek MMC driver

:::::: TO: Chaotian Jing <chaotian.jing@mediatek.com>
:::::: CC: Ulf Hansson <ulf.hansson@linaro.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 66024 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181123/07b8e4d9/attachment-0001.gz>

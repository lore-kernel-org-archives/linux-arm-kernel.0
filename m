From: lkp@intel.com (kbuild test robot)
Date: Fri, 23 Nov 2018 04:35:20 +0800
Subject: [PATCH] mmc: mediatek: add MT8183 SDIO driver support
In-Reply-To: <1542870318-10731-1-git-send-email-jjian.zhou@mediatek.com>
References: <1542870318-10731-1-git-send-email-jjian.zhou@mediatek.com>
Message-ID: <201811230435.FE0QEUrJ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi jjian,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on ulf.hansson-mmc/next]
[also build test ERROR on v4.20-rc3 next-20181122]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jjian-Zhou/mmc-mediatek-add-MT8183-SDIO-driver-support/20181123-025850
base:   git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git next
config: x86_64-randconfig-u0-11230408 (attached as .config)
compiler: gcc-5 (Debian 5.5.0-3) 5.4.1 20171010
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All error/warnings (new ones prefixed by >>):

   drivers/mmc/host/mtk-sd.c: In function 'msdc_drv_probe':
>> drivers/mmc/host/mtk-sd.c:2263:12: error: invalid storage class for function 'msdc_drv_remove'
    static int msdc_drv_remove(struct platform_device *pdev)
               ^
>> drivers/mmc/host/mtk-sd.c:2263:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    static int msdc_drv_remove(struct platform_device *pdev)
    ^
>> drivers/mmc/host/mtk-sd.c:2292:13: error: invalid storage class for function 'msdc_save_reg'
    static void msdc_save_reg(struct msdc_host *host)
                ^
>> drivers/mmc/host/mtk-sd.c:2319:13: error: invalid storage class for function 'msdc_restore_reg'
    static void msdc_restore_reg(struct msdc_host *host)
                ^
>> drivers/mmc/host/mtk-sd.c:2346:12: error: invalid storage class for function 'msdc_runtime_suspend'
    static int msdc_runtime_suspend(struct device *dev)
               ^
>> drivers/mmc/host/mtk-sd.c:2356:12: error: invalid storage class for function 'msdc_runtime_resume'
    static int msdc_runtime_resume(struct device *dev)
               ^
   In file included from include/linux/device.h:23:0,
                    from include/linux/dma-mapping.h:7,
                    from drivers/mmc/host/mtk-sd.c:18:
>> drivers/mmc/host/mtk-sd.c:2370:21: error: initializer element is not constant
     SET_RUNTIME_PM_OPS(msdc_runtime_suspend, msdc_runtime_resume, NULL)
                        ^
   include/linux/pm.h:354:21: note: in definition of macro 'SET_RUNTIME_PM_OPS'
     .runtime_suspend = suspend_fn, \
                        ^
   drivers/mmc/host/mtk-sd.c:2370:21: note: (near initialization for 'msdc_dev_pm_ops.runtime_suspend')
     SET_RUNTIME_PM_OPS(msdc_runtime_suspend, msdc_runtime_resume, NULL)
                        ^
   include/linux/pm.h:354:21: note: in definition of macro 'SET_RUNTIME_PM_OPS'
     .runtime_suspend = suspend_fn, \
                        ^
   drivers/mmc/host/mtk-sd.c:2370:43: error: initializer element is not constant
     SET_RUNTIME_PM_OPS(msdc_runtime_suspend, msdc_runtime_resume, NULL)
                                              ^
   include/linux/pm.h:355:20: note: in definition of macro 'SET_RUNTIME_PM_OPS'
     .runtime_resume = resume_fn, \
                       ^
   drivers/mmc/host/mtk-sd.c:2370:43: note: (near initialization for 'msdc_dev_pm_ops.runtime_resume')
     SET_RUNTIME_PM_OPS(msdc_runtime_suspend, msdc_runtime_resume, NULL)
                                              ^
   include/linux/pm.h:355:20: note: in definition of macro 'SET_RUNTIME_PM_OPS'
     .runtime_resume = resume_fn, \
                       ^
   drivers/mmc/host/mtk-sd.c:2375:12: error: initializer element is not constant
     .remove = msdc_drv_remove,
               ^
   drivers/mmc/host/mtk-sd.c:2375:12: note: (near initialization for 'mt_msdc_driver.remove')
   In file included from include/linux/dma-mapping.h:7:0,
                    from drivers/mmc/host/mtk-sd.c:18:
>> drivers/mmc/host/mtk-sd.c:2383:24: error: invalid storage class for function 'mt_msdc_driver_init'
    module_platform_driver(mt_msdc_driver);
                           ^
   include/linux/device.h:1611:19: note: in definition of macro 'module_driver'
    static int __init __driver##_init(void) \
                      ^
>> drivers/mmc/host/mtk-sd.c:2383:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(mt_msdc_driver);
    ^
   In file included from include/linux/kernel.h:10:0,
                    from include/linux/list.h:9,
                    from include/linux/module.h:9,
                    from drivers/mmc/host/mtk-sd.c:15:
>> include/linux/compiler.h:285:44: error: initializer element is not constant
      __PASTE(__addressable_##sym, __LINE__) = (void *)&sym;
                                               ^
   include/linux/init.h:187:2: note: in expansion of macro '__ADDRESSABLE'
     __ADDRESSABLE(fn)     \
     ^
   include/linux/init.h:198:35: note: in expansion of macro '___define_initcall'
    #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
                                      ^
   include/linux/init.h:227:30: note: in expansion of macro '__define_initcall'
    #define device_initcall(fn)  __define_initcall(fn, 6)
                                 ^
   include/linux/init.h:232:24: note: in expansion of macro 'device_initcall'
    #define __initcall(fn) device_initcall(fn)
                           ^
   include/linux/module.h:87:24: note: in expansion of macro '__initcall'
    #define module_init(x) __initcall(x);
                           ^
   include/linux/device.h:1615:1: note: in expansion of macro 'module_init'
    module_init(__driver##_init); \
    ^
   include/linux/platform_device.h:229:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^
>> drivers/mmc/host/mtk-sd.c:2383:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(mt_msdc_driver);
    ^
   In file included from include/linux/dma-mapping.h:7:0,
                    from drivers/mmc/host/mtk-sd.c:18:
>> drivers/mmc/host/mtk-sd.c:2383:24: error: invalid storage class for function 'mt_msdc_driver_exit'
    module_platform_driver(mt_msdc_driver);
                           ^
   include/linux/device.h:1616:20: note: in definition of macro 'module_driver'
    static void __exit __driver##_exit(void) \
                       ^
>> drivers/mmc/host/mtk-sd.c:2383:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(mt_msdc_driver);
    ^
>> include/linux/device.h:1616:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    static void __exit __driver##_exit(void) \
    ^
   include/linux/platform_device.h:229:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^
>> drivers/mmc/host/mtk-sd.c:2383:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(mt_msdc_driver);
    ^
   In file included from include/linux/printk.h:6:0,
                    from include/linux/kernel.h:14,
                    from include/linux/list.h:9,
                    from include/linux/module.h:9,
                    from drivers/mmc/host/mtk-sd.c:15:
   drivers/mmc/host/mtk-sd.c:2383:24: error: initializer element is not constant
    module_platform_driver(mt_msdc_driver);
                           ^
   include/linux/init.h:235:50: note: in definition of macro '__exitcall'
     static exitcall_t __exitcall_##fn __exit_call = fn
                                                     ^
   include/linux/device.h:1620:1: note: in expansion of macro 'module_exit'
    module_exit(__driver##_exit);
    ^
   include/linux/platform_device.h:229:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^
>> drivers/mmc/host/mtk-sd.c:2383:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(mt_msdc_driver);
    ^
   In file included from include/linux/module.h:18:0,
                    from drivers/mmc/host/mtk-sd.c:15:
>> include/linux/moduleparam.h:28:3: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
      struct __UNIQUE_ID(name) {}
      ^
   include/linux/module.h:161:32: note: in expansion of macro '__MODULE_INFO'
    #define MODULE_INFO(tag, info) __MODULE_INFO(tag, tag, info)
                                   ^
   include/linux/module.h:199:34: note: in expansion of macro 'MODULE_INFO'
    #define MODULE_LICENSE(_license) MODULE_INFO(license, _license)
                                     ^
>> drivers/mmc/host/mtk-sd.c:2384:1: note: in expansion of macro 'MODULE_LICENSE'
    MODULE_LICENSE("GPL v2");
    ^
   In file included from <command-line>:0:0:
>> include/linux/compiler-gcc.h:75:45: error: expected declaration or statement at end of input
    #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
                                                ^
   include/linux/compiler_types.h:53:23: note: in definition of macro '___PASTE'
    #define ___PASTE(a,b) a##b
                          ^
   include/linux/compiler-gcc.h:75:29: note: in expansion of macro '__PASTE'
    #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
                                ^
   include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
    #define __PASTE(a,b) ___PASTE(a,b)
                         ^
   include/linux/compiler-gcc.h:75:37: note: in expansion of macro '__PASTE'
    #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
                                        ^
   include/linux/moduleparam.h:28:10: note: in expansion of macro '__UNIQUE_ID'
      struct __UNIQUE_ID(name) {}
             ^
   include/linux/module.h:161:32: note: in expansion of macro '__MODULE_INFO'
    #define MODULE_INFO(tag, info) __MODULE_INFO(tag, tag, info)
                                   ^
   include/linux/module.h:208:42: note: in expansion of macro 'MODULE_INFO'
    #define MODULE_DESCRIPTION(_description) MODULE_INFO(description, _description)
                                             ^
>> drivers/mmc/host/mtk-sd.c:2385:1: note: in expansion of macro 'MODULE_DESCRIPTION'
    MODULE_DESCRIPTION("MediaTek SD/MMC Card Driver");
    ^
   drivers/mmc/host/mtk-sd.c: At top level:
   drivers/mmc/host/mtk-sd.c:2094:12: warning: 'msdc_drv_probe' defined but not used [-Wunused-function]
    static int msdc_drv_probe(struct platform_device *pdev)
               ^
--
   drivers/mmc//host/mtk-sd.c: In function 'msdc_drv_probe':
   drivers/mmc//host/mtk-sd.c:2263:12: error: invalid storage class for function 'msdc_drv_remove'
    static int msdc_drv_remove(struct platform_device *pdev)
               ^
   drivers/mmc//host/mtk-sd.c:2263:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    static int msdc_drv_remove(struct platform_device *pdev)
    ^
   drivers/mmc//host/mtk-sd.c:2292:13: error: invalid storage class for function 'msdc_save_reg'
    static void msdc_save_reg(struct msdc_host *host)
                ^
   drivers/mmc//host/mtk-sd.c:2319:13: error: invalid storage class for function 'msdc_restore_reg'
    static void msdc_restore_reg(struct msdc_host *host)
                ^
   drivers/mmc//host/mtk-sd.c:2346:12: error: invalid storage class for function 'msdc_runtime_suspend'
    static int msdc_runtime_suspend(struct device *dev)
               ^
   drivers/mmc//host/mtk-sd.c:2356:12: error: invalid storage class for function 'msdc_runtime_resume'
    static int msdc_runtime_resume(struct device *dev)
               ^
   In file included from include/linux/device.h:23:0,
                    from include/linux/dma-mapping.h:7,
                    from drivers/mmc//host/mtk-sd.c:18:
   drivers/mmc//host/mtk-sd.c:2370:21: error: initializer element is not constant
     SET_RUNTIME_PM_OPS(msdc_runtime_suspend, msdc_runtime_resume, NULL)
                        ^
   include/linux/pm.h:354:21: note: in definition of macro 'SET_RUNTIME_PM_OPS'
     .runtime_suspend = suspend_fn, \
                        ^
   drivers/mmc//host/mtk-sd.c:2370:21: note: (near initialization for 'msdc_dev_pm_ops.runtime_suspend')
     SET_RUNTIME_PM_OPS(msdc_runtime_suspend, msdc_runtime_resume, NULL)
                        ^
   include/linux/pm.h:354:21: note: in definition of macro 'SET_RUNTIME_PM_OPS'
     .runtime_suspend = suspend_fn, \
                        ^
   drivers/mmc//host/mtk-sd.c:2370:43: error: initializer element is not constant
     SET_RUNTIME_PM_OPS(msdc_runtime_suspend, msdc_runtime_resume, NULL)
                                              ^
   include/linux/pm.h:355:20: note: in definition of macro 'SET_RUNTIME_PM_OPS'
     .runtime_resume = resume_fn, \
                       ^
   drivers/mmc//host/mtk-sd.c:2370:43: note: (near initialization for 'msdc_dev_pm_ops.runtime_resume')
     SET_RUNTIME_PM_OPS(msdc_runtime_suspend, msdc_runtime_resume, NULL)
                                              ^
   include/linux/pm.h:355:20: note: in definition of macro 'SET_RUNTIME_PM_OPS'
     .runtime_resume = resume_fn, \
                       ^
   drivers/mmc//host/mtk-sd.c:2375:12: error: initializer element is not constant
     .remove = msdc_drv_remove,
               ^
   drivers/mmc//host/mtk-sd.c:2375:12: note: (near initialization for 'mt_msdc_driver.remove')
   In file included from include/linux/dma-mapping.h:7:0,
                    from drivers/mmc//host/mtk-sd.c:18:
   drivers/mmc//host/mtk-sd.c:2383:24: error: invalid storage class for function 'mt_msdc_driver_init'
    module_platform_driver(mt_msdc_driver);
                           ^
   include/linux/device.h:1611:19: note: in definition of macro 'module_driver'
    static int __init __driver##_init(void) \
                      ^
   drivers/mmc//host/mtk-sd.c:2383:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(mt_msdc_driver);
    ^
   In file included from include/linux/kernel.h:10:0,
                    from include/linux/list.h:9,
                    from include/linux/module.h:9,
                    from drivers/mmc//host/mtk-sd.c:15:
>> include/linux/compiler.h:285:44: error: initializer element is not constant
      __PASTE(__addressable_##sym, __LINE__) = (void *)&sym;
                                               ^
   include/linux/init.h:187:2: note: in expansion of macro '__ADDRESSABLE'
     __ADDRESSABLE(fn)     \
     ^
   include/linux/init.h:198:35: note: in expansion of macro '___define_initcall'
    #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
                                      ^
   include/linux/init.h:227:30: note: in expansion of macro '__define_initcall'
    #define device_initcall(fn)  __define_initcall(fn, 6)
                                 ^
   include/linux/init.h:232:24: note: in expansion of macro 'device_initcall'
    #define __initcall(fn) device_initcall(fn)
                           ^
   include/linux/module.h:87:24: note: in expansion of macro '__initcall'
    #define module_init(x) __initcall(x);
                           ^
   include/linux/device.h:1615:1: note: in expansion of macro 'module_init'
    module_init(__driver##_init); \
    ^
   include/linux/platform_device.h:229:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^
   drivers/mmc//host/mtk-sd.c:2383:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(mt_msdc_driver);
    ^
   In file included from include/linux/dma-mapping.h:7:0,
                    from drivers/mmc//host/mtk-sd.c:18:
   drivers/mmc//host/mtk-sd.c:2383:24: error: invalid storage class for function 'mt_msdc_driver_exit'
    module_platform_driver(mt_msdc_driver);
                           ^
   include/linux/device.h:1616:20: note: in definition of macro 'module_driver'
    static void __exit __driver##_exit(void) \
                       ^
   drivers/mmc//host/mtk-sd.c:2383:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(mt_msdc_driver);
    ^
>> include/linux/device.h:1616:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    static void __exit __driver##_exit(void) \
    ^
   include/linux/platform_device.h:229:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^
   drivers/mmc//host/mtk-sd.c:2383:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(mt_msdc_driver);
    ^
   In file included from include/linux/printk.h:6:0,
                    from include/linux/kernel.h:14,
                    from include/linux/list.h:9,
                    from include/linux/module.h:9,
                    from drivers/mmc//host/mtk-sd.c:15:
   drivers/mmc//host/mtk-sd.c:2383:24: error: initializer element is not constant
    module_platform_driver(mt_msdc_driver);
                           ^
   include/linux/init.h:235:50: note: in definition of macro '__exitcall'
     static exitcall_t __exitcall_##fn __exit_call = fn
                                                     ^
   include/linux/device.h:1620:1: note: in expansion of macro 'module_exit'
    module_exit(__driver##_exit);
    ^
   include/linux/platform_device.h:229:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^
   drivers/mmc//host/mtk-sd.c:2383:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(mt_msdc_driver);
    ^
   In file included from include/linux/module.h:18:0,
                    from drivers/mmc//host/mtk-sd.c:15:
>> include/linux/moduleparam.h:28:3: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
      struct __UNIQUE_ID(name) {}
      ^
   include/linux/module.h:161:32: note: in expansion of macro '__MODULE_INFO'
    #define MODULE_INFO(tag, info) __MODULE_INFO(tag, tag, info)
                                   ^
   include/linux/module.h:199:34: note: in expansion of macro 'MODULE_INFO'
    #define MODULE_LICENSE(_license) MODULE_INFO(license, _license)
                                     ^
   drivers/mmc//host/mtk-sd.c:2384:1: note: in expansion of macro 'MODULE_LICENSE'
    MODULE_LICENSE("GPL v2");
    ^
   In file included from <command-line>:0:0:
>> include/linux/compiler-gcc.h:75:45: error: expected declaration or statement at end of input
    #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
                                                ^
   include/linux/compiler_types.h:53:23: note: in definition of macro '___PASTE'
    #define ___PASTE(a,b) a##b
                          ^
   include/linux/compiler-gcc.h:75:29: note: in expansion of macro '__PASTE'
    #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
                                ^
   include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
    #define __PASTE(a,b) ___PASTE(a,b)
                         ^
   include/linux/compiler-gcc.h:75:37: note: in expansion of macro '__PASTE'
    #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
                                        ^
   include/linux/moduleparam.h:28:10: note: in expansion of macro '__UNIQUE_ID'
      struct __UNIQUE_ID(name) {}
             ^
   include/linux/module.h:161:32: note: in expansion of macro '__MODULE_INFO'
    #define MODULE_INFO(tag, info) __MODULE_INFO(tag, tag, info)
                                   ^
   include/linux/module.h:208:42: note: in expansion of macro 'MODULE_INFO'
    #define MODULE_DESCRIPTION(_description) MODULE_INFO(description, _description)
                                             ^
   drivers/mmc//host/mtk-sd.c:2385:1: note: in expansion of macro 'MODULE_DESCRIPTION'
    MODULE_DESCRIPTION("MediaTek SD/MMC Card Driver");
    ^
   drivers/mmc//host/mtk-sd.c: At top level:
   drivers/mmc//host/mtk-sd.c:2094:12: warning: 'msdc_drv_probe' defined but not used [-Wunused-function]
    static int msdc_drv_probe(struct platform_device *pdev)
               ^

vim +/msdc_drv_remove +2263 drivers/mmc/host/mtk-sd.c

20848903 Chaotian Jing 2015-06-15  2262  
20848903 Chaotian Jing 2015-06-15 @2263  static int msdc_drv_remove(struct platform_device *pdev)
20848903 Chaotian Jing 2015-06-15  2264  {
20848903 Chaotian Jing 2015-06-15  2265  	struct mmc_host *mmc;
20848903 Chaotian Jing 2015-06-15  2266  	struct msdc_host *host;
20848903 Chaotian Jing 2015-06-15  2267  
20848903 Chaotian Jing 2015-06-15  2268  	mmc = platform_get_drvdata(pdev);
20848903 Chaotian Jing 2015-06-15  2269  	host = mmc_priv(mmc);
20848903 Chaotian Jing 2015-06-15  2270  
4b8a43e9 Chaotian Jing 2015-06-15  2271  	pm_runtime_get_sync(host->dev);
4b8a43e9 Chaotian Jing 2015-06-15  2272  
20848903 Chaotian Jing 2015-06-15  2273  	platform_set_drvdata(pdev, NULL);
20848903 Chaotian Jing 2015-06-15  2274  	mmc_remove_host(host->mmc);
20848903 Chaotian Jing 2015-06-15  2275  	msdc_deinit_hw(host);
20848903 Chaotian Jing 2015-06-15  2276  	msdc_gate_clock(host);
20848903 Chaotian Jing 2015-06-15  2277  
4b8a43e9 Chaotian Jing 2015-06-15  2278  	pm_runtime_disable(host->dev);
4b8a43e9 Chaotian Jing 2015-06-15  2279  	pm_runtime_put_noidle(host->dev);
20848903 Chaotian Jing 2015-06-15  2280  	dma_free_coherent(&pdev->dev,
16f2e0c6 Phong LE      2017-05-24  2281  			2 * sizeof(struct mt_gpdma_desc),
20848903 Chaotian Jing 2015-06-15  2282  			host->dma.gpd, host->dma.gpd_addr);
20848903 Chaotian Jing 2015-06-15  2283  	dma_free_coherent(&pdev->dev, MAX_BD_NUM * sizeof(struct mt_bdma_desc),
20848903 Chaotian Jing 2015-06-15  2284  			host->dma.bd, host->dma.bd_addr);
20848903 Chaotian Jing 2015-06-15  2285  
20848903 Chaotian Jing 2015-06-15  2286  	mmc_free_host(host->mmc);
20848903 Chaotian Jing 2015-06-15  2287  
20848903 Chaotian Jing 2015-06-15  2288  	return 0;
20848903 Chaotian Jing 2015-06-15  2289  }
20848903 Chaotian Jing 2015-06-15  2290  
4b8a43e9 Chaotian Jing 2015-06-15  2291  #ifdef CONFIG_PM
4b8a43e9 Chaotian Jing 2015-06-15 @2292  static void msdc_save_reg(struct msdc_host *host)
4b8a43e9 Chaotian Jing 2015-06-15  2293  {
39add252 Chaotian Jing 2017-10-16  2294  	u32 tune_reg = host->dev_comp->pad_tune_reg;
39add252 Chaotian Jing 2017-10-16  2295  
4b8a43e9 Chaotian Jing 2015-06-15  2296  	host->save_para.msdc_cfg = readl(host->base + MSDC_CFG);
4b8a43e9 Chaotian Jing 2015-06-15  2297  	host->save_para.iocon = readl(host->base + MSDC_IOCON);
4b8a43e9 Chaotian Jing 2015-06-15  2298  	host->save_para.sdc_cfg = readl(host->base + SDC_CFG);
4b8a43e9 Chaotian Jing 2015-06-15  2299  	host->save_para.patch_bit0 = readl(host->base + MSDC_PATCH_BIT);
4b8a43e9 Chaotian Jing 2015-06-15  2300  	host->save_para.patch_bit1 = readl(host->base + MSDC_PATCH_BIT1);
2fea5819 Chaotian Jing 2017-10-16  2301  	host->save_para.patch_bit2 = readl(host->base + MSDC_PATCH_BIT2);
6397b7f5 Chaotian Jing 2015-10-27  2302  	host->save_para.pad_ds_tune = readl(host->base + PAD_DS_TUNE);
1ede5cb8 yong mao      2017-03-15  2303  	host->save_para.pad_cmd_tune = readl(host->base + PAD_CMD_TUNE);
6397b7f5 Chaotian Jing 2015-10-27  2304  	host->save_para.emmc50_cfg0 = readl(host->base + EMMC50_CFG0);
c8609b22 Chaotian Jing 2017-10-16  2305  	host->save_para.emmc50_cfg3 = readl(host->base + EMMC50_CFG3);
d9dcbfc8 Chaotian Jing 2017-10-16  2306  	host->save_para.sdc_fifo_cfg = readl(host->base + SDC_FIFO_CFG);
a2e6d1f6 Chaotian Jing 2018-10-13  2307  	if (host->top_base) {
a2e6d1f6 Chaotian Jing 2018-10-13  2308  		host->save_para.emmc_top_control =
a2e6d1f6 Chaotian Jing 2018-10-13  2309  			readl(host->top_base + EMMC_TOP_CONTROL);
a2e6d1f6 Chaotian Jing 2018-10-13  2310  		host->save_para.emmc_top_cmd =
a2e6d1f6 Chaotian Jing 2018-10-13  2311  			readl(host->top_base + EMMC_TOP_CMD);
a2e6d1f6 Chaotian Jing 2018-10-13  2312  		host->save_para.emmc50_pad_ds_tune =
a2e6d1f6 Chaotian Jing 2018-10-13  2313  			readl(host->top_base + EMMC50_PAD_DS_TUNE);
a2e6d1f6 Chaotian Jing 2018-10-13  2314  	} else {
a2e6d1f6 Chaotian Jing 2018-10-13  2315  		host->save_para.pad_tune = readl(host->base + tune_reg);
a2e6d1f6 Chaotian Jing 2018-10-13  2316  	}
4b8a43e9 Chaotian Jing 2015-06-15  2317  }
4b8a43e9 Chaotian Jing 2015-06-15  2318  
4b8a43e9 Chaotian Jing 2015-06-15 @2319  static void msdc_restore_reg(struct msdc_host *host)
4b8a43e9 Chaotian Jing 2015-06-15  2320  {
39add252 Chaotian Jing 2017-10-16  2321  	u32 tune_reg = host->dev_comp->pad_tune_reg;
39add252 Chaotian Jing 2017-10-16  2322  
4b8a43e9 Chaotian Jing 2015-06-15  2323  	writel(host->save_para.msdc_cfg, host->base + MSDC_CFG);
4b8a43e9 Chaotian Jing 2015-06-15  2324  	writel(host->save_para.iocon, host->base + MSDC_IOCON);
4b8a43e9 Chaotian Jing 2015-06-15  2325  	writel(host->save_para.sdc_cfg, host->base + SDC_CFG);
4b8a43e9 Chaotian Jing 2015-06-15  2326  	writel(host->save_para.patch_bit0, host->base + MSDC_PATCH_BIT);
4b8a43e9 Chaotian Jing 2015-06-15  2327  	writel(host->save_para.patch_bit1, host->base + MSDC_PATCH_BIT1);
2fea5819 Chaotian Jing 2017-10-16  2328  	writel(host->save_para.patch_bit2, host->base + MSDC_PATCH_BIT2);
6397b7f5 Chaotian Jing 2015-10-27  2329  	writel(host->save_para.pad_ds_tune, host->base + PAD_DS_TUNE);
1ede5cb8 yong mao      2017-03-15  2330  	writel(host->save_para.pad_cmd_tune, host->base + PAD_CMD_TUNE);
6397b7f5 Chaotian Jing 2015-10-27  2331  	writel(host->save_para.emmc50_cfg0, host->base + EMMC50_CFG0);
c8609b22 Chaotian Jing 2017-10-16  2332  	writel(host->save_para.emmc50_cfg3, host->base + EMMC50_CFG3);
d9dcbfc8 Chaotian Jing 2017-10-16  2333  	writel(host->save_para.sdc_fifo_cfg, host->base + SDC_FIFO_CFG);
a2e6d1f6 Chaotian Jing 2018-10-13  2334  	if (host->top_base) {
a2e6d1f6 Chaotian Jing 2018-10-13  2335  		writel(host->save_para.emmc_top_control,
a2e6d1f6 Chaotian Jing 2018-10-13  2336  		       host->top_base + EMMC_TOP_CONTROL);
a2e6d1f6 Chaotian Jing 2018-10-13  2337  		writel(host->save_para.emmc_top_cmd,
a2e6d1f6 Chaotian Jing 2018-10-13  2338  		       host->top_base + EMMC_TOP_CMD);
a2e6d1f6 Chaotian Jing 2018-10-13  2339  		writel(host->save_para.emmc50_pad_ds_tune,
a2e6d1f6 Chaotian Jing 2018-10-13  2340  		       host->top_base + EMMC50_PAD_DS_TUNE);
a2e6d1f6 Chaotian Jing 2018-10-13  2341  	} else {
a2e6d1f6 Chaotian Jing 2018-10-13  2342  		writel(host->save_para.pad_tune, host->base + tune_reg);
a2e6d1f6 Chaotian Jing 2018-10-13  2343  	}
4b8a43e9 Chaotian Jing 2015-06-15  2344  }
4b8a43e9 Chaotian Jing 2015-06-15  2345  
4b8a43e9 Chaotian Jing 2015-06-15 @2346  static int msdc_runtime_suspend(struct device *dev)
4b8a43e9 Chaotian Jing 2015-06-15  2347  {
4b8a43e9 Chaotian Jing 2015-06-15  2348  	struct mmc_host *mmc = dev_get_drvdata(dev);
4b8a43e9 Chaotian Jing 2015-06-15  2349  	struct msdc_host *host = mmc_priv(mmc);
4b8a43e9 Chaotian Jing 2015-06-15  2350  
4b8a43e9 Chaotian Jing 2015-06-15  2351  	msdc_save_reg(host);
4b8a43e9 Chaotian Jing 2015-06-15  2352  	msdc_gate_clock(host);
4b8a43e9 Chaotian Jing 2015-06-15  2353  	return 0;
4b8a43e9 Chaotian Jing 2015-06-15  2354  }
4b8a43e9 Chaotian Jing 2015-06-15  2355  
4b8a43e9 Chaotian Jing 2015-06-15 @2356  static int msdc_runtime_resume(struct device *dev)
4b8a43e9 Chaotian Jing 2015-06-15  2357  {
4b8a43e9 Chaotian Jing 2015-06-15  2358  	struct mmc_host *mmc = dev_get_drvdata(dev);
4b8a43e9 Chaotian Jing 2015-06-15  2359  	struct msdc_host *host = mmc_priv(mmc);
4b8a43e9 Chaotian Jing 2015-06-15  2360  
4b8a43e9 Chaotian Jing 2015-06-15  2361  	msdc_ungate_clock(host);
4b8a43e9 Chaotian Jing 2015-06-15  2362  	msdc_restore_reg(host);
4b8a43e9 Chaotian Jing 2015-06-15  2363  	return 0;
4b8a43e9 Chaotian Jing 2015-06-15  2364  }
4b8a43e9 Chaotian Jing 2015-06-15  2365  #endif
4b8a43e9 Chaotian Jing 2015-06-15  2366  
4b8a43e9 Chaotian Jing 2015-06-15  2367  static const struct dev_pm_ops msdc_dev_pm_ops = {
4b8a43e9 Chaotian Jing 2015-06-15  2368  	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
4b8a43e9 Chaotian Jing 2015-06-15  2369  				pm_runtime_force_resume)
4b8a43e9 Chaotian Jing 2015-06-15 @2370  	SET_RUNTIME_PM_OPS(msdc_runtime_suspend, msdc_runtime_resume, NULL)
4b8a43e9 Chaotian Jing 2015-06-15  2371  };
4b8a43e9 Chaotian Jing 2015-06-15  2372  
20848903 Chaotian Jing 2015-06-15  2373  static struct platform_driver mt_msdc_driver = {
20848903 Chaotian Jing 2015-06-15  2374  	.probe = msdc_drv_probe,
20848903 Chaotian Jing 2015-06-15 @2375  	.remove = msdc_drv_remove,
20848903 Chaotian Jing 2015-06-15  2376  	.driver = {
20848903 Chaotian Jing 2015-06-15  2377  		.name = "mtk-msdc",
20848903 Chaotian Jing 2015-06-15  2378  		.of_match_table = msdc_of_ids,
4b8a43e9 Chaotian Jing 2015-06-15  2379  		.pm = &msdc_dev_pm_ops,
20848903 Chaotian Jing 2015-06-15  2380  	},
20848903 Chaotian Jing 2015-06-15  2381  };
20848903 Chaotian Jing 2015-06-15  2382  
20848903 Chaotian Jing 2015-06-15 @2383  module_platform_driver(mt_msdc_driver);
20848903 Chaotian Jing 2015-06-15 @2384  MODULE_LICENSE("GPL v2");
20848903 Chaotian Jing 2015-06-15 @2385  MODULE_DESCRIPTION("MediaTek SD/MMC Card Driver");

:::::: The code at line 2263 was first introduced by commit
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
Size: 27111 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181123/47c53626/attachment-0001.gz>

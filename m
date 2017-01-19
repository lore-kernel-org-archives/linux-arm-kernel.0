From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 20 Jan 2017 07:52:18 +0800
Subject: [arm:phy-cleanup 10/10] drivers/net/wireless/ath/ath5k/ahb.c:233:1:
 note: in expansion of macro 'module_platform_driver'
Message-ID: <201701200700.w0DZO2hP%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git phy-cleanup
head:   a8d93f6890893686b4e5f5e8e4ae39c64af2391d
commit: a8d93f6890893686b4e5f5e8e4ae39c64af2391d [10/10] net: dsa: remove unnecessary phy*.h includes
config: mips-ath25_defconfig (attached as .config)
compiler: mips-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout a8d93f6890893686b4e5f5e8e4ae39c64af2391d
        # save the attached .config to linux build tree
        make.cross ARCH=mips 

All warnings (new ones prefixed by >>):

   In file included from include/linux/platform_device.h:14:0,
                    from drivers/net/wireless/ath/ath5k/ahb.c:20:
   include/linux/device.h:1463:1: warning: data definition has no type or storage class
    module_init(__driver##_init); \
    ^
   include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^~~~~~~~~~~~~
>> drivers/net/wireless/ath/ath5k/ahb.c:233:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(ath_ahb_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/device.h:1463:1: error: type defaults to 'int' in declaration of 'module_init' [-Werror=implicit-int]
    module_init(__driver##_init); \
    ^
   include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^~~~~~~~~~~~~
>> drivers/net/wireless/ath/ath5k/ahb.c:233:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(ath_ahb_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/wireless/ath/ath5k/ahb.c:233:1: warning: parameter names (without types) in function declaration
   In file included from include/linux/platform_device.h:14:0,
                    from drivers/net/wireless/ath/ath5k/ahb.c:20:
   include/linux/device.h:1468:1: warning: data definition has no type or storage class
    module_exit(__driver##_exit);
    ^
   include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^~~~~~~~~~~~~
>> drivers/net/wireless/ath/ath5k/ahb.c:233:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(ath_ahb_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/device.h:1468:1: error: type defaults to 'int' in declaration of 'module_exit' [-Werror=implicit-int]
    module_exit(__driver##_exit);
    ^
   include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^~~~~~~~~~~~~
>> drivers/net/wireless/ath/ath5k/ahb.c:233:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(ath_ahb_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/wireless/ath/ath5k/ahb.c:233:1: warning: parameter names (without types) in function declaration
   In file included from include/linux/platform_device.h:14:0,
                    from drivers/net/wireless/ath/ath5k/ahb.c:20:
   drivers/net/wireless/ath/ath5k/ahb.c:233:24: warning: 'ath_ahb_driver_exit' defined but not used [-Wunused-function]
    module_platform_driver(ath_ahb_driver);
                           ^
   include/linux/device.h:1464:20: note: in definition of macro 'module_driver'
    static void __exit __driver##_exit(void) \
                       ^~~~~~~~
>> drivers/net/wireless/ath/ath5k/ahb.c:233:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(ath_ahb_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/ath/ath5k/ahb.c:233:24: warning: 'ath_ahb_driver_init' defined but not used [-Wunused-function]
    module_platform_driver(ath_ahb_driver);
                           ^
   include/linux/device.h:1459:19: note: in definition of macro 'module_driver'
    static int __init __driver##_init(void) \
                      ^~~~~~~~
>> drivers/net/wireless/ath/ath5k/ahb.c:233:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(ath_ahb_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/module_platform_driver +233 drivers/net/wireless/ath/ath5k/ahb.c

0e5d3ab5 Sergey Ryazanov 2014-10-29  217  
0e5d3ab5 Sergey Ryazanov 2014-10-29  218  	ath5k_deinit_ah(ah);
0e5d3ab5 Sergey Ryazanov 2014-10-29  219  	iounmap(ah->iobase);
0e5d3ab5 Sergey Ryazanov 2014-10-29  220  	ieee80211_free_hw(hw);
0e5d3ab5 Sergey Ryazanov 2014-10-29  221  
0e5d3ab5 Sergey Ryazanov 2014-10-29  222  	return 0;
0e5d3ab5 Sergey Ryazanov 2014-10-29  223  }
0e5d3ab5 Sergey Ryazanov 2014-10-29  224  
0e5d3ab5 Sergey Ryazanov 2014-10-29  225  static struct platform_driver ath_ahb_driver = {
0e5d3ab5 Sergey Ryazanov 2014-10-29  226  	.probe      = ath_ahb_probe,
0e5d3ab5 Sergey Ryazanov 2014-10-29  227  	.remove     = ath_ahb_remove,
0e5d3ab5 Sergey Ryazanov 2014-10-29  228  	.driver		= {
0e5d3ab5 Sergey Ryazanov 2014-10-29  229  		.name	= "ar231x-wmac",
0e5d3ab5 Sergey Ryazanov 2014-10-29  230  	},
0e5d3ab5 Sergey Ryazanov 2014-10-29  231  };
0e5d3ab5 Sergey Ryazanov 2014-10-29  232  
0e5d3ab5 Sergey Ryazanov 2014-10-29 @233  module_platform_driver(ath_ahb_driver);

:::::: The code at line 233 was first introduced by commit
:::::: 0e5d3ab532dd6bd43406d91b1dacb391973f831f ath5k: revert AHB bus support removing

:::::: TO: Sergey Ryazanov <ryazanov.s.a@gmail.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 11636 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170120/95324930/attachment-0001.gz>

From: lkp@intel.com (kbuild test robot)
Date: Sat, 30 Dec 2017 14:38:16 +0800
Subject: [PATCH 11/20] nvmem: meson-efuse: Convert to use
 devm_nvmem_register()
In-Reply-To: <20171227225956.14442-12-andrew.smirnov@gmail.com>
References: <20171227225956.14442-12-andrew.smirnov@gmail.com>
Message-ID: <201712301413.ZHQ2tX6r%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrey,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.15-rc5]
[cannot apply to next-20171222]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Andrey-Smirnov/Verbatim-device-names-and-devm_nvmem_-un-register/20171230-114930
config: arm64-allyesconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> drivers/nvmem/meson-efuse.c:72:12: error: 'meson_efuse_remove' undeclared here (not in a function); did you mean 'meson_efuse_probe'?
     .remove = meson_efuse_remove,
               ^~~~~~~~~~~~~~~~~~
               meson_efuse_probe

vim +72 drivers/nvmem/meson-efuse.c

ad855eae Carlo Caione 2016-08-27  69  
ad855eae Carlo Caione 2016-08-27  70  static struct platform_driver meson_efuse_driver = {
ad855eae Carlo Caione 2016-08-27  71  	.probe = meson_efuse_probe,
ad855eae Carlo Caione 2016-08-27 @72  	.remove = meson_efuse_remove,
ad855eae Carlo Caione 2016-08-27  73  	.driver = {
ad855eae Carlo Caione 2016-08-27  74  		.name = "meson-efuse",
ad855eae Carlo Caione 2016-08-27  75  		.of_match_table = meson_efuse_match,
ad855eae Carlo Caione 2016-08-27  76  	},
ad855eae Carlo Caione 2016-08-27  77  };
ad855eae Carlo Caione 2016-08-27  78  

:::::: The code at line 72 was first introduced by commit
:::::: ad855eae6caf0d1dd17bce5bcd8e07759adc9903 nvmem: amlogic: Add Amlogic Meson EFUSE driver

:::::: TO: Carlo Caione <carlo@endlessm.com>
:::::: CC: Kevin Hilman <khilman@baylibre.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 58528 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171230/927dbd78/attachment-0001.gz>

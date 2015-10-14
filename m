From: lkp@intel.com (kbuild test robot)
Date: Thu, 15 Oct 2015 01:47:13 +0800
Subject: [PATCH 3/6] mfd: axp20x: Add support for RSB based AXP223 PMIC
In-Reply-To: <1444840342-9233-4-git-send-email-wens@csie.org>
Message-ID: <201510150145.SeZXblZX%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

[auto build test ERROR on next-20151013 -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Chen-Yu-Tsai/mfd-axp20x-Add-support-for-RSB-based-AXP223/20151015-004334
config: i386-randconfig-s1-201541 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

warning: (MFD_AXP20X) selects MFD_AXP20X_RSB which has unmet direct dependencies (HAS_IOMEM && SUNXI_RSB)
   drivers/built-in.o: In function `axp20x_sunxi_rsb_probe':
>> axp20x-rsb.c:(.text+0xe00d7): undefined reference to `__devm_regmap_init_sunxi_rsb'
   drivers/built-in.o: In function `axp20x_sunxi_rsb_driver_init':
>> axp20x-rsb.c:(.init.text+0x81ce): undefined reference to `sunxi_rsb_driver_register'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 25103 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151015/b327a98a/attachment-0001.obj>

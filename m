From: lkp@intel.com (kbuild test robot)
Date: Thu, 15 Oct 2015 07:00:12 +0800
Subject: [PATCH 3/6] mfd: axp20x: Add support for RSB based AXP223 PMIC
In-Reply-To: <1444840342-9233-4-git-send-email-wens@csie.org>
Message-ID: <201510150602.aCB7sfZA%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

[auto build test ERROR on next-20151013 -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Chen-Yu-Tsai/mfd-axp20x-Add-support-for-RSB-based-AXP223/20151015-004334
config: x86_64-allmodconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `axp20x_i2c_remove':
   axp20x-i2c.c:(.text+0x22810b): undefined reference to `axp20x_device_remove'
   drivers/built-in.o: In function `axp20x_i2c_probe':
   axp20x-i2c.c:(.text+0x22827d): undefined reference to `axp20x_match_device'
   axp20x-i2c.c:(.text+0x2282ff): undefined reference to `__devm_regmap_init_i2c'
   axp20x-i2c.c:(.text+0x22834c): undefined reference to `axp20x_device_probe'
   drivers/built-in.o: In function `axp20x_sunxi_rsb_remove':
>> axp20x-rsb.c:(.text+0x228388): undefined reference to `axp20x_device_remove'
   drivers/built-in.o: In function `axp20x_sunxi_rsb_probe':
>> axp20x-rsb.c:(.text+0x22844d): undefined reference to `axp20x_match_device'
   axp20x-rsb.c:(.text+0x2284cb): undefined reference to `__devm_regmap_init_sunxi_rsb'
>> axp20x-rsb.c:(.text+0x228518): undefined reference to `axp20x_device_probe'
   drivers/built-in.o: In function `axp20x_i2c_driver_init':
   axp20x-i2c.c:(.init.text+0x1a8c9): undefined reference to `i2c_register_driver'
   drivers/built-in.o: In function `axp20x_sunxi_rsb_driver_init':
   axp20x-rsb.c:(.init.text+0x1a8e9): undefined reference to `sunxi_rsb_driver_register'
   drivers/built-in.o: In function `axp20x_i2c_driver_exit':
   axp20x-i2c.c:(.exit.text+0x683): undefined reference to `i2c_del_driver'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 50719 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151015/21cb6bfa/attachment-0001.obj>

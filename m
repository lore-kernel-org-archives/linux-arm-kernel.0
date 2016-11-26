From: lkp@intel.com (kbuild test robot)
Date: Sun, 27 Nov 2016 02:55:27 +0800
Subject: [PATCH 4/5] regulator: Add support for TI TWL6032
In-Reply-To: <20161126181326.14951-5-Nicolae_Rosia@mentor.com>
Message-ID: <201611270236.UFgW5zDA%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolae,

[auto build test ERROR on omap/for-next]
[also build test ERROR on v4.9-rc6]
[cannot apply to next-20161125]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Nicolae-Rosia/mfd-twl-improvements-and-new-regulator-driver/20161127-022201
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git for-next
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   In file included from drivers/regulator/twl6032-regulator.c:11:0:
>> drivers/regulator/twl6032-regulator.c:557:31: error: 'twl6032_regulator_driver_ids' undeclared here (not in a function)
    MODULE_DEVICE_TABLE(platform, twl6032_regulator_driver_ids);
                                  ^
   include/linux/module.h:213:21: note: in definition of macro 'MODULE_DEVICE_TABLE'
    extern const typeof(name) __mod_##type##__##name##_device_table  \
                        ^~~~
>> include/linux/module.h:213:27: error: '__mod_platform__twl6032_regulator_driver_ids_device_table' aliased to undefined symbol 'twl6032_regulator_driver_ids'
    extern const typeof(name) __mod_##type##__##name##_device_table  \
                              ^
>> drivers/regulator/twl6032-regulator.c:557:1: note: in expansion of macro 'MODULE_DEVICE_TABLE'
    MODULE_DEVICE_TABLE(platform, twl6032_regulator_driver_ids);
    ^~~~~~~~~~~~~~~~~~~

vim +/twl6032_regulator_driver_ids +557 drivers/regulator/twl6032-regulator.c

   551	
   552	static const struct of_device_id twl6032_dt_match[] = {
   553		{ .compatible = "ti,twl6032-regulator" },
   554		{ /* last entry */ }
   555	};
   556	
 > 557	MODULE_DEVICE_TABLE(platform, twl6032_regulator_driver_ids);
   558	
   559	static struct platform_driver twl6032_regulator_driver = {
   560		.driver = {

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 56830 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161127/cdcde6ff/attachment-0001.gz>

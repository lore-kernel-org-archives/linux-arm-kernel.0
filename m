From: lkp@intel.com (kbuild test robot)
Date: Tue, 9 Aug 2016 21:11:41 +0800
Subject: Applied "regmap: debugfs: Add support for dumping write only
 device registers" to the regmap tree
In-Reply-To: <E1bX6OV-0003hs-C1@debutante>
Message-ID: <201608092107.96Ssum57%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

[auto build test ERROR on regmap/for-next]
[also build test ERROR on v4.8-rc1 next-20160809]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Mark-Brown/Applied-regmap-debugfs-Add-support-for-dumping-write-only-device-registers-to-the-regmap-tree/20160809-205351
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next
config: x86_64-randconfig-x013-201632 (attached as .config)
compiler: gcc-6 (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/base/regmap/regmap-debugfs.c: In function 'regmap_printable':
>> drivers/base/regmap/regmap-debugfs.c:85:37: error: implicit declaration of function 'regmap_cached' [-Werror=implicit-function-declaration]
     if (!regmap_readable(map, reg) && !regmap_cached(map, reg))
                                        ^~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/regmap_cached +85 drivers/base/regmap/regmap-debugfs.c

    79	
    80	static bool regmap_printable(struct regmap *map, unsigned int reg)
    81	{
    82		if (regmap_precious(map, reg))
    83			return false;
    84	
  > 85		if (!regmap_readable(map, reg) && !regmap_cached(map, reg))
    86			return false;
    87	
    88		return true;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 25238 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160809/8bfc58e1/attachment-0001.obj>

From: lkp@intel.com (kbuild test robot)
Date: Thu, 26 Jan 2017 20:30:49 +0800
Subject: [PATCH] regulator: constify regulator_ops structures
In-Reply-To: <1485427668-2816-1-git-send-email-bhumirks@gmail.com>
Message-ID: <201701262050.ENVMjmGT%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bhumika,

[auto build test ERROR on regulator/for-next]
[cannot apply to v4.10-rc5 next-20170125]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Bhumika-Goyal/regulator-constify-regulator_ops-structures/20170126-185451
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
config: x86_64-randconfig-s2-01261858 (attached as .config)
compiler: gcc-4.4 (Debian 4.4.7-8) 4.4.7
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/regulator/anatop-regulator.c: In function 'anatop_regulator_probe':
>> drivers/regulator/anatop-regulator.c:310: error: assignment of read-only variable 'anatop_rops'
   drivers/regulator/anatop-regulator.c:311: error: assignment of read-only variable 'anatop_rops'
   drivers/regulator/anatop-regulator.c:312: error: assignment of read-only variable 'anatop_rops'

vim +/anatop_rops +310 drivers/regulator/anatop-regulator.c

ca7734ad Andrey Smirnov 2017-01-10  304  		u32 enable_bit;
ca7734ad Andrey Smirnov 2017-01-10  305  
605ebd35 Philipp Zabel  2014-02-11  306  		rdesc->ops = &anatop_rops;
ca7734ad Andrey Smirnov 2017-01-10  307  
ca7734ad Andrey Smirnov 2017-01-10  308  		if (!of_property_read_u32(np, "anatop-enable-bit",
ca7734ad Andrey Smirnov 2017-01-10  309  					  &enable_bit)) {
ca7734ad Andrey Smirnov 2017-01-10 @310  			anatop_rops.enable  = regulator_enable_regmap;
ca7734ad Andrey Smirnov 2017-01-10  311  			anatop_rops.disable = regulator_disable_regmap;
ca7734ad Andrey Smirnov 2017-01-10  312  			anatop_rops.is_enabled = regulator_is_enabled_regmap;
ca7734ad Andrey Smirnov 2017-01-10  313  

:::::: The code at line 310 was first introduced by commit
:::::: ca7734ad77b4ffb83a03c80b8d64d40c7ef49263 regulator: anatop: Add support for "anatop-enable-bit"

:::::: TO: Andrey Smirnov <andrew.smirnov@gmail.com>
:::::: CC: Mark Brown <broonie@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 20822 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170126/69c88127/attachment-0001.gz>

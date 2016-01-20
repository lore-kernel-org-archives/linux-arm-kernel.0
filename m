From: lkp@intel.com (kbuild test robot)
Date: Wed, 20 Jan 2016 20:24:14 +0800
Subject: [alsa-devel] [PATCH v2] ASoC: avoid unused variable warning for
 rt5659_acpi_match
In-Reply-To: <1477393.QDzvbob2TI@wuerfel>
Message-ID: <201601202039.6UklCR3X%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

[auto build test ERROR on asoc/for-next]
[also build test ERROR on next-20160120]
[cannot apply to v4.4]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Arnd-Bergmann/ASoC-avoid-unused-variable-warning-for-rt5659_acpi_match/20160120-190911
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
config: openrisc-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=openrisc 

All error/warnings (new ones prefixed by >>):

>> sound/soc/codecs/rt5659.c:4204:1: error: expected ',' or ';' before 'struct'
   sound/soc/codecs/rt5659.c: In function 'rt5659_i2c_driver_init':
>> sound/soc/codecs/rt5659.c:4216:1: error: 'rt5659_i2c_driver' undeclared (first use in this function)
   sound/soc/codecs/rt5659.c:4216:1: note: each undeclared identifier is reported only once for each function it appears in
   sound/soc/codecs/rt5659.c: In function 'rt5659_i2c_driver_exit':
>> sound/soc/codecs/rt5659.c:4216:1: error: 'rt5659_i2c_driver' undeclared (first use in this function)
   sound/soc/codecs/rt5659.c: At top level:
   sound/soc/codecs/rt5659.c:3974:12: warning: 'rt5659_i2c_probe' defined but not used
   sound/soc/codecs/rt5659.c:4172:12: warning: 'rt5659_i2c_remove' defined but not used
   sound/soc/codecs/rt5659.c: In function 'rt5659_i2c_driver_init':
>> sound/soc/codecs/rt5659.c:4216:1: warning: control reaches end of non-void function

vim +4204 sound/soc/codecs/rt5659.c

51bb9d21 Arnd Bergmann 2016-01-20  4198  	{ "10EC5659", 0, },
d3cb2de2 Bard Liao     2015-11-09  4199  	{ },
d3cb2de2 Bard Liao     2015-11-09  4200  };
d3cb2de2 Bard Liao     2015-11-09  4201  MODULE_DEVICE_TABLE(acpi, rt5659_acpi_match);
51bb9d21 Arnd Bergmann 2016-01-20  4202  #endif
d3cb2de2 Bard Liao     2015-11-09  4203  
d3cb2de2 Bard Liao     2015-11-09 @4204  struct i2c_driver rt5659_i2c_driver = {
d3cb2de2 Bard Liao     2015-11-09  4205  	.driver = {
d3cb2de2 Bard Liao     2015-11-09  4206  		.name = "rt5659",
d3cb2de2 Bard Liao     2015-11-09  4207  		.owner = THIS_MODULE,
51bb9d21 Arnd Bergmann 2016-01-20  4208  		.of_match_table = of_match_ptr(rt5659_of_match),
d3cb2de2 Bard Liao     2015-11-09  4209  		.acpi_match_table = ACPI_PTR(rt5659_acpi_match),
d3cb2de2 Bard Liao     2015-11-09  4210  	},
d3cb2de2 Bard Liao     2015-11-09  4211  	.probe = rt5659_i2c_probe,
d3cb2de2 Bard Liao     2015-11-09  4212  	.remove = rt5659_i2c_remove,
d3cb2de2 Bard Liao     2015-11-09  4213  	.shutdown = rt5659_i2c_shutdown,
d3cb2de2 Bard Liao     2015-11-09  4214  	.id_table = rt5659_i2c_id,
d3cb2de2 Bard Liao     2015-11-09  4215  };
d3cb2de2 Bard Liao     2015-11-09 @4216  module_i2c_driver(rt5659_i2c_driver);
d3cb2de2 Bard Liao     2015-11-09  4217  
d3cb2de2 Bard Liao     2015-11-09  4218  MODULE_DESCRIPTION("ASoC RT5659 driver");
d3cb2de2 Bard Liao     2015-11-09  4219  MODULE_AUTHOR("Bard Liao <bardliao@realtek.com>");

:::::: The code at line 4204 was first introduced by commit
:::::: d3cb2de2479bbbde29391393d68f2e313e1f0504 ASoC: rt5659: add rt5659 codec driver

:::::: TO: Bard Liao <bardliao@realtek.com>
:::::: CC: Mark Brown <broonie@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 35893 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160120/db03b4ae/attachment-0001.obj>

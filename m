From: lkp@intel.com (kbuild test robot)
Date: Wed, 20 Jan 2016 19:34:06 +0800
Subject: [alsa-devel] [PATCH v2] ASoC: avoid unused variable warning for
 rt5659_acpi_match
In-Reply-To: <1477393.QDzvbob2TI@wuerfel>
Message-ID: <201601201952.vmgArdQg%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

[auto build test ERROR on asoc/for-next]
[also build test ERROR on next-20160120]
[cannot apply to v4.4]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Arnd-Bergmann/ASoC-avoid-unused-variable-warning-for-rt5659_acpi_match/20160120-190911
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
config: i386-allmodconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

>> sound/soc/codecs/rt5659.c:4196:1: error: expected ',' or ';' before 'static'
    static struct acpi_device_id rt5659_acpi_match[] = {
    ^
   In file included from sound/soc/codecs/rt5659.c:12:0:
>> sound/soc/codecs/rt5659.c:4201:27: error: 'rt5659_acpi_match' undeclared here (not in a function)
    MODULE_DEVICE_TABLE(acpi, rt5659_acpi_match);
                              ^
   include/linux/module.h:223:21: note: in definition of macro 'MODULE_DEVICE_TABLE'
    extern const typeof(name) __mod_##type##__##name##_device_table  \
                        ^
>> include/linux/module.h:223:27: error: '__mod_acpi__rt5659_acpi_match_device_table' aliased to undefined symbol 'rt5659_acpi_match'
    extern const typeof(name) __mod_##type##__##name##_device_table  \
                              ^
>> sound/soc/codecs/rt5659.c:4201:1: note: in expansion of macro 'MODULE_DEVICE_TABLE'
    MODULE_DEVICE_TABLE(acpi, rt5659_acpi_match);
    ^

vim +4196 sound/soc/codecs/rt5659.c

d3cb2de2 Bard Liao     2015-11-09  4190  	{ },
d3cb2de2 Bard Liao     2015-11-09  4191  };
51bb9d21 Arnd Bergmann 2016-01-20  4192  MODULE_DEVICE_TABLE(of, rt5659_of_match)
51bb9d21 Arnd Bergmann 2016-01-20  4193  #endif
d3cb2de2 Bard Liao     2015-11-09  4194  
51bb9d21 Arnd Bergmann 2016-01-20  4195  #ifdef CONFIG_ACPI
d3cb2de2 Bard Liao     2015-11-09 @4196  static struct acpi_device_id rt5659_acpi_match[] = {
51bb9d21 Arnd Bergmann 2016-01-20  4197  	{ "10EC5658", 0, },
51bb9d21 Arnd Bergmann 2016-01-20  4198  	{ "10EC5659", 0, },
d3cb2de2 Bard Liao     2015-11-09  4199  	{ },
d3cb2de2 Bard Liao     2015-11-09  4200  };
d3cb2de2 Bard Liao     2015-11-09 @4201  MODULE_DEVICE_TABLE(acpi, rt5659_acpi_match);
51bb9d21 Arnd Bergmann 2016-01-20  4202  #endif
d3cb2de2 Bard Liao     2015-11-09  4203  
d3cb2de2 Bard Liao     2015-11-09  4204  struct i2c_driver rt5659_i2c_driver = {

:::::: The code at line 4196 was first introduced by commit
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
Size: 52676 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160120/a7f57720/attachment-0001.obj>

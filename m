From: lkp@intel.com (kbuild test robot)
Date: Sun, 18 Jun 2017 13:38:09 +0800
Subject: [PATCH 2/5] soc: bcm: brcmstb: Add Kconfig entry point for power
 management
In-Reply-To: <20170616213703.21487-3-f.fainelli@gmail.com>
Message-ID: <201706181328.kI8hkcFu%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.12-rc5 next-20170616]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Florian-Fainelli/Broadcom-STB-S2-S3-S5-support-for-ARM-and-MIPS/20170618-091951
config: arm-multi_v7_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

Note: the linux-review/Florian-Fainelli/Broadcom-STB-S2-S3-S5-support-for-ARM-and-MIPS/20170618-091951 HEAD 353cf2b6363828f6d8a3139858d669f7098d9b69 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

>> scripts/Makefile.modbuiltin:25: drivers/soc/bcm/brcmstb/pm/Makefile: No such file or directory
>> make[6]: *** No rule to make target 'drivers/soc/bcm/brcmstb/pm/Makefile'.
   make[6]: Failed to remake makefile 'drivers/soc/bcm/brcmstb/pm/Makefile'.
--
>> scripts/Makefile.build:44: drivers/soc/bcm/brcmstb/pm/Makefile: No such file or directory
>> make[6]: *** No rule to make target 'drivers/soc/bcm/brcmstb/pm/Makefile'.
   make[6]: Failed to remake makefile 'drivers/soc/bcm/brcmstb/pm/Makefile'.

vim +25 scripts/Makefile.modbuiltin

bc081dd6 Michal Marek 2009-12-07   9  
bc081dd6 Michal Marek 2009-12-07  10  -include include/config/auto.conf
bc081dd6 Michal Marek 2009-12-07  11  # tristate.conf sets tristate variables to uppercase 'Y' or 'M'
bc081dd6 Michal Marek 2009-12-07  12  # That way, we get the list of built-in modules in obj-Y
bc081dd6 Michal Marek 2009-12-07  13  -include include/config/tristate.conf
bc081dd6 Michal Marek 2009-12-07  14  
bc081dd6 Michal Marek 2009-12-07  15  include scripts/Kbuild.include
bc081dd6 Michal Marek 2009-12-07  16  
607b30fc Michal Marek 2010-06-10  17  ifneq ($(KBUILD_SRC),)
607b30fc Michal Marek 2010-06-10  18  # Create output directory if not already present
607b30fc Michal Marek 2010-06-10  19  _dummy := $(shell [ -d $(obj) ] || mkdir -p $(obj))
607b30fc Michal Marek 2010-06-10  20  endif
607b30fc Michal Marek 2010-06-10  21  
bc081dd6 Michal Marek 2009-12-07  22  # The filename Kbuild has precedence over Makefile
bc081dd6 Michal Marek 2009-12-07  23  kbuild-dir := $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
bc081dd6 Michal Marek 2009-12-07  24  kbuild-file := $(if $(wildcard $(kbuild-dir)/Kbuild),$(kbuild-dir)/Kbuild,$(kbuild-dir)/Makefile)
bc081dd6 Michal Marek 2009-12-07 @25  include $(kbuild-file)
bc081dd6 Michal Marek 2009-12-07  26  
bc081dd6 Michal Marek 2009-12-07  27  include scripts/Makefile.lib
bc081dd6 Michal Marek 2009-12-07  28  __subdir-Y     := $(patsubst %/,%,$(filter %/, $(obj-Y)))
bc081dd6 Michal Marek 2009-12-07  29  subdir-Y       += $(__subdir-Y)
bc081dd6 Michal Marek 2009-12-07  30  subdir-ym      := $(sort $(subdir-y) $(subdir-Y) $(subdir-m))
bc081dd6 Michal Marek 2009-12-07  31  subdir-ym      := $(addprefix $(obj)/,$(subdir-ym))
bc081dd6 Michal Marek 2009-12-07  32  obj-Y          := $(addprefix $(obj)/,$(obj-Y))
bc081dd6 Michal Marek 2009-12-07  33  

:::::: The code at line 25 was first introduced by commit
:::::: bc081dd6e9f622c73334dc465359168543ccaabf kbuild: generate modules.builtin

:::::: TO: Michal Marek <mmarek@suse.cz>
:::::: CC: Michal Marek <mmarek@suse.cz>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 41296 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170618/9ddd2e5e/attachment-0001.gz>

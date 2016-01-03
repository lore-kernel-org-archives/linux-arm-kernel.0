From: fengguang.wu@intel.com (kbuild test robot)
Date: Sun, 3 Jan 2016 11:11:47 +0800
Subject: [arm-platforms:kvm-arm/wsinc 36/37] scripts/Makefile.modbuiltin:25:
 arch/arm/kvm/hyp/Makefile: No such file or directory
Message-ID: <201601031144.30CfOd0V%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm/wsinc
head:   924b82915891e3fb6510bcec0f0d1dab36a55036
commit: 531340bc7ccd35ca5436d8f75a11ea59e2480ea7 [36/37] ARM: KVM: Add TLB invalidation code
config: arm-axm55xx_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 531340bc7ccd35ca5436d8f75a11ea59e2480ea7
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> scripts/Makefile.modbuiltin:25: arch/arm/kvm/hyp/Makefile: No such file or directory
>> make[3]: *** No rule to make target 'arch/arm/kvm/hyp/Makefile'.
   make[3]: Failed to remake makefile 'arch/arm/kvm/hyp/Makefile'.
--
>> scripts/Makefile.build:44: arch/arm/kvm/hyp/Makefile: No such file or directory
>> make[3]: *** No rule to make target 'arch/arm/kvm/hyp/Makefile'.
   make[3]: Failed to remake makefile 'arch/arm/kvm/hyp/Makefile'.

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
Type: application/octet-stream
Size: 18491 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160103/39925452/attachment-0001.obj>

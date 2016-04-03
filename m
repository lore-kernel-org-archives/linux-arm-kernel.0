From: lkp@intel.com (kbuild test robot)
Date: Sun, 3 Apr 2016 20:16:49 +0800
Subject: [PATCH 2/2] ARM: at91: pm: switch to the PIE infrastructure
In-Reply-To: <1459668234-16033-3-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <201604032013.bYRI4QjO%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

[auto build test ERROR on arm/for-next]
[also build test ERROR on v4.6-rc1 next-20160401]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Alexandre-Belloni/Embedding-Position-Independent-Executables/20160403-152807
base:   http://repo.or.cz/linux-2.6/linux-2.6-arm.git for-next
config: arm-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/mach-at91/pm/pie_stage2.o: In function `atmel_pm_suspend':
>> :(.text+0x10): undefined reference to `__gnu_mcount_nc'
   arch/arm/mach-at91/pm/pie_stage2.o: In function `__pie___div0':
   :(.text+0x3a4): undefined reference to `__gnu_mcount_nc'
   arch/arm/mach-at91/pm/pie_stage2.o: In function `__pie___aeabi_unwind_cpp_pr0':
   :(.text+0x3d4): undefined reference to `__gnu_mcount_nc'
   arch/arm/mach-at91/pm/pie_stage2.o: In function `__pie___aeabi_unwind_cpp_pr1':
   :(.text+0x404): undefined reference to `__gnu_mcount_nc'
   arch/arm/mach-at91/pm/pie_stage2.o: In function `__pie___aeabi_unwind_cpp_pr2':
   :(.text+0x434): undefined reference to `__gnu_mcount_nc'
   arch/arm/mach-at91/pm/pie_stage2.o: In function `_GLOBAL__sub_I_65535_0_atmel_pm_suspend':
>> :(.text.startup+0x14): undefined reference to `__gcov_init'
   arch/arm/mach-at91/pm/pie_stage2.o: In function `__pie__GLOBAL__sub_I_65535_0_(double, int, void, )':
   :(.text.startup+0x30): undefined reference to `__gcov_init'
>> arch/arm/mach-at91/pm/pie_stage2.o:(.data+0x10): undefined reference to `__gcov_merge_add'
>> arch/arm/mach-at91/pm/pie_stage2.o:(.data.rel+0x10): undefined reference to `__gcov_merge_add'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 56972 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160403/168a9af1/attachment-0001.obj>

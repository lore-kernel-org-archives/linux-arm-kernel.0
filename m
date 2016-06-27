From: lkp@intel.com (kbuild test robot)
Date: Tue, 28 Jun 2016 05:02:16 +0800
Subject: [PATCH] arm64:acpi fix the acpi alignment exception when 'mem='
 specified
In-Reply-To: <1466591071-2833-1-git-send-email-dennis.chen@arm.com>
Message-ID: <201606280452.NGLJGTeC%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on v4.7-rc5 next-20160627]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Dennis-Chen/arm64-acpi-fix-the-acpi-alignment-exception-when-mem-specified/20160622-183826
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   arch/arm64/kernel/built-in.o: In function `acpi_boot_table_init':
>> arch/arm64/kernel/vdso/vdso.o:(.init.text+0x3204): undefined reference to `nr_acpi_regs'
   aarch64-linux-gnu-ld: arch/arm64/kernel/built-in.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against external symbol `nr_acpi_regs' can not be used when making a shared object; recompile with -fPIC
>> arch/arm64/kernel/vdso/vdso.o:(.init.text+0x3208): undefined reference to `acpi_regs'
   aarch64-linux-gnu-ld: arch/arm64/kernel/built-in.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against external symbol `acpi_regs' can not be used when making a shared object; recompile with -fPIC
   arch/arm64/kernel/vdso/vdso.o:(.init.text+0x3210): undefined reference to `nr_acpi_regs'
   arch/arm64/kernel/vdso/vdso.o:(.init.text+0x3218): undefined reference to `acpi_regs'
   lib/built-in.o: In function `get_signed_val':
   ubsan.c:(.text.unlikely+0xa20): undefined reference to `__ashlti3'
   ubsan.c:(.text.unlikely+0xa28): undefined reference to `__ashrti3'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 50235 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160628/b7aeb6f9/attachment-0001.obj>

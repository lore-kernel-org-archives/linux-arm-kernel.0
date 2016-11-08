From: lkp@intel.com (kbuild test robot)
Date: Tue, 8 Nov 2016 13:17:02 +0800
Subject: [PATCH V5 2/3] ARM64 LPC: Add missing range exception for
 special ISA
In-Reply-To: <1478576829-112707-3-git-send-email-yuanzhichang@hisilicon.com>
Message-ID: <201611081319.MFXrz420%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi zhichang.yuan,

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on v4.9-rc4 next-20161028]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/zhichang-yuan/ARM64-LPC-legacy-ISA-I-O-support/20161108-114742
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: mips-ath25_defconfig (attached as .config)
compiler: mips-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=mips 

All error/warnings (new ones prefixed by >>):

   In file included from arch/mips/pci/pci.c:18:0:
>> include/linux/pci.h:2113:25: error: expected identifier or '(' before numeric constant
    #define PCIBIOS_MIN_IO  0
                            ^
>> arch/mips/pci/pci.c:34:15: note: in expansion of macro 'PCIBIOS_MIN_IO'
    unsigned long PCIBIOS_MIN_IO;
                  ^~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:6:0,
                    from include/linux/kernel.h:6,
                    from include/asm-generic/bug.h:13,
                    from arch/mips/include/asm/bug.h:41,
                    from include/linux/bug.h:4,
                    from arch/mips/pci/pci.c:11:
>> include/linux/pci.h:2113:25: error: expected identifier or '(' before numeric constant
    #define PCIBIOS_MIN_IO  0
                            ^
   include/linux/export.h:57:21: note: in definition of macro '___EXPORT_SYMBOL'
     extern typeof(sym) sym;     \
                        ^~~
>> arch/mips/pci/pci.c:326:1: note: in expansion of macro 'EXPORT_SYMBOL'
    EXPORT_SYMBOL(PCIBIOS_MIN_IO);
    ^~~~~~~~~~~~~
   arch/mips/pci/pci.c:326:15: note: in expansion of macro 'PCIBIOS_MIN_IO'
    EXPORT_SYMBOL(PCIBIOS_MIN_IO);
                  ^~~~~~~~~~~~~~
>> include/linux/export.h:66:21: error: lvalue required as unary '&' operand
     = { (unsigned long)&sym, __kstrtab_##sym }
                        ^
>> include/linux/export.h:94:25: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^~~~~~~~~~~~~~~~
   include/linux/export.h:98:2: note: in expansion of macro '__EXPORT_SYMBOL'
     __EXPORT_SYMBOL(sym, "")
     ^~~~~~~~~~~~~~~
>> arch/mips/pci/pci.c:326:1: note: in expansion of macro 'EXPORT_SYMBOL'
    EXPORT_SYMBOL(PCIBIOS_MIN_IO);
    ^~~~~~~~~~~~~

vim +2113 include/linux/pci.h

  2107	
  2108	/*
  2109	 * define this macro here to refrain from compilation error for some
  2110	 * platforms. Please keep this macro at the end of this header file.
  2111	 */
  2112	#ifndef PCIBIOS_MIN_IO
> 2113	#define PCIBIOS_MIN_IO		0
  2114	#endif
  2115	
  2116	#endif /* LINUX_PCI_H */

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 11431 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161108/33074cfc/attachment-0001.gz>

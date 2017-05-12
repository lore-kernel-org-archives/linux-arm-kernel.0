From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 13 May 2017 04:57:49 +0800
Subject: [xlnx:master 329/592] arch/x86/include/asm/pgtable_types.h:56:43:
 warning: left shift count >= width of type
Message-ID: <201705130444.Cp4PBTrP%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pantelis,

FYI, the error/warning still remains.

tree:   https://github.com/Xilinx/linux-xlnx master
head:   17360fb326e0a7fa424286973d0afa8da24f7b99
commit: 18e575b575916fa70eb4e9bbab4759c20e40d7bd [329/592] of: changesets: Introduce changeset helper methods
config: x86_64-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout 18e575b575916fa70eb4e9bbab4759c20e40d7bd
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   In file included from arch/x86/include/asm/paravirt_types.h:44:0,
                    from arch/x86/include/asm/ptrace.h:71,
                    from arch/x86/include/asm/math_emu.h:4,
                    from arch/x86/include/asm/processor.h:11,
                    from arch/x86/include/asm/cpufeature.h:4,
                    from arch/x86/include/asm/thread_info.h:52,
                    from include/linux/thread_info.h:58,
                    from arch/x86/include/asm/preempt.h:6,
                    from include/linux/preempt.h:59,
                    from include/linux/spinlock.h:50,
                    from include/linux/seqlock.h:35,
                    from include/linux/time.h:5,
                    from include/uapi/linux/timex.h:56,
                    from include/linux/timex.h:56,
                    from include/linux/clocksource.h:12,
                    from arch/x86/include/asm/vgtod.h:5,
                    from arch/x86//entry/vdso/vdso32/../vclock_gettime.c:15,
                    from arch/x86//entry/vdso/vdso32/vclock_gettime.c:32:
   arch/x86/include/asm/pgtable.h: In function 'pte_flags_pkey':
>> arch/x86/include/asm/pgtable_types.h:56:43: warning: left shift count >= width of type [-Wshift-count-overflow]
    #define _PAGE_PKEY_BIT0 (_AT(pteval_t, 1) << _PAGE_BIT_PKEY_BIT0)
                                              ^
>> arch/x86/include/asm/pgtable_types.h:68:26: note: in expansion of macro '_PAGE_PKEY_BIT0'
    #define _PAGE_PKEY_MASK (_PAGE_PKEY_BIT0 | \
                             ^~~~~~~~~~~~~~~
>> arch/x86/include/asm/pgtable.h:977:22: note: in expansion of macro '_PAGE_PKEY_MASK'
     return (pte_flags & _PAGE_PKEY_MASK) >> _PAGE_BIT_PKEY_BIT0;
                         ^~~~~~~~~~~~~~~
   arch/x86/include/asm/pgtable_types.h:57:43: warning: left shift count >= width of type [-Wshift-count-overflow]
    #define _PAGE_PKEY_BIT1 (_AT(pteval_t, 1) << _PAGE_BIT_PKEY_BIT1)
                                              ^
>> arch/x86/include/asm/pgtable_types.h:69:5: note: in expansion of macro '_PAGE_PKEY_BIT1'
        _PAGE_PKEY_BIT1 | \
        ^~~~~~~~~~~~~~~
>> arch/x86/include/asm/pgtable.h:977:22: note: in expansion of macro '_PAGE_PKEY_MASK'
     return (pte_flags & _PAGE_PKEY_MASK) >> _PAGE_BIT_PKEY_BIT0;
                         ^~~~~~~~~~~~~~~
   arch/x86/include/asm/pgtable_types.h:58:43: warning: left shift count >= width of type [-Wshift-count-overflow]
    #define _PAGE_PKEY_BIT2 (_AT(pteval_t, 1) << _PAGE_BIT_PKEY_BIT2)
                                              ^
>> arch/x86/include/asm/pgtable_types.h:70:5: note: in expansion of macro '_PAGE_PKEY_BIT2'
        _PAGE_PKEY_BIT2 | \
        ^~~~~~~~~~~~~~~
>> arch/x86/include/asm/pgtable.h:977:22: note: in expansion of macro '_PAGE_PKEY_MASK'
     return (pte_flags & _PAGE_PKEY_MASK) >> _PAGE_BIT_PKEY_BIT0;
                         ^~~~~~~~~~~~~~~
   arch/x86/include/asm/pgtable_types.h:59:43: warning: left shift count >= width of type [-Wshift-count-overflow]
    #define _PAGE_PKEY_BIT3 (_AT(pteval_t, 1) << _PAGE_BIT_PKEY_BIT3)
                                              ^
>> arch/x86/include/asm/pgtable_types.h:71:5: note: in expansion of macro '_PAGE_PKEY_BIT3'
        _PAGE_PKEY_BIT3)
        ^~~~~~~~~~~~~~~
>> arch/x86/include/asm/pgtable.h:977:22: note: in expansion of macro '_PAGE_PKEY_MASK'
     return (pte_flags & _PAGE_PKEY_MASK) >> _PAGE_BIT_PKEY_BIT0;
                         ^~~~~~~~~~~~~~~
   In file included from include/linux/kasan.h:16:0,
                    from include/linux/slab.h:118,
                    from include/linux/of.h:1187,
                    from include/linux/clocksource.h:18,
                    from arch/x86/include/asm/vgtod.h:5,
                    from arch/x86//entry/vdso/vdso32/../vclock_gettime.c:15,
                    from arch/x86//entry/vdso/vdso32/vclock_gettime.c:32:
>> arch/x86/include/asm/pgtable.h:977:39: warning: right shift count >= width of type [-Wshift-count-overflow]
     return (pte_flags & _PAGE_PKEY_MASK) >> _PAGE_BIT_PKEY_BIT0;
                                          ^~

vim +56 arch/x86/include/asm/pgtable_types.h

f955371ca David Vrabel        2014-01-07  50  #define _PAGE_SOFTW2	(_AT(pteval_t, 1) << _PAGE_BIT_SOFTW2)
8d19c99fa Jeremy Fitzhardinge 2009-02-08  51  #define _PAGE_PAT	(_AT(pteval_t, 1) << _PAGE_BIT_PAT)
8d19c99fa Jeremy Fitzhardinge 2009-02-08  52  #define _PAGE_PAT_LARGE (_AT(pteval_t, 1) << _PAGE_BIT_PAT_LARGE)
8d19c99fa Jeremy Fitzhardinge 2009-02-08  53  #define _PAGE_SPECIAL	(_AT(pteval_t, 1) << _PAGE_BIT_SPECIAL)
8d19c99fa Jeremy Fitzhardinge 2009-02-08  54  #define _PAGE_CPA_TEST	(_AT(pteval_t, 1) << _PAGE_BIT_CPA_TEST)
5c1d90f51 Dave Hansen         2016-02-12  55  #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
5c1d90f51 Dave Hansen         2016-02-12 @56  #define _PAGE_PKEY_BIT0	(_AT(pteval_t, 1) << _PAGE_BIT_PKEY_BIT0)
5c1d90f51 Dave Hansen         2016-02-12  57  #define _PAGE_PKEY_BIT1	(_AT(pteval_t, 1) << _PAGE_BIT_PKEY_BIT1)
5c1d90f51 Dave Hansen         2016-02-12  58  #define _PAGE_PKEY_BIT2	(_AT(pteval_t, 1) << _PAGE_BIT_PKEY_BIT2)
5c1d90f51 Dave Hansen         2016-02-12  59  #define _PAGE_PKEY_BIT3	(_AT(pteval_t, 1) << _PAGE_BIT_PKEY_BIT3)
5c1d90f51 Dave Hansen         2016-02-12  60  #else
5c1d90f51 Dave Hansen         2016-02-12  61  #define _PAGE_PKEY_BIT0	(_AT(pteval_t, 0))
5c1d90f51 Dave Hansen         2016-02-12  62  #define _PAGE_PKEY_BIT1	(_AT(pteval_t, 0))
5c1d90f51 Dave Hansen         2016-02-12  63  #define _PAGE_PKEY_BIT2	(_AT(pteval_t, 0))
5c1d90f51 Dave Hansen         2016-02-12  64  #define _PAGE_PKEY_BIT3	(_AT(pteval_t, 0))
5c1d90f51 Dave Hansen         2016-02-12  65  #endif
8d19c99fa Jeremy Fitzhardinge 2009-02-08  66  #define __HAVE_ARCH_PTE_SPECIAL
8d19c99fa Jeremy Fitzhardinge 2009-02-08  67  
019132ff3 Dave Hansen         2016-02-12 @68  #define _PAGE_PKEY_MASK (_PAGE_PKEY_BIT0 | \
019132ff3 Dave Hansen         2016-02-12 @69  			 _PAGE_PKEY_BIT1 | \
019132ff3 Dave Hansen         2016-02-12 @70  			 _PAGE_PKEY_BIT2 | \
019132ff3 Dave Hansen         2016-02-12 @71  			 _PAGE_PKEY_BIT3)
019132ff3 Dave Hansen         2016-02-12  72  
97e3c602c Dave Hansen         2016-07-07  73  #if defined(CONFIG_X86_64) || defined(CONFIG_X86_PAE)
97e3c602c Dave Hansen         2016-07-07  74  #define _PAGE_KNL_ERRATUM_MASK (_PAGE_DIRTY | _PAGE_ACCESSED)

:::::: The code at line 56 was first introduced by commit
:::::: 5c1d90f51027e197e1299ab1235a2fed78910905 x86/mm/pkeys: Add PTE bits for storing protection key

:::::: TO: Dave Hansen <dave.hansen@linux.intel.com>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 56917 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170513/7ea9367b/attachment-0001.gz>

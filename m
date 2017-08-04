From: lkp@intel.com (kbuild test robot)
Date: Fri, 4 Aug 2017 10:26:23 +0800
Subject: [PATCH 2/2] arm64: Define PAGE_OFFSET using GENMASK_ULL
In-Reply-To: <20170802225159.159536-2-mka@chromium.org>
Message-ID: <201708041034.3NVJyLsx%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on v4.13-rc3 next-20170803]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Matthias-Kaehlcke/bitops-Avoid-integer-overflow-warning-in-GENMASK_ULL/20170803-230211
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All error/warnings (new ones prefixed by >>):

   In file included from arch/arm64/include/asm/pgtable.h:22:0,
                    from arch/arm64/include/asm/kernel-pgtable.h:22,
                    from arch/arm64/kernel/head.S:34:
>> arch/arm64/include/asm/memory.h:68:33: error: missing binary operator before token "("
    #define PAGE_OFFSET  GENMASK_ULL(BITS_PER_LONG_LONG - 1, VA_BITS - 1)
                                    ^
>> arch/arm64/kernel/head.S:51:8: note: in expansion of macro 'PAGE_OFFSET'
    #elif (PAGE_OFFSET & 0x1fffff) != 0
           ^~~~~~~~~~~
--
   In file included from include/linux/printk.h:6:0,
                    from include/linux/kernel.h:13,
                    from arch/arm64/mm/init.c:20:
   arch/arm64/mm/init.c: In function 'mem_init':
   include/linux/kern_levels.h:4:18: warning: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'long long unsigned int' [-Wformat=]
    #define KERN_SOH "\001"  /* ASCII Start Of Header */
                     ^
   include/linux/kern_levels.h:12:21: note: in expansion of macro 'KERN_SOH'
    #define KERN_NOTICE KERN_SOH "5" /* normal but significant condition */
                        ^~~~~~~~
>> include/linux/printk.h:306:9: note: in expansion of macro 'KERN_NOTICE'
     printk(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
            ^~~~~~~~~~~
>> arch/arm64/mm/init.c:614:2: note: in expansion of macro 'pr_notice'
     pr_notice("    vmalloc : 0x%16lx - 0x%16lx   (%6ld GB)\n",
     ^~~~~~~~~
>> include/linux/kern_levels.h:4:18: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'long long unsigned int' [-Wformat=]
    #define KERN_SOH "\001"  /* ASCII Start Of Header */
                     ^
   include/linux/kern_levels.h:12:21: note: in expansion of macro 'KERN_SOH'
    #define KERN_NOTICE KERN_SOH "5" /* normal but significant condition */
                        ^~~~~~~~
>> include/linux/printk.h:306:9: note: in expansion of macro 'KERN_NOTICE'
     printk(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
            ^~~~~~~~~~~
>> arch/arm64/mm/init.c:614:2: note: in expansion of macro 'pr_notice'
     pr_notice("    vmalloc : 0x%16lx - 0x%16lx   (%6ld GB)\n",
     ^~~~~~~~~
   include/linux/kern_levels.h:4:18: warning: format '%lx' expects argument of type 'long unsigned int', but argument 2 has type 'long long unsigned int' [-Wformat=]
    #define KERN_SOH "\001"  /* ASCII Start Of Header */
                     ^
   include/linux/kern_levels.h:12:21: note: in expansion of macro 'KERN_SOH'
    #define KERN_NOTICE KERN_SOH "5" /* normal but significant condition */
                        ^~~~~~~~
>> include/linux/printk.h:306:9: note: in expansion of macro 'KERN_NOTICE'
     printk(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
            ^~~~~~~~~~~
   arch/arm64/mm/init.c:626:2: note: in expansion of macro 'pr_notice'
     pr_notice("    fixed   : 0x%16lx - 0x%16lx   (%6ld KB)\n",
     ^~~~~~~~~
   include/linux/kern_levels.h:4:18: warning: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'long long unsigned int' [-Wformat=]
    #define KERN_SOH "\001"  /* ASCII Start Of Header */
                     ^
   include/linux/kern_levels.h:12:21: note: in expansion of macro 'KERN_SOH'
    #define KERN_NOTICE KERN_SOH "5" /* normal but significant condition */
                        ^~~~~~~~
>> include/linux/printk.h:306:9: note: in expansion of macro 'KERN_NOTICE'
     printk(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
            ^~~~~~~~~~~
   arch/arm64/mm/init.c:626:2: note: in expansion of macro 'pr_notice'
     pr_notice("    fixed   : 0x%16lx - 0x%16lx   (%6ld KB)\n",
     ^~~~~~~~~
>> include/linux/kern_levels.h:4:18: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'long long unsigned int' [-Wformat=]
    #define KERN_SOH "\001"  /* ASCII Start Of Header */
                     ^
   include/linux/kern_levels.h:12:21: note: in expansion of macro 'KERN_SOH'
    #define KERN_NOTICE KERN_SOH "5" /* normal but significant condition */
                        ^~~~~~~~
>> include/linux/printk.h:306:9: note: in expansion of macro 'KERN_NOTICE'
     printk(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
            ^~~~~~~~~~~
   arch/arm64/mm/init.c:626:2: note: in expansion of macro 'pr_notice'
     pr_notice("    fixed   : 0x%16lx - 0x%16lx   (%6ld KB)\n",
     ^~~~~~~~~
   include/linux/kern_levels.h:4:18: warning: format '%lx' expects argument of type 'long unsigned int', but argument 2 has type 'long long unsigned int' [-Wformat=]
    #define KERN_SOH "\001"  /* ASCII Start Of Header */
                     ^
   include/linux/kern_levels.h:12:21: note: in expansion of macro 'KERN_SOH'
    #define KERN_NOTICE KERN_SOH "5" /* normal but significant condition */
                        ^~~~~~~~
>> include/linux/printk.h:306:9: note: in expansion of macro 'KERN_NOTICE'
     printk(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
            ^~~~~~~~~~~
   arch/arm64/mm/init.c:628:2: note: in expansion of macro 'pr_notice'
     pr_notice("    PCI I/O : 0x%16lx - 0x%16lx   (%6ld MB)\n",
     ^~~~~~~~~
   include/linux/kern_levels.h:4:18: warning: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'long long unsigned int' [-Wformat=]
    #define KERN_SOH "\001"  /* ASCII Start Of Header */
                     ^
   include/linux/kern_levels.h:12:21: note: in expansion of macro 'KERN_SOH'
    #define KERN_NOTICE KERN_SOH "5" /* normal but significant condition */
                        ^~~~~~~~
>> include/linux/printk.h:306:9: note: in expansion of macro 'KERN_NOTICE'
     printk(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
            ^~~~~~~~~~~
   arch/arm64/mm/init.c:628:2: note: in expansion of macro 'pr_notice'
     pr_notice("    PCI I/O : 0x%16lx - 0x%16lx   (%6ld MB)\n",
     ^~~~~~~~~
>> include/linux/kern_levels.h:4:18: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'long long unsigned int' [-Wformat=]
    #define KERN_SOH "\001"  /* ASCII Start Of Header */
                     ^
   include/linux/kern_levels.h:12:21: note: in expansion of macro 'KERN_SOH'
    #define KERN_NOTICE KERN_SOH "5" /* normal but significant condition */
                        ^~~~~~~~
>> include/linux/printk.h:306:9: note: in expansion of macro 'KERN_NOTICE'
     printk(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
            ^~~~~~~~~~~
   arch/arm64/mm/init.c:628:2: note: in expansion of macro 'pr_notice'
     pr_notice("    PCI I/O : 0x%16lx - 0x%16lx   (%6ld MB)\n",
     ^~~~~~~~~
   include/linux/kern_levels.h:4:18: warning: format '%lx' expects argument of type 'long unsigned int', but argument 2 has type 'long long unsigned int' [-Wformat=]
    #define KERN_SOH "\001"  /* ASCII Start Of Header */
                     ^
   include/linux/kern_levels.h:12:21: note: in expansion of macro 'KERN_SOH'
    #define KERN_NOTICE KERN_SOH "5" /* normal but significant condition */
                        ^~~~~~~~
>> include/linux/printk.h:306:9: note: in expansion of macro 'KERN_NOTICE'
     printk(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
            ^~~~~~~~~~~
   arch/arm64/mm/init.c:631:2: note: in expansion of macro 'pr_notice'
     pr_notice("    vmemmap : 0x%16lx - 0x%16lx   (%6ld GB maximum)\n",
     ^~~~~~~~~
   include/linux/kern_levels.h:4:18: warning: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'long long unsigned int' [-Wformat=]
    #define KERN_SOH "\001"  /* ASCII Start Of Header */
                     ^
   include/linux/kern_levels.h:12:21: note: in expansion of macro 'KERN_SOH'
    #define KERN_NOTICE KERN_SOH "5" /* normal but significant condition */
                        ^~~~~~~~
>> include/linux/printk.h:306:9: note: in expansion of macro 'KERN_NOTICE'
     printk(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
            ^~~~~~~~~~~
   arch/arm64/mm/init.c:631:2: note: in expansion of macro 'pr_notice'
     pr_notice("    vmemmap : 0x%16lx - 0x%16lx   (%6ld GB maximum)\n",
     ^~~~~~~~~
>> include/linux/kern_levels.h:4:18: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'long long unsigned int' [-Wformat=]
    #define KERN_SOH "\001"  /* ASCII Start Of Header */
                     ^
   include/linux/kern_levels.h:12:21: note: in expansion of macro 'KERN_SOH'
    #define KERN_NOTICE KERN_SOH "5" /* normal but significant condition */
                        ^~~~~~~~
>> include/linux/printk.h:306:9: note: in expansion of macro 'KERN_NOTICE'
     printk(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
            ^~~~~~~~~~~
   arch/arm64/mm/init.c:631:2: note: in expansion of macro 'pr_notice'
     pr_notice("    vmemmap : 0x%16lx - 0x%16lx   (%6ld GB maximum)\n",
     ^~~~~~~~~
   include/linux/kern_levels.h:4:18: warning: format '%lx' expects argument of type 'long unsigned int', but argument 2 has type 'long long unsigned int' [-Wformat=]
    #define KERN_SOH "\001"  /* ASCII Start Of Header */
                     ^
   include/linux/kern_levels.h:12:21: note: in expansion of macro 'KERN_SOH'
    #define KERN_NOTICE KERN_SOH "5" /* normal but significant condition */
                        ^~~~~~~~
>> include/linux/printk.h:306:9: note: in expansion of macro 'KERN_NOTICE'
     printk(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
            ^~~~~~~~~~~
   arch/arm64/mm/init.c:637:2: note: in expansion of macro 'pr_notice'
     pr_notice("    memory  : 0x%16lx - 0x%16lx   (%6ld MB)\n",
     ^~~~~~~~~
>> include/linux/kern_levels.h:4:18: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'long long unsigned int' [-Wformat=]
    #define KERN_SOH "\001"  /* ASCII Start Of Header */
                     ^
   include/linux/kern_levels.h:12:21: note: in expansion of macro 'KERN_SOH'
    #define KERN_NOTICE KERN_SOH "5" /* normal but significant condition */
                        ^~~~~~~~
>> include/linux/printk.h:306:9: note: in expansion of macro 'KERN_NOTICE'
     printk(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
            ^~~~~~~~~~~
   arch/arm64/mm/init.c:637:2: note: in expansion of macro 'pr_notice'
     pr_notice("    memory  : 0x%16lx - 0x%16lx   (%6ld MB)\n",
     ^~~~~~~~~
--
   In file included from include/linux/printk.h:6:0,
                    from include/linux/kernel.h:13,
                    from include/asm-generic/bug.h:15,
                    from arch/arm64/include/asm/bug.h:66,
                    from include/linux/bug.h:4,
                    from include/linux/mmdebug.h:4,
                    from include/linux/mm.h:8,
                    from include/linux/mman.h:4,
                    from arch/arm64/kvm/../../../virt/kvm/arm/mmu.c:19:
   arch/arm64/kvm/../../../virt/kvm/arm/mmu.c: In function 'kvm_mmu_init':
   include/linux/kern_levels.h:4:18: warning: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'long long unsigned int' [-Wformat=]
    #define KERN_SOH "\001"  /* ASCII Start Of Header */
                     ^
   include/linux/kern_levels.h:13:19: note: in expansion of macro 'KERN_SOH'
    #define KERN_INFO KERN_SOH "6" /* informational */
                      ^~~~~~~~
   include/linux/printk.h:308:9: note: in expansion of macro 'KERN_INFO'
     printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
            ^~~~~~~~~
>> include/linux/kvm_host.h:446:2: note: in expansion of macro 'pr_info'
     pr_info("kvm [%i]: " fmt, task_pid_nr(current), ## __VA_ARGS__)
     ^~~~~~~
>> arch/arm64/kvm/../../../virt/kvm/arm/mmu.c:1754:2: note: in expansion of macro 'kvm_info'
     kvm_info("HYP VA range: %lx:%lx\n",
     ^~~~~~~~

vim +68 arch/arm64/include/asm/memory.h

    56	
    57	/*
    58	 * PAGE_OFFSET - the virtual address of the start of the linear map (top
    59	 *		 (VA_BITS - 1))
    60	 * KIMAGE_VADDR - the virtual address of the start of the kernel image
    61	 * VA_BITS - the maximum number of bits for virtual addresses.
    62	 * VA_START - the first kernel virtual address.
    63	 * TASK_SIZE - the maximum size of a user space task.
    64	 * TASK_UNMAPPED_BASE - the lower boundary of the mmap VM area.
    65	 */
    66	#define VA_BITS			(CONFIG_ARM64_VA_BITS)
    67	#define VA_START		(UL(0xffffffffffffffff) << VA_BITS)
  > 68	#define PAGE_OFFSET		GENMASK_ULL(BITS_PER_LONG_LONG - 1, VA_BITS - 1)
    69	#define KIMAGE_VADDR		(MODULES_END)
    70	#define MODULES_END		(MODULES_VADDR + MODULES_VSIZE)
    71	#define MODULES_VADDR		(VA_START + KASAN_SHADOW_SIZE)
    72	#define MODULES_VSIZE		(SZ_128M)
    73	#define VMEMMAP_START		(PAGE_OFFSET - VMEMMAP_SIZE)
    74	#define PCI_IO_END		(VMEMMAP_START - SZ_2M)
    75	#define PCI_IO_START		(PCI_IO_END - PCI_IO_SIZE)
    76	#define FIXADDR_TOP		(PCI_IO_START - SZ_2M)
    77	#define TASK_SIZE_64		(UL(1) << VA_BITS)
    78	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 35216 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170804/36183971/attachment-0001.gz>

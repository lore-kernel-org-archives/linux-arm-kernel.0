From: lkp@intel.com (kbuild test robot)
Date: Fri, 16 Mar 2018 16:26:22 +0800
Subject: [PATCH v1 1/4] asm/tlbflush: Add flush_tlb_pgtable() for ARM64
In-Reply-To: <1521017305-28518-2-git-send-email-cpandya@codeaurora.org>
References: <1521017305-28518-2-git-send-email-cpandya@codeaurora.org>
Message-ID: <201803161605.N8znqGqC%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chintan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.16-rc5 next-20180316]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Chintan-Pandya/Fix-issues-with-huge-mapping-in-ioremap/20180316-132223
config: powerpc-ppc64_defconfig (attached as .config)
compiler: powerpc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/include/asm/tlb.h:36:0,
                    from arch/powerpc/mm/mem.c:50:
>> include/asm-generic/tlb.h:299:20: error: conflicting types for 'flush_tlb_pgtable'
    static inline void flush_tlb_pgtable(struct mm_struct *mm,
                       ^~~~~~~~~~~~~~~~~
   In file included from arch/powerpc/include/asm/tlbflush.h:81:0,
                    from arch/powerpc/include/asm/pgtable.h:24,
                    from include/linux/memremap.h:8,
                    from include/linux/mm.h:27,
                    from arch/powerpc/mm/mem.c:27:
   arch/powerpc/include/asm/book3s/64/tlbflush.h:143:20: note: previous definition of 'flush_tlb_pgtable' was here
    static inline void flush_tlb_pgtable(struct mmu_gather *tlb, unsigned long address)
                       ^~~~~~~~~~~~~~~~~

vim +/flush_tlb_pgtable +299 include/asm-generic/tlb.h

   297	
   298	#ifndef CONFIG_ARM64
 > 299	static inline void flush_tlb_pgtable(struct mm_struct *mm,

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 24001 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180316/a6ef022c/attachment-0001.gz>

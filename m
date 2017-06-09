From: lkp@intel.com (kbuild test robot)
Date: Fri, 9 Jun 2017 15:45:09 +0800
Subject: [PATCH v3] mm: huge-vmap: fail gracefully on unexpected huge
 vmap mappings
In-Reply-To: <20170608113548.24905-1-ard.biesheuvel@linaro.org>
Message-ID: <201706091553.AtM2cOo2%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.12-rc4]
[cannot apply to next-20170608]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ard-Biesheuvel/mm-huge-vmap-fail-gracefully-on-unexpected-huge-vmap-mappings/20170609-093900
config: i386-randconfig-i1-06042254 (attached as .config)
compiler: gcc-4.8 (Debian 4.8.4-1) 4.8.4
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   arch/x86/built-in.o: In function `vmalloc_fault':
>> fault.c:(.text.unlikely+0x1765): undefined reference to `pmd_huge'
   mm/built-in.o: In function `follow_page_mask':
   (.text+0x21da6): undefined reference to `pud_huge'
   mm/built-in.o: In function `follow_page_mask':
   (.text+0x21e39): undefined reference to `pmd_huge'
   mm/built-in.o: In function `__follow_pte_pmd.isra.86':
   memory.c:(.text+0x2381c): undefined reference to `pmd_huge'
   memory.c:(.text+0x2384a): undefined reference to `pmd_huge'
   mm/built-in.o: In function `apply_to_page_range':
   (.text+0x2648d): undefined reference to `pud_huge'
   mm/built-in.o: In function `apply_to_page_range':
   (.text+0x26608): undefined reference to `pmd_huge'
   mm/built-in.o: In function `vmalloc_to_page':
   (.text+0x30ea3): undefined reference to `pud_huge'
   mm/built-in.o: In function `vmalloc_to_page':
   (.text+0x30ec8): undefined reference to `pmd_huge'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 27823 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170609/e3264f7f/attachment-0001.gz>

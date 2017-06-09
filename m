From: lkp@intel.com (kbuild test robot)
Date: Fri, 9 Jun 2017 12:32:47 +0800
Subject: [PATCH v3] mm: huge-vmap: fail gracefully on unexpected huge
 vmap mappings
In-Reply-To: <20170608113548.24905-1-ard.biesheuvel@linaro.org>
Message-ID: <201706091241.ZiwfHOYj%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.12-rc4]
[cannot apply to next-20170608]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ard-Biesheuvel/mm-huge-vmap-fail-gracefully-on-unexpected-huge-vmap-mappings/20170609-093900
config: x86_64-kexec (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   arch/x86/built-in.o: In function `vmalloc_fault':
>> fault.c:(.text+0x422c5): undefined reference to `pud_huge'
>> fault.c:(.text+0x4238e): undefined reference to `pmd_huge'
   mm/built-in.o: In function `follow_page_mask':
>> (.text+0x2fcde): undefined reference to `pud_huge'
   mm/built-in.o: In function `follow_page_mask':
>> (.text+0x2fda8): undefined reference to `pmd_huge'
   mm/built-in.o: In function `__follow_pte_pmd.isra.10':
>> memory.c:(.text+0x31b91): undefined reference to `pmd_huge'
   memory.c:(.text+0x31bbf): undefined reference to `pmd_huge'
   mm/built-in.o: In function `apply_to_page_range':
   (.text+0x34e77): undefined reference to `pud_huge'
   mm/built-in.o: In function `apply_to_page_range':
   (.text+0x35043): undefined reference to `pmd_huge'
   mm/built-in.o: In function `vmalloc_to_page':
   (.text+0x421a0): undefined reference to `pud_huge'
   mm/built-in.o: In function `vmalloc_to_page':
   (.text+0x421ec): undefined reference to `pmd_huge'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 25324 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170609/379ddcad/attachment-0001.gz>

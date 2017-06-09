From: lkp@intel.com (kbuild test robot)
Date: Fri, 9 Jun 2017 10:29:08 +0800
Subject: [PATCH v4] mm: huge-vmap: fail gracefully on unexpected huge
 vmap mappings
In-Reply-To: <20170608192219.8338-1-ard.biesheuvel@linaro.org>
Message-ID: <201706091054.LKccOscH%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

[auto build test ERROR on mmotm/master]
[also build test ERROR on v4.12-rc4 next-20170608]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ard-Biesheuvel/mm-huge-vmap-fail-gracefully-on-unexpected-huge-vmap-mappings/20170609-093236
base:   git://git.cmpxchg.org/linux-mmotm.git master
config: x86_64-randconfig-x019-201723 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All error/warnings (new ones prefixed by >>):

   mm/vmalloc.c: In function 'vmalloc_to_page':
>> mm/vmalloc.c:2775:0: error: unterminated argument list invoking macro "WARN_ON_ONCE"
    
    
>> mm/vmalloc.c:303:2: error: 'WARN_ON_ONCE' undeclared (first use in this function)
     WARN_ON_ONCE(pmd_bad(*pmd);
     ^~~~~~~~~~~~
   mm/vmalloc.c:303:2: note: each undeclared identifier is reported only once for each function it appears in
>> mm/vmalloc.c:303:2: error: expected ';' at end of input
>> mm/vmalloc.c:303:2: error: expected declaration or statement at end of input
   mm/vmalloc.c:276:15: warning: unused variable 'pte' [-Wunused-variable]
     pte_t *ptep, pte;
                  ^~~
   mm/vmalloc.c:276:9: warning: unused variable 'ptep' [-Wunused-variable]
     pte_t *ptep, pte;
            ^~~~
   mm/vmalloc.c:271:15: warning: unused variable 'page' [-Wunused-variable]
     struct page *page = NULL;
                  ^~~~
   mm/vmalloc.c: At top level:
>> mm/vmalloc.c:47:13: warning: '__vunmap' used but never defined
    static void __vunmap(const void *, int);
                ^~~~~~~~
   mm/vmalloc.c: In function 'vmalloc_to_page':
>> mm/vmalloc.c:303:2: warning: control reaches end of non-void function [-Wreturn-type]
     WARN_ON_ONCE(pmd_bad(*pmd);
     ^~~~~~~~~~~~
   At top level:
   mm/vmalloc.c:240:12: warning: 'vmap_page_range' defined but not used [-Wunused-function]
    static int vmap_page_range(unsigned long start, unsigned long end,
               ^~~~~~~~~~~~~~~
   mm/vmalloc.c:121:13: warning: 'vunmap_page_range' defined but not used [-Wunused-function]
    static void vunmap_page_range(unsigned long addr, unsigned long end)
                ^~~~~~~~~~~~~~~~~
   mm/vmalloc.c:49:13: warning: 'free_work' defined but not used [-Wunused-function]
    static void free_work(struct work_struct *w)
                ^~~~~~~~~

vim +/WARN_ON_ONCE +2775 mm/vmalloc.c

5f6a6a9c4 Alexey Dobriyan   2008-10-06  2769  	proc_create("vmallocinfo", S_IRUSR, NULL, &proc_vmalloc_operations);
5f6a6a9c4 Alexey Dobriyan   2008-10-06  2770  	return 0;
5f6a6a9c4 Alexey Dobriyan   2008-10-06  2771  }
5f6a6a9c4 Alexey Dobriyan   2008-10-06  2772  module_init(proc_vmalloc_init);
db3808c1b Joonsoo Kim       2013-04-29  2773  
a10aa5798 Christoph Lameter 2008-04-28  2774  #endif
a10aa5798 Christoph Lameter 2008-04-28 @2775  

:::::: The code at line 2775 was first introduced by commit
:::::: a10aa579878fc6f9cd17455067380bbdf1d53c91 vmalloc: show vmalloced areas via /proc/vmallocinfo

:::::: TO: Christoph Lameter <clameter@sgi.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 31818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170609/46c091e8/attachment-0001.gz>

From: lkp@intel.com (kbuild test robot)
Date: Wed, 4 Apr 2018 22:19:33 +0800
Subject: [PATCH v6 1/5] mm: page_alloc: remain memblock_next_valid_pfn()
 on arm and arm64
In-Reply-To: <1522810579-7466-2-git-send-email-hejianet@gmail.com>
References: <1522810579-7466-2-git-send-email-hejianet@gmail.com>
Message-ID: <201804042156.YTVq2WAJ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jia,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on v4.16 next-20180403]
[cannot apply to linus/master mmotm/master]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jia-He/mm-page_alloc-remain-memblock_next_valid_pfn-on-arm-and-arm64/20180404-200732
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: i386-randconfig-x013-201813 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/gfp.h:6:0,
                    from include/linux/mm.h:10,
                    from mm/page_alloc.c:18:
   mm/page_alloc.c: In function 'memmap_init_zone':
>> include/linux/mmzone.h:1299:28: error: called object is not a function or function pointer
    #define next_valid_pfn (pfn++)
                           ~~~~^~~
>> mm/page_alloc.c:5349:39: note: in expansion of macro 'next_valid_pfn'
     for (pfn = start_pfn; pfn < end_pfn; next_valid_pfn(pfn)) {
                                          ^~~~~~~~~~~~~~

vim +1299 include/linux/mmzone.h

  1296	
  1297	/* fallback to default defitions*/
  1298	#ifndef next_valid_pfn
> 1299	#define next_valid_pfn	(pfn++)
  1300	#endif
  1301	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 31450 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180404/29e2103e/attachment-0001.gz>

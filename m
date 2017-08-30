From: lkp@intel.com (kbuild test robot)
Date: Thu, 31 Aug 2017 07:12:31 +0800
Subject: [PATCH v7 08/11] mm: zero reserved and unavailable struct pages
In-Reply-To: <1503972142-289376-9-git-send-email-pasha.tatashin@oracle.com>
Message-ID: <201708310652.1lgOVyko%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

[auto build test ERROR on sparc/master]
[also build test ERROR on v4.13-rc7 next-20170829]
[cannot apply to mmotm/master]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Pavel-Tatashin/complete-deferred-page-initialization/20170831-041021
base:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master
config: cris-allmodconfig (attached as .config)
compiler: cris-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=cris 

All errors (new ones prefixed by >>):

   In file included from mm/page_alloc.c:18:0:
   include/linux/mm.h:1974:33: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'zero_resv_unavail'
    static inline void __paginginit zero_resv_unavail(void) {}
                                    ^~~~~~~~~~~~~~~~~
   mm/page_alloc.c: In function 'free_area_init':
>> mm/page_alloc.c:6863:2: error: implicit declaration of function 'zero_resv_unavail' [-Werror=implicit-function-declaration]
     zero_resv_unavail();
     ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/zero_resv_unavail +6863 mm/page_alloc.c

  6858	
  6859	void __init free_area_init(unsigned long *zones_size)
  6860	{
  6861		free_area_init_node(0, zones_size,
  6862				__pa(PAGE_OFFSET) >> PAGE_SHIFT, NULL);
> 6863		zero_resv_unavail();
  6864	}
  6865	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 42983 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170831/cef71a4d/attachment-0001.gz>

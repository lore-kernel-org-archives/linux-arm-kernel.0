From: lkp@intel.com (kbuild test robot)
Date: Thu, 31 Aug 2017 05:22:48 +0800
Subject: [PATCH v7 08/11] mm: zero reserved and unavailable struct pages
In-Reply-To: <1503972142-289376-9-git-send-email-pasha.tatashin@oracle.com>
Message-ID: <201708310421.NmkLnF43%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

[auto build test ERROR on sparc/master]
[also build test ERROR on v4.13-rc7 next-20170829]
[cannot apply to mmotm/master]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Pavel-Tatashin/complete-deferred-page-initialization/20170831-041021
base:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master
config: tile-allmodconfig (attached as .config)
compiler: tilegx-linux-gcc (GCC) 4.6.2
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=tile 

All errors (new ones prefixed by >>):

   In file included from include/linux/pid_namespace.h:6:0,
                    from include/linux/ptrace.h:9,
                    from arch/tile/kernel/asm-offsets.c:35:
>> include/linux/mm.h:1974:33: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'zero_resv_unavail'
   make[2]: *** [arch/tile/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [sub-make] Error 2

vim +1974 include/linux/mm.h

  1970	
  1971	#ifdef CONFIG_HAVE_MEMBLOCK
  1972	void zero_resv_unavail(void);
  1973	#else
> 1974	static inline void __paginginit zero_resv_unavail(void) {}
  1975	#endif
  1976	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 49789 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170831/61f40b2f/attachment-0001.gz>

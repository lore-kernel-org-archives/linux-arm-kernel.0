From: lkp@intel.com (kbuild test robot)
Date: Tue, 20 Mar 2018 09:41:14 +0800
Subject: [PATCH v5 08/12] clk: actions: Add factor clock support
In-Reply-To: <20180317100952.28538-9-manivannan.sadhasivam@linaro.org>
References: <20180317100952.28538-9-manivannan.sadhasivam@linaro.org>
Message-ID: <201803200916.tC5n98xo%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Manivannan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v4.16-rc4]
[cannot apply to next-20180319]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Manivannan-Sadhasivam/Add-clock-driver-for-Actions-S900-SoC/20180319-015124
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   In file included from arch/arm/include/asm/div64.h:127:0,
                    from include/linux/kernel.h:173,
                    from include/asm-generic/bug.h:18,
                    from arch/arm/include/asm/bug.h:60,
                    from include/linux/bug.h:5,
                    from include/linux/io.h:23,
                    from include/linux/clk-provider.h:14,
                    from drivers/clk/actions/owl-factor.c:11:
   drivers/clk/actions/owl-factor.c: In function 'owl_factor_helper_recalc_rate':
   include/asm-generic/div64.h:222:28: warning: comparison of distinct pointer types lacks a cast
     (void)(((typeof((n)) *)0) == ((uint64_t *)0)); \
                               ^
   drivers/clk/actions/owl-factor.c:170:2: note: in expansion of macro 'do_div'
     do_div(rate, div);
     ^~~~~~
   In file included from include/linux/init.h:5:0,
                    from include/linux/io.h:22,
                    from include/linux/clk-provider.h:14,
                    from drivers/clk/actions/owl-factor.c:11:
   include/asm-generic/div64.h:235:25: warning: right shift count >= width of type [-Wshift-count-overflow]
     } else if (likely(((n) >> 32) == 0)) {  \
                            ^
   include/linux/compiler.h:76:40: note: in definition of macro 'likely'
    # define likely(x) __builtin_expect(!!(x), 1)
                                           ^
   drivers/clk/actions/owl-factor.c:170:2: note: in expansion of macro 'do_div'
     do_div(rate, div);
     ^~~~~~
   In file included from arch/arm/include/asm/div64.h:127:0,
                    from include/linux/kernel.h:173,
                    from include/asm-generic/bug.h:18,
                    from arch/arm/include/asm/bug.h:60,
                    from include/linux/bug.h:5,
                    from include/linux/io.h:23,
                    from include/linux/clk-provider.h:14,
                    from drivers/clk/actions/owl-factor.c:11:
>> include/asm-generic/div64.h:239:22: error: passing argument 1 of '__div64_32' from incompatible pointer type [-Werror=incompatible-pointer-types]
      __rem = __div64_32(&(n), __base); \
                         ^
   drivers/clk/actions/owl-factor.c:170:2: note: in expansion of macro 'do_div'
     do_div(rate, div);
     ^~~~~~
   In file included from include/linux/kernel.h:173:0,
                    from include/asm-generic/bug.h:18,
                    from arch/arm/include/asm/bug.h:60,
                    from include/linux/bug.h:5,
                    from include/linux/io.h:23,
                    from include/linux/clk-provider.h:14,
                    from drivers/clk/actions/owl-factor.c:11:
   arch/arm/include/asm/div64.h:33:24: note: expected 'uint64_t * {aka long long unsigned int *}' but argument is of type 'long unsigned int *'
    static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
                           ^~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from arch/arm/include/asm/div64.h:127:0,
                    from include/linux/kernel.h:173,
                    from include/asm-generic/bug.h:18,
                    from arch/arm/include/asm/bug.h:60,
                    from include/linux/bug.h:5,
                    from include/linux/io.h:23,
                    from include/linux/clk-provider.h:14,
                    from drivers/clk//actions/owl-factor.c:11:
   drivers/clk//actions/owl-factor.c: In function 'owl_factor_helper_recalc_rate':
   include/asm-generic/div64.h:222:28: warning: comparison of distinct pointer types lacks a cast
     (void)(((typeof((n)) *)0) == ((uint64_t *)0)); \
                               ^
   drivers/clk//actions/owl-factor.c:170:2: note: in expansion of macro 'do_div'
     do_div(rate, div);
     ^~~~~~
   In file included from include/linux/init.h:5:0,
                    from include/linux/io.h:22,
                    from include/linux/clk-provider.h:14,
                    from drivers/clk//actions/owl-factor.c:11:
   include/asm-generic/div64.h:235:25: warning: right shift count >= width of type [-Wshift-count-overflow]
     } else if (likely(((n) >> 32) == 0)) {  \
                            ^
   include/linux/compiler.h:76:40: note: in definition of macro 'likely'
    # define likely(x) __builtin_expect(!!(x), 1)
                                           ^
   drivers/clk//actions/owl-factor.c:170:2: note: in expansion of macro 'do_div'
     do_div(rate, div);
     ^~~~~~
   In file included from arch/arm/include/asm/div64.h:127:0,
                    from include/linux/kernel.h:173,
                    from include/asm-generic/bug.h:18,
                    from arch/arm/include/asm/bug.h:60,
                    from include/linux/bug.h:5,
                    from include/linux/io.h:23,
                    from include/linux/clk-provider.h:14,
                    from drivers/clk//actions/owl-factor.c:11:
>> include/asm-generic/div64.h:239:22: error: passing argument 1 of '__div64_32' from incompatible pointer type [-Werror=incompatible-pointer-types]
      __rem = __div64_32(&(n), __base); \
                         ^
   drivers/clk//actions/owl-factor.c:170:2: note: in expansion of macro 'do_div'
     do_div(rate, div);
     ^~~~~~
   In file included from include/linux/kernel.h:173:0,
                    from include/asm-generic/bug.h:18,
                    from arch/arm/include/asm/bug.h:60,
                    from include/linux/bug.h:5,
                    from include/linux/io.h:23,
                    from include/linux/clk-provider.h:14,
                    from drivers/clk//actions/owl-factor.c:11:
   arch/arm/include/asm/div64.h:33:24: note: expected 'uint64_t * {aka long long unsigned int *}' but argument is of type 'long unsigned int *'
    static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
                           ^~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/__div64_32 +239 include/asm-generic/div64.h

^1da177e Linus Torvalds 2005-04-16  215  
^1da177e Linus Torvalds 2005-04-16  216  /* The unnecessary pointer compare is there
^1da177e Linus Torvalds 2005-04-16  217   * to check for type safety (n must be 64bit)
^1da177e Linus Torvalds 2005-04-16  218   */
^1da177e Linus Torvalds 2005-04-16  219  # define do_div(n,base) ({				\
^1da177e Linus Torvalds 2005-04-16  220  	uint32_t __base = (base);			\
^1da177e Linus Torvalds 2005-04-16  221  	uint32_t __rem;					\
^1da177e Linus Torvalds 2005-04-16  222  	(void)(((typeof((n)) *)0) == ((uint64_t *)0));	\
911918aa Nicolas Pitre  2015-11-02  223  	if (__builtin_constant_p(__base) &&		\
911918aa Nicolas Pitre  2015-11-02  224  	    is_power_of_2(__base)) {			\
911918aa Nicolas Pitre  2015-11-02  225  		__rem = (n) & (__base - 1);		\
911918aa Nicolas Pitre  2015-11-02  226  		(n) >>= ilog2(__base);			\
461a5e51 Nicolas Pitre  2015-10-30  227  	} else if (__div64_const32_is_OK &&		\
461a5e51 Nicolas Pitre  2015-10-30  228  		   __builtin_constant_p(__base) &&	\
461a5e51 Nicolas Pitre  2015-10-30  229  		   __base != 0) {			\
461a5e51 Nicolas Pitre  2015-10-30  230  		uint32_t __res_lo, __n_lo = (n);	\
461a5e51 Nicolas Pitre  2015-10-30  231  		(n) = __div64_const32(n, __base);	\
461a5e51 Nicolas Pitre  2015-10-30  232  		/* the remainder can be computed with 32-bit regs */ \
461a5e51 Nicolas Pitre  2015-10-30  233  		__res_lo = (n);				\
461a5e51 Nicolas Pitre  2015-10-30  234  		__rem = __n_lo - __res_lo * __base;	\
911918aa Nicolas Pitre  2015-11-02  235  	} else if (likely(((n) >> 32) == 0)) {		\
^1da177e Linus Torvalds 2005-04-16  236  		__rem = (uint32_t)(n) % __base;		\
^1da177e Linus Torvalds 2005-04-16  237  		(n) = (uint32_t)(n) / __base;		\
^1da177e Linus Torvalds 2005-04-16  238  	} else 						\
^1da177e Linus Torvalds 2005-04-16 @239  		__rem = __div64_32(&(n), __base);	\
^1da177e Linus Torvalds 2005-04-16  240  	__rem;						\
^1da177e Linus Torvalds 2005-04-16  241   })
^1da177e Linus Torvalds 2005-04-16  242  

:::::: The code at line 239 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 64883 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180320/22fc4d87/attachment-0001.gz>

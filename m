From: fengguang.wu@intel.com (kbuild test robot)
Date: Mon, 31 Jul 2017 19:10:28 +0800
Subject: [xlnx:master 688/864] include/linux/kernel.h:836:48: error:
 initialization from incompatible pointer type
Message-ID: <201707311918.dqq2z8nM%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

FYI, the error/warning still remains.

tree:   https://github.com/Xilinx/linux-xlnx master
head:   00346d2eba7634f4fb2c2117ac371e0c104a2870
commit: 472236088ad190937efa1be2d96965f9bb7c9bcb [688/864] kbuild: Add option to turn incompatible pointer check into error
config: blackfin-allyesconfig (attached as .config)
compiler: bfin-uclinux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 472236088ad190937efa1be2d96965f9bb7c9bcb
        # save the attached .config to linux build tree
        make.cross ARCH=blackfin 

All errors (new ones prefixed by >>):

   drivers/misc/jesd204b/xilinx_jesd204b.c:28:17: error: field 'hw' has incomplete type
     struct clk_hw  hw;
                    ^~
   In file included from include/linux/clk.h:16:0,
                    from drivers/misc/jesd204b/xilinx_jesd204b.c:11:
   drivers/misc/jesd204b/xilinx_jesd204b.c: In function 'jesd204b_clk_enable':
>> include/linux/kernel.h:836:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/misc/jesd204b/xilinx_jesd204b.c:34:26: note: in expansion of macro 'container_of'
    #define to_clk_priv(_hw) container_of(_hw, struct child_clk, hw)
                             ^~~~~~~~~~~~
   drivers/misc/jesd204b/xilinx_jesd204b.c:214:2: note: in expansion of macro 'to_clk_priv'
     to_clk_priv(hw)->enabled = true;
     ^~~~~~~~~~~
   drivers/misc/jesd204b/xilinx_jesd204b.c: In function 'jesd204b_clk_disable':
>> include/linux/kernel.h:836:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/misc/jesd204b/xilinx_jesd204b.c:34:26: note: in expansion of macro 'container_of'
    #define to_clk_priv(_hw) container_of(_hw, struct child_clk, hw)
                             ^~~~~~~~~~~~
   drivers/misc/jesd204b/xilinx_jesd204b.c:221:2: note: in expansion of macro 'to_clk_priv'
     to_clk_priv(hw)->enabled = false;
     ^~~~~~~~~~~
   drivers/misc/jesd204b/xilinx_jesd204b.c: In function 'jesd204b_clk_is_enabled':
>> include/linux/kernel.h:836:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/misc/jesd204b/xilinx_jesd204b.c:34:26: note: in expansion of macro 'container_of'
    #define to_clk_priv(_hw) container_of(_hw, struct child_clk, hw)
                             ^~~~~~~~~~~~
   drivers/misc/jesd204b/xilinx_jesd204b.c:226:9: note: in expansion of macro 'to_clk_priv'
     return to_clk_priv(hw)->enabled;
            ^~~~~~~~~~~
   drivers/misc/jesd204b/xilinx_jesd204b.c: At top level:
   drivers/misc/jesd204b/xilinx_jesd204b.c:229:21: error: variable 'clkout_ops' has initializer but incomplete type
    static const struct clk_ops clkout_ops = {
                        ^~~~~~~
   drivers/misc/jesd204b/xilinx_jesd204b.c:230:2: error: unknown field 'recalc_rate' specified in initializer
     .recalc_rate = jesd204b_clk_recalc_rate,
     ^
   drivers/misc/jesd204b/xilinx_jesd204b.c:230:17: warning: excess elements in struct initializer
     .recalc_rate = jesd204b_clk_recalc_rate,
                    ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/jesd204b/xilinx_jesd204b.c:230:17: note: (near initialization for 'clkout_ops')
   drivers/misc/jesd204b/xilinx_jesd204b.c:231:2: error: unknown field 'enable' specified in initializer
     .enable = jesd204b_clk_enable,
     ^
   drivers/misc/jesd204b/xilinx_jesd204b.c:231:12: warning: excess elements in struct initializer
     .enable = jesd204b_clk_enable,
               ^~~~~~~~~~~~~~~~~~~
   drivers/misc/jesd204b/xilinx_jesd204b.c:231:12: note: (near initialization for 'clkout_ops')
   drivers/misc/jesd204b/xilinx_jesd204b.c:232:2: error: unknown field 'disable' specified in initializer
     .disable = jesd204b_clk_disable,
     ^
   drivers/misc/jesd204b/xilinx_jesd204b.c:232:13: warning: excess elements in struct initializer
     .disable = jesd204b_clk_disable,
                ^~~~~~~~~~~~~~~~~~~~
   drivers/misc/jesd204b/xilinx_jesd204b.c:232:13: note: (near initialization for 'clkout_ops')
   drivers/misc/jesd204b/xilinx_jesd204b.c:233:2: error: unknown field 'is_enabled' specified in initializer
     .is_enabled = jesd204b_clk_is_enabled,
     ^
   drivers/misc/jesd204b/xilinx_jesd204b.c:233:16: warning: excess elements in struct initializer
     .is_enabled = jesd204b_clk_is_enabled,
                   ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/jesd204b/xilinx_jesd204b.c:233:16: note: (near initialization for 'clkout_ops')
   drivers/misc/jesd204b/xilinx_jesd204b.c: In function 'jesd204b_probe':
   drivers/misc/jesd204b/xilinx_jesd204b.c:251:23: error: storage size of 'init' isn't known
     struct clk_init_data init;
                          ^~~~
   drivers/misc/jesd204b/xilinx_jesd204b.c:251:23: warning: unused variable 'init' [-Wunused-variable]
   drivers/misc/jesd204b/xilinx_jesd204b.c: At top level:
   drivers/misc/jesd204b/xilinx_jesd204b.c:229:29: error: storage size of 'clkout_ops' isn't known
    static const struct clk_ops clkout_ops = {
                                ^~~~~~~~~~
   cc1: some warnings being treated as errors

vim +836 include/linux/kernel.h

^1da177e Linus Torvalds 2005-04-16  820  
91f68b73 Wu Fengguang   2009-01-07  821  
91f68b73 Wu Fengguang   2009-01-07  822  /*
91f68b73 Wu Fengguang   2009-01-07  823   * swap - swap value of @a and @b
91f68b73 Wu Fengguang   2009-01-07  824   */
ac7b9004 Peter Zijlstra 2009-02-04  825  #define swap(a, b) \
ac7b9004 Peter Zijlstra 2009-02-04  826  	do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
91f68b73 Wu Fengguang   2009-01-07  827  
^1da177e Linus Torvalds 2005-04-16  828  /**
^1da177e Linus Torvalds 2005-04-16  829   * container_of - cast a member of a structure out to the containing structure
^1da177e Linus Torvalds 2005-04-16  830   * @ptr:	the pointer to the member.
^1da177e Linus Torvalds 2005-04-16  831   * @type:	the type of the container struct this is embedded in.
^1da177e Linus Torvalds 2005-04-16  832   * @member:	the name of the member within the struct.
^1da177e Linus Torvalds 2005-04-16  833   *
^1da177e Linus Torvalds 2005-04-16  834   */
^1da177e Linus Torvalds 2005-04-16  835  #define container_of(ptr, type, member) ({			\
^1da177e Linus Torvalds 2005-04-16 @836  	const typeof( ((type *)0)->member ) *__mptr = (ptr);	\
^1da177e Linus Torvalds 2005-04-16  837  	(type *)( (char *)__mptr - offsetof(type,member) );})
^1da177e Linus Torvalds 2005-04-16  838  

:::::: The code at line 836 was first introduced by commit
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
Size: 42448 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170731/7cdf480e/attachment-0001.gz>

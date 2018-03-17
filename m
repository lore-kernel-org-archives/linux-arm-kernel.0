From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 17 Mar 2018 11:14:20 +0800
Subject: [xlnx:master 1122/1540] include/linux/kernel.h:929:32: error:
 dereferencing pointer to incomplete type 'struct clk_hw'
Message-ID: <201803171107.n0gIjuck%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   82f616d7008a600126b365e6e84985843fc60a18
commit: 818f168696f561c127f161379eb5b8d1835218a2 [1122/1540] Merge tag 'v4.14' into master
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 818f168696f561c127f161379eb5b8d1835218a2
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All errors (new ones prefixed by >>):

   drivers/misc/jesd204b/xilinx_jesd204b.c:28:17: error: field 'hw' has incomplete type
     struct clk_hw  hw;
                    ^~
   In file included from include/linux/err.h:5:0,
                    from include/linux/clk.h:15,
                    from drivers/misc/jesd204b/xilinx_jesd204b.c:11:
   drivers/misc/jesd204b/xilinx_jesd204b.c: In function 'jesd204b_clk_enable':
>> include/linux/kernel.h:929:32: error: dereferencing pointer to incomplete type 'struct clk_hw'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                                   ^~~~~~
   include/linux/compiler.h:554:19: note: in definition of macro '__compiletime_assert'
      bool __cond = !(condition);    \
                      ^~~~~~~~~
   include/linux/compiler.h:577:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:47:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:929:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
     ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:929:20: note: in expansion of macro '__same_type'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                       ^~~~~~~~~~~
   drivers/misc/jesd204b/xilinx_jesd204b.c:34:26: note: in expansion of macro 'container_of'
    #define to_clk_priv(_hw) container_of(_hw, struct child_clk, hw)
                             ^~~~~~~~~~~~
   drivers/misc/jesd204b/xilinx_jesd204b.c:214:2: note: in expansion of macro 'to_clk_priv'
     to_clk_priv(hw)->enabled = true;
     ^~~~~~~~~~~
   drivers/misc/jesd204b/xilinx_jesd204b.c: At top level:
   drivers/misc/jesd204b/xilinx_jesd204b.c:229:21: error: variable 'clkout_ops' has initializer but incomplete type
    static const struct clk_ops clkout_ops = {
                        ^~~~~~~
   drivers/misc/jesd204b/xilinx_jesd204b.c:230:3: error: 'const struct clk_ops' has no member named 'recalc_rate'
     .recalc_rate = jesd204b_clk_recalc_rate,
      ^~~~~~~~~~~
   drivers/misc/jesd204b/xilinx_jesd204b.c:230:17: warning: excess elements in struct initializer
     .recalc_rate = jesd204b_clk_recalc_rate,
                    ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/jesd204b/xilinx_jesd204b.c:230:17: note: (near initialization for 'clkout_ops')
   drivers/misc/jesd204b/xilinx_jesd204b.c:231:3: error: 'const struct clk_ops' has no member named 'enable'
     .enable = jesd204b_clk_enable,
      ^~~~~~
   drivers/misc/jesd204b/xilinx_jesd204b.c:231:12: warning: excess elements in struct initializer
     .enable = jesd204b_clk_enable,
               ^~~~~~~~~~~~~~~~~~~
   drivers/misc/jesd204b/xilinx_jesd204b.c:231:12: note: (near initialization for 'clkout_ops')
   drivers/misc/jesd204b/xilinx_jesd204b.c:232:3: error: 'const struct clk_ops' has no member named 'disable'
     .disable = jesd204b_clk_disable,
      ^~~~~~~
   drivers/misc/jesd204b/xilinx_jesd204b.c:232:13: warning: excess elements in struct initializer
     .disable = jesd204b_clk_disable,
                ^~~~~~~~~~~~~~~~~~~~
   drivers/misc/jesd204b/xilinx_jesd204b.c:232:13: note: (near initialization for 'clkout_ops')
   drivers/misc/jesd204b/xilinx_jesd204b.c:233:3: error: 'const struct clk_ops' has no member named 'is_enabled'
     .is_enabled = jesd204b_clk_is_enabled,
      ^~~~~~~~~~
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
--
   drivers/misc//jesd204b/xilinx_jesd204b.c:28:17: error: field 'hw' has incomplete type
     struct clk_hw  hw;
                    ^~
   In file included from include/linux/err.h:5:0,
                    from include/linux/clk.h:15,
                    from drivers/misc//jesd204b/xilinx_jesd204b.c:11:
   drivers/misc//jesd204b/xilinx_jesd204b.c: In function 'jesd204b_clk_enable':
>> include/linux/kernel.h:929:32: error: dereferencing pointer to incomplete type 'struct clk_hw'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                                   ^~~~~~
   include/linux/compiler.h:554:19: note: in definition of macro '__compiletime_assert'
      bool __cond = !(condition);    \
                      ^~~~~~~~~
   include/linux/compiler.h:577:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:47:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:929:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
     ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:929:20: note: in expansion of macro '__same_type'
     BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
                       ^~~~~~~~~~~
   drivers/misc//jesd204b/xilinx_jesd204b.c:34:26: note: in expansion of macro 'container_of'
    #define to_clk_priv(_hw) container_of(_hw, struct child_clk, hw)
                             ^~~~~~~~~~~~
   drivers/misc//jesd204b/xilinx_jesd204b.c:214:2: note: in expansion of macro 'to_clk_priv'
     to_clk_priv(hw)->enabled = true;
     ^~~~~~~~~~~
   drivers/misc//jesd204b/xilinx_jesd204b.c: At top level:
   drivers/misc//jesd204b/xilinx_jesd204b.c:229:21: error: variable 'clkout_ops' has initializer but incomplete type
    static const struct clk_ops clkout_ops = {
                        ^~~~~~~
   drivers/misc//jesd204b/xilinx_jesd204b.c:230:3: error: 'const struct clk_ops' has no member named 'recalc_rate'
     .recalc_rate = jesd204b_clk_recalc_rate,
      ^~~~~~~~~~~
   drivers/misc//jesd204b/xilinx_jesd204b.c:230:17: warning: excess elements in struct initializer
     .recalc_rate = jesd204b_clk_recalc_rate,
                    ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc//jesd204b/xilinx_jesd204b.c:230:17: note: (near initialization for 'clkout_ops')
   drivers/misc//jesd204b/xilinx_jesd204b.c:231:3: error: 'const struct clk_ops' has no member named 'enable'
     .enable = jesd204b_clk_enable,
      ^~~~~~
   drivers/misc//jesd204b/xilinx_jesd204b.c:231:12: warning: excess elements in struct initializer
     .enable = jesd204b_clk_enable,
               ^~~~~~~~~~~~~~~~~~~
   drivers/misc//jesd204b/xilinx_jesd204b.c:231:12: note: (near initialization for 'clkout_ops')
   drivers/misc//jesd204b/xilinx_jesd204b.c:232:3: error: 'const struct clk_ops' has no member named 'disable'
     .disable = jesd204b_clk_disable,
      ^~~~~~~
   drivers/misc//jesd204b/xilinx_jesd204b.c:232:13: warning: excess elements in struct initializer
     .disable = jesd204b_clk_disable,
                ^~~~~~~~~~~~~~~~~~~~
   drivers/misc//jesd204b/xilinx_jesd204b.c:232:13: note: (near initialization for 'clkout_ops')
   drivers/misc//jesd204b/xilinx_jesd204b.c:233:3: error: 'const struct clk_ops' has no member named 'is_enabled'
     .is_enabled = jesd204b_clk_is_enabled,
      ^~~~~~~~~~
   drivers/misc//jesd204b/xilinx_jesd204b.c:233:16: warning: excess elements in struct initializer
     .is_enabled = jesd204b_clk_is_enabled,
                   ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc//jesd204b/xilinx_jesd204b.c:233:16: note: (near initialization for 'clkout_ops')
   drivers/misc//jesd204b/xilinx_jesd204b.c: In function 'jesd204b_probe':
   drivers/misc//jesd204b/xilinx_jesd204b.c:251:23: error: storage size of 'init' isn't known
     struct clk_init_data init;
                          ^~~~
   drivers/misc//jesd204b/xilinx_jesd204b.c:251:23: warning: unused variable 'init' [-Wunused-variable]
   drivers/misc//jesd204b/xilinx_jesd204b.c: At top level:
   drivers/misc//jesd204b/xilinx_jesd204b.c:229:29: error: storage size of 'clkout_ops' isn't known
    static const struct clk_ops clkout_ops = {
                                ^~~~~~~~~~

vim +929 include/linux/kernel.h

^1da177e4 Linus Torvalds 2005-04-16  910  
91f68b735 Wu Fengguang   2009-01-07  911  
e8c97af0c Randy Dunlap   2017-10-13  912  /**
e8c97af0c Randy Dunlap   2017-10-13  913   * swap - swap values of @a and @b
e8c97af0c Randy Dunlap   2017-10-13  914   * @a: first value
e8c97af0c Randy Dunlap   2017-10-13  915   * @b: second value
91f68b735 Wu Fengguang   2009-01-07  916   */
ac7b90049 Peter Zijlstra 2009-02-04  917  #define swap(a, b) \
ac7b90049 Peter Zijlstra 2009-02-04  918  	do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
91f68b735 Wu Fengguang   2009-01-07  919  
^1da177e4 Linus Torvalds 2005-04-16  920  /**
^1da177e4 Linus Torvalds 2005-04-16  921   * container_of - cast a member of a structure out to the containing structure
^1da177e4 Linus Torvalds 2005-04-16  922   * @ptr:	the pointer to the member.
^1da177e4 Linus Torvalds 2005-04-16  923   * @type:	the type of the container struct this is embedded in.
^1da177e4 Linus Torvalds 2005-04-16  924   * @member:	the name of the member within the struct.
^1da177e4 Linus Torvalds 2005-04-16  925   *
^1da177e4 Linus Torvalds 2005-04-16  926   */
^1da177e4 Linus Torvalds 2005-04-16  927  #define container_of(ptr, type, member) ({				\
c7acec713 Ian Abbott     2017-07-12  928  	void *__mptr = (void *)(ptr);					\
c7acec713 Ian Abbott     2017-07-12 @929  	BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&	\
c7acec713 Ian Abbott     2017-07-12  930  			 !__same_type(*(ptr), void),			\
c7acec713 Ian Abbott     2017-07-12  931  			 "pointer type mismatch in container_of()");	\
c7acec713 Ian Abbott     2017-07-12  932  	((type *)(__mptr - offsetof(type, member))); })
^1da177e4 Linus Torvalds 2005-04-16  933  

:::::: The code at line 929 was first introduced by commit
:::::: c7acec713d14c6ce8a20154f9dfda258d6bcad3b kernel.h: handle pointers to arrays better in container_of()

:::::: TO: Ian Abbott <abbotti@mev.co.uk>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 49051 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180317/5f80e652/attachment-0001.gz>

From: lkp@intel.com (kbuild test robot)
Date: Sat, 24 Nov 2018 07:49:34 +0800
Subject: [xlnx:xlnx_rebase_v4.14 1151/1439]
 drivers/soc/xilinx/xlnx_vcu_clk.c:264:8: error: implicit declaration of
 function 'clk_readl'; did you mean 'clk_enable'?
Message-ID: <201811240731.KJ5cT6Rf%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx xlnx_rebase_v4.14
head:   eeab73d1207d6fc2082776c954eb19fd7290bfbe
commit: 75f3a107776efa327c6354bdd41509f0b28f5fa1 [1151/1439] soc: xilinx: Use CCF to use clocks
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 75f3a107776efa327c6354bdd41509f0b28f5fa1
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=ia64 

All errors (new ones prefixed by >>):

   drivers/soc/xilinx/xlnx_vcu_clk.c:122:16: error: field 'hw' has incomplete type
     struct clk_hw hw;
                   ^~
   drivers/soc/xilinx/xlnx_vcu_clk.c:245:18: warning: 'struct clk_div_table' declared inside parameter list will not be visible outside of this definition or declaration
        const struct clk_div_table *table, u8 width,
                     ^~~~~~~~~~~~~
   drivers/soc/xilinx/xlnx_vcu_clk.c: In function 'xvcu_divider_get_val':
   drivers/soc/xilinx/xlnx_vcu_clk.c:250:14: error: 'CLK_DIVIDER_ROUND_CLOSEST' undeclared (first use in this function); did you mean 'DIV_ROUND_CLOSEST'?
     if (flags & CLK_DIVIDER_ROUND_CLOSEST)
                 ^~~~~~~~~~~~~~~~~~~~~~~~~
                 DIV_ROUND_CLOSEST
   drivers/soc/xilinx/xlnx_vcu_clk.c:250:14: note: each undeclared identifier is reported only once for each function it appears in
   drivers/soc/xilinx/xlnx_vcu_clk.c: In function 'xvcu_divider_recalc_rate':
   drivers/soc/xilinx/xlnx_vcu_clk.c:261:32: error: implicit declaration of function 'to_clk_divider'; did you mean 'module_driver'? [-Werror=implicit-function-declaration]
     struct clk_divider *divider = to_clk_divider(hw);
                                   ^~~~~~~~~~~~~~
                                   module_driver
   drivers/soc/xilinx/xlnx_vcu_clk.c:261:32: warning: initialization of 'struct clk_divider *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>> drivers/soc/xilinx/xlnx_vcu_clk.c:264:8: error: implicit declaration of function 'clk_readl'; did you mean 'clk_enable'? [-Werror=implicit-function-declaration]
     val = clk_readl(divider->reg) >> divider->shift;
           ^~~~~~~~~
           clk_enable
   drivers/soc/xilinx/xlnx_vcu_clk.c:264:25: error: dereferencing pointer to incomplete type 'struct clk_divider'
     val = clk_readl(divider->reg) >> divider->shift;
                            ^~
   drivers/soc/xilinx/xlnx_vcu_clk.c:267:9: error: implicit declaration of function 'divider_recalc_rate'; did you mean 'xvcu_divider_recalc_rate'? [-Werror=implicit-function-declaration]
     return divider_recalc_rate(hw, parent_rate, val, divider->table,
            ^~~~~~~~~~~~~~~~~~~
            xvcu_divider_recalc_rate
   drivers/soc/xilinx/xlnx_vcu_clk.c: In function 'xvcu_divider_round_rate':
   drivers/soc/xilinx/xlnx_vcu_clk.c:274:32: warning: initialization of 'struct clk_divider *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     struct clk_divider *divider = to_clk_divider(hw);
                                   ^~~~~~~~~~~~~~
   drivers/soc/xilinx/xlnx_vcu_clk.c:277:54: error: dereferencing pointer to incomplete type 'struct clk_divider'
     bestdiv = xvcu_divider_get_val(rate, *prate, divider->table,
                                                         ^~
   drivers/soc/xilinx/xlnx_vcu_clk.c: In function 'xvcu_divider_set_rate':
   drivers/soc/xilinx/xlnx_vcu_clk.c:288:32: warning: initialization of 'struct clk_divider *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     struct clk_divider *divider = to_clk_divider(hw);
                                   ^~~~~~~~~~~~~~
   drivers/soc/xilinx/xlnx_vcu_clk.c:292:57: error: dereferencing pointer to incomplete type 'struct clk_divider'
     value = xvcu_divider_get_val(rate, parent_rate, divider->table,
                                                            ^~
>> drivers/soc/xilinx/xlnx_vcu_clk.c:300:2: error: implicit declaration of function 'clk_writel'; did you mean 'up_write'? [-Werror=implicit-function-declaration]
     clk_writel(val, divider->reg);
     ^~~~~~~~~~
     up_write
   drivers/soc/xilinx/xlnx_vcu_clk.c: At top level:
   drivers/soc/xilinx/xlnx_vcu_clk.c:305:21: error: variable 'xvcu_divider_ops' has initializer but incomplete type
    static const struct clk_ops xvcu_divider_ops = {
                        ^~~~~~~
   drivers/soc/xilinx/xlnx_vcu_clk.c:306:3: error: 'const struct clk_ops' has no member named 'recalc_rate'
     .recalc_rate = xvcu_divider_recalc_rate,
      ^~~~~~~~~~~
   drivers/soc/xilinx/xlnx_vcu_clk.c:306:17: warning: excess elements in struct initializer
     .recalc_rate = xvcu_divider_recalc_rate,
                    ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/soc/xilinx/xlnx_vcu_clk.c:306:17: note: (near initialization for 'xvcu_divider_ops')
   drivers/soc/xilinx/xlnx_vcu_clk.c:307:3: error: 'const struct clk_ops' has no member named 'round_rate'
     .round_rate = xvcu_divider_round_rate,
      ^~~~~~~~~~
   drivers/soc/xilinx/xlnx_vcu_clk.c:307:16: warning: excess elements in struct initializer
     .round_rate = xvcu_divider_round_rate,
                   ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/soc/xilinx/xlnx_vcu_clk.c:307:16: note: (near initialization for 'xvcu_divider_ops')
   drivers/soc/xilinx/xlnx_vcu_clk.c:308:3: error: 'const struct clk_ops' has no member named 'set_rate'
     .set_rate = xvcu_divider_set_rate,
      ^~~~~~~~
   drivers/soc/xilinx/xlnx_vcu_clk.c:308:14: warning: excess elements in struct initializer
     .set_rate = xvcu_divider_set_rate,
                 ^~~~~~~~~~~~~~~~~~~~~
   drivers/soc/xilinx/xlnx_vcu_clk.c:308:14: note: (near initialization for 'xvcu_divider_ops')
   drivers/soc/xilinx/xlnx_vcu_clk.c: In function 'xvcu_register_divider':
   drivers/soc/xilinx/xlnx_vcu_clk.c:337:23: error: storage size of 'init' isn't known
     struct clk_init_data init;
                          ^~~~
   drivers/soc/xilinx/xlnx_vcu_clk.c:341:23: error: dereferencing pointer to incomplete type 'struct clk_divider'
     div = kzalloc(sizeof(*div), GFP_KERNEL);
                          ^~~~
   drivers/soc/xilinx/xlnx_vcu_clk.c:347:23: error: 'CLK_IS_BASIC' undeclared (first use in this function); did you mean 'CLOCKS_MASK'?
     init.flags = flags | CLK_IS_BASIC;
                          ^~~~~~~~~~~~
                          CLOCKS_MASK
   drivers/soc/xilinx/xlnx_vcu_clk.c:361:8: error: implicit declaration of function 'clk_hw_register'; did you mean 'class_register'? [-Werror=implicit-function-declaration]
     ret = clk_hw_register(dev, hw);
           ^~~~~~~~~~~~~~~
           class_register
   drivers/soc/xilinx/xlnx_vcu_clk.c:337:23: warning: unused variable 'init' [-Wunused-variable]
     struct clk_init_data init;
                          ^~~~
   In file included from include/linux/err.h:5,
                    from include/linux/clk.h:15,
                    from drivers/soc/xilinx/xlnx_vcu_clk.c:11:
   drivers/soc/xilinx/xlnx_vcu_clk.c: In function 'xvcu_pll_is_enabled':
   include/linux/kernel.h:929:32: error: dereferencing pointer to incomplete type 'struct clk_hw'
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
   drivers/soc/xilinx/xlnx_vcu_clk.c:82:25: note: in expansion of macro 'container_of'
    #define to_vcu_pll(_hw) container_of(_hw, struct vcu_pll, hw)
                            ^~~~~~~~~~~~
   drivers/soc/xilinx/xlnx_vcu_clk.c:454:24: note: in expansion of macro 'to_vcu_pll'
     struct vcu_pll *pll = to_vcu_pll(hw);
                           ^~~~~~~~~~
   drivers/soc/xilinx/xlnx_vcu_clk.c: At top level:
   drivers/soc/xilinx/xlnx_vcu_clk.c:649:21: error: variable 'vcu_pll_ops' has initializer but incomplete type
    static const struct clk_ops vcu_pll_ops = {
                        ^~~~~~~
   drivers/soc/xilinx/xlnx_vcu_clk.c:650:3: error: 'const struct clk_ops' has no member named 'enable'
     .enable = xvcu_pll_enable,
      ^~~~~~
   drivers/soc/xilinx/xlnx_vcu_clk.c:650:12: warning: excess elements in struct initializer
     .enable = xvcu_pll_enable,
               ^~~~~~~~~~~~~~~
   drivers/soc/xilinx/xlnx_vcu_clk.c:650:12: note: (near initialization for 'vcu_pll_ops')
   drivers/soc/xilinx/xlnx_vcu_clk.c:651:3: error: 'const struct clk_ops' has no member named 'disable'
     .disable = xvcu_pll_disable,
      ^~~~~~~
   drivers/soc/xilinx/xlnx_vcu_clk.c:651:13: warning: excess elements in struct initializer
     .disable = xvcu_pll_disable,
                ^~~~~~~~~~~~~~~~
   drivers/soc/xilinx/xlnx_vcu_clk.c:651:13: note: (near initialization for 'vcu_pll_ops')
   drivers/soc/xilinx/xlnx_vcu_clk.c:652:3: error: 'const struct clk_ops' has no member named 'is_enabled'
     .is_enabled = xvcu_pll_is_enabled,
      ^~~~~~~~~~
   drivers/soc/xilinx/xlnx_vcu_clk.c:652:16: warning: excess elements in struct initializer
     .is_enabled = xvcu_pll_is_enabled,
                   ^~~~~~~~~~~~~~~~~~~
   drivers/soc/xilinx/xlnx_vcu_clk.c:652:16: note: (near initialization for 'vcu_pll_ops')
   drivers/soc/xilinx/xlnx_vcu_clk.c:653:3: error: 'const struct clk_ops' has no member named 'round_rate'
     .round_rate = vcu_pll_round_rate,
      ^~~~~~~~~~
   drivers/soc/xilinx/xlnx_vcu_clk.c:653:16: warning: excess elements in struct initializer
     .round_rate = vcu_pll_round_rate,
                   ^~~~~~~~~~~~~~~~~~
   drivers/soc/xilinx/xlnx_vcu_clk.c:653:16: note: (near initialization for 'vcu_pll_ops')
   drivers/soc/xilinx/xlnx_vcu_clk.c:654:3: error: 'const struct clk_ops' has no member named 'recalc_rate'
     .recalc_rate = vcu_pll_recalc_rate,
      ^~~~~~~~~~~
   drivers/soc/xilinx/xlnx_vcu_clk.c:654:17: warning: excess elements in struct initializer
     .recalc_rate = vcu_pll_recalc_rate,
                    ^~~~~~~~~~~~~~~~~~~
   drivers/soc/xilinx/xlnx_vcu_clk.c:654:17: note: (near initialization for 'vcu_pll_ops')
   drivers/soc/xilinx/xlnx_vcu_clk.c:655:3: error: 'const struct clk_ops' has no member named 'set_rate'
     .set_rate = vcu_pll_set_rate,
      ^~~~~~~~
   drivers/soc/xilinx/xlnx_vcu_clk.c:655:14: warning: excess elements in struct initializer
     .set_rate = vcu_pll_set_rate,
                 ^~~~~~~~~~~~~~~~
   drivers/soc/xilinx/xlnx_vcu_clk.c:655:14: note: (near initialization for 'vcu_pll_ops')
   drivers/soc/xilinx/xlnx_vcu_clk.c: In function 'xvcu_register_pll':
   drivers/soc/xilinx/xlnx_vcu_clk.c:677:23: error: storage size of 'init' isn't known
     struct clk_init_data init;
                          ^~~~
   drivers/soc/xilinx/xlnx_vcu_clk.c:697:8: error: implicit declaration of function 'devm_clk_hw_register'; did you mean 'device_unregister'? [-Werror=implicit-function-declaration]
     ret = devm_clk_hw_register(dev, hw);
           ^~~~~~~~~~~~~~~~~~~~
           device_unregister
   drivers/soc/xilinx/xlnx_vcu_clk.c:701:2: error: implicit declaration of function 'clk_hw_set_rate_range'; did you mean 'walk_system_ram_range'? [-Werror=implicit-function-declaration]
     clk_hw_set_rate_range(hw, FVCO_MIN, FVCO_MAX);
     ^~~~~~~~~~~~~~~~~~~~~
     walk_system_ram_range
   drivers/soc/xilinx/xlnx_vcu_clk.c:677:23: warning: unused variable 'init' [-Wunused-variable]
     struct clk_init_data init;
                          ^~~~
   drivers/soc/xilinx/xlnx_vcu_clk.c: In function 'register_vcu_leaf_clocks':
   drivers/soc/xilinx/xlnx_vcu_clk.c:736:7: error: implicit declaration of function 'clk_hw_register_mux'; did you mean 'class_register'? [-Werror=implicit-function-declaration]
     hw = clk_hw_register_mux(dev, clk_mux, parents, nparents,
          ^~~~~~~~~~~~~~~~~~~
          class_register
   drivers/soc/xilinx/xlnx_vcu_clk.c:737:6: error: 'CLK_SET_RATE_PARENT' undeclared (first use in this function); did you mean 'DL_STATE_DORMANT'?
         CLK_SET_RATE_PARENT | CLK_IS_BASIC |
         ^~~~~~~~~~~~~~~~~~~
         DL_STATE_DORMANT
   drivers/soc/xilinx/xlnx_vcu_clk.c:737:28: error: 'CLK_IS_BASIC' undeclared (first use in this function); did you mean 'CLOCKS_MASK'?
         CLK_SET_RATE_PARENT | CLK_IS_BASIC |
                               ^~~~~~~~~~~~
                               CLOCKS_MASK
   drivers/soc/xilinx/xlnx_vcu_clk.c:738:6: error: 'CLK_SET_RATE_NO_REPARENT' undeclared (first use in this function); did you mean 'DL_STATE_DORMANT'?
         CLK_SET_RATE_NO_REPARENT,
         ^~~~~~~~~~~~~~~~~~~~~~~~
         DL_STATE_DORMANT
   drivers/soc/xilinx/xlnx_vcu_clk.c:749:10: error: 'CLK_DIVIDER_ONE_BASED' undeclared (first use in this function)
             CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO |
             ^~~~~~~~~~~~~~~~~~~~~
>> drivers/soc/xilinx/xlnx_vcu_clk.c:749:34: error: 'CLK_DIVIDER_ALLOW_ZERO' undeclared (first use in this function)
             CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO |
                                     ^~~~~~~~~~~~~~~~~~~~~~
   drivers/soc/xilinx/xlnx_vcu_clk.c:750:10: error: 'CLK_DIVIDER_ROUND_CLOSEST' undeclared (first use in this function); did you mean 'DIV_ROUND_CLOSEST'?
             CLK_DIVIDER_ROUND_CLOSEST,
             ^~~~~~~~~~~~~~~~~~~~~~~~~
             DIV_ROUND_CLOSEST
   drivers/soc/xilinx/xlnx_vcu_clk.c:753:9: error: implicit declaration of function 'clk_hw_register_gate'; did you mean 'class_register'? [-Werror=implicit-function-declaration]
     return clk_hw_register_gate(dev, name, clk_div,
            ^~~~~~~~~~~~~~~~~~~~
            class_register
   drivers/soc/xilinx/xlnx_vcu_clk.c: In function 'unregister_vcu_leaf_clocks':
   drivers/soc/xilinx/xlnx_vcu_clk.c:771:11: error: implicit declaration of function 'clk_hw_get_parent'; did you mean 'clk_get_parent'? [-Werror=implicit-function-declaration]
     parent = clk_hw_get_parent(hw);
              ^~~~~~~~~~~~~~~~~
              clk_get_parent
   drivers/soc/xilinx/xlnx_vcu_clk.c:771:9: warning: assignment to 'struct clk_hw *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     parent = clk_hw_get_parent(hw);
            ^
   drivers/soc/xilinx/xlnx_vcu_clk.c:772:2: error: implicit declaration of function 'clk_hw_unregister_gate'; did you mean 'class_unregister'? [-Werror=implicit-function-declaration]
     clk_hw_unregister_gate(hw);
     ^~~~~~~~~~~~~~~~~~~~~~
     class_unregister
   drivers/soc/xilinx/xlnx_vcu_clk.c:775:9: warning: assignment to 'struct clk_hw *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     parent = clk_hw_get_parent(hw);
            ^
   drivers/soc/xilinx/xlnx_vcu_clk.c:776:2: error: implicit declaration of function 'clk_hw_unregister_divider'; did you mean 'xvcu_register_divider'? [-Werror=implicit-function-declaration]
     clk_hw_unregister_divider(hw);
     ^~~~~~~~~~~~~~~~~~~~~~~~~
     xvcu_register_divider
   drivers/soc/xilinx/xlnx_vcu_clk.c:779:2: error: implicit declaration of function 'clk_hw_unregister_mux'; did you mean 'class_unregister'? [-Werror=implicit-function-declaration]
     clk_hw_unregister_mux(hw);
     ^~~~~~~~~~~~~~~~~~~~~
     class_unregister
   drivers/soc/xilinx/xlnx_vcu_clk.c: In function 'xvcu_clock_init':
   drivers/soc/xilinx/xlnx_vcu_clk.c:805:42: error: dereferencing pointer to incomplete type 'struct clk_hw_onecell_data'
     vcu_clk_data = devm_kzalloc(dev, sizeof(*vcu_clk_data) +
                                             ^~~~~~~~~~~~~
   drivers/soc/xilinx/xlnx_vcu_clk.c:811:11: error: implicit declaration of function '__clk_get_name'; did you mean 'clk_get_rate'? [-Werror=implicit-function-declaration]
     parent = __clk_get_name(ref_clk);
              ^~~~~~~~~~~~~~
              clk_get_rate
   drivers/soc/xilinx/xlnx_vcu_clk.c:811:9: warning: assignment to 'const char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     parent = __clk_get_name(ref_clk);
            ^
   drivers/soc/xilinx/xlnx_vcu_clk.c:813:11: error: 'CLK_SET_RATE_NO_REPARENT' undeclared (first use in this function); did you mean 'DL_STATE_DORMANT'?
              CLK_SET_RATE_NO_REPARENT);
              ^~~~~~~~~~~~~~~~~~~~~~~~
              DL_STATE_DORMANT
   drivers/soc/xilinx/xlnx_vcu_clk.c:832:3: error: implicit declaration of function 'clk_hw_register_fixed_factor' [-Werror=implicit-function-declaration]
      clk_hw_register_fixed_factor(dev, "vcu_pll_half", "vcu_pll",
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/soc/xilinx/xlnx_vcu_clk.c:834:11: error: 'CLK_SET_RATE_PARENT' undeclared (first use in this function); did you mean 'DL_STATE_DORMANT'?
              CLK_SET_RATE_PARENT,
              ^~~~~~~~~~~~~~~~~~~
              DL_STATE_DORMANT
   drivers/soc/xilinx/xlnx_vcu_clk.c:870:9: error: implicit declaration of function 'of_clk_add_hw_provider'; did you mean 'of_clk_get_from_provider'? [-Werror=implicit-function-declaration]
     return of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
            ^~~~~~~~~~~~~~~~~~~~~~
            of_clk_get_from_provider
   drivers/soc/xilinx/xlnx_vcu_clk.c:870:46: error: 'of_clk_hw_onecell_get' undeclared (first use in this function); did you mean 'clk_hw_onecell_data'?
     return of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
                                                 ^~~~~~~~~~~~~~~~~~~~~
                                                 clk_hw_onecell_data
   drivers/soc/xilinx/xlnx_vcu_clk.c: In function 'xvcu_clk_remove':
   drivers/soc/xilinx/xlnx_vcu_clk.c:894:2: error: implicit declaration of function 'clk_hw_unregister'; did you mean 'class_unregister'? [-Werror=implicit-function-declaration]
     clk_hw_unregister(vcu_clk_data->hws[vcu_pll_half]);
     ^~~~~~~~~~~~~~~~~
     class_unregister
   drivers/soc/xilinx/xlnx_vcu_clk.c:895:2: error: implicit declaration of function 'of_clk_del_provider'; did you mean 'of_clk_get_from_provider'? [-Werror=implicit-function-declaration]
     of_clk_del_provider(pdev->dev.parent->of_node);
     ^~~~~~~~~~~~~~~~~~~
     of_clk_get_from_provider
   drivers/soc/xilinx/xlnx_vcu_clk.c: At top level:
   drivers/soc/xilinx/xlnx_vcu_clk.c:305:29: error: storage size of 'xvcu_divider_ops' isn't known
    static const struct clk_ops xvcu_divider_ops = {
                                ^~~~~~~~~~~~~~~~
   drivers/soc/xilinx/xlnx_vcu_clk.c:649:29: error: storage size of 'vcu_pll_ops' isn't known
    static const struct clk_ops vcu_pll_ops = {
                                ^~~~~~~~~~~
   drivers/soc/xilinx/xlnx_vcu_clk.c: In function 'xvcu_clock_init':
   drivers/soc/xilinx/xlnx_vcu_clk.c:872:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^
   cc1: some warnings being treated as errors

vim +264 drivers/soc/xilinx/xlnx_vcu_clk.c

   243	
   244	static int xvcu_divider_get_val(unsigned long rate, unsigned long parent_rate,
   245					const struct clk_div_table *table, u8 width,
   246					unsigned long flags)
   247	{
   248		unsigned int div;
   249	
 > 250		if (flags & CLK_DIVIDER_ROUND_CLOSEST)
   251			div = DIV_ROUND_CLOSEST_ULL((u64)parent_rate, rate);
   252		else
   253			div = DIV_ROUND_UP_ULL((u64)parent_rate, rate);
   254	
   255		return min_t(unsigned int, div, div_mask(width));
   256	}
   257	
   258	static unsigned long xvcu_divider_recalc_rate(struct clk_hw *hw,
   259						      unsigned long parent_rate)
   260	{
   261		struct clk_divider *divider = to_clk_divider(hw);
   262		unsigned int val;
   263	
 > 264		val = clk_readl(divider->reg) >> divider->shift;
   265		val &= div_mask(divider->width);
   266	
   267		return divider_recalc_rate(hw, parent_rate, val, divider->table,
   268					   divider->flags);
   269	}
   270	
   271	static long xvcu_divider_round_rate(struct clk_hw *hw, unsigned long rate,
   272					    unsigned long *prate)
   273	{
   274		struct clk_divider *divider = to_clk_divider(hw);
   275		int bestdiv;
   276	
   277		bestdiv = xvcu_divider_get_val(rate, *prate, divider->table,
   278					       divider->width, divider->flags);
   279	
   280		*prate = rate * bestdiv;
   281	
   282		return rate;
   283	}
   284	
   285	static int xvcu_divider_set_rate(struct clk_hw *hw, unsigned long rate,
   286					 unsigned long parent_rate)
   287	{
 > 288		struct clk_divider *divider = to_clk_divider(hw);
   289		int value;
   290		u32 val;
   291	
   292		value = xvcu_divider_get_val(rate, parent_rate, divider->table,
   293					     divider->width, divider->flags);
   294		if (value < 0)
   295			return value;
   296	
   297		val = clk_readl(divider->reg);
   298		val &= ~(div_mask(divider->width) << divider->shift);
   299		val |= (u32)value << divider->shift;
 > 300		clk_writel(val, divider->reg);
   301	
   302		return 0;
   303	}
   304	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 49122 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181124/7e35c19c/attachment-0001.gz>

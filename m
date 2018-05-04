From: lkp@intel.com (kbuild test robot)
Date: Fri, 4 May 2018 10:22:21 +0800
Subject: [PATCH 3/3] spi: meson-axg: add a linear clock divider support
In-Reply-To: <20180503213645.20694-4-yixun.lan@amlogic.com>
References: <20180503213645.20694-4-yixun.lan@amlogic.com>
Message-ID: <201805041028.gcPs4iEb%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sunny,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v4.17-rc3]
[also build test ERROR on next-20180503]
[cannot apply to spi/for-next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Yixun-Lan/spi-meson-axg-add-few-enhanced-features/20180504-083512
config: sparc64-allmodconfig (attached as .config)
compiler: sparc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sparc64 

All error/warnings (new ones prefixed by >>):

>> drivers//spi/spi-meson-spicc.c:517:15: error: variable 'meson_spicc_div0' has initializer but incomplete type
    static struct clk_fixed_factor meson_spicc_div0 = {
                  ^~~~~~~~~~~~~~~~
>> drivers//spi/spi-meson-spicc.c:518:3: error: 'struct clk_fixed_factor' has no member named 'mult'
     .mult = 1,
      ^~~~
>> drivers//spi/spi-meson-spicc.c:518:10: warning: excess elements in struct initializer
     .mult = 1,
             ^
   drivers//spi/spi-meson-spicc.c:518:10: note: (near initialization for 'meson_spicc_div0')
>> drivers//spi/spi-meson-spicc.c:519:3: error: 'struct clk_fixed_factor' has no member named 'div'
     .div = 4,
      ^~~
   drivers//spi/spi-meson-spicc.c:519:9: warning: excess elements in struct initializer
     .div = 4,
            ^
   drivers//spi/spi-meson-spicc.c:519:9: note: (near initialization for 'meson_spicc_div0')
>> drivers//spi/spi-meson-spicc.c:522:15: error: variable 'meson_spicc_div1' has initializer but incomplete type
    static struct clk_divider meson_spicc_div1 = {
                  ^~~~~~~~~~~
>> drivers//spi/spi-meson-spicc.c:523:3: error: 'struct clk_divider' has no member named 'reg'
     .reg = (void *) SPICC_CONREG,
      ^~~
   drivers//spi/spi-meson-spicc.c:523:9: warning: excess elements in struct initializer
     .reg = (void *) SPICC_CONREG,
            ^
   drivers//spi/spi-meson-spicc.c:523:9: note: (near initialization for 'meson_spicc_div1')
>> drivers//spi/spi-meson-spicc.c:524:3: error: 'struct clk_divider' has no member named 'shift'
     .shift = 16,
      ^~~~~
   drivers//spi/spi-meson-spicc.c:524:11: warning: excess elements in struct initializer
     .shift = 16,
              ^~
   drivers//spi/spi-meson-spicc.c:524:11: note: (near initialization for 'meson_spicc_div1')
>> drivers//spi/spi-meson-spicc.c:525:3: error: 'struct clk_divider' has no member named 'width'
     .width = 3,
      ^~~~~
   drivers//spi/spi-meson-spicc.c:525:11: warning: excess elements in struct initializer
     .width = 3,
              ^
   drivers//spi/spi-meson-spicc.c:525:11: note: (near initialization for 'meson_spicc_div1')
>> drivers//spi/spi-meson-spicc.c:526:3: error: 'struct clk_divider' has no member named 'flags'
     .flags = CLK_DIVIDER_POWER_OF_TWO,
      ^~~~~
>> drivers//spi/spi-meson-spicc.c:526:11: error: 'CLK_DIVIDER_POWER_OF_TWO' undeclared here (not in a function)
     .flags = CLK_DIVIDER_POWER_OF_TWO,
              ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers//spi/spi-meson-spicc.c:526:11: warning: excess elements in struct initializer
   drivers//spi/spi-meson-spicc.c:526:11: note: (near initialization for 'meson_spicc_div1')
>> drivers//spi/spi-meson-spicc.c:530:15: error: variable 'meson_spicc_div2' has initializer but incomplete type
    static struct clk_fixed_factor meson_spicc_div2 = {
                  ^~~~~~~~~~~~~~~~
   drivers//spi/spi-meson-spicc.c:531:3: error: 'struct clk_fixed_factor' has no member named 'mult'
     .mult = 1,
      ^~~~
   drivers//spi/spi-meson-spicc.c:531:10: warning: excess elements in struct initializer
     .mult = 1,
             ^
   drivers//spi/spi-meson-spicc.c:531:10: note: (near initialization for 'meson_spicc_div2')
   drivers//spi/spi-meson-spicc.c:532:3: error: 'struct clk_fixed_factor' has no member named 'div'
     .div = 2,
      ^~~
   drivers//spi/spi-meson-spicc.c:532:9: warning: excess elements in struct initializer
     .div = 2,
            ^
   drivers//spi/spi-meson-spicc.c:532:9: note: (near initialization for 'meson_spicc_div2')
>> drivers//spi/spi-meson-spicc.c:535:15: error: variable 'meson_spicc_div3' has initializer but incomplete type
    static struct clk_divider meson_spicc_div3 = {
                  ^~~~~~~~~~~
   drivers//spi/spi-meson-spicc.c:536:3: error: 'struct clk_divider' has no member named 'reg'
     .reg = (void *) SPICC_ENH_CTL0,
      ^~~
   drivers//spi/spi-meson-spicc.c:536:9: warning: excess elements in struct initializer
     .reg = (void *) SPICC_ENH_CTL0,
            ^
   drivers//spi/spi-meson-spicc.c:536:9: note: (near initialization for 'meson_spicc_div3')
   drivers//spi/spi-meson-spicc.c:537:3: error: 'struct clk_divider' has no member named 'shift'
     .shift = 16,
      ^~~~~
   drivers//spi/spi-meson-spicc.c:537:11: warning: excess elements in struct initializer
     .shift = 16,
              ^~
   drivers//spi/spi-meson-spicc.c:537:11: note: (near initialization for 'meson_spicc_div3')
   drivers//spi/spi-meson-spicc.c:538:3: error: 'struct clk_divider' has no member named 'width'
     .width = 8,
      ^~~~~
   drivers//spi/spi-meson-spicc.c:538:11: warning: excess elements in struct initializer
     .width = 8,
              ^
   drivers//spi/spi-meson-spicc.c:538:11: note: (near initialization for 'meson_spicc_div3')
>> drivers//spi/spi-meson-spicc.c:541:15: error: variable 'meson_spicc_sel' has initializer but incomplete type
    static struct clk_mux meson_spicc_sel = {
                  ^~~~~~~
>> drivers//spi/spi-meson-spicc.c:542:3: error: 'struct clk_mux' has no member named 'reg'
     .reg = (void *) SPICC_ENH_CTL0,
      ^~~
   drivers//spi/spi-meson-spicc.c:542:9: warning: excess elements in struct initializer
     .reg = (void *) SPICC_ENH_CTL0,
            ^
   drivers//spi/spi-meson-spicc.c:542:9: note: (near initialization for 'meson_spicc_sel')
>> drivers//spi/spi-meson-spicc.c:543:3: error: 'struct clk_mux' has no member named 'mask'
     .mask = 0x1,
      ^~~~
   drivers//spi/spi-meson-spicc.c:543:10: warning: excess elements in struct initializer
     .mask = 0x1,
             ^~~
   drivers//spi/spi-meson-spicc.c:543:10: note: (near initialization for 'meson_spicc_sel')
>> drivers//spi/spi-meson-spicc.c:544:3: error: 'struct clk_mux' has no member named 'shift'
     .shift = 24,
      ^~~~~
   drivers//spi/spi-meson-spicc.c:544:11: warning: excess elements in struct initializer
     .shift = 24,
              ^~
   drivers//spi/spi-meson-spicc.c:544:11: note: (near initialization for 'meson_spicc_sel')
   drivers//spi/spi-meson-spicc.c: In function 'meson_spicc_clk_init':
>> drivers//spi/spi-meson-spicc.c:553:23: error: storage size of 'init' isn't known
     struct clk_init_data init;
                          ^~~~
>> drivers//spi/spi-meson-spicc.c:562:14: error: 'clk_fixed_factor_ops' undeclared (first use in this function); did you mean 'clk_fixed_factor'?
     init.ops = &clk_fixed_factor_ops;
                 ^~~~~~~~~~~~~~~~~~~~
                 clk_fixed_factor
   drivers//spi/spi-meson-spicc.c:562:14: note: each undeclared identifier is reported only once for each function it appears in
>> drivers//spi/spi-meson-spicc.c:564:20: error: implicit declaration of function '__clk_get_name'; did you mean 'clk_get_rate'? [-Werror=implicit-function-declaration]
     parent_names[0] = __clk_get_name(spicc->core);
                       ^~~~~~~~~~~~~~
                       clk_get_rate
>> drivers//spi/spi-meson-spicc.c:564:18: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     parent_names[0] = __clk_get_name(spicc->core);
                     ^

vim +/meson_spicc_div0 +517 drivers//spi/spi-meson-spicc.c

   497	
   498	/*
   499	 * The Clock Mux
   500	 *            x-----------------x   x------------x    x------\
   501	 *        |---| 0) fixed factor |---| 1) old div |----|      |
   502	 *        |   x-----------------x   x------------x    |      |
   503	 * src ---|                                           |5) mux|-- out
   504	 *        |   x-----------------x   x------------x    |      |
   505	 *        |---| 2) fixed factor |---| 3) new div |0---|      |
   506	 *            x-----------------x   x------------x    x------/
   507	 *
   508	 * Clk path for GX series:
   509	 *    src -> 0 -> 1 -> out
   510	 *
   511	 * Clk path for AXG series:
   512	 *    src -> 0 -> 1 -> 5 -> out
   513	 *    src -> 2 -> 3 -> 5 -> out
   514	 */
   515	
   516	/* algorithm for div0 + div1: rate = freq / 4 / (2 ^ N) */
 > 517	static struct clk_fixed_factor meson_spicc_div0 = {
 > 518		.mult	= 1,
 > 519		.div	= 4,
   520	};
   521	
 > 522	static struct clk_divider meson_spicc_div1 = {
 > 523		.reg	= (void *) SPICC_CONREG,
 > 524		.shift	= 16,
 > 525		.width	= 3,
 > 526		.flags	= CLK_DIVIDER_POWER_OF_TWO,
   527	};
   528	
   529	/* algorithm for div2 + div3: rate = freq / 2 / (N + 1) */
 > 530	static struct clk_fixed_factor meson_spicc_div2 = {
 > 531		.mult	= 1,
   532		.div	= 2,
   533	};
   534	
 > 535	static struct clk_divider meson_spicc_div3 = {
   536		.reg	= (void *) SPICC_ENH_CTL0,
 > 537		.shift	= 16,
 > 538		.width	= 8,
   539	};
   540	
 > 541	static struct clk_mux meson_spicc_sel = {
 > 542		.reg	= (void *) SPICC_ENH_CTL0,
 > 543		.mask	= 0x1,
 > 544		.shift	= 24,
   545	};
   546	
   547	static int meson_spicc_clk_init(struct meson_spicc_device *spicc)
   548	{
   549		struct device *dev = &spicc->pdev->dev;
   550		struct clk_fixed_factor *div0;
   551		struct clk_divider *div1;
   552		struct clk_mux *mux;
 > 553		struct clk_init_data init;
   554		struct clk *clk;
   555		const char *parent_names[1];
   556		const char *mux_parent_names[2];
   557		char name[32];
   558	
   559		div0 = &meson_spicc_div0;
   560		snprintf(name, sizeof(name), "%s#_div0", dev_name(dev));
   561		init.name = name;
 > 562		init.ops = &clk_fixed_factor_ops;
   563		init.flags = 0;
 > 564		parent_names[0] = __clk_get_name(spicc->core);
   565		init.parent_names = parent_names;
   566		init.num_parents = 1;
   567	
 > 568		div0->hw.init = &init;
   569	
 > 570		clk = devm_clk_register(dev, &div0->hw);
   571		if (WARN_ON(IS_ERR(clk)))
   572			return PTR_ERR(clk);
   573	
   574		div1 = &meson_spicc_div1;
   575		snprintf(name, sizeof(name), "%s#_div1", dev_name(dev));
   576		init.name = name;
 > 577		init.ops = &clk_divider_ops;
 > 578		init.flags = CLK_SET_RATE_PARENT;
   579		parent_names[0] = __clk_get_name(clk);
   580		init.parent_names = parent_names;
   581		init.num_parents = 1;
   582	
 > 583		div1->reg = spicc->base + (u64) div1->reg;
   584		div1->hw.init = &init;
   585	
   586		clk = devm_clk_register(dev, &div1->hw);
   587		if (WARN_ON(IS_ERR(clk)))
   588			return PTR_ERR(clk);
   589	
   590		if (spicc->data->has_enhance_clk_div == false) {
   591			spicc->clk = clk;
   592			return 0;
   593		}
   594	
   595		mux_parent_names[0] = __clk_get_name(clk);
   596	
   597		div0 = &meson_spicc_div2;
   598		snprintf(name, sizeof(name), "%s#_div2", dev_name(dev));
   599		init.name = name;
   600		init.ops = &clk_fixed_factor_ops;
   601		init.flags = 0;
 > 602		parent_names[0] = __clk_get_name(spicc->core);
   603		init.parent_names = parent_names;
   604		init.num_parents = 1;
   605	
   606		div0->hw.init = &init;
   607	
   608		clk = devm_clk_register(dev, &div0->hw);
   609		if (WARN_ON(IS_ERR(clk)))
   610			return PTR_ERR(clk);
   611	
   612		div1 = &meson_spicc_div3;
   613		snprintf(name, sizeof(name), "%s#_div3", dev_name(dev));
   614		init.name = name;
   615		init.ops = &clk_divider_ops;
   616		init.flags = CLK_SET_RATE_PARENT;
   617		parent_names[0] = __clk_get_name(clk);
   618		init.parent_names = parent_names;
   619		init.num_parents = 1;
   620	
   621		div1->reg = spicc->base + (u64) div1->reg;
   622		div1->hw.init = &init;
   623	
   624		clk = devm_clk_register(dev, &div1->hw);
   625		if (WARN_ON(IS_ERR(clk)))
   626			return PTR_ERR(clk);
   627	
 > 628		mux_parent_names[1] = __clk_get_name(clk);
   629	
   630		mux = &meson_spicc_sel;
   631		snprintf(name, sizeof(name), "%s#_sel", dev_name(dev));
   632		init.name = name;
 > 633		init.ops = &clk_mux_ops;
   634		init.parent_names = mux_parent_names;
   635		init.num_parents = 2;
 > 636		init.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT;
   637	
 > 638		mux->reg = spicc->base + (u64) mux->reg;
   639		mux->hw.init = &init;
   640	
   641		spicc->clk = devm_clk_register(dev, &mux->hw);
   642		if (WARN_ON(IS_ERR(spicc->clk)))
   643			return PTR_ERR(spicc->clk);
   644	
   645		clk_set_parent(spicc->clk, clk);
   646		return 0;
   647	}
   648	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 53170 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180504/00b4c323/attachment-0001.gz>

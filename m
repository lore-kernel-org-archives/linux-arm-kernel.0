From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 15 Sep 2016 08:48:37 +0800
Subject: [clk:clk-next 19/25] drivers/clk/zte/clk-zx296718.c:554:35: warning:
 cast from pointer to integer of different size
Message-ID: <201609150835.X8m7MFub%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
head:   f5644f10dcfbab90ffd27da1d8d51ffc13e1bc84
commit: ca0233285a93222b2b0c7384b9345711b3d68b5c [19/25] clk: zx: register ZX296718 clocks
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout ca0233285a93222b2b0c7384b9345711b3d68b5c
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

   drivers/clk/zte/clk-zx296718.c: In function 'top_clocks_init':
>> drivers/clk/zte/clk-zx296718.c:554:35: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      zx296718_pll_clk[i].reg_base += (u64)reg_base;
                                      ^
   drivers/clk/zte/clk-zx296718.c:579:29: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      top_mux_clk[i].mux.reg += (u64)reg_base;
                                ^
   drivers/clk/zte/clk-zx296718.c:592:31: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      top_gate_clk[i].gate.reg += (u64)reg_base;
                                  ^
   drivers/clk/zte/clk-zx296718.c:605:29: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      top_div_clk[i].div.reg += (u64)reg_base;
                                ^
   drivers/clk/zte/clk-zx296718.c: In function 'lsp0_clocks_init':
   drivers/clk/zte/clk-zx296718.c:745:30: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      lsp0_mux_clk[i].mux.reg += (u64)reg_base;
                                 ^
   drivers/clk/zte/clk-zx296718.c:758:32: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      lsp0_gate_clk[i].gate.reg += (u64)reg_base;
                                   ^
   drivers/clk/zte/clk-zx296718.c:771:30: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      lsp0_div_clk[i].div.reg += (u64)reg_base;
                                 ^
   drivers/clk/zte/clk-zx296718.c: In function 'lsp1_clocks_init':
   drivers/clk/zte/clk-zx296718.c:850:30: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      lsp1_mux_clk[i].mux.reg += (u64)reg_base;
                                 ^
   drivers/clk/zte/clk-zx296718.c:863:32: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      lsp1_gate_clk[i].gate.reg += (u64)reg_base;
                                   ^
   drivers/clk/zte/clk-zx296718.c:876:30: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      lsp1_div_clk[i].div.reg += (u64)reg_base;
                                 ^

vim +554 drivers/clk/zte/clk-zx296718.c

   538			[TOP_NR_CLKS - 1] = NULL,
   539		},
   540	};
   541	
   542	static int __init top_clocks_init(struct device_node *np)
   543	{
   544		void __iomem *reg_base;
   545		int i, ret;
   546	
   547		reg_base = of_iomap(np, 0);
   548		if (!reg_base) {
   549			pr_err("%s: Unable to map clk base\n", __func__);
   550			return -ENXIO;
   551		}
   552	
   553		for (i = 0; i < ARRAY_SIZE(zx296718_pll_clk); i++) {
 > 554			zx296718_pll_clk[i].reg_base += (u64)reg_base;
   555			ret = clk_hw_register(NULL, &zx296718_pll_clk[i].hw);
   556			if (ret) {
   557				pr_warn("top clk %s init error!\n",
   558					zx296718_pll_clk[i].hw.init->name);
   559			}
   560		}
   561	
   562		for (i = 0; i < ARRAY_SIZE(top_ffactor_clk); i++) {

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 58522 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160915/1d2cc8ea/attachment-0001.obj>

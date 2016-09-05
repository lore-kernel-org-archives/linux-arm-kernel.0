From: lkp@intel.com (kbuild test robot)
Date: Mon, 5 Sep 2016 09:37:29 +0800
Subject: [PATCH v4 4/5] net: stmmac: add a glue driver for the Amlogic
 Meson 8b / GXBB DWMAC
In-Reply-To: <20160904182320.671-5-martin.blumenstingl@googlemail.com>
Message-ID: <201609050953.67GKeUAU%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

[auto build test ERROR on next-20160825]
[also build test ERROR on v4.8-rc5]
[cannot apply to robh/for-next net-next/master net/master v4.8-rc4 v4.8-rc3 v4.8-rc2]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Martin-Blumenstingl/meson-Meson8b-and-GXBB-DWMAC-glue-driver/20160905-023130
config: sparc64-allyesconfig (attached as .config)
compiler: sparc64-linux-gnu-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sparc64 

All error/warnings (new ones prefixed by >>):

>> drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:63:18: error: field 'm250_mux' has incomplete type
     struct clk_mux  m250_mux;
                     ^
>> drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:67:21: error: field 'm250_div' has incomplete type
     struct clk_divider m250_div;
                        ^
>> drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:70:21: error: field 'm25_div' has incomplete type
     struct clk_divider m25_div;
                        ^
   drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c: In function 'meson8b_init_clk':
>> drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:88:23: error: storage size of 'init' isn't known
     struct clk_init_data init;
                          ^
>> drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:94:30: error: array type has incomplete element type 'struct clk_div_table'
     static struct clk_div_table clk_25m_div_table[] = {
                                 ^
>> drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:95:5: error: field name not in record or union initializer
      { .val = 0, .div = 5 },
        ^
   drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:95:5: note: (near initialization for 'clk_25m_div_table')
   drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:95:15: error: field name not in record or union initializer
      { .val = 0, .div = 5 },
                  ^
   drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:95:15: note: (near initialization for 'clk_25m_div_table')
   drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:96:5: error: field name not in record or union initializer
      { .val = 1, .div = 10 },
        ^
   drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:96:5: note: (near initialization for 'clk_25m_div_table')
   drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:96:15: error: field name not in record or union initializer
      { .val = 1, .div = 10 },
                  ^
   drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:96:15: note: (near initialization for 'clk_25m_div_table')
>> drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:114:4: error: implicit declaration of function '__clk_get_name' [-Werror=implicit-function-declaration]
       __clk_get_name(dwmac->m250_mux_parent[i]);
       ^
>> drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:113:23: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
      mux_parent_names[i] =
                          ^
>> drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:120:14: error: 'clk_mux_ops' undeclared (first use in this function)
     init.ops = &clk_mux_ops;
                 ^
   drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:120:14: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:132:24: error: implicit declaration of function 'devm_clk_register' [-Werror=implicit-function-declaration]
     dwmac->m250_mux_clk = devm_clk_register(dev, &dwmac->m250_mux.hw);
                           ^
>> drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:139:14: error: 'clk_divider_ops' undeclared (first use in this function)
     init.ops = &clk_divider_ops;
                 ^
>> drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:140:15: error: 'CLK_SET_RATE_PARENT' undeclared (first use in this function)
     init.flags = CLK_SET_RATE_PARENT;
                  ^
   drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:141:21: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     clk_div_parents[0] = __clk_get_name(dwmac->m250_mux_clk);
                        ^
>> drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:149:26: error: 'CLK_DIVIDER_ONE_BASED' undeclared (first use in this function)
     dwmac->m250_div.flags = CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO;
                             ^
>> drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:149:50: error: 'CLK_DIVIDER_ALLOW_ZERO' undeclared (first use in this function)
     dwmac->m250_div.flags = CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO;
                                                     ^
>> drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:159:15: error: 'CLK_IS_BASIC' undeclared (first use in this function)
     init.flags = CLK_IS_BASIC | CLK_SET_RATE_PARENT;
                  ^
   drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:160:21: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     clk_div_parents[0] = __clk_get_name(dwmac->m250_div_clk);
                        ^
>> drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:94:30: warning: unused variable 'clk_25m_div_table' [-Wunused-variable]
     static struct clk_div_table clk_25m_div_table[] = {
                                 ^
>> drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:88:23: warning: unused variable 'init' [-Wunused-variable]
     struct clk_init_data init;
                          ^
   cc1: some warnings being treated as errors

vim +/m250_mux +63 drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c

    57		struct platform_device	*pdev;
    58	
    59		void __iomem		*regs;
    60	
    61		phy_interface_t		phy_mode;
    62	
  > 63		struct clk_mux		m250_mux;
    64		struct clk		*m250_mux_clk;
    65		struct clk		*m250_mux_parent[MUX_CLK_NUM_PARENTS];
    66	
  > 67		struct clk_divider	m250_div;
    68		struct clk		*m250_div_clk;
    69	
  > 70		struct clk_divider	m25_div;
    71		struct clk		*m25_div_clk;
    72	};
    73	
    74	static void meson8b_dwmac_mask_bits(struct meson8b_dwmac *dwmac, u32 reg,
    75					    u32 mask, u32 value)
    76	{
    77		u32 data;
    78	
    79		data = readl(dwmac->regs + reg);
    80		data &= ~mask;
    81		data |= (value & mask);
    82	
    83		writel(data, dwmac->regs + reg);
    84	}
    85	
    86	static int meson8b_init_clk(struct meson8b_dwmac *dwmac)
    87	{
  > 88		struct clk_init_data init;
    89		int i, ret;
    90		struct device *dev = &dwmac->pdev->dev;
    91		char clk_name[32];
    92		const char *clk_div_parents[1];
    93		const char *mux_parent_names[MUX_CLK_NUM_PARENTS];
  > 94		static struct clk_div_table clk_25m_div_table[] = {
  > 95			{ .val = 0, .div = 5 },
  > 96			{ .val = 1, .div = 10 },
    97			{ /* sentinel */ },
    98		};
    99	
   100		/* get the mux parents from DT */
   101		for (i = 0; i < MUX_CLK_NUM_PARENTS; i++) {
   102			char name[16];
   103	
   104			snprintf(name, sizeof(name), "clkin%d", i);
   105			dwmac->m250_mux_parent[i] = devm_clk_get(dev, name);
   106			if (IS_ERR(dwmac->m250_mux_parent[i])) {
   107				ret = PTR_ERR(dwmac->m250_mux_parent[i]);
   108				if (ret != -EPROBE_DEFER)
   109					dev_err(dev, "Missing clock %s\n", name);
   110				return ret;
   111			}
   112	
 > 113			mux_parent_names[i] =
 > 114				__clk_get_name(dwmac->m250_mux_parent[i]);
   115		}
   116	
   117		/* create the m250_mux */
   118		snprintf(clk_name, sizeof(clk_name), "%s#m250_sel", dev_name(dev));
   119		init.name = clk_name;
 > 120		init.ops = &clk_mux_ops;
   121		init.flags = 0;
   122		init.parent_names = mux_parent_names;
   123		init.num_parents = MUX_CLK_NUM_PARENTS;
   124	
   125		dwmac->m250_mux.reg = dwmac->regs + PRG_ETH0;
   126		dwmac->m250_mux.shift = PRG_ETH0_CLK_M250_SEL_SHIFT;
   127		dwmac->m250_mux.mask = PRG_ETH0_CLK_M250_SEL_MASK;
   128		dwmac->m250_mux.flags = 0;
   129		dwmac->m250_mux.table = NULL;
   130		dwmac->m250_mux.hw.init = &init;
   131	
 > 132		dwmac->m250_mux_clk = devm_clk_register(dev, &dwmac->m250_mux.hw);
   133		if (WARN_ON(IS_ERR(dwmac->m250_mux_clk)))
   134			return PTR_ERR(dwmac->m250_mux_clk);
   135	
   136		/* create the m250_div */
   137		snprintf(clk_name, sizeof(clk_name), "%s#m250_div", dev_name(dev));
   138		init.name = devm_kstrdup(dev, clk_name, GFP_KERNEL);
 > 139		init.ops = &clk_divider_ops;
 > 140		init.flags = CLK_SET_RATE_PARENT;
 > 141		clk_div_parents[0] = __clk_get_name(dwmac->m250_mux_clk);
   142		init.parent_names = clk_div_parents;
   143		init.num_parents = ARRAY_SIZE(clk_div_parents);
   144	
   145		dwmac->m250_div.reg = dwmac->regs + PRG_ETH0;
   146		dwmac->m250_div.shift = PRG_ETH0_CLK_M250_DIV_SHIFT;
   147		dwmac->m250_div.width = PRG_ETH0_CLK_M250_DIV_WIDTH;
   148		dwmac->m250_div.hw.init = &init;
 > 149		dwmac->m250_div.flags = CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO;
   150	
   151		dwmac->m250_div_clk = devm_clk_register(dev, &dwmac->m250_div.hw);
   152		if (WARN_ON(IS_ERR(dwmac->m250_div_clk)))
   153			return PTR_ERR(dwmac->m250_div_clk);
   154	
   155		/* create the m25_div */
   156		snprintf(clk_name, sizeof(clk_name), "%s#m25_div", dev_name(dev));
   157		init.name = devm_kstrdup(dev, clk_name, GFP_KERNEL);
   158		init.ops = &clk_divider_ops;
 > 159		init.flags = CLK_IS_BASIC | CLK_SET_RATE_PARENT;
   160		clk_div_parents[0] = __clk_get_name(dwmac->m250_div_clk);
   161		init.parent_names = clk_div_parents;
   162		init.num_parents = ARRAY_SIZE(clk_div_parents);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 47275 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160905/62dbfa76/attachment-0001.obj>

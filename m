From: lkp@intel.com (kbuild test robot)
Date: Sat, 26 Mar 2016 16:41:20 +0800
Subject: [PATCH v5 4/4] clk: rockchip: add clock controller for the RK3399
In-Reply-To: <1458974276-10325-5-git-send-email-zhengxing@rock-chips.com>
Message-ID: <201603261645.lZcOmgu0%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Xing,

[auto build test ERROR on rockchip/for-next]
[also build test ERROR on v4.5 next-20160324]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Xing-Zheng/clk-rockchip-fix-big-LITTLE-cores-alternate-reparent-failed/20160326-144243
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
config: arm-multi_v7_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   In file included from drivers/clk/rockchip/clk-rk3399.c:22:0:
>> drivers/clk/rockchip/clk-rk3399.c:195:15: error: 'pll_rk3399' undeclared here (not in a function)
     [lpll] = PLL(pll_rk3399, PLL_APLLL, "lpll", mux_pll_p, 0, RK3399_PLL_CON(0),
                  ^
   drivers/clk/rockchip/clk.h:206:12: note: in definition of macro 'PLL'
      .type  = _type,    \
               ^
>> drivers/clk/rockchip/clk-rk3399.c:212:2: error: initializer element is not constant
     [ppll] = PLL(pll_rk3399, PLL_PPLL, "ppll",  mux_pll_p, 0, RK3399_PMU_PLL_CON(0),
     ^
   drivers/clk/rockchip/clk-rk3399.c:212:2: error: (near initialization for 'rk3399_pmu_pll_clks[0].type')
>> drivers/clk/rockchip/clk-rk3399.c:257:2: error: unknown field 'mux_core_alt' specified in initializer
     .mux_core_alt = 3,
     ^
>> drivers/clk/rockchip/clk-rk3399.c:258:2: error: unknown field 'mux_core_main' specified in initializer
     .mux_core_main = 0,
     ^
>> drivers/clk/rockchip/clk-rk3399.c:260:2: error: unknown field 'mux_core_mask' specified in initializer
     .mux_core_mask = 0x3,
     ^
>> drivers/clk/rockchip/clk-rk3399.c:260:2: warning: excess elements in struct initializer
   drivers/clk/rockchip/clk-rk3399.c:260:2: warning: (near initialization for 'rk3399_cpuclkl_data')
   drivers/clk/rockchip/clk-rk3399.c:267:2: error: unknown field 'mux_core_alt' specified in initializer
     .mux_core_alt = 3,
     ^
   drivers/clk/rockchip/clk-rk3399.c:268:2: error: unknown field 'mux_core_main' specified in initializer
     .mux_core_main = 1,
     ^
   drivers/clk/rockchip/clk-rk3399.c:270:2: error: unknown field 'mux_core_mask' specified in initializer
     .mux_core_mask = 0x3,
     ^
   drivers/clk/rockchip/clk-rk3399.c:270:2: warning: excess elements in struct initializer
   drivers/clk/rockchip/clk-rk3399.c:270:2: warning: (near initialization for 'rk3399_cpuclkb_data')
>> drivers/clk/rockchip/clk-rk3399.c:1125:2: error: implicit declaration of function 'COMPOSITE_FRACMUX_NOGATE' [-Werror=implicit-function-declaration]
     COMPOSITE_FRACMUX_NOGATE(0, "dclk_vop0_frac", "dclk_vop0_div", CLK_SET_RATE_PARENT,
     ^
>> drivers/clk/rockchip/clk-rk3399.c:1127:4: warning: missing braces around initializer [-Wmissing-braces]
       &rk3399_dclk_vop0_fracmux),
       ^
   drivers/clk/rockchip/clk-rk3399.c:1127:4: warning: (near initialization for 'rk3399_clk_branches[300]') [-Wmissing-braces]
   drivers/clk/rockchip/clk-rk3399.c:1127:4: error: initializer element is not constant
   drivers/clk/rockchip/clk-rk3399.c:1127:4: error: (near initialization for 'rk3399_clk_branches[300].id')
>> drivers/clk/rockchip/clk-rk3399.c:1129:2: warning: braces around scalar initializer
     COMPOSITE(SCLK_VOP0_PWM, "clk_vop0_pwm", mux_pll_src_vpll_cpll_gpll_24m_p, CLK_IGNORE_UNUSED,
     ^
   drivers/clk/rockchip/clk-rk3399.c:1129:2: warning: (near initialization for 'rk3399_clk_branches[300].branch_type')
>> drivers/clk/rockchip/clk-rk3399.c:1129:2: error: field name not in record or union initializer
   drivers/clk/rockchip/clk-rk3399.c:1129:2: error: (near initialization for 'rk3399_clk_branches[300].branch_type')
>> drivers/clk/rockchip/clk-rk3399.c:1129:2: error: field name not in record or union initializer
   drivers/clk/rockchip/clk-rk3399.c:1129:2: error: (near initialization for 'rk3399_clk_branches[300].branch_type')
>> drivers/clk/rockchip/clk-rk3399.c:1129:2: warning: excess elements in scalar initializer
   drivers/clk/rockchip/clk-rk3399.c:1129:2: warning: (near initialization for 'rk3399_clk_branches[300].branch_type')
>> drivers/clk/rockchip/clk-rk3399.c:1129:2: error: field name not in record or union initializer
   drivers/clk/rockchip/clk-rk3399.c:1129:2: error: (near initialization for 'rk3399_clk_branches[300].branch_type')
>> drivers/clk/rockchip/clk-rk3399.c:1129:2: warning: excess elements in scalar initializer
   drivers/clk/rockchip/clk-rk3399.c:1129:2: warning: (near initialization for 'rk3399_clk_branches[300].branch_type')
>> drivers/clk/rockchip/clk-rk3399.c:1129:2: error: field name not in record or union initializer
   drivers/clk/rockchip/clk-rk3399.c:1129:2: error: (near initialization for 'rk3399_clk_branches[300].branch_type')
>> drivers/clk/rockchip/clk-rk3399.c:1129:2: warning: excess elements in scalar initializer
   drivers/clk/rockchip/clk-rk3399.c:1129:2: warning: (near initialization for 'rk3399_clk_branches[300].branch_type')
>> drivers/clk/rockchip/clk-rk3399.c:1129:2: error: field name not in record or union initializer
   drivers/clk/rockchip/clk-rk3399.c:1129:2: error: (near initialization for 'rk3399_clk_branches[300].branch_type')
   In file included from include/linux/io.h:23:0,
                    from include/linux/clk-provider.h:14,
                    from drivers/clk/rockchip/clk-rk3399.c:16:
>> include/linux/bug.h:34:45: warning: excess elements in scalar initializer
    #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
                                                ^
   include/linux/compiler-gcc.h:64:28: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
    #define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
                               ^
   include/linux/kernel.h:54:59: note: in expansion of macro '__must_be_array'
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                                                              ^
>> drivers/clk/rockchip/clk.h:310:18: note: in expansion of macro 'ARRAY_SIZE'
      .num_parents = ARRAY_SIZE(pnames),  \
                     ^
>> drivers/clk/rockchip/clk-rk3399.c:1129:2: note: in expansion of macro 'COMPOSITE'
     COMPOSITE(SCLK_VOP0_PWM, "clk_vop0_pwm", mux_pll_src_vpll_cpll_gpll_24m_p, CLK_IGNORE_UNUSED,
     ^
   include/linux/bug.h:34:45: warning: (near initialization for 'rk3399_clk_branches[300].branch_type')
    #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
                                                ^
   include/linux/compiler-gcc.h:64:28: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
    #define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
                               ^
   include/linux/kernel.h:54:59: note: in expansion of macro '__must_be_array'
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                                                              ^

vim +/pll_rk3399 +195 drivers/clk/rockchip/clk-rk3399.c

    16	#include <linux/clk-provider.h>
    17	#include <linux/of.h>
    18	#include <linux/of_address.h>
    19	#include <linux/platform_device.h>
    20	#include <linux/regmap.h>
    21	#include <dt-bindings/clock/rk3399-cru.h>
  > 22	#include "clk.h"
    23	
    24	#define RK3399_PMUGRF_SOC_CON0			0x180
    25	#define RK3399_PMUCRU_PCLK_GATE_MASK		0x1
    26	#define RK3399_PMUCRU_PCLK_GATE_SHIFT		4
    27	#define RK3399_PMUCRU_PCLK_ALIVE_MASK		0x1
    28	#define RK3399_PMUCRU_PCLK_ALIVE_SHIFT		6
    29	
    30	enum rk3399_plls {
    31		lpll, bpll, dpll, cpll, gpll, npll, vpll,
    32	};
    33	
    34	enum rk3399_pmu_plls {
    35		ppll,
    36	};
    37	
    38	static struct rockchip_pll_rate_table rk3399_pll_rates[] = {
    39		/* _mhz, _refdiv, _fbdiv, _postdiv1, _postdiv2, _dsmpd, _frac */
    40		RK3036_PLL_RATE(2208000000, 1, 92, 1, 1, 1, 0),
    41		RK3036_PLL_RATE(2184000000, 1, 91, 1, 1, 1, 0),
    42		RK3036_PLL_RATE(2160000000, 1, 90, 1, 1, 1, 0),
    43		RK3036_PLL_RATE(2136000000, 1, 89, 1, 1, 1, 0),
    44		RK3036_PLL_RATE(2112000000, 1, 88, 1, 1, 1, 0),
    45		RK3036_PLL_RATE(2088000000, 1, 87, 1, 1, 1, 0),
    46		RK3036_PLL_RATE(2064000000, 1, 86, 1, 1, 1, 0),
    47		RK3036_PLL_RATE(2040000000, 1, 85, 1, 1, 1, 0),
    48		RK3036_PLL_RATE(2016000000, 1, 84, 1, 1, 1, 0),
    49		RK3036_PLL_RATE(1992000000, 1, 83, 1, 1, 1, 0),
    50		RK3036_PLL_RATE(1968000000, 1, 82, 1, 1, 1, 0),
    51		RK3036_PLL_RATE(1944000000, 1, 81, 1, 1, 1, 0),
    52		RK3036_PLL_RATE(1920000000, 1, 80, 1, 1, 1, 0),
    53		RK3036_PLL_RATE(1896000000, 1, 79, 1, 1, 1, 0),
    54		RK3036_PLL_RATE(1872000000, 1, 78, 1, 1, 1, 0),
    55		RK3036_PLL_RATE(1848000000, 1, 77, 1, 1, 1, 0),
    56		RK3036_PLL_RATE(1824000000, 1, 76, 1, 1, 1, 0),
    57		RK3036_PLL_RATE(1800000000, 1, 75, 1, 1, 1, 0),
    58		RK3036_PLL_RATE(1776000000, 1, 74, 1, 1, 1, 0),
    59		RK3036_PLL_RATE(1752000000, 1, 73, 1, 1, 1, 0),
    60		RK3036_PLL_RATE(1728000000, 1, 72, 1, 1, 1, 0),
    61		RK3036_PLL_RATE(1704000000, 1, 71, 1, 1, 1, 0),
    62		RK3036_PLL_RATE(1680000000, 1, 70, 1, 1, 1, 0),
    63		RK3036_PLL_RATE(1656000000, 1, 69, 1, 1, 1, 0),
    64		RK3036_PLL_RATE(1632000000, 1, 68, 1, 1, 1, 0),
    65		RK3036_PLL_RATE(1608000000, 1, 67, 1, 1, 1, 0),
    66		RK3036_PLL_RATE(1584000000, 1, 66, 1, 1, 1, 0),
    67		RK3036_PLL_RATE(1560000000, 1, 65, 1, 1, 1, 0),
    68		RK3036_PLL_RATE(1536000000, 1, 64, 1, 1, 1, 0),
    69		RK3036_PLL_RATE(1512000000, 1, 63, 1, 1, 1, 0),
    70		RK3036_PLL_RATE(1488000000, 1, 62, 1, 1, 1, 0),
    71		RK3036_PLL_RATE(1464000000, 1, 61, 1, 1, 1, 0),
    72		RK3036_PLL_RATE(1440000000, 1, 60, 1, 1, 1, 0),
    73		RK3036_PLL_RATE(1416000000, 1, 59, 1, 1, 1, 0),
    74		RK3036_PLL_RATE(1392000000, 1, 58, 1, 1, 1, 0),
    75		RK3036_PLL_RATE(1368000000, 1, 57, 1, 1, 1, 0),
    76		RK3036_PLL_RATE(1344000000, 1, 56, 1, 1, 1, 0),
    77		RK3036_PLL_RATE(1320000000, 1, 55, 1, 1, 1, 0),
    78		RK3036_PLL_RATE(1296000000, 1, 54, 1, 1, 1, 0),
    79		RK3036_PLL_RATE(1272000000, 1, 53, 1, 1, 1, 0),
    80		RK3036_PLL_RATE(1248000000, 1, 52, 1, 1, 1, 0),
    81		RK3036_PLL_RATE(1200000000, 1, 50, 1, 1, 1, 0),
    82		RK3036_PLL_RATE(1188000000, 2, 99, 1, 1, 1, 0),
    83		RK3036_PLL_RATE(1104000000, 1, 46, 1, 1, 1, 0),
    84		RK3036_PLL_RATE(1100000000, 12, 550, 1, 1, 1, 0),
    85		RK3036_PLL_RATE(1008000000, 1, 84, 2, 1, 1, 0),
    86		RK3036_PLL_RATE(1000000000, 6, 500, 2, 1, 1, 0),
    87		RK3036_PLL_RATE( 984000000, 1, 82, 2, 1, 1, 0),
    88		RK3036_PLL_RATE( 960000000, 1, 80, 2, 1, 1, 0),
    89		RK3036_PLL_RATE( 936000000, 1, 78, 2, 1, 1, 0),
    90		RK3036_PLL_RATE( 912000000, 1, 76, 2, 1, 1, 0),
    91		RK3036_PLL_RATE( 900000000, 4, 300, 2, 1, 1, 0),
    92		RK3036_PLL_RATE( 888000000, 1, 74, 2, 1, 1, 0),
    93		RK3036_PLL_RATE( 864000000, 1, 72, 2, 1, 1, 0),
    94		RK3036_PLL_RATE( 840000000, 1, 70, 2, 1, 1, 0),
    95		RK3036_PLL_RATE( 816000000, 1, 68, 2, 1, 1, 0),
    96		RK3036_PLL_RATE( 800000000, 6, 400, 2, 1, 1, 0),
    97		RK3036_PLL_RATE( 700000000, 6, 350, 2, 1, 1, 0),
    98		RK3036_PLL_RATE( 696000000, 1, 58, 2, 1, 1, 0),
    99		RK3036_PLL_RATE( 676000000, 3, 169, 2, 1, 1, 0),
   100		RK3036_PLL_RATE( 600000000, 1, 75, 3, 1, 1, 0),
   101		RK3036_PLL_RATE( 594000000, 2, 99, 2, 1, 1, 0),
   102		RK3036_PLL_RATE( 504000000, 1, 63, 3, 1, 1, 0),
   103		RK3036_PLL_RATE( 500000000, 6, 250, 2, 1, 1, 0),
   104		RK3036_PLL_RATE( 408000000, 1, 68, 2, 2, 1, 0),
   105		RK3036_PLL_RATE( 312000000, 1, 52, 2, 2, 1, 0),
   106		RK3036_PLL_RATE( 216000000, 1, 72, 4, 2, 1, 0),
   107		RK3036_PLL_RATE(  96000000, 1, 64, 4, 4, 1, 0),
   108		{ /* sentinel */ },
   109	};
   110	
   111	/* CRU parents */
   112	PNAME(mux_pll_p)				= { "xin24m", "xin32k" };
   113	
   114	PNAME(mux_armclkl_p)				= { "clk_core_l_lpll_src",
   115							    "clk_core_l_bpll_src",
   116							    "clk_core_l_dpll_src",
   117							    "clk_core_l_gpll_src" };
   118	PNAME(mux_armclkb_p)				= { "clk_core_b_lpll_src",
   119							    "clk_core_b_bpll_src",
   120							    "clk_core_b_dpll_src",
   121							    "clk_core_b_gpll_src" };
   122	PNAME(mux_aclk_cci_p)				= { "cpll_aclk_cci_src",
   123							    "gpll_aclk_cci_src",
   124							    "npll_aclk_cci_src",
   125							    "vpll_aclk_cci_src" };
   126	PNAME(mux_cci_trace_p)				= { "cpll_cci_trace", "gpll_cci_trace" };
   127	PNAME(mux_cs_p)					= { "cpll_cs", "gpll_cs", "npll_cs"};
   128	PNAME(mux_aclk_perihp_p)			= { "cpll_aclk_perihp_src", "gpll_aclk_perihp_src" };
   129	
   130	PNAME(mux_pll_src_cpll_gpll_p)			= { "cpll", "gpll" };
   131	PNAME(mux_pll_src_cpll_gpll_npll_p)		= { "cpll", "gpll", "npll" };
   132	PNAME(mux_pll_src_cpll_gpll_ppll_p)		= { "cpll", "gpll", "ppll" };
   133	PNAME(mux_pll_src_cpll_gpll_upll_p)		= { "cpll", "gpll", "upll" };
   134	PNAME(mux_pll_src_npll_cpll_gpll_p)		= { "npll", "cpll", "gpll" };
   135	PNAME(mux_pll_src_cpll_gpll_npll_ppll_p)	= { "cpll", "gpll", "npll", "ppll" };
   136	PNAME(mux_pll_src_cpll_gpll_npll_24m_p)		= { "cpll", "gpll", "npll", "xin24m" };
   137	PNAME(mux_pll_src_cpll_gpll_npll_usbphy480m_p)	= { "cpll", "gpll", "npll", "clk_usbphy_480m" };
   138	PNAME(mux_pll_src_ppll_cpll_gpll_npll_p)	= { "ppll", "cpll", "gpll", "npll", "upll" };
   139	PNAME(mux_pll_src_cpll_gpll_npll_upll_24m_p)	= { "cpll", "gpll", "npll", "upll", "xin24m" };
   140	PNAME(mux_pll_src_cpll_gpll_npll_ppll_upll_24m_p) = { "cpll", "gpll", "npll", "ppll", "upll", "xin24m" };
   141	
   142	PNAME(mux_pll_src_vpll_cpll_gpll_p)		= { "vpll", "cpll", "gpll" };
   143	PNAME(mux_pll_src_vpll_cpll_gpll_npll_p)	= { "vpll", "cpll", "gpll", "npll" };
   144	PNAME(mux_pll_src_vpll_cpll_gpll_24m_p)		= { "vpll", "cpll", "gpll", "xin24m" };
   145	
   146	PNAME(mux_dclk_vop0_p)				= { "dclk_vop0_div", "dclk_vop0_frac" };
   147	PNAME(mux_dclk_vop1_p)				= { "dclk_vop1_div", "dclk_vop1_frac" };
   148	
   149	PNAME(mux_clk_cif_p)				= { "clk_cifout_div", "xin24m" };
   150	
   151	PNAME(mux_pll_src_24m_usbphy480m_p)		= { "xin24m", "clk_usbphy_480m" };
   152	PNAME(mux_pll_src_24m_pciephy_p)		= { "xin24m", "clk_pciephy_ref100m" };
   153	PNAME(mux_pll_src_24m_32k_cpll_gpll_p)		= { "xin24m", "xin32k", "cpll", "gpll" };
   154	PNAME(mux_pciecore_cru_phy_p)			= { "clk_pcie_core_cru", "clk_pcie_core_phy" };
   155	
   156	PNAME(mux_aclk_emmc_p)				= { "cpll_aclk_emmc_src", "gpll_aclk_emmc_src" };
   157	
   158	PNAME(mux_aclk_perilp0_p)			= { "cpll_aclk_perilp0_src", "gpll_aclk_perilp0_src" };
   159	
   160	PNAME(mux_fclk_cm0s_p)				= { "cpll_fclk_cm0s_src", "gpll_fclk_cm0s_src" };
   161	
   162	PNAME(mux_hclk_perilp1_p)			= { "cpll_hclk_perilp1_src", "gpll_hclk_perilp1_src" };
   163	
   164	PNAME(mux_clk_testout1_p)			= { "clk_testout1_pll_src", "xin24m" };
   165	PNAME(mux_clk_testout2_p)			= { "clk_testout2_pll_src", "xin24m" };
   166	
   167	PNAME(mux_usbphy_480m_p)			= { "clk_usbphy0_480m_src", "clk_usbphy1_480m_src" };
   168	PNAME(mux_aclk_gmac_p)				= { "cpll_aclk_gmac_src", "gpll_aclk_gmac_src" };
   169	PNAME(mux_rmii_p)				= { "clk_gmac", "clkin_gmac" };
   170	PNAME(mux_spdif_p)				= { "clk_spdif_div", "clk_spdif_frac",
   171							    "clkin_i2s", "xin12m" };
   172	PNAME(mux_i2s0_p)				= { "clk_i2s0_div", "clk_i2s0_frac",
   173							    "clkin_i2s", "xin12m" };
   174	PNAME(mux_i2s1_p)				= { "clk_i2s1_div", "clk_i2s1_frac",
   175							    "clkin_i2s", "xin12m" };
   176	PNAME(mux_i2s2_p)				= { "clk_i2s2_div", "clk_i2s2_frac",
   177							    "clkin_i2s", "xin12m" };
   178	PNAME(mux_i2sch_p)				= { "clk_i2s0", "clk_i2s1", "clk_i2s2" };
   179	PNAME(mux_i2sout_p)				= { "clk_i2sout_src", "xin12m" };
   180	
   181	PNAME(mux_uart0_p)				= { "clk_uart0_div", "clk_uart0_frac", "xin24m" };
   182	PNAME(mux_uart1_p)				= { "clk_uart1_div", "clk_uart1_frac", "xin24m" };
   183	PNAME(mux_uart2_p)				= { "clk_uart2_div", "clk_uart2_frac", "xin24m" };
   184	PNAME(mux_uart3_p)				= { "clk_uart3_div", "clk_uart3_frac", "xin24m" };
   185	
   186	/* PMU CRU parents */
   187	PNAME(mux_ppll_24m_p)				= { "ppll", "xin24m" };
   188	PNAME(mux_24m_ppll_p)				= { "xin24m", "ppll" };
   189	PNAME(mux_fclk_cm0s_pmu_ppll_p)			= { "fclk_cm0s_pmu_ppll_src", "xin24m" };
   190	PNAME(mux_wifi_pmu_p)				= { "clk_wifi_div", "clk_wifi_frac" };
   191	PNAME(mux_uart4_pmu_p)				= { "clk_uart4_div", "clk_uart4_frac", "xin24m" };
   192	PNAME(mux_clk_testout2_2io_p)			= { "clk_testout2", "clk_32k_suspend_pmu" };
   193	
   194	static struct rockchip_pll_clock rk3399_pll_clks[] __initdata = {
 > 195		[lpll] = PLL(pll_rk3399, PLL_APLLL, "lpll", mux_pll_p, 0, RK3399_PLL_CON(0),
   196			     RK3399_PLL_CON(3), 8, 31, 0, rk3399_pll_rates),
   197		[bpll] = PLL(pll_rk3399, PLL_APLLB, "bpll", mux_pll_p, 0, RK3399_PLL_CON(8),
   198			     RK3399_PLL_CON(11), 8, 31, 0, rk3399_pll_rates),
   199		[dpll] = PLL(pll_rk3399, PLL_DPLL, "dpll", mux_pll_p, 0, RK3399_PLL_CON(16),
   200			     RK3399_PLL_CON(19), 8, 31, 0, NULL),
   201		[cpll] = PLL(pll_rk3399, PLL_CPLL, "cpll", mux_pll_p, 0, RK3399_PLL_CON(24),
   202			     RK3399_PLL_CON(27), 8, 31, ROCKCHIP_PLL_SYNC_RATE, rk3399_pll_rates),
   203		[gpll] = PLL(pll_rk3399, PLL_GPLL, "gpll", mux_pll_p, 0, RK3399_PLL_CON(32),
   204			     RK3399_PLL_CON(35), 8, 31, ROCKCHIP_PLL_SYNC_RATE, rk3399_pll_rates),
   205		[npll] = PLL(pll_rk3399, PLL_NPLL, "npll",  mux_pll_p, 0, RK3399_PLL_CON(40),
   206			     RK3399_PLL_CON(43), 8, 31, ROCKCHIP_PLL_SYNC_RATE, rk3399_pll_rates),
   207		[vpll] = PLL(pll_rk3399, PLL_VPLL, "vpll",  mux_pll_p, 0, RK3399_PLL_CON(48),
   208			     RK3399_PLL_CON(51), 8, 31, ROCKCHIP_PLL_SYNC_RATE, rk3399_pll_rates),
   209	};
   210	
   211	static struct rockchip_pll_clock rk3399_pmu_pll_clks[] __initdata = {
 > 212		[ppll] = PLL(pll_rk3399, PLL_PPLL, "ppll",  mux_pll_p, 0, RK3399_PMU_PLL_CON(0),
   213			     RK3399_PMU_PLL_CON(3), 8, 31, ROCKCHIP_PLL_SYNC_RATE, rk3399_pll_rates),
   214	};
   215	
   216	#define MFLAGS CLK_MUX_HIWORD_MASK
   217	#define DFLAGS CLK_DIVIDER_HIWORD_MASK
   218	#define GFLAGS (CLK_GATE_HIWORD_MASK | CLK_GATE_SET_TO_DISABLE)
   219	#define IFLAGS ROCKCHIP_INVERTER_HIWORD_MASK
   220	
   221	static struct rockchip_clk_branch rk3399_uart0_fracmux __initdata =
   222		MUX(SCLK_UART0, "clk_uart0", mux_uart0_p, CLK_SET_RATE_PARENT,
   223				RK3399_CLKSEL_CON(33), 8, 2, MFLAGS);
   224	
   225	static struct rockchip_clk_branch rk3399_uart1_fracmux __initdata =
   226		MUX(SCLK_UART1, "clk_uart1", mux_uart1_p, CLK_SET_RATE_PARENT,
   227				RK3399_CLKSEL_CON(34), 8, 2, MFLAGS);
   228	
   229	static struct rockchip_clk_branch rk3399_uart2_fracmux __initdata =
   230		MUX(SCLK_UART2, "clk_uart2", mux_uart2_p, CLK_SET_RATE_PARENT,
   231				RK3399_CLKSEL_CON(35), 8, 2, MFLAGS);
   232	
   233	static struct rockchip_clk_branch rk3399_uart3_fracmux __initdata =
   234		MUX(SCLK_UART3, "clk_uart3", mux_uart3_p, CLK_SET_RATE_PARENT,
   235				RK3399_CLKSEL_CON(36), 8, 2, MFLAGS);
   236	
   237	static struct rockchip_clk_branch rk3399_uart4_pmu_fracmux __initdata =
   238		MUX(SCLK_UART4_PMU, "clk_uart4_pmu", mux_uart4_pmu_p, CLK_SET_RATE_PARENT,
   239				RK3399_PMU_CLKSEL_CON(5), 8, 2, MFLAGS);
   240	
   241	static struct rockchip_clk_branch rk3399_dclk_vop0_fracmux __initdata =
   242		MUX(DCLK_VOP0, "dclk_vop0", mux_dclk_vop0_p, CLK_SET_RATE_PARENT,
   243				RK3399_CLKSEL_CON(49), 11, 1, MFLAGS);
   244	
   245	static struct rockchip_clk_branch rk3399_dclk_vop1_fracmux __initdata =
   246		MUX(DCLK_VOP1, "dclk_vop1", mux_dclk_vop1_p, CLK_SET_RATE_PARENT,
   247				RK3399_CLKSEL_CON(50), 11, 1, MFLAGS);
   248	
   249	static struct rockchip_clk_branch rk3399_pmuclk_wifi_fracmux __initdata =
   250		MUX(SCLK_WIFI_PMU, "clk_wifi_pmu", mux_wifi_pmu_p, CLK_SET_RATE_PARENT,
   251				RK3399_PMU_CLKSEL_CON(1), 14, 1, MFLAGS);
   252	
   253	static const struct rockchip_cpuclk_reg_data rk3399_cpuclkl_data = {
   254		.core_reg = RK3399_CLKSEL_CON(0),
   255		.div_core_shift = 0,
   256		.div_core_mask = 0x1f,
 > 257		.mux_core_alt = 3,
 > 258		.mux_core_main = 0,
   259		.mux_core_shift = 6,
 > 260		.mux_core_mask = 0x3,
   261	};
   262	
   263	static const struct rockchip_cpuclk_reg_data rk3399_cpuclkb_data = {
   264		.core_reg = RK3399_CLKSEL_CON(2),
   265		.div_core_shift = 0,
   266		.div_core_mask = 0x1f,
   267		.mux_core_alt = 3,
 > 268		.mux_core_main = 1,
   269		.mux_core_shift = 6,
 > 270		.mux_core_mask = 0x3,
   271	};
   272	
   273	#define RK3399_DIV_ACLKM_MASK		0x1f

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 37228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160326/001791ad/attachment-0001.obj>

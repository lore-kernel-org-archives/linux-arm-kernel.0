From: lkp@intel.com (kbuild test robot)
Date: Wed, 6 Jul 2016 02:56:29 +0800
Subject: [PATCH v3 2/2] clk: samsung: exynos7: Add clocks for atlas block
In-Reply-To: <1467750561-13957-3-git-send-email-a.kesavan@samsung.com>
Message-ID: <201607060224.EFZSaMHu%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test WARNING on clk/clk-next]
[also build test WARNING on next-20160705]
[cannot apply to v4.7-rc6]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Abhilash-Kesavan/Add-CPU-clock-support-for-Exynos7/20160706-002658
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

>> drivers/clk/samsung/clk-exynos7.c:43:2: warning: this decimal constant is unsigned only in ISO C90
     PLL_35XX_RATE(2496000000, 208, 2, 0),
     ^~~~~~~~~~~~~
   drivers/clk/samsung/clk-exynos7.c:44:2: warning: this decimal constant is unsigned only in ISO C90
     PLL_35XX_RATE(2400000000, 200, 2, 0),
     ^~~~~~~~~~~~~
   drivers/clk/samsung/clk-exynos7.c:45:2: warning: this decimal constant is unsigned only in ISO C90
     PLL_35XX_RATE(2304000000, 192, 2, 0),
     ^~~~~~~~~~~~~
   drivers/clk/samsung/clk-exynos7.c:46:2: warning: this decimal constant is unsigned only in ISO C90
     PLL_35XX_RATE(2200000000, 275, 3, 0),
     ^~~~~~~~~~~~~

vim +43 drivers/clk/samsung/clk-exynos7.c

    27	#define BUS1_DPLL_CON0		0x0120
    28	#define MFC_PLL_CON0		0x0130
    29	#define AUD_PLL_CON0		0x0140
    30	#define MUX_SEL_TOPC0		0x0200
    31	#define MUX_SEL_TOPC1		0x0204
    32	#define MUX_SEL_TOPC2		0x0208
    33	#define MUX_SEL_TOPC3		0x020C
    34	#define DIV_TOPC0		0x0600
    35	#define DIV_TOPC1		0x0604
    36	#define DIV_TOPC3		0x060C
    37	#define ENABLE_ACLK_TOPC0	0x0800
    38	#define ENABLE_ACLK_TOPC1	0x0804
    39	#define ENABLE_SCLK_TOPC1	0x0A04
    40	
    41	static const struct samsung_pll_rate_table pll1450x_24mhz_tbl[] = {
    42		/* rate, m, p, s */
  > 43		PLL_35XX_RATE(2496000000, 208, 2, 0),
    44		PLL_35XX_RATE(2400000000, 200, 2, 0),
    45		PLL_35XX_RATE(2304000000, 192, 2, 0),
    46		PLL_35XX_RATE(2200000000, 275, 3, 0),
    47		PLL_35XX_RATE(2100000000, 175, 2, 0),
    48		PLL_35XX_RATE(2000000000, 250, 3, 0),
    49		PLL_35XX_RATE(1896000000, 158, 2, 0),
    50		PLL_35XX_RATE(1800000000, 150, 2, 0),
    51		PLL_35XX_RATE(1704000000, 142, 2, 0),

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 55044 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160706/69d5255f/attachment-0001.obj>

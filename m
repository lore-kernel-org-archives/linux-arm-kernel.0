From: bhumirks@gmail.com (Bhumika Goyal)
Date: Fri, 18 Aug 2017 15:38:17 +0530
Subject: [PATCH] clk: make clk_init_data const
Message-ID: <1503050897-23252-1-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make these const as they are only stored in the init field of a clk_hw
structure, which is const.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
To test changes in clk-common.c, I compiled clk-atlas6.c and clk-prima2.c
as it gets included in these two files.

 drivers/clk/clk-twl6040.c     |  2 +-
 drivers/clk/clk-wm831x.c      |  6 ++--
 drivers/clk/sirf/clk-atlas6.c |  2 +-
 drivers/clk/sirf/clk-atlas7.c | 18 +++++-----
 drivers/clk/sirf/clk-common.c | 80 +++++++++++++++++++++----------------------
 drivers/clk/sirf/clk-prima2.c |  2 +-
 6 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/drivers/clk/clk-twl6040.c b/drivers/clk/clk-twl6040.c
index 7b222a5..25dfe05 100644
--- a/drivers/clk/clk-twl6040.c
+++ b/drivers/clk/clk-twl6040.c
@@ -82,7 +82,7 @@ static unsigned long twl6040_pdmclk_recalc_rate(struct clk_hw *hw,
 	.recalc_rate = twl6040_pdmclk_recalc_rate,
 };
 
-static struct clk_init_data twl6040_pdmclk_init = {
+static const struct clk_init_data twl6040_pdmclk_init = {
 	.name = "pdmclk",
 	.ops = &twl6040_pdmclk_ops,
 	.flags = CLK_GET_RATE_NOCACHE,
diff --git a/drivers/clk/clk-wm831x.c b/drivers/clk/clk-wm831x.c
index a47960a..1467695 100644
--- a/drivers/clk/clk-wm831x.c
+++ b/drivers/clk/clk-wm831x.c
@@ -52,7 +52,7 @@ static unsigned long wm831x_xtal_recalc_rate(struct clk_hw *hw,
 	.recalc_rate = wm831x_xtal_recalc_rate,
 };
 
-static struct clk_init_data wm831x_xtal_init = {
+static const struct clk_init_data wm831x_xtal_init = {
 	.name = "xtal",
 	.ops = &wm831x_xtal_ops,
 };
@@ -225,7 +225,7 @@ static u8 wm831x_fll_get_parent(struct clk_hw *hw)
 	.get_parent = wm831x_fll_get_parent,
 };
 
-static struct clk_init_data wm831x_fll_init = {
+static const struct clk_init_data wm831x_fll_init = {
 	.name = "fll",
 	.ops = &wm831x_fll_ops,
 	.parent_names = wm831x_fll_parents,
@@ -338,7 +338,7 @@ static int wm831x_clkout_set_parent(struct clk_hw *hw, u8 parent)
 	.set_parent = wm831x_clkout_set_parent,
 };
 
-static struct clk_init_data wm831x_clkout_init = {
+static const struct clk_init_data wm831x_clkout_init = {
 	.name = "clkout",
 	.ops = &wm831x_clkout_ops,
 	.parent_names = wm831x_clkout_parents,
diff --git a/drivers/clk/sirf/clk-atlas6.c b/drivers/clk/sirf/clk-atlas6.c
index 665fa68..0cd11e6 100644
--- a/drivers/clk/sirf/clk-atlas6.c
+++ b/drivers/clk/sirf/clk-atlas6.c
@@ -42,7 +42,7 @@
 	},
 };
 
-static struct clk_init_data clk_nand_init = {
+static const struct clk_init_data clk_nand_init = {
 	.name = "nand",
 	.ops = &dmn_ops,
 	.parent_names = dmn_clk_parents,
diff --git a/drivers/clk/sirf/clk-atlas7.c b/drivers/clk/sirf/clk-atlas7.c
index d0c6c9a..be012b4 100644
--- a/drivers/clk/sirf/clk-atlas7.c
+++ b/drivers/clk/sirf/clk-atlas7.c
@@ -392,7 +392,7 @@ static unsigned long pll_clk_recalc_rate(struct clk_hw *hw,
 	"xin",
 };
 
-static struct clk_init_data clk_cpupll_init = {
+static const struct clk_init_data clk_cpupll_init = {
 	.name = "cpupll_vco",
 	.ops = &ab_pll_ops,
 	.parent_names = pll_clk_parents,
@@ -406,7 +406,7 @@ static unsigned long pll_clk_recalc_rate(struct clk_hw *hw,
 	},
 };
 
-static struct clk_init_data clk_mempll_init = {
+static const struct clk_init_data clk_mempll_init = {
 	.name = "mempll_vco",
 	.ops = &ab_pll_ops,
 	.parent_names = pll_clk_parents,
@@ -420,7 +420,7 @@ static unsigned long pll_clk_recalc_rate(struct clk_hw *hw,
 	},
 };
 
-static struct clk_init_data clk_sys0pll_init = {
+static const struct clk_init_data clk_sys0pll_init = {
 	.name = "sys0pll_vco",
 	.ops = &ab_pll_ops,
 	.parent_names = pll_clk_parents,
@@ -434,7 +434,7 @@ static unsigned long pll_clk_recalc_rate(struct clk_hw *hw,
 	},
 };
 
-static struct clk_init_data clk_sys1pll_init = {
+static const struct clk_init_data clk_sys1pll_init = {
 	.name = "sys1pll_vco",
 	.ops = &ab_pll_ops,
 	.parent_names = pll_clk_parents,
@@ -448,7 +448,7 @@ static unsigned long pll_clk_recalc_rate(struct clk_hw *hw,
 	},
 };
 
-static struct clk_init_data clk_sys2pll_init = {
+static const struct clk_init_data clk_sys2pll_init = {
 	.name = "sys2pll_vco",
 	.ops = &ab_pll_ops,
 	.parent_names = pll_clk_parents,
@@ -462,7 +462,7 @@ static unsigned long pll_clk_recalc_rate(struct clk_hw *hw,
 	},
 };
 
-static struct clk_init_data clk_sys3pll_init = {
+static const struct clk_init_data clk_sys3pll_init = {
 	.name = "sys3pll_vco",
 	.ops = &ab_pll_ops,
 	.parent_names = pll_clk_parents,
@@ -596,7 +596,7 @@ static int dto_clk_set_parent(struct clk_hw *hw, u8 index)
 	"sys3pll_clk1",
 };
 
-static struct clk_init_data clk_audiodto_init = {
+static const struct clk_init_data clk_audiodto_init = {
 	.name = "audio_dto",
 	.ops = &dto_ops,
 	.parent_names = audiodto_clk_parents,
@@ -617,7 +617,7 @@ static int dto_clk_set_parent(struct clk_hw *hw, u8 index)
 	"sys3pll_clk1",
 };
 
-static struct clk_init_data clk_disp0dto_init = {
+static const struct clk_init_data clk_disp0dto_init = {
 	.name = "disp0_dto",
 	.ops = &dto_ops,
 	.parent_names = disp0dto_clk_parents,
@@ -638,7 +638,7 @@ static int dto_clk_set_parent(struct clk_hw *hw, u8 index)
 	"sys3pll_clk1",
 };
 
-static struct clk_init_data clk_disp1dto_init = {
+static const struct clk_init_data clk_disp1dto_init = {
 	.name = "disp1_dto",
 	.ops = &dto_ops,
 	.parent_names = disp1dto_clk_parents,
diff --git a/drivers/clk/sirf/clk-common.c b/drivers/clk/sirf/clk-common.c
index 77e1e24..4fa3d09 100644
--- a/drivers/clk/sirf/clk-common.c
+++ b/drivers/clk/sirf/clk-common.c
@@ -194,21 +194,21 @@ static unsigned long cpu_clk_recalc_rate(struct clk_hw *hw,
 	"osc",
 };
 
-static struct clk_init_data clk_pll1_init = {
+static const struct clk_init_data clk_pll1_init = {
 	.name = "pll1",
 	.ops = &std_pll_ops,
 	.parent_names = pll_clk_parents,
 	.num_parents = ARRAY_SIZE(pll_clk_parents),
 };
 
-static struct clk_init_data clk_pll2_init = {
+static const struct clk_init_data clk_pll2_init = {
 	.name = "pll2",
 	.ops = &std_pll_ops,
 	.parent_names = pll_clk_parents,
 	.num_parents = ARRAY_SIZE(pll_clk_parents),
 };
 
-static struct clk_init_data clk_pll3_init = {
+static const struct clk_init_data clk_pll3_init = {
 	.name = "pll3",
 	.ops = &std_pll_ops,
 	.parent_names = pll_clk_parents,
@@ -271,7 +271,7 @@ static unsigned long usb_pll_clk_recalc_rate(struct clk_hw *hw, unsigned long pa
 	.recalc_rate = usb_pll_clk_recalc_rate,
 };
 
-static struct clk_init_data clk_usb_pll_init = {
+static const struct clk_init_data clk_usb_pll_init = {
 	.name = "usb_pll",
 	.ops = &usb_pll_ops,
 	.parent_names = pll_clk_parents,
@@ -445,7 +445,7 @@ static int cpu_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	.get_parent = dmn_clk_get_parent,
 };
 
-static struct clk_init_data clk_mem_init = {
+static const struct clk_init_data clk_mem_init = {
 	.name = "mem",
 	.ops = &msi_ops,
 	.parent_names = dmn_clk_parents,
@@ -459,7 +459,7 @@ static int cpu_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	},
 };
 
-static struct clk_init_data clk_sys_init = {
+static const struct clk_init_data clk_sys_init = {
 	.name = "sys",
 	.ops = &msi_ops,
 	.parent_names = dmn_clk_parents,
@@ -474,7 +474,7 @@ static int cpu_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	},
 };
 
-static struct clk_init_data clk_io_init = {
+static const struct clk_init_data clk_io_init = {
 	.name = "io",
 	.ops = &msi_ops,
 	.parent_names = dmn_clk_parents,
@@ -496,7 +496,7 @@ static int cpu_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	.recalc_rate = cpu_clk_recalc_rate,
 };
 
-static struct clk_init_data clk_cpu_init = {
+static const struct clk_init_data clk_cpu_init = {
 	.name = "cpu",
 	.ops = &cpu_ops,
 	.parent_names = dmn_clk_parents,
@@ -524,7 +524,7 @@ static int cpu_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 
 /* dsp, gfx, mm, lcd and vpp domain */
 
-static struct clk_init_data clk_dsp_init = {
+static const struct clk_init_data clk_dsp_init = {
 	.name = "dsp",
 	.ops = &dmn_ops,
 	.parent_names = dmn_clk_parents,
@@ -539,7 +539,7 @@ static int cpu_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	},
 };
 
-static struct clk_init_data clk_gfx_init = {
+static const struct clk_init_data clk_gfx_init = {
 	.name = "gfx",
 	.ops = &dmn_ops,
 	.parent_names = dmn_clk_parents,
@@ -554,7 +554,7 @@ static int cpu_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	},
 };
 
-static struct clk_init_data clk_mm_init = {
+static const struct clk_init_data clk_mm_init = {
 	.name = "mm",
 	.ops = &dmn_ops,
 	.parent_names = dmn_clk_parents,
@@ -574,7 +574,7 @@ static int cpu_clk_set_rate(struct clk_hw *hw, unsigned long rate,
  */
 #define clk_gfx2d clk_mm
 
-static struct clk_init_data clk_lcd_init = {
+static const struct clk_init_data clk_lcd_init = {
 	.name = "lcd",
 	.ops = &dmn_ops,
 	.parent_names = dmn_clk_parents,
@@ -589,7 +589,7 @@ static int cpu_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	},
 };
 
-static struct clk_init_data clk_vpp_init = {
+static const struct clk_init_data clk_vpp_init = {
 	.name = "vpp",
 	.ops = &dmn_ops,
 	.parent_names = dmn_clk_parents,
@@ -604,21 +604,21 @@ static int cpu_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	},
 };
 
-static struct clk_init_data clk_mmc01_init = {
+static const struct clk_init_data clk_mmc01_init = {
 	.name = "mmc01",
 	.ops = &dmn_ops,
 	.parent_names = dmn_clk_parents,
 	.num_parents = ARRAY_SIZE(dmn_clk_parents),
 };
 
-static struct clk_init_data clk_mmc23_init = {
+static const struct clk_init_data clk_mmc23_init = {
 	.name = "mmc23",
 	.ops = &dmn_ops,
 	.parent_names = dmn_clk_parents,
 	.num_parents = ARRAY_SIZE(dmn_clk_parents),
 };
 
-static struct clk_init_data clk_mmc45_init = {
+static const struct clk_init_data clk_mmc45_init = {
 	.name = "mmc45",
 	.ops = &dmn_ops,
 	.parent_names = dmn_clk_parents,
@@ -685,7 +685,7 @@ static void std_clk_disable(struct clk_hw *hw)
 	.disable = std_clk_disable,
 };
 
-static struct clk_init_data clk_cphif_init = {
+static const struct clk_init_data clk_cphif_init = {
 	.name = "cphif",
 	.ops = &ios_ops,
 	.parent_names = std_clk_io_parents,
@@ -699,7 +699,7 @@ static void std_clk_disable(struct clk_hw *hw)
 	},
 };
 
-static struct clk_init_data clk_dmac0_init = {
+static const struct clk_init_data clk_dmac0_init = {
 	.name = "dmac0",
 	.ops = &ios_ops,
 	.parent_names = std_clk_io_parents,
@@ -713,7 +713,7 @@ static void std_clk_disable(struct clk_hw *hw)
 	},
 };
 
-static struct clk_init_data clk_dmac1_init = {
+static const struct clk_init_data clk_dmac1_init = {
 	.name = "dmac1",
 	.ops = &ios_ops,
 	.parent_names = std_clk_io_parents,
@@ -727,7 +727,7 @@ static void std_clk_disable(struct clk_hw *hw)
 	},
 };
 
-static struct clk_init_data clk_audio_init = {
+static const struct clk_init_data clk_audio_init = {
 	.name = "audio",
 	.ops = &ios_ops,
 	.parent_names = std_clk_io_parents,
@@ -741,7 +741,7 @@ static void std_clk_disable(struct clk_hw *hw)
 	},
 };
 
-static struct clk_init_data clk_uart0_init = {
+static const struct clk_init_data clk_uart0_init = {
 	.name = "uart0",
 	.ops = &ios_ops,
 	.parent_names = std_clk_io_parents,
@@ -755,7 +755,7 @@ static void std_clk_disable(struct clk_hw *hw)
 	},
 };
 
-static struct clk_init_data clk_uart1_init = {
+static const struct clk_init_data clk_uart1_init = {
 	.name = "uart1",
 	.ops = &ios_ops,
 	.parent_names = std_clk_io_parents,
@@ -769,7 +769,7 @@ static void std_clk_disable(struct clk_hw *hw)
 	},
 };
 
-static struct clk_init_data clk_uart2_init = {
+static const struct clk_init_data clk_uart2_init = {
 	.name = "uart2",
 	.ops = &ios_ops,
 	.parent_names = std_clk_io_parents,
@@ -783,7 +783,7 @@ static void std_clk_disable(struct clk_hw *hw)
 	},
 };
 
-static struct clk_init_data clk_usp0_init = {
+static const struct clk_init_data clk_usp0_init = {
 	.name = "usp0",
 	.ops = &ios_ops,
 	.parent_names = std_clk_io_parents,
@@ -797,7 +797,7 @@ static void std_clk_disable(struct clk_hw *hw)
 	},
 };
 
-static struct clk_init_data clk_usp1_init = {
+static const struct clk_init_data clk_usp1_init = {
 	.name = "usp1",
 	.ops = &ios_ops,
 	.parent_names = std_clk_io_parents,
@@ -811,7 +811,7 @@ static void std_clk_disable(struct clk_hw *hw)
 	},
 };
 
-static struct clk_init_data clk_usp2_init = {
+static const struct clk_init_data clk_usp2_init = {
 	.name = "usp2",
 	.ops = &ios_ops,
 	.parent_names = std_clk_io_parents,
@@ -825,7 +825,7 @@ static void std_clk_disable(struct clk_hw *hw)
 	},
 };
 
-static struct clk_init_data clk_vip_init = {
+static const struct clk_init_data clk_vip_init = {
 	.name = "vip",
 	.ops = &ios_ops,
 	.parent_names = std_clk_io_parents,
@@ -839,7 +839,7 @@ static void std_clk_disable(struct clk_hw *hw)
 	},
 };
 
-static struct clk_init_data clk_spi0_init = {
+static const struct clk_init_data clk_spi0_init = {
 	.name = "spi0",
 	.ops = &ios_ops,
 	.parent_names = std_clk_io_parents,
@@ -853,7 +853,7 @@ static void std_clk_disable(struct clk_hw *hw)
 	},
 };
 
-static struct clk_init_data clk_spi1_init = {
+static const struct clk_init_data clk_spi1_init = {
 	.name = "spi1",
 	.ops = &ios_ops,
 	.parent_names = std_clk_io_parents,
@@ -867,7 +867,7 @@ static void std_clk_disable(struct clk_hw *hw)
 	},
 };
 
-static struct clk_init_data clk_tsc_init = {
+static const struct clk_init_data clk_tsc_init = {
 	.name = "tsc",
 	.ops = &ios_ops,
 	.parent_names = std_clk_io_parents,
@@ -881,7 +881,7 @@ static void std_clk_disable(struct clk_hw *hw)
 	},
 };
 
-static struct clk_init_data clk_i2c0_init = {
+static const struct clk_init_data clk_i2c0_init = {
 	.name = "i2c0",
 	.ops = &ios_ops,
 	.parent_names = std_clk_io_parents,
@@ -895,7 +895,7 @@ static void std_clk_disable(struct clk_hw *hw)
 	},
 };
 
-static struct clk_init_data clk_i2c1_init = {
+static const struct clk_init_data clk_i2c1_init = {
 	.name = "i2c1",
 	.ops = &ios_ops,
 	.parent_names = std_clk_io_parents,
@@ -909,7 +909,7 @@ static void std_clk_disable(struct clk_hw *hw)
 	},
 };
 
-static struct clk_init_data clk_pwmc_init = {
+static const struct clk_init_data clk_pwmc_init = {
 	.name = "pwmc",
 	.ops = &ios_ops,
 	.parent_names = std_clk_io_parents,
@@ -923,7 +923,7 @@ static void std_clk_disable(struct clk_hw *hw)
 	},
 };
 
-static struct clk_init_data clk_efuse_init = {
+static const struct clk_init_data clk_efuse_init = {
 	.name = "efuse",
 	.ops = &ios_ops,
 	.parent_names = std_clk_io_parents,
@@ -937,7 +937,7 @@ static void std_clk_disable(struct clk_hw *hw)
 	},
 };
 
-static struct clk_init_data clk_pulse_init = {
+static const struct clk_init_data clk_pulse_init = {
 	.name = "pulse",
 	.ops = &ios_ops,
 	.parent_names = std_clk_io_parents,
@@ -955,7 +955,7 @@ static void std_clk_disable(struct clk_hw *hw)
 	"dsp",
 };
 
-static struct clk_init_data clk_gps_init = {
+static const struct clk_init_data clk_gps_init = {
 	.name = "gps",
 	.ops = &ios_ops,
 	.parent_names = std_clk_dsp_parents,
@@ -969,7 +969,7 @@ static void std_clk_disable(struct clk_hw *hw)
 	},
 };
 
-static struct clk_init_data clk_mf_init = {
+static const struct clk_init_data clk_mf_init = {
 	.name = "mf",
 	.ops = &ios_ops,
 	.parent_names = std_clk_io_parents,
@@ -987,7 +987,7 @@ static void std_clk_disable(struct clk_hw *hw)
 	"sys",
 };
 
-static struct clk_init_data clk_security_init = {
+static const struct clk_init_data clk_security_init = {
 	.name = "security",
 	.ops = &ios_ops,
 	.parent_names = std_clk_sys_parents,
@@ -1005,7 +1005,7 @@ static void std_clk_disable(struct clk_hw *hw)
 	"usb_pll",
 };
 
-static struct clk_init_data clk_usb0_init = {
+static const struct clk_init_data clk_usb0_init = {
 	.name = "usb0",
 	.ops = &ios_ops,
 	.parent_names = std_clk_usb_parents,
@@ -1019,7 +1019,7 @@ static void std_clk_disable(struct clk_hw *hw)
 	},
 };
 
-static struct clk_init_data clk_usb1_init = {
+static const struct clk_init_data clk_usb1_init = {
 	.name = "usb1",
 	.ops = &ios_ops,
 	.parent_names = std_clk_usb_parents,
diff --git a/drivers/clk/sirf/clk-prima2.c b/drivers/clk/sirf/clk-prima2.c
index aac1c8ec..2f82432 100644
--- a/drivers/clk/sirf/clk-prima2.c
+++ b/drivers/clk/sirf/clk-prima2.c
@@ -42,7 +42,7 @@
 	},
 };
 
-static struct clk_init_data clk_nand_init = {
+static const struct clk_init_data clk_nand_init = {
 	.name = "nand",
 	.ops = &ios_ops,
 	.parent_names = std_clk_io_parents,
-- 
1.9.1

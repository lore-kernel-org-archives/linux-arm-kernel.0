From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 11 Dec 2013 16:13:31 +0800
Subject: [PATCH 01/02] clk: hi3620: fix wrong flags on divider
Message-ID: <1386749612-12437-1-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The flags on dividers should be CLK_DIVIDER_HIWORD_MASK, not
CLK_MUX_HIWORD_MASK.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 drivers/clk/hisilicon/clk-hi3620.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3620.c b/drivers/clk/hisilicon/clk-hi3620.c
index b66b074..f0e779f 100644
--- a/drivers/clk/hisilicon/clk-hi3620.c
+++ b/drivers/clk/hisilicon/clk-hi3620.c
@@ -60,8 +60,8 @@ static const char *spi2_mux_p[] __initdata = { "osc26m", "rclk_cfgaxi", };
 static const char *saxi_mux_p[] __initdata = { "armpll3", "armpll2", };
 static const char *pwm0_mux_p[] __initdata = { "osc32k", "osc26m", };
 static const char *pwm1_mux_p[] __initdata = { "osc32k", "osc26m", };
-static const char *sd_mux_p[] __initdata = { "armpll3", "armpll2", };
-static const char *mmc1_mux_p[] __initdata = { "armpll3", "armpll2", };
+static const char *sd_mux_p[] __initdata = { "armpll2", "armpll3", };
+static const char *mmc1_mux_p[] __initdata = { "armpll2", "armpll3", };
 static const char *mmc1_mux2_p[] __initdata = { "osc26m", "mmc1_div", };
 static const char *g2d_mux_p[] __initdata = { "armpll2", "armpll3", };
 static const char *venc_mux_p[] __initdata = { "armpll2", "armpll3", };
@@ -74,8 +74,8 @@ static const char *edc1_mux_p[] __initdata = { "armpll2", "armpll3", };
 static const char *ldi1_mux_p[] __initdata = { "armpll2", "armpll4",
 					     "armpll3", "armpll5", };
 static const char *rclk_hsic_p[] __initdata = { "armpll3", "armpll2", };
-static const char *mmc2_mux_p[] __initdata = { "armpll3", "armpll2", };
-static const char *mmc3_mux_p[] __initdata = { "armpll3", "armpll2", };
+static const char *mmc2_mux_p[] __initdata = { "armpll2", "armpll3", };
+static const char *mmc3_mux_p[] __initdata = { "armpll2", "armpll3", };
 
 
 /* fixed rate clocks */
@@ -137,13 +137,13 @@ static struct hisi_mux_clock hi3620_mux_clks[] __initdata = {
 };
 
 static struct hisi_divider_clock hi3620_div_clks[] __initdata = {
-	{ HI3620_SHAREAXI_DIV, "saxi_div",   "saxi_mux",  0, 0x100, 0, 5, CLK_MUX_HIWORD_MASK, NULL, },
-	{ HI3620_CFGAXI_DIV,   "cfgaxi_div", "saxi_div",  0, 0x100, 5, 2, CLK_MUX_HIWORD_MASK, NULL, },
-	{ HI3620_SD_DIV,       "sd_div",     "sd_mux",	  0, 0x108, 0, 4, CLK_MUX_HIWORD_MASK, NULL, },
-	{ HI3620_MMC1_DIV,     "mmc1_div",   "mmc1_mux",  0, 0x108, 5, 4, CLK_MUX_HIWORD_MASK, NULL, },
-	{ HI3620_HSIC_DIV,     "hsic_div",   "rclk_hsic", 0, 0x130, 0, 2, CLK_MUX_HIWORD_MASK, NULL, },
-	{ HI3620_MMC2_DIV,     "mmc2_div",   "mmc2_mux",  0, 0x140, 0, 4, CLK_MUX_HIWORD_MASK, NULL, },
-	{ HI3620_MMC3_DIV,     "mmc3_div",   "mmc3_mux",  0, 0x140, 5, 4, CLK_MUX_HIWORD_MASK, NULL, },
+	{ HI3620_SHAREAXI_DIV, "saxi_div",   "saxi_mux",  0, 0x100, 0, 5, CLK_DIVIDER_HIWORD_MASK, NULL, },
+	{ HI3620_CFGAXI_DIV,   "cfgaxi_div", "saxi_div",  0, 0x100, 5, 2, CLK_DIVIDER_HIWORD_MASK, NULL, },
+	{ HI3620_SD_DIV,       "sd_div",     "sd_mux",	  0, 0x108, 0, 4, CLK_DIVIDER_HIWORD_MASK, NULL, },
+	{ HI3620_MMC1_DIV,     "mmc1_div",   "mmc1_mux",  0, 0x108, 5, 4, CLK_DIVIDER_HIWORD_MASK, NULL, },
+	{ HI3620_HSIC_DIV,     "hsic_div",   "rclk_hsic", 0, 0x130, 0, 2, CLK_DIVIDER_HIWORD_MASK, NULL, },
+	{ HI3620_MMC2_DIV,     "mmc2_div",   "mmc2_mux",  0, 0x140, 0, 4, CLK_DIVIDER_HIWORD_MASK, NULL, },
+	{ HI3620_MMC3_DIV,     "mmc3_div",   "mmc3_mux",  0, 0x140, 5, 4, CLK_DIVIDER_HIWORD_MASK, NULL, },
 };
 
 static struct hisi_gate_clock hi3620_seperated_gate_clks[] __initdata = {
-- 
1.8.3.2

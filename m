From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 28 Jul 2015 19:43:20 -0400 (EDT)
Subject: [PATCH] drivers/clk: appropriate __init annotation for const data
Message-ID: <alpine.LFD.2.20.1507281430130.26147@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Init data marked const should be annotated with __initconst for
correctness and not __initdata.  This also fixes LTO builds that
otherwise fail with section mismatch errors.

Signed-off-by: Nicolas Pitre <nico@linaro.org>

diff --git a/drivers/clk/clk-asm9260.c b/drivers/clk/clk-asm9260.c
index 90897af8d9..25308ce09a 100644
--- a/drivers/clk/clk-asm9260.c
+++ b/drivers/clk/clk-asm9260.c
@@ -244,10 +244,10 @@ static const struct asm9260_gate_data asm9260_ahb_gates[] __initconst = {
 		HW_AHBCLKCTRL1,	16 },
 };
 
-static const char __initdata *main_mux_p[] =   { NULL, NULL };
-static const char __initdata *i2s0_mux_p[] =   { NULL, NULL, "i2s0m_div"};
-static const char __initdata *i2s1_mux_p[] =   { NULL, NULL, "i2s1m_div"};
-static const char __initdata *clkout_mux_p[] = { NULL, NULL, "rtc"};
+static const char *const main_mux_p[] __initconst =   { NULL, NULL };
+static const char *const i2s0_mux_p[] __initconst =   { NULL, NULL, "i2s0m_div"};
+static const char *const i2s1_mux_p[] __initconst =   { NULL, NULL, "i2s1m_div"};
+static const char *const clkout_mux_p[] __initconst = { NULL, NULL, "rtc"};
 static u32 three_mux_table[] = {0, 1, 3};
 
 static struct asm9260_mux_clock asm9260_mux_clks[] __initdata = {
diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
index 3f6f7ad394..c316454ef8 100644
--- a/drivers/clk/clk-stm32f4.c
+++ b/drivers/clk/clk-stm32f4.c
@@ -293,7 +293,7 @@ stm32f4_rcc_lookup_clk(struct of_phandle_args *clkspec, void *data)
 	return clks[i];
 }
 
-static const char *sys_parents[] __initdata =   { "hsi", NULL, "pll" };
+static const char *const sys_parents[] __initconst =   { "hsi", NULL, "pll" };
 
 static const struct clk_div_table ahb_div_table[] = {
 	{ 0x0,   1 }, { 0x1,   1 }, { 0x2,   1 }, { 0x3,   1 },
diff --git a/drivers/clk/hisilicon/clk-hi6220.c b/drivers/clk/hisilicon/clk-hi6220.c
index 4563343b64..d7c7d73bd3 100644
--- a/drivers/clk/hisilicon/clk-hi6220.c
+++ b/drivers/clk/hisilicon/clk-hi6220.c
@@ -91,23 +91,23 @@ CLK_OF_DECLARE(hi6220_clk_ao, "hisilicon,hi6220-aoctrl", hi6220_clk_ao_init);
 
 
 /* clocks in sysctrl */
-static const char *mmc0_mux0_p[] __initdata = { "pll_ddr_gate", "syspll", };
-static const char *mmc0_mux1_p[] __initdata = { "mmc0_mux0", "pll_media_gate", };
-static const char *mmc0_src_p[] __initdata = { "mmc0srcsel", "mmc0_div", };
-static const char *mmc1_mux0_p[] __initdata = { "pll_ddr_gate", "syspll", };
-static const char *mmc1_mux1_p[] __initdata = { "mmc1_mux0", "pll_media_gate", };
-static const char *mmc1_src_p[]  __initdata = { "mmc1srcsel", "mmc1_div", };
-static const char *mmc2_mux0_p[] __initdata = { "pll_ddr_gate", "syspll", };
-static const char *mmc2_mux1_p[] __initdata = { "mmc2_mux0", "pll_media_gate", };
-static const char *mmc2_src_p[]  __initdata = { "mmc2srcsel", "mmc2_div", };
-static const char *mmc0_sample_in[] __initdata = { "mmc0_sample", "mmc0_pad", };
-static const char *mmc1_sample_in[] __initdata = { "mmc1_sample", "mmc1_pad", };
-static const char *mmc2_sample_in[] __initdata = { "mmc2_sample", "mmc2_pad", };
-static const char *uart1_src[] __initdata = { "clk_tcxo", "clk_150m", };
-static const char *uart2_src[] __initdata = { "clk_tcxo", "clk_150m", };
-static const char *uart3_src[] __initdata = { "clk_tcxo", "clk_150m", };
-static const char *uart4_src[] __initdata = { "clk_tcxo", "clk_150m", };
-static const char *hifi_src[] __initdata = { "syspll", "pll_media_gate", };
+static const char *const mmc0_mux0_p[] __initconst = { "pll_ddr_gate", "syspll", };
+static const char *const mmc0_mux1_p[] __initconst = { "mmc0_mux0", "pll_media_gate", };
+static const char *const mmc0_src_p[] __initconst = { "mmc0srcsel", "mmc0_div", };
+static const char *const mmc1_mux0_p[] __initconst = { "pll_ddr_gate", "syspll", };
+static const char *const mmc1_mux1_p[] __initconst = { "mmc1_mux0", "pll_media_gate", };
+static const char *const mmc1_src_p[]  __initconst = { "mmc1srcsel", "mmc1_div", };
+static const char *const mmc2_mux0_p[] __initconst = { "pll_ddr_gate", "syspll", };
+static const char *const mmc2_mux1_p[] __initconst = { "mmc2_mux0", "pll_media_gate", };
+static const char *const mmc2_src_p[]  __initconst = { "mmc2srcsel", "mmc2_div", };
+static const char *const mmc0_sample_in[] __initconst = { "mmc0_sample", "mmc0_pad", };
+static const char *const mmc1_sample_in[] __initconst = { "mmc1_sample", "mmc1_pad", };
+static const char *const mmc2_sample_in[] __initconst = { "mmc2_sample", "mmc2_pad", };
+static const char *const uart1_src[] __initconst = { "clk_tcxo", "clk_150m", };
+static const char *const uart2_src[] __initconst = { "clk_tcxo", "clk_150m", };
+static const char *const uart3_src[] __initconst = { "clk_tcxo", "clk_150m", };
+static const char *const uart4_src[] __initconst = { "clk_tcxo", "clk_150m", };
+static const char *const hifi_src[] __initconst = { "syspll", "pll_media_gate", };
 
 static struct hisi_gate_clock hi6220_separated_gate_clks_sys[] __initdata = {
 	{ HI6220_MMC0_CLK,      "mmc0_clk",      "mmc0_src",       CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x200, 0,  0, },
@@ -197,9 +197,9 @@ CLK_OF_DECLARE(hi6220_clk_sys, "hisilicon,hi6220-sysctrl", hi6220_clk_sys_init);
 
 
 /* clocks in media controller */
-static const char *clk_1000_1200_src[] __initdata = { "pll_gpu_gate", "media_syspll_src", };
-static const char *clk_1440_1200_src[] __initdata = { "media_syspll_src", "media_pll_src", };
-static const char *clk_1000_1440_src[] __initdata = { "pll_gpu_gate", "media_pll_src", };
+static const char *const clk_1000_1200_src[] __initconst = { "pll_gpu_gate", "media_syspll_src", };
+static const char *const clk_1440_1200_src[] __initconst = { "media_syspll_src", "media_pll_src", };
+static const char *const clk_1000_1440_src[] __initconst = { "pll_gpu_gate", "media_pll_src", };
 
 static struct hisi_gate_clock hi6220_separated_gate_clks_media[] __initdata = {
 	{ HI6220_DSI_PCLK,       "dsi_pclk",         "vpucodec",      CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x520, 0,  0, },
diff --git a/drivers/clk/versatile/clk-realview.c b/drivers/clk/versatile/clk-realview.c
index c8b523117f..0c1f224515 100644
--- a/drivers/clk/versatile/clk-realview.c
+++ b/drivers/clk/versatile/clk-realview.c
@@ -33,13 +33,13 @@ static const struct icst_params realview_oscvco_params = {
 	.idx2s		= icst307_idx2s,
 };
 
-static const struct clk_icst_desc __initdata realview_osc0_desc = {
+static const struct clk_icst_desc realview_osc0_desc __initconst = {
 	.params = &realview_oscvco_params,
 	.vco_offset = REALVIEW_SYS_OSC0_OFFSET,
 	.lock_offset = REALVIEW_SYS_LOCK_OFFSET,
 };
 
-static const struct clk_icst_desc __initdata realview_osc4_desc = {
+static const struct clk_icst_desc realview_osc4_desc __initconst = {
 	.params = &realview_oscvco_params,
 	.vco_offset = REALVIEW_SYS_OSC4_OFFSET,
 	.lock_offset = REALVIEW_SYS_LOCK_OFFSET,
diff --git a/drivers/clk/versatile/clk-versatile.c b/drivers/clk/versatile/clk-versatile.c
index 7a4f8635bd..81d59eada2 100644
--- a/drivers/clk/versatile/clk-versatile.c
+++ b/drivers/clk/versatile/clk-versatile.c
@@ -35,7 +35,7 @@ static const struct icst_params cp_auxosc_params = {
 	.idx2s		= icst525_idx2s,
 };
 
-static const struct clk_icst_desc __initdata cm_auxosc_desc = {
+static const struct clk_icst_desc cm_auxosc_desc __initconst = {
 	.params = &cp_auxosc_params,
 	.vco_offset = 0x1c,
 	.lock_offset = INTEGRATOR_HDR_LOCK_OFFSET,

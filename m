From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 11 Feb 2010 11:16:28 -0700
Subject: [PATCH 02/13] OMAP4 clock: drop the CLOCK_IN_OMAP4430 clock flag
In-Reply-To: <20100211181236.795.56094.stgit@localhost.localdomain>
References: <20100211181236.795.56094.stgit@localhost.localdomain>
Message-ID: <20100211181625.795.95638.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CLOCK_IN_OMAP4430 clock flag is not currently needed in the OMAP4
ES1 clock tree, and platform discrimination via clock flags is
deprecated in favor of the clkdev mechanism, so, drop it.  (The OMAP4
clock tree autogeneration script has been updated accordingly.)

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c    |  124 +++----------------------------
 arch/arm/plat-omap/include/plat/clock.h |    4 +
 2 files changed, 13 insertions(+), 115 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 1cb789d..70b314c 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -39,42 +39,42 @@ static struct clk extalt_clkin_ck = {
 	.name		= "extalt_clkin_ck",
 	.rate		= 59000000,
 	.ops		= &clkops_null,
-	.flags		= CLOCK_IN_OMAP4430 | ALWAYS_ENABLED,
+	.flags		= ALWAYS_ENABLED,
 };
 
 static struct clk pad_clks_ck = {
 	.name		= "pad_clks_ck",
 	.rate		= 12000000,
 	.ops		= &clkops_null,
-	.flags		= CLOCK_IN_OMAP4430 | ALWAYS_ENABLED,
+	.flags		= ALWAYS_ENABLED,
 };
 
 static struct clk pad_slimbus_core_clks_ck = {
 	.name		= "pad_slimbus_core_clks_ck",
 	.rate		= 12000000,
 	.ops		= &clkops_null,
-	.flags		= CLOCK_IN_OMAP4430 | ALWAYS_ENABLED,
+	.flags		= ALWAYS_ENABLED,
 };
 
 static struct clk secure_32k_clk_src_ck = {
 	.name		= "secure_32k_clk_src_ck",
 	.rate		= 32768,
 	.ops		= &clkops_null,
-	.flags		= CLOCK_IN_OMAP4430 | ALWAYS_ENABLED,
+	.flags		= ALWAYS_ENABLED,
 };
 
 static struct clk slimbus_clk = {
 	.name		= "slimbus_clk",
 	.rate		= 12000000,
 	.ops		= &clkops_null,
-	.flags		= CLOCK_IN_OMAP4430 | ALWAYS_ENABLED,
+	.flags		= ALWAYS_ENABLED,
 };
 
 static struct clk sys_32k_ck = {
 	.name		= "sys_32k_ck",
 	.rate		= 32768,
 	.ops		= &clkops_null,
-	.flags		= CLOCK_IN_OMAP4430 | ALWAYS_ENABLED,
+	.flags		= ALWAYS_ENABLED,
 };
 
 static struct clk virt_12000000_ck = {
@@ -179,35 +179,35 @@ static struct clk sys_clkin_ck = {
 	.clksel_mask	= OMAP4430_SYS_CLKSEL_MASK,
 	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
-	.flags		= CLOCK_IN_OMAP4430 | ALWAYS_ENABLED,
+	.flags		= ALWAYS_ENABLED,
 };
 
 static struct clk utmi_phy_clkout_ck = {
 	.name		= "utmi_phy_clkout_ck",
 	.rate		= 12000000,
 	.ops		= &clkops_null,
-	.flags		= CLOCK_IN_OMAP4430 | ALWAYS_ENABLED,
+	.flags		= ALWAYS_ENABLED,
 };
 
 static struct clk xclk60mhsp1_ck = {
 	.name		= "xclk60mhsp1_ck",
 	.rate		= 12000000,
 	.ops		= &clkops_null,
-	.flags		= CLOCK_IN_OMAP4430 | ALWAYS_ENABLED,
+	.flags		= ALWAYS_ENABLED,
 };
 
 static struct clk xclk60mhsp2_ck = {
 	.name		= "xclk60mhsp2_ck",
 	.rate		= 12000000,
 	.ops		= &clkops_null,
-	.flags		= CLOCK_IN_OMAP4430 | ALWAYS_ENABLED,
+	.flags		= ALWAYS_ENABLED,
 };
 
 static struct clk xclk60motg_ck = {
 	.name		= "xclk60motg_ck",
 	.rate		= 60000000,
 	.ops		= &clkops_null,
-	.flags		= CLOCK_IN_OMAP4430 | ALWAYS_ENABLED,
+	.flags		= ALWAYS_ENABLED,
 };
 
 /* Module clocks and DPLL outputs */
@@ -233,7 +233,6 @@ static struct clk dpll_sys_ref_clk = {
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static const struct clksel abe_dpll_refclk_mux_sel[] = {
@@ -251,7 +250,6 @@ static struct clk abe_dpll_refclk_mux_ck = {
 	.clksel_mask	= OMAP4430_CLKSEL_0_0_MASK,
 	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 /* DPLL_ABE */
@@ -283,7 +281,6 @@ static struct clk dpll_abe_ck = {
 	.recalc		= &omap3_dpll_recalc,
 	.round_rate	= &omap2_dpll_round_rate,
 	.set_rate	= &omap3_noncore_dpll_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static struct clk dpll_abe_m2x2_ck = {
@@ -291,7 +288,6 @@ static struct clk dpll_abe_m2x2_ck = {
 	.parent		= &dpll_abe_ck,
 	.ops		= &clkops_null,
 	.recalc		= &followparent_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static struct clk abe_24m_fclk = {
@@ -299,7 +295,6 @@ static struct clk abe_24m_fclk = {
 	.parent		= &dpll_abe_m2x2_ck,
 	.ops		= &clkops_null,
 	.recalc		= &followparent_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static const struct clksel_rate div3_1to4_rates[] = {
@@ -324,7 +319,6 @@ static struct clk abe_clk = {
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static const struct clksel aess_fclk_div[] = {
@@ -342,7 +336,6 @@ static struct clk aess_fclk = {
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static const struct clksel_rate div31_1to31_rates[] = {
@@ -395,7 +388,6 @@ static struct clk dpll_abe_m3_ck = {
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static const struct clksel core_hsd_byp_clk_mux_sel[] = {
@@ -413,7 +405,6 @@ static struct clk core_hsd_byp_clk_mux_ck = {
 	.clksel_mask	= OMAP4430_DPLL_BYP_CLKSEL_MASK,
 	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 /* DPLL_CORE */
@@ -443,7 +434,6 @@ static struct clk dpll_core_ck = {
 	.init		= &omap2_init_dpll_parent,
 	.ops		= &clkops_null,
 	.recalc		= &omap3_dpll_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static const struct clksel dpll_core_m6_div[] = {
@@ -461,7 +451,6 @@ static struct clk dpll_core_m6_ck = {
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static const struct clksel dbgclk_mux_sel[] = {
@@ -475,7 +464,6 @@ static struct clk dbgclk_mux_ck = {
 	.parent		= &sys_clkin_ck,
 	.ops		= &clkops_null,
 	.recalc		= &followparent_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static struct clk dpll_core_m2_ck = {
@@ -488,7 +476,6 @@ static struct clk dpll_core_m2_ck = {
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static struct clk ddrphy_ck = {
@@ -496,7 +483,6 @@ static struct clk ddrphy_ck = {
 	.parent		= &dpll_core_m2_ck,
 	.ops		= &clkops_null,
 	.recalc		= &followparent_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static struct clk dpll_core_m5_ck = {
@@ -509,7 +495,6 @@ static struct clk dpll_core_m5_ck = {
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static const struct clksel div_core_div[] = {
@@ -527,7 +512,6 @@ static struct clk div_core_ck = {
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static const struct clksel_rate div4_1to8_rates[] = {
@@ -553,7 +537,6 @@ static struct clk div_iva_hs_clk = {
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static struct clk div_mpu_hs_clk = {
@@ -566,7 +549,6 @@ static struct clk div_mpu_hs_clk = {
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static struct clk dpll_core_m4_ck = {
@@ -579,7 +561,6 @@ static struct clk dpll_core_m4_ck = {
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static struct clk dll_clk_div_ck = {
@@ -587,7 +568,6 @@ static struct clk dll_clk_div_ck = {
 	.parent		= &dpll_core_m4_ck,
 	.ops		= &clkops_null,
 	.recalc		= &followparent_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static struct clk dpll_abe_m2_ck = {
@@ -600,7 +580,6 @@ static struct clk dpll_abe_m2_ck = {
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static struct clk dpll_core_m3_ck = {
@@ -613,7 +592,6 @@ static struct clk dpll_core_m3_ck = {
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static struct clk dpll_core_m7_ck = {
@@ -626,7 +604,6 @@ static struct clk dpll_core_m7_ck = {
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static const struct clksel iva_hsd_byp_clk_mux_sel[] = {
@@ -640,7 +617,6 @@ static struct clk iva_hsd_byp_clk_mux_ck = {
 	.parent		= &dpll_sys_ref_clk,
 	.ops		= &clkops_null,
 	.recalc		= &followparent_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 /* DPLL_IVA */
@@ -672,7 +648,6 @@ static struct clk dpll_iva_ck = {
 	.recalc		= &omap3_dpll_recalc,
 	.round_rate	= &omap2_dpll_round_rate,
 	.set_rate	= &omap3_noncore_dpll_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static const struct clksel dpll_iva_m4_div[] = {
@@ -690,7 +665,6 @@ static struct clk dpll_iva_m4_ck = {
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static struct clk dpll_iva_m5_ck = {
@@ -703,7 +677,6 @@ static struct clk dpll_iva_m5_ck = {
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 /* DPLL_MPU */
@@ -735,7 +708,6 @@ static struct clk dpll_mpu_ck = {
 	.recalc		= &omap3_dpll_recalc,
 	.round_rate	= &omap2_dpll_round_rate,
 	.set_rate	= &omap3_noncore_dpll_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static const struct clksel dpll_mpu_m2_div[] = {
@@ -753,7 +725,6 @@ static struct clk dpll_mpu_m2_ck = {
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static struct clk per_hs_clk_div_ck = {
@@ -761,7 +732,6 @@ static struct clk per_hs_clk_div_ck = {
 	.parent		= &dpll_abe_m3_ck,
 	.ops		= &clkops_null,
 	.recalc		= &followparent_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static const struct clksel per_hsd_byp_clk_mux_sel[] = {
@@ -779,7 +749,6 @@ static struct clk per_hsd_byp_clk_mux_ck = {
 	.clksel_mask	= OMAP4430_DPLL_BYP_CLKSEL_MASK,
 	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 /* DPLL_PER */
@@ -811,7 +780,6 @@ static struct clk dpll_per_ck = {
 	.recalc		= &omap3_dpll_recalc,
 	.round_rate	= &omap2_dpll_round_rate,
 	.set_rate	= &omap3_noncore_dpll_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static const struct clksel dpll_per_m2_div[] = {
@@ -829,7 +797,6 @@ static struct clk dpll_per_m2_ck = {
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static struct clk dpll_per_m2x2_ck = {
@@ -837,7 +804,6 @@ static struct clk dpll_per_m2x2_ck = {
 	.parent		= &dpll_per_ck,
 	.ops		= &clkops_null,
 	.recalc		= &followparent_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static struct clk dpll_per_m3_ck = {
@@ -850,7 +816,6 @@ static struct clk dpll_per_m3_ck = {
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static struct clk dpll_per_m4_ck = {
@@ -863,7 +828,6 @@ static struct clk dpll_per_m4_ck = {
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static struct clk dpll_per_m5_ck = {
@@ -876,7 +840,6 @@ static struct clk dpll_per_m5_ck = {
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static struct clk dpll_per_m6_ck = {
@@ -889,7 +852,6 @@ static struct clk dpll_per_m6_ck = {
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static struct clk dpll_per_m7_ck = {
@@ -902,7 +864,6 @@ static struct clk dpll_per_m7_ck = {
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 /* DPLL_UNIPRO */
@@ -934,7 +895,6 @@ static struct clk dpll_unipro_ck = {
 	.recalc		= &omap3_dpll_recalc,
 	.round_rate	= &omap2_dpll_round_rate,
 	.set_rate	= &omap3_noncore_dpll_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static const struct clksel dpll_unipro_m2x2_div[] = {
@@ -952,7 +912,6 @@ static struct clk dpll_unipro_m2x2_ck = {
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static struct clk usb_hs_clk_div_ck = {
@@ -960,7 +919,6 @@ static struct clk usb_hs_clk_div_ck = {
 	.parent		= &dpll_abe_m3_ck,
 	.ops		= &clkops_null,
 	.recalc		= &followparent_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 /* DPLL_USB */
@@ -993,7 +951,6 @@ static struct clk dpll_usb_ck = {
 	.recalc		= &omap3_dpll_recalc,
 	.round_rate	= &omap2_dpll_round_rate,
 	.set_rate	= &omap3_noncore_dpll_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static struct clk dpll_usb_clkdcoldo_ck = {
@@ -1001,7 +958,6 @@ static struct clk dpll_usb_clkdcoldo_ck = {
 	.parent		= &dpll_usb_ck,
 	.ops		= &clkops_null,
 	.recalc		= &followparent_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static const struct clksel dpll_usb_m2_div[] = {
@@ -1019,7 +975,6 @@ static struct clk dpll_usb_m2_ck = {
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static const struct clksel ducati_clk_mux_sel[] = {
@@ -1037,7 +992,6 @@ static struct clk ducati_clk_mux_ck = {
 	.clksel_mask	= OMAP4430_CLKSEL_0_0_MASK,
 	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static struct clk func_12m_fclk = {
@@ -1045,7 +999,6 @@ static struct clk func_12m_fclk = {
 	.parent		= &dpll_per_m2x2_ck,
 	.ops		= &clkops_null,
 	.recalc		= &followparent_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static struct clk func_24m_clk = {
@@ -1053,7 +1006,6 @@ static struct clk func_24m_clk = {
 	.parent		= &dpll_per_m2_ck,
 	.ops		= &clkops_null,
 	.recalc		= &followparent_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static struct clk func_24mc_fclk = {
@@ -1061,7 +1013,6 @@ static struct clk func_24mc_fclk = {
 	.parent		= &dpll_per_m2x2_ck,
 	.ops		= &clkops_null,
 	.recalc		= &followparent_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static const struct clksel_rate div2_4to8_rates[] = {
@@ -1085,7 +1036,6 @@ static struct clk func_48m_fclk = {
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static struct clk func_48mc_fclk = {
@@ -1093,7 +1043,6 @@ static struct clk func_48mc_fclk = {
 	.parent		= &dpll_per_m2x2_ck,
 	.ops		= &clkops_null,
 	.recalc		= &followparent_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static const struct clksel_rate div2_2to4_rates[] = {
@@ -1117,7 +1066,6 @@ static struct clk func_64m_fclk = {
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static const struct clksel func_96m_fclk_div[] = {
@@ -1135,7 +1083,6 @@ static struct clk func_96m_fclk = {
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static const struct clksel hsmmc6_fclk_sel[] = {
@@ -1149,7 +1096,6 @@ static struct clk hsmmc6_fclk = {
 	.parent		= &func_64m_fclk,
 	.ops		= &clkops_null,
 	.recalc		= &followparent_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static const struct clksel_rate div2_1to8_rates[] = {
@@ -1173,7 +1119,6 @@ static struct clk init_60m_fclk = {
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static const struct clksel l3_div_div[] = {
@@ -1191,7 +1136,6 @@ static struct clk l3_div_ck = {
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static const struct clksel l4_div_div[] = {
@@ -1209,7 +1153,6 @@ static struct clk l4_div_ck = {
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static struct clk lp_clk_div_ck = {
@@ -1217,7 +1160,6 @@ static struct clk lp_clk_div_ck = {
 	.parent		= &dpll_abe_m2x2_ck,
 	.ops		= &clkops_null,
 	.recalc		= &followparent_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static const struct clksel l4_wkup_clk_mux_sel[] = {
@@ -1235,7 +1177,6 @@ static struct clk l4_wkup_clk_mux_ck = {
 	.clksel_mask	= OMAP4430_CLKSEL_0_0_MASK,
 	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static const struct clksel per_abe_nc_fclk_div[] = {
@@ -1253,7 +1194,6 @@ static struct clk per_abe_nc_fclk = {
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static const struct clksel mcasp2_fclk_sel[] = {
@@ -1267,7 +1207,6 @@ static struct clk mcasp2_fclk = {
 	.parent		= &func_96m_fclk,
 	.ops		= &clkops_null,
 	.recalc		= &followparent_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static struct clk mcasp3_fclk = {
@@ -1275,7 +1214,6 @@ static struct clk mcasp3_fclk = {
 	.parent		= &func_96m_fclk,
 	.ops		= &clkops_null,
 	.recalc		= &followparent_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static struct clk ocp_abe_iclk = {
@@ -1283,7 +1221,6 @@ static struct clk ocp_abe_iclk = {
 	.parent		= &aess_fclk,
 	.ops		= &clkops_null,
 	.recalc		= &followparent_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static struct clk per_abe_24m_fclk = {
@@ -1291,7 +1228,6 @@ static struct clk per_abe_24m_fclk = {
 	.parent		= &dpll_abe_m2_ck,
 	.ops		= &clkops_null,
 	.recalc		= &followparent_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static const struct clksel pmd_stm_clock_mux_sel[] = {
@@ -1306,7 +1242,6 @@ static struct clk pmd_stm_clock_mux_ck = {
 	.parent		= &sys_clkin_ck,
 	.ops		= &clkops_null,
 	.recalc		= &followparent_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static struct clk pmd_trace_clk_mux_ck = {
@@ -1314,7 +1249,6 @@ static struct clk pmd_trace_clk_mux_ck = {
 	.parent		= &sys_clkin_ck,
 	.ops		= &clkops_null,
 	.recalc		= &followparent_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static struct clk syc_clk_div_ck = {
@@ -1327,7 +1261,6 @@ static struct clk syc_clk_div_ck = {
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 /* Leaf clocks controlled by modules */
@@ -1398,7 +1331,6 @@ static struct clk dmic_sync_mux_ck = {
 	.clksel_mask	= OMAP4430_CLKSEL_INTERNAL_SOURCE_MASK,
 	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static const struct clksel func_dmic_abe_gfclk_sel[] = {
@@ -1418,7 +1350,6 @@ static struct clk dmic_ck = {
 	.clksel_mask	= OMAP4430_CLKSEL_SOURCE_MASK,
 	.ops		= &clkops_omap2_dflt,
 	.recalc		= &omap2_clksel_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 	.enable_reg	= OMAP4430_CM1_ABE_DMIC_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
 	.clkdm_name	= "abe_clkdm",
@@ -1480,7 +1411,6 @@ static struct clk fdif_ck = {
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 	.enable_reg	= OMAP4430_CM_CAM_FDIF_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
 	.clkdm_name	= "iss_clkdm",
@@ -1501,7 +1431,6 @@ static struct clk per_sgx_fclk = {
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static const struct clksel sgx_clk_mux_sel[] = {
@@ -1520,7 +1449,6 @@ static struct clk gfx_ck = {
 	.clksel_mask	= OMAP4430_CLKSEL_SGX_FCLK_MASK,
 	.ops		= &clkops_omap2_dflt,
 	.recalc		= &omap2_clksel_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 	.enable_reg	= OMAP4430_CM_GFX_GFX_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
 	.clkdm_name	= "l3_gfx_clkdm",
@@ -1612,7 +1540,6 @@ static struct clk gptimer1_ck = {
 	.clksel_mask	= OMAP4430_CLKSEL_MASK,
 	.ops		= &clkops_omap2_dflt,
 	.recalc		= &omap2_clksel_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 	.enable_reg	= OMAP4430_CM_WKUP_TIMER1_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
 	.clkdm_name	= "l4_wkup_clkdm",
@@ -1628,7 +1555,6 @@ static struct clk gptimer10_ck = {
 	.clksel_mask	= OMAP4430_CLKSEL_MASK,
 	.ops		= &clkops_omap2_dflt,
 	.recalc		= &omap2_clksel_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 	.enable_reg	= OMAP4430_CM_L4PER_DMTIMER10_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
 	.clkdm_name	= "l4_per_clkdm",
@@ -1644,7 +1570,6 @@ static struct clk gptimer11_ck = {
 	.clksel_mask	= OMAP4430_CLKSEL_MASK,
 	.ops		= &clkops_omap2_dflt,
 	.recalc		= &omap2_clksel_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 	.enable_reg	= OMAP4430_CM_L4PER_DMTIMER11_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
 	.clkdm_name	= "l4_per_clkdm",
@@ -1660,7 +1585,6 @@ static struct clk gptimer2_ck = {
 	.clksel_mask	= OMAP4430_CLKSEL_MASK,
 	.ops		= &clkops_omap2_dflt,
 	.recalc		= &omap2_clksel_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 	.enable_reg	= OMAP4430_CM_L4PER_DMTIMER2_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
 	.clkdm_name	= "l4_per_clkdm",
@@ -1676,7 +1600,6 @@ static struct clk gptimer3_ck = {
 	.clksel_mask	= OMAP4430_CLKSEL_MASK,
 	.ops		= &clkops_omap2_dflt,
 	.recalc		= &omap2_clksel_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 	.enable_reg	= OMAP4430_CM_L4PER_DMTIMER3_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
 	.clkdm_name	= "l4_per_clkdm",
@@ -1692,7 +1615,6 @@ static struct clk gptimer4_ck = {
 	.clksel_mask	= OMAP4430_CLKSEL_MASK,
 	.ops		= &clkops_omap2_dflt,
 	.recalc		= &omap2_clksel_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 	.enable_reg	= OMAP4430_CM_L4PER_DMTIMER4_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
 	.clkdm_name	= "l4_per_clkdm",
@@ -1714,7 +1636,6 @@ static struct clk gptimer5_ck = {
 	.clksel_mask	= OMAP4430_CLKSEL_MASK,
 	.ops		= &clkops_omap2_dflt,
 	.recalc		= &omap2_clksel_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 	.enable_reg	= OMAP4430_CM1_ABE_TIMER5_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
 	.clkdm_name	= "abe_clkdm",
@@ -1730,7 +1651,6 @@ static struct clk gptimer6_ck = {
 	.clksel_mask	= OMAP4430_CLKSEL_MASK,
 	.ops		= &clkops_omap2_dflt,
 	.recalc		= &omap2_clksel_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 	.enable_reg	= OMAP4430_CM1_ABE_TIMER6_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
 	.clkdm_name	= "abe_clkdm",
@@ -1746,7 +1666,6 @@ static struct clk gptimer7_ck = {
 	.clksel_mask	= OMAP4430_CLKSEL_MASK,
 	.ops		= &clkops_omap2_dflt,
 	.recalc		= &omap2_clksel_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 	.enable_reg	= OMAP4430_CM1_ABE_TIMER7_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
 	.clkdm_name	= "abe_clkdm",
@@ -1762,7 +1681,6 @@ static struct clk gptimer8_ck = {
 	.clksel_mask	= OMAP4430_CLKSEL_MASK,
 	.ops		= &clkops_omap2_dflt,
 	.recalc		= &omap2_clksel_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 	.enable_reg	= OMAP4430_CM1_ABE_TIMER8_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
 	.clkdm_name	= "abe_clkdm",
@@ -1778,7 +1696,6 @@ static struct clk gptimer9_ck = {
 	.clksel_mask	= OMAP4430_CLKSEL_MASK,
 	.ops		= &clkops_omap2_dflt,
 	.recalc		= &omap2_clksel_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 	.enable_reg	= OMAP4430_CM_L4PER_DMTIMER9_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
 	.clkdm_name	= "l4_per_clkdm",
@@ -1805,7 +1722,6 @@ static struct clk hsi_ck = {
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 	.enable_reg	= OMAP4430_CM_L3INIT_HSI_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
 	.clkdm_name	= "l3_init_clkdm",
@@ -1910,7 +1826,6 @@ static struct clk mcasp_sync_mux_ck = {
 	.clksel_mask	= OMAP4430_CLKSEL_INTERNAL_SOURCE_MASK,
 	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static const struct clksel func_mcasp_abe_gfclk_sel[] = {
@@ -1930,7 +1845,6 @@ static struct clk mcasp_ck = {
 	.clksel_mask	= OMAP4430_CLKSEL_SOURCE_MASK,
 	.ops		= &clkops_omap2_dflt,
 	.recalc		= &omap2_clksel_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 	.enable_reg	= OMAP4430_CM1_ABE_MCASP_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
 	.clkdm_name	= "abe_clkdm",
@@ -1945,7 +1859,6 @@ static struct clk mcbsp1_sync_mux_ck = {
 	.clksel_mask	= OMAP4430_CLKSEL_INTERNAL_SOURCE_MASK,
 	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static const struct clksel func_mcbsp1_gfclk_sel[] = {
@@ -1965,7 +1878,6 @@ static struct clk mcbsp1_ck = {
 	.clksel_mask	= OMAP4430_CLKSEL_SOURCE_MASK,
 	.ops		= &clkops_omap2_dflt,
 	.recalc		= &omap2_clksel_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 	.enable_reg	= OMAP4430_CM1_ABE_MCBSP1_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
 	.clkdm_name	= "abe_clkdm",
@@ -1980,7 +1892,6 @@ static struct clk mcbsp2_sync_mux_ck = {
 	.clksel_mask	= OMAP4430_CLKSEL_INTERNAL_SOURCE_MASK,
 	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static const struct clksel func_mcbsp2_gfclk_sel[] = {
@@ -2000,7 +1911,6 @@ static struct clk mcbsp2_ck = {
 	.clksel_mask	= OMAP4430_CLKSEL_SOURCE_MASK,
 	.ops		= &clkops_omap2_dflt,
 	.recalc		= &omap2_clksel_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 	.enable_reg	= OMAP4430_CM1_ABE_MCBSP2_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
 	.clkdm_name	= "abe_clkdm",
@@ -2015,7 +1925,6 @@ static struct clk mcbsp3_sync_mux_ck = {
 	.clksel_mask	= OMAP4430_CLKSEL_INTERNAL_SOURCE_MASK,
 	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static const struct clksel func_mcbsp3_gfclk_sel[] = {
@@ -2035,7 +1944,6 @@ static struct clk mcbsp3_ck = {
 	.clksel_mask	= OMAP4430_CLKSEL_SOURCE_MASK,
 	.ops		= &clkops_omap2_dflt,
 	.recalc		= &omap2_clksel_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 	.enable_reg	= OMAP4430_CM1_ABE_MCBSP3_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
 	.clkdm_name	= "abe_clkdm",
@@ -2050,7 +1958,6 @@ static struct clk mcbsp4_sync_mux_ck = {
 	.clksel_mask	= OMAP4430_CLKSEL_INTERNAL_SOURCE_MASK,
 	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static const struct clksel per_mcbsp4_gfclk_sel[] = {
@@ -2069,7 +1976,6 @@ static struct clk mcbsp4_ck = {
 	.clksel_mask	= OMAP4430_CLKSEL_SOURCE_24_24_MASK,
 	.ops		= &clkops_omap2_dflt,
 	.recalc		= &omap2_clksel_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 	.enable_reg	= OMAP4430_CM_L4PER_MCBSP4_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
 	.clkdm_name	= "l4_per_clkdm",
@@ -2125,7 +2031,6 @@ static struct clk mmc1_ck = {
 	.clksel_mask	= OMAP4430_CLKSEL_MASK,
 	.ops		= &clkops_omap2_dflt,
 	.recalc		= &omap2_clksel_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 	.enable_reg	= OMAP4430_CM_L3INIT_MMC1_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
 	.clkdm_name	= "l3_init_clkdm",
@@ -2141,7 +2046,6 @@ static struct clk mmc2_ck = {
 	.clksel_mask	= OMAP4430_CLKSEL_MASK,
 	.ops		= &clkops_omap2_dflt,
 	.recalc		= &omap2_clksel_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 	.enable_reg	= OMAP4430_CM_L3INIT_MMC2_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
 	.clkdm_name	= "l3_init_clkdm",
@@ -2443,7 +2347,6 @@ static struct clk otg_60m_gfclk_ck = {
 	.clksel_mask	= OMAP4430_CLKSEL_60M_MASK,
 	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static const struct clksel stm_clk_div_div[] = {
@@ -2461,7 +2364,6 @@ static struct clk stm_clk_div_ck = {
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static const struct clksel trace_clk_div_div[] = {
@@ -2479,7 +2381,6 @@ static struct clk trace_clk_div_ck = {
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static const struct clksel_rate div2_14to18_rates[] = {
@@ -2503,7 +2404,6 @@ static struct clk usim_fclk = {
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static const struct clksel utmi_p1_gfclk_sel[] = {
@@ -2521,7 +2421,6 @@ static struct clk utmi_p1_gfclk_ck = {
 	.clksel_mask	= OMAP4430_CLKSEL_UTMI_P1_MASK,
 	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 static const struct clksel utmi_p2_gfclk_sel[] = {
@@ -2539,7 +2438,6 @@ static struct clk utmi_p2_gfclk_ck = {
 	.clksel_mask	= OMAP4430_CLKSEL_UTMI_P2_MASK,
 	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
-	.flags		= CLOCK_IN_OMAP4430,
 };
 
 /*
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 7b7d046..1015b1c 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -199,8 +199,8 @@ extern const struct clkops clkops_null;
 #define DELAYED_APP		(1 << 9)	/* Delay application of clock */
 #define CONFIG_PARTICIPANT	(1 << 10)	/* Fundamental clock */
 #define ENABLE_ON_INIT		(1 << 11)	/* Enable upon framework init */
-#define INVERT_ENABLE           (1 << 12)       /* 0 enables, 1 disables */
-#define CLOCK_IN_OMAP4430	(1 << 13)
+#define INVERT_ENABLE		(1 << 12)	/* 0 enables, 1 disables */
+/* bit 13 is currently free */
 #define ALWAYS_ENABLED		(1 << 14)
 /* bits 15-31 are currently free */
 

From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sat, 10 Nov 2012 12:13:41 +0530
Subject: [PATCH 2/8] CLK: SPEAr13xx: Fix mux clock names
In-Reply-To: <cover.1352529508.git.viresh.kumar@linaro.org>
References: <cover.1352529508.git.viresh.kumar@linaro.org>
Message-ID: <d8462e3a359a4021e14bdc49d8bb8923c79e48ab.1352529508.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shiraz Hashim <shiraz.hashim@st.com>

This patch updates mux clock names of multiple clocks. It updates _clk with
_mclk to make it more readable.

Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clk/spear/spear1310_clock.c |  4 ++--
 drivers/clk/spear/spear1340_clock.c | 20 ++++++++++----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/spear/spear1310_clock.c b/drivers/clk/spear/spear1310_clock.c
index f13b1d2..2f1cb71 100644
--- a/drivers/clk/spear/spear1310_clock.c
+++ b/drivers/clk/spear/spear1310_clock.c
@@ -633,7 +633,7 @@ void __init spear1310_clk_init(void)
 			ARRAY_SIZE(clcd_pixel_parents), 0,
 			SPEAR1310_PERIP_CLK_CFG, SPEAR1310_CLCD_CLK_SHIFT,
 			SPEAR1310_CLCD_CLK_MASK, 0, &_lock);
-	clk_register_clkdev(clk, "clcd_pixel_clk", NULL);
+	clk_register_clkdev(clk, "clcd_pixel_mclk", NULL);
 
 	clk = clk_register_gate(NULL, "clcd_clk", "clcd_pixel_mclk", 0,
 			SPEAR1310_PERIP1_CLK_ENB, SPEAR1310_CLCD_CLK_ENB, 0,
@@ -645,7 +645,7 @@ void __init spear1310_clk_init(void)
 			ARRAY_SIZE(i2s_src_parents), 0, SPEAR1310_I2S_CLK_CFG,
 			SPEAR1310_I2S_SRC_CLK_SHIFT, SPEAR1310_I2S_SRC_CLK_MASK,
 			0, &_lock);
-	clk_register_clkdev(clk, "i2s_src_clk", NULL);
+	clk_register_clkdev(clk, "i2s_src_mclk", NULL);
 
 	clk = clk_register_aux("i2s_prs1_clk", NULL, "i2s_src_mclk", 0,
 			SPEAR1310_I2S_CLK_CFG, &i2s_prs1_masks, i2s_prs1_rtbl,
diff --git a/drivers/clk/spear/spear1340_clock.c b/drivers/clk/spear/spear1340_clock.c
index dae2ba6..4733d99 100644
--- a/drivers/clk/spear/spear1340_clock.c
+++ b/drivers/clk/spear/spear1340_clock.c
@@ -521,7 +521,7 @@ void __init spear1340_clk_init(void)
 			ARRAY_SIZE(sys_parents), 0, SPEAR1340_SYS_CLK_CTRL,
 			SPEAR1340_SCLK_SRC_SEL_SHIFT,
 			SPEAR1340_SCLK_SRC_SEL_MASK, 0, &_lock);
-	clk_register_clkdev(clk, "sys_clk", NULL);
+	clk_register_clkdev(clk, "sys_mclk", NULL);
 
 	clk = clk_register_fixed_factor(NULL, "cpu_clk", "sys_mclk", 0, 1,
 			2);
@@ -697,7 +697,7 @@ void __init spear1340_clk_init(void)
 			ARRAY_SIZE(clcd_pixel_parents), 0,
 			SPEAR1340_PERIP_CLK_CFG, SPEAR1340_CLCD_CLK_SHIFT,
 			SPEAR1340_CLCD_CLK_MASK, 0, &_lock);
-	clk_register_clkdev(clk, "clcd_pixel_clk", NULL);
+	clk_register_clkdev(clk, "clcd_pixel_mclk", NULL);
 
 	clk = clk_register_gate(NULL, "clcd_clk", "clcd_pixel_mclk", 0,
 			SPEAR1340_PERIP1_CLK_ENB, SPEAR1340_CLCD_CLK_ENB, 0,
@@ -709,7 +709,7 @@ void __init spear1340_clk_init(void)
 			ARRAY_SIZE(i2s_src_parents), 0, SPEAR1340_I2S_CLK_CFG,
 			SPEAR1340_I2S_SRC_CLK_SHIFT, SPEAR1340_I2S_SRC_CLK_MASK,
 			0, &_lock);
-	clk_register_clkdev(clk, "i2s_src_clk", NULL);
+	clk_register_clkdev(clk, "i2s_src_mclk", NULL);
 
 	clk = clk_register_aux("i2s_prs1_clk", NULL, "i2s_src_mclk", 0,
 			SPEAR1340_I2S_CLK_CFG, &i2s_prs1_masks, i2s_prs1_rtbl,
@@ -720,7 +720,7 @@ void __init spear1340_clk_init(void)
 			ARRAY_SIZE(i2s_ref_parents), 0, SPEAR1340_I2S_CLK_CFG,
 			SPEAR1340_I2S_REF_SHIFT, SPEAR1340_I2S_REF_SEL_MASK, 0,
 			&_lock);
-	clk_register_clkdev(clk, "i2s_ref_clk", NULL);
+	clk_register_clkdev(clk, "i2s_ref_mclk", NULL);
 
 	clk = clk_register_gate(NULL, "i2s_ref_pad_clk", "i2s_ref_mclk", 0,
 			SPEAR1340_PERIP2_CLK_ENB, SPEAR1340_I2S_REF_PAD_CLK_ENB,
@@ -846,30 +846,30 @@ void __init spear1340_clk_init(void)
 			ARRAY_SIZE(gen_synth0_1_parents), 0, SPEAR1340_PLL_CFG,
 			SPEAR1340_GEN_SYNT0_1_CLK_SHIFT,
 			SPEAR1340_GEN_SYNT_CLK_MASK, 0, &_lock);
-	clk_register_clkdev(clk, "gen_syn0_1_clk", NULL);
+	clk_register_clkdev(clk, "gen_syn0_1_mclk", NULL);
 
 	clk = clk_register_mux(NULL, "gen_syn2_3_mclk", gen_synth2_3_parents,
 			ARRAY_SIZE(gen_synth2_3_parents), 0, SPEAR1340_PLL_CFG,
 			SPEAR1340_GEN_SYNT2_3_CLK_SHIFT,
 			SPEAR1340_GEN_SYNT_CLK_MASK, 0, &_lock);
-	clk_register_clkdev(clk, "gen_syn2_3_clk", NULL);
+	clk_register_clkdev(clk, "gen_syn2_3_mclk", NULL);
 
-	clk = clk_register_frac("gen_syn0_clk", "gen_syn0_1_clk", 0,
+	clk = clk_register_frac("gen_syn0_clk", "gen_syn0_1_mclk", 0,
 			SPEAR1340_GEN_CLK_SYNT0, gen_rtbl, ARRAY_SIZE(gen_rtbl),
 			&_lock);
 	clk_register_clkdev(clk, "gen_syn0_clk", NULL);
 
-	clk = clk_register_frac("gen_syn1_clk", "gen_syn0_1_clk", 0,
+	clk = clk_register_frac("gen_syn1_clk", "gen_syn0_1_mclk", 0,
 			SPEAR1340_GEN_CLK_SYNT1, gen_rtbl, ARRAY_SIZE(gen_rtbl),
 			&_lock);
 	clk_register_clkdev(clk, "gen_syn1_clk", NULL);
 
-	clk = clk_register_frac("gen_syn2_clk", "gen_syn2_3_clk", 0,
+	clk = clk_register_frac("gen_syn2_clk", "gen_syn2_3_mclk", 0,
 			SPEAR1340_GEN_CLK_SYNT2, gen_rtbl, ARRAY_SIZE(gen_rtbl),
 			&_lock);
 	clk_register_clkdev(clk, "gen_syn2_clk", NULL);
 
-	clk = clk_register_frac("gen_syn3_clk", "gen_syn2_3_clk", 0,
+	clk = clk_register_frac("gen_syn3_clk", "gen_syn2_3_mclk", 0,
 			SPEAR1340_GEN_CLK_SYNT3, gen_rtbl, ARRAY_SIZE(gen_rtbl),
 			&_lock);
 	clk_register_clkdev(clk, "gen_syn3_clk", NULL);
-- 
1.7.12.rc2.18.g61b472e

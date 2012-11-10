From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sat, 10 Nov 2012 12:13:42 +0530
Subject: [PATCH 3/8] CLK: SPEAr13xx: fix parent names of multiple clocks
In-Reply-To: <cover.1352529508.git.viresh.kumar@linaro.org>
References: <cover.1352529508.git.viresh.kumar@linaro.org>
Message-ID: <e251a2f4fb6ab547cfd454efdf03298fdf7b2860.1352529508.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shiraz Hashim <shiraz.hashim@st.com>

This patch fixes parent names of multiple clocks.

Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clk/spear/spear1310_clock.c | 2 +-
 drivers/clk/spear/spear1340_clock.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/spear/spear1310_clock.c b/drivers/clk/spear/spear1310_clock.c
index 2f1cb71..e84b1fb 100644
--- a/drivers/clk/spear/spear1310_clock.c
+++ b/drivers/clk/spear/spear1310_clock.c
@@ -664,7 +664,7 @@ void __init spear1310_clk_init(void)
 	clk_register_clkdev(clk, "i2s_ref_pad_clk", NULL);
 
 	clk = clk_register_aux("i2s_sclk_clk", "i2s_sclk_gclk",
-			"i2s_ref_pad_clk", 0, SPEAR1310_I2S_CLK_CFG,
+			"i2s_ref_mclk", 0, SPEAR1310_I2S_CLK_CFG,
 			&i2s_sclk_masks, i2s_sclk_rtbl,
 			ARRAY_SIZE(i2s_sclk_rtbl), &_lock, &clk1);
 	clk_register_clkdev(clk, "i2s_sclk_clk", NULL);
diff --git a/drivers/clk/spear/spear1340_clock.c b/drivers/clk/spear/spear1340_clock.c
index 4733d99..020431a 100644
--- a/drivers/clk/spear/spear1340_clock.c
+++ b/drivers/clk/spear/spear1340_clock.c
@@ -370,7 +370,7 @@ static struct frac_rate_tbl gen_rtbl[] = {
 /* clock parents */
 static const char *vco_parents[] = { "osc_24m_clk", "osc_25m_clk", };
 static const char *sys_parents[] = { "pll1_clk", "pll1_clk", "pll1_clk",
-	"pll1_clk", "sys_synth_clk", "sys_synth_clk", "pll2_clk", "pll3_clk", };
+	"pll1_clk", "sys_syn_clk", "sys_syn_clk", "pll2_clk", "pll3_clk", };
 static const char *ahb_parents[] = { "cpu_div3_clk", "amba_syn_clk", };
 static const char *gpt_parents[] = { "osc_24m_clk", "apb_clk", };
 static const char *uart0_parents[] = { "pll5_clk", "osc_24m_clk",
@@ -391,7 +391,7 @@ static const char *spdif_in_parents[] = { "pll2_clk", "gen_syn3_clk", };
 
 static const char *gen_synth0_1_parents[] = { "vco1div4_clk", "vco3div2_clk",
 	"pll3_clk", };
-static const char *gen_synth2_3_parents[] = { "vco1div4_clk", "vco3div2_clk",
+static const char *gen_synth2_3_parents[] = { "vco1div4_clk", "vco2div2_clk",
 	"pll2_clk", };
 
 void __init spear1340_clk_init(void)
@@ -956,7 +956,7 @@ void __init spear1340_clk_init(void)
 			&_lock);
 	clk_register_clkdev(clk, NULL, "d0500000.cam3");
 
-	clk = clk_register_gate(NULL, "pwm_clk", "pwm_mclk", 0,
+	clk = clk_register_gate(NULL, "pwm_clk", "ahb_clk", 0,
 			SPEAR1340_PERIP3_CLK_ENB, SPEAR1340_PWM_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "e0180000.pwm");
-- 
1.7.12.rc2.18.g61b472e

From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sat, 10 Nov 2012 12:13:44 +0530
Subject: [PATCH 5/8] CLK: SPEAr: Add missing clocks
In-Reply-To: <cover.1352529508.git.viresh.kumar@linaro.org>
References: <cover.1352529508.git.viresh.kumar@linaro.org>
Message-ID: <98db45b077ddc4697205e8755f124a7bb3c16ad4.1352529508.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vipul Kumar Samar <vipulkumar.samar@st.com>

This patch adds missing clocks: twd and macb.

Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
Signed-off-by: Deepak Sikri <deepak.sikri@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clk/spear/spear1310_clock.c | 4 ++++
 drivers/clk/spear/spear1340_clock.c | 4 ++++
 drivers/clk/spear/spear3xx_clock.c  | 8 ++++++++
 3 files changed, 16 insertions(+)

diff --git a/drivers/clk/spear/spear1310_clock.c b/drivers/clk/spear/spear1310_clock.c
index 2809b67..b64d511 100644
--- a/drivers/clk/spear/spear1310_clock.c
+++ b/drivers/clk/spear/spear1310_clock.c
@@ -491,6 +491,10 @@ void __init spear1310_clk_init(void)
 			2);
 	clk_register_clkdev(clk, NULL, "ec800620.wdt");
 
+	clk = clk_register_fixed_factor(NULL, "smp_twd_clk", "cpu_clk", 0, 1,
+			2);
+	clk_register_clkdev(clk, NULL, "smp_twd");
+
 	clk = clk_register_fixed_factor(NULL, "ahb_clk", "pll1_clk", 0, 1,
 			6);
 	clk_register_clkdev(clk, "ahb_clk", NULL);
diff --git a/drivers/clk/spear/spear1340_clock.c b/drivers/clk/spear/spear1340_clock.c
index aa5ed43..8f00533 100644
--- a/drivers/clk/spear/spear1340_clock.c
+++ b/drivers/clk/spear/spear1340_clock.c
@@ -535,6 +535,10 @@ void __init spear1340_clk_init(void)
 			2);
 	clk_register_clkdev(clk, NULL, "ec800620.wdt");
 
+	clk = clk_register_fixed_factor(NULL, "smp_twd_clk", "cpu_clk", 0, 1,
+			2);
+	clk_register_clkdev(clk, NULL, "smp_twd");
+
 	clk = clk_register_mux(NULL, "ahb_clk", ahb_parents,
 			ARRAY_SIZE(ahb_parents), 0, SPEAR1340_SYS_CLK_CTRL,
 			SPEAR1340_HCLK_SRC_SEL_SHIFT,
diff --git a/drivers/clk/spear/spear3xx_clock.c b/drivers/clk/spear/spear3xx_clock.c
index de28152..1cc034b 100644
--- a/drivers/clk/spear/spear3xx_clock.c
+++ b/drivers/clk/spear/spear3xx_clock.c
@@ -284,6 +284,14 @@ static void __init spear320_clk_init(void)
 			4);
 	clk_register_clkdev(clk, "i2s_sclk", NULL);
 
+	clk = clk_register_fixed_factor(NULL, "macb1_clk", "ras_apb_clk", 0, 1,
+			1);
+	clk_register_clkdev(clk, "hclk", "aa000000.eth");
+
+	clk = clk_register_fixed_factor(NULL, "macb2_clk", "ras_apb_clk", 0, 1,
+			1);
+	clk_register_clkdev(clk, "hclk", "ab000000.eth");
+
 	clk = clk_register_mux(NULL, "rs485_clk", uartx_parents,
 			ARRAY_SIZE(uartx_parents), CLK_SET_RATE_PARENT,
 			SPEAR320_EXT_CTRL_REG, SPEAR320_RS485_PCLK_SHIFT,
-- 
1.7.12.rc2.18.g61b472e

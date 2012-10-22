From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Mon, 22 Oct 2012 15:57:59 +0200
Subject: [PATCH 3/5] clk: ux500: Register msp clock lookups for u8500
In-Reply-To: <1350914281-1332-1-git-send-email-ulf.hansson@stericsson.com>
References: <1350914281-1332-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1350914281-1332-4-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/clk/ux500/u8500_clk.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/clk/ux500/u8500_clk.c b/drivers/clk/ux500/u8500_clk.c
index 36ef41d..be843ba 100644
--- a/drivers/clk/ux500/u8500_clk.c
+++ b/drivers/clk/ux500/u8500_clk.c
@@ -232,8 +232,13 @@ void u8500_clk_init(void)
 
 	clk = clk_reg_prcc_pclk("p1_pclk3", "per1clk", U8500_CLKRST1_BASE,
 				BIT(3), 0);
+	clk_register_clkdev(clk, "apb_pclk", "msp0");
+	clk_register_clkdev(clk, "apb_pclk", "ux500-msp-i2s.0");
+
 	clk = clk_reg_prcc_pclk("p1_pclk4", "per1clk", U8500_CLKRST1_BASE,
 				BIT(4), 0);
+	clk_register_clkdev(clk, "apb_pclk", "msp1");
+	clk_register_clkdev(clk, "apb_pclk", "ux500-msp-i2s.1");
 
 	clk = clk_reg_prcc_pclk("p1_pclk5", "per1clk", U8500_CLKRST1_BASE,
 				BIT(5), 0);
@@ -262,6 +267,8 @@ void u8500_clk_init(void)
 
 	clk = clk_reg_prcc_pclk("p1_pclk11", "per1clk", U8500_CLKRST1_BASE,
 				BIT(11), 0);
+	clk_register_clkdev(clk, "apb_pclk", "msp3");
+	clk_register_clkdev(clk, "apb_pclk", "ux500-msp-i2s.3");
 
 	clk = clk_reg_prcc_pclk("p2_pclk0", "per2clk", U8500_CLKRST2_BASE,
 				BIT(0), 0);
@@ -285,6 +292,8 @@ void u8500_clk_init(void)
 
 	clk = clk_reg_prcc_pclk("p2_pclk5", "per2clk", U8500_CLKRST2_BASE,
 				BIT(5), 0);
+	clk_register_clkdev(clk, "apb_pclk", "msp2");
+	clk_register_clkdev(clk, "apb_pclk", "ux500-msp-i2s.2");
 
 	clk = clk_reg_prcc_pclk("p2_pclk6", "per2clk", U8500_CLKRST2_BASE,
 				BIT(6), 0);
@@ -415,8 +424,13 @@ void u8500_clk_init(void)
 
 	clk = clk_reg_prcc_kclk("p1_msp0_kclk", "msp02clk",
 			U8500_CLKRST1_BASE, BIT(3), CLK_SET_RATE_GATE);
+	clk_register_clkdev(clk, NULL, "msp0");
+	clk_register_clkdev(clk, NULL, "ux500-msp-i2s.0");
+
 	clk = clk_reg_prcc_kclk("p1_msp1_kclk", "msp1clk",
 			U8500_CLKRST1_BASE, BIT(4), CLK_SET_RATE_GATE);
+	clk_register_clkdev(clk, NULL, "msp1");
+	clk_register_clkdev(clk, NULL, "ux500-msp-i2s.1");
 
 	clk = clk_reg_prcc_kclk("p1_sdi0_kclk", "sdmmcclk",
 			U8500_CLKRST1_BASE, BIT(5), CLK_SET_RATE_GATE);
@@ -436,6 +450,8 @@ void u8500_clk_init(void)
 
 	clk = clk_reg_prcc_kclk("p1_msp3_kclk", "msp1clk",
 			U8500_CLKRST1_BASE, BIT(10), CLK_SET_RATE_GATE);
+	clk_register_clkdev(clk, NULL, "msp3");
+	clk_register_clkdev(clk, NULL, "ux500-msp-i2s.3");
 
 	/* Periph2 */
 	clk = clk_reg_prcc_kclk("p2_i2c3_kclk", "i2cclk",
@@ -448,6 +464,8 @@ void u8500_clk_init(void)
 
 	clk = clk_reg_prcc_kclk("p2_msp2_kclk", "msp02clk",
 			U8500_CLKRST2_BASE, BIT(3), CLK_SET_RATE_GATE);
+	clk_register_clkdev(clk, NULL, "msp2");
+	clk_register_clkdev(clk, NULL, "ux500-msp-i2s.2");
 
 	clk = clk_reg_prcc_kclk("p2_sdi1_kclk", "sdmmcclk",
 			U8500_CLKRST2_BASE, BIT(4), CLK_SET_RATE_GATE);
-- 
1.7.10

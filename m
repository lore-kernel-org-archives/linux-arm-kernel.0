From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Mon, 22 Oct 2012 15:57:57 +0200
Subject: [PATCH 1/5] clk: ux500: Register i2c clock lookups for u8500
In-Reply-To: <1350914281-1332-1-git-send-email-ulf.hansson@stericsson.com>
References: <1350914281-1332-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1350914281-1332-2-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Wolfram Sang <w.sang@pengutronix.de>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/clk/ux500/u8500_clk.c |   19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ux500/u8500_clk.c b/drivers/clk/ux500/u8500_clk.c
index ca4a25e..7ad01aa 100644
--- a/drivers/clk/ux500/u8500_clk.c
+++ b/drivers/clk/ux500/u8500_clk.c
@@ -228,6 +228,8 @@ void u8500_clk_init(void)
 
 	clk = clk_reg_prcc_pclk("p1_pclk2", "per1clk", U8500_CLKRST1_BASE,
 				BIT(2), 0);
+	clk_register_clkdev(clk, "apb_pclk", "nmk-i2c.1");
+
 	clk = clk_reg_prcc_pclk("p1_pclk3", "per1clk", U8500_CLKRST1_BASE,
 				BIT(3), 0);
 	clk = clk_reg_prcc_pclk("p1_pclk4", "per1clk", U8500_CLKRST1_BASE,
@@ -239,6 +241,7 @@ void u8500_clk_init(void)
 
 	clk = clk_reg_prcc_pclk("p1_pclk6", "per1clk", U8500_CLKRST1_BASE,
 				BIT(6), 0);
+	clk_register_clkdev(clk, "apb_pclk", "nmk-i2c.2");
 
 	clk = clk_reg_prcc_pclk("p1_pclk7", "per1clk", U8500_CLKRST1_BASE,
 				BIT(7), 0);
@@ -255,11 +258,14 @@ void u8500_clk_init(void)
 
 	clk = clk_reg_prcc_pclk("p1_pclk10", "per1clk", U8500_CLKRST1_BASE,
 				BIT(10), 0);
+	clk_register_clkdev(clk, "apb_pclk", "nmk-i2c.4");
+
 	clk = clk_reg_prcc_pclk("p1_pclk11", "per1clk", U8500_CLKRST1_BASE,
 				BIT(11), 0);
 
 	clk = clk_reg_prcc_pclk("p2_pclk0", "per2clk", U8500_CLKRST2_BASE,
 				BIT(0), 0);
+	clk_register_clkdev(clk, "apb_pclk", "nmk-i2c.3");
 
 	clk = clk_reg_prcc_pclk("p2_pclk1", "per2clk", U8500_CLKRST2_BASE,
 				BIT(1), 0);
@@ -284,7 +290,6 @@ void u8500_clk_init(void)
 				BIT(6), 0);
 	clk_register_clkdev(clk, "apb_pclk", "sdi1");
 
-
 	clk = clk_reg_prcc_pclk("p2_pclk7", "per2clk", U8500_CLKRST2_BASE,
 				BIT(7), 0);
 	clk_register_clkdev(clk, "apb_pclk", "sdi3");
@@ -318,8 +323,10 @@ void u8500_clk_init(void)
 				BIT(1), 0);
 	clk = clk_reg_prcc_pclk("p3_pclk2", "per3clk", U8500_CLKRST3_BASE,
 				BIT(2), 0);
+
 	clk = clk_reg_prcc_pclk("p3_pclk3", "per3clk", U8500_CLKRST3_BASE,
 				BIT(3), 0);
+	clk_register_clkdev(clk, "apb_pclk", "nmk-i2c.0");
 
 	clk = clk_reg_prcc_pclk("p3_pclk4", "per3clk", U8500_CLKRST3_BASE,
 				BIT(4), 0);
@@ -401,6 +408,8 @@ void u8500_clk_init(void)
 
 	clk = clk_reg_prcc_kclk("p1_i2c1_kclk", "i2cclk",
 			U8500_CLKRST1_BASE, BIT(2), CLK_SET_RATE_GATE);
+	clk_register_clkdev(clk, NULL, "nmk-i2c.1");
+
 	clk = clk_reg_prcc_kclk("p1_msp0_kclk", "msp02clk",
 			U8500_CLKRST1_BASE, BIT(3), CLK_SET_RATE_GATE);
 	clk = clk_reg_prcc_kclk("p1_msp1_kclk", "msp1clk",
@@ -412,17 +421,23 @@ void u8500_clk_init(void)
 
 	clk = clk_reg_prcc_kclk("p1_i2c2_kclk", "i2cclk",
 			U8500_CLKRST1_BASE, BIT(6), CLK_SET_RATE_GATE);
+	clk_register_clkdev(clk, NULL, "nmk-i2c.2");
+
 	clk = clk_reg_prcc_kclk("p1_slimbus0_kclk", "slimclk",
 			U8500_CLKRST1_BASE, BIT(3), CLK_SET_RATE_GATE);
 	/* FIXME: Redefinition of BIT(3). */
+
 	clk = clk_reg_prcc_kclk("p1_i2c4_kclk", "i2cclk",
 			U8500_CLKRST1_BASE, BIT(9), CLK_SET_RATE_GATE);
+	clk_register_clkdev(clk, NULL, "nmk-i2c.4");
+
 	clk = clk_reg_prcc_kclk("p1_msp3_kclk", "msp1clk",
 			U8500_CLKRST1_BASE, BIT(10), CLK_SET_RATE_GATE);
 
 	/* Periph2 */
 	clk = clk_reg_prcc_kclk("p2_i2c3_kclk", "i2cclk",
 			U8500_CLKRST2_BASE, BIT(0), CLK_SET_RATE_GATE);
+	clk_register_clkdev(clk, NULL, "nmk-i2c.3");
 
 	clk = clk_reg_prcc_kclk("p2_sdi4_kclk", "sdmmcclk",
 			U8500_CLKRST2_BASE, BIT(2), CLK_SET_RATE_GATE);
@@ -452,8 +467,10 @@ void u8500_clk_init(void)
 			U8500_CLKRST3_BASE, BIT(1), CLK_SET_RATE_GATE);
 	clk = clk_reg_prcc_kclk("p3_ssp1_kclk", "sspclk",
 			U8500_CLKRST3_BASE, BIT(2), CLK_SET_RATE_GATE);
+
 	clk = clk_reg_prcc_kclk("p3_i2c0_kclk", "i2cclk",
 			U8500_CLKRST3_BASE, BIT(3), CLK_SET_RATE_GATE);
+	clk_register_clkdev(clk, NULL, "nmk-i2c.0");
 
 	clk = clk_reg_prcc_kclk("p3_sdi2_kclk", "sdmmcclk",
 			U8500_CLKRST3_BASE, BIT(4), CLK_SET_RATE_GATE);
-- 
1.7.10

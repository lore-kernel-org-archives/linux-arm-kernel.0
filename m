From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Mon, 22 Oct 2012 15:57:58 +0200
Subject: [PATCH 2/5] clk: ux500: Register ssp clock lookups for u8500
In-Reply-To: <1350914281-1332-1-git-send-email-ulf.hansson@stericsson.com>
References: <1350914281-1332-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1350914281-1332-3-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/clk/ux500/u8500_clk.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/ux500/u8500_clk.c b/drivers/clk/ux500/u8500_clk.c
index 7ad01aa..36ef41d 100644
--- a/drivers/clk/ux500/u8500_clk.c
+++ b/drivers/clk/ux500/u8500_clk.c
@@ -321,8 +321,11 @@ void u8500_clk_init(void)
 
 	clk = clk_reg_prcc_pclk("p3_pclk1", "per3clk", U8500_CLKRST3_BASE,
 				BIT(1), 0);
+	clk_register_clkdev(clk, "apb_pclk", "ssp0");
+
 	clk = clk_reg_prcc_pclk("p3_pclk2", "per3clk", U8500_CLKRST3_BASE,
 				BIT(2), 0);
+	clk_register_clkdev(clk, "apb_pclk", "ssp1");
 
 	clk = clk_reg_prcc_pclk("p3_pclk3", "per3clk", U8500_CLKRST3_BASE,
 				BIT(3), 0);
@@ -465,8 +468,11 @@ void u8500_clk_init(void)
 	/* Periph3 */
 	clk = clk_reg_prcc_kclk("p3_ssp0_kclk", "sspclk",
 			U8500_CLKRST3_BASE, BIT(1), CLK_SET_RATE_GATE);
+	clk_register_clkdev(clk, NULL, "ssp0");
+
 	clk = clk_reg_prcc_kclk("p3_ssp1_kclk", "sspclk",
 			U8500_CLKRST3_BASE, BIT(2), CLK_SET_RATE_GATE);
+	clk_register_clkdev(clk, NULL, "ssp1");
 
 	clk = clk_reg_prcc_kclk("p3_i2c0_kclk", "i2cclk",
 			U8500_CLKRST3_BASE, BIT(3), CLK_SET_RATE_GATE);
-- 
1.7.10

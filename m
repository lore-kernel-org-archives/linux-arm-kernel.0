From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Mon, 22 Oct 2012 15:58:01 +0200
Subject: [PATCH 5/5] clk: ux500: Register slimbus clock lookups for u8500
In-Reply-To: <1350914281-1332-1-git-send-email-ulf.hansson@stericsson.com>
References: <1350914281-1332-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1350914281-1332-6-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

At the same time the prcc bit for the kclk is corrected to
bit 8 instead of 3.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/clk/ux500/u8500_clk.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/ux500/u8500_clk.c b/drivers/clk/ux500/u8500_clk.c
index 0aae929..e2c17d1 100644
--- a/drivers/clk/ux500/u8500_clk.c
+++ b/drivers/clk/ux500/u8500_clk.c
@@ -254,6 +254,7 @@ void u8500_clk_init(void)
 
 	clk = clk_reg_prcc_pclk("p1_pclk8", "per1clk", U8500_CLKRST1_BASE,
 				BIT(8), 0);
+	clk_register_clkdev(clk, "apb_pclk", "slimbus0");
 
 	clk = clk_reg_prcc_pclk("p1_pclk9", "per1clk", U8500_CLKRST1_BASE,
 				BIT(9), 0);
@@ -441,8 +442,8 @@ void u8500_clk_init(void)
 	clk_register_clkdev(clk, NULL, "nmk-i2c.2");
 
 	clk = clk_reg_prcc_kclk("p1_slimbus0_kclk", "slimclk",
-			U8500_CLKRST1_BASE, BIT(3), CLK_SET_RATE_GATE);
-	/* FIXME: Redefinition of BIT(3). */
+			U8500_CLKRST1_BASE, BIT(8), CLK_SET_RATE_GATE);
+	clk_register_clkdev(clk, NULL, "slimbus0");
 
 	clk = clk_reg_prcc_kclk("p1_i2c4_kclk", "i2cclk",
 			U8500_CLKRST1_BASE, BIT(9), CLK_SET_RATE_GATE);
-- 
1.7.10

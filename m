From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Wed, 31 Oct 2012 14:40:52 +0100
Subject: [PATCH 1/2] clk: ux500: Register rng clock lookups for u8500
In-Reply-To: <1351690853-13021-1-git-send-email-ulf.hansson@stericsson.com>
References: <1351690853-13021-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1351690853-13021-2-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/clk/ux500/u8500_clk.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ux500/u8500_clk.c b/drivers/clk/ux500/u8500_clk.c
index afdf738..6390486 100644
--- a/drivers/clk/ux500/u8500_clk.c
+++ b/drivers/clk/ux500/u8500_clk.c
@@ -371,6 +371,7 @@ void u8500_clk_init(void)
 
 	clk = clk_reg_prcc_pclk("p6_pclk0", "per6clk", U8500_CLKRST6_BASE,
 				BIT(0), 0);
+	clk_register_clkdev(clk, "apb_pclk", "rng");
 
 	clk = clk_reg_prcc_pclk("p6_pclk1", "per6clk", U8500_CLKRST6_BASE,
 				BIT(1), 0);
@@ -514,5 +515,5 @@ void u8500_clk_init(void)
 	/* Periph6 */
 	clk = clk_reg_prcc_kclk("p3_rng_kclk", "rngclk",
 			U8500_CLKRST6_BASE, BIT(0), CLK_SET_RATE_GATE);
-
+	clk_register_clkdev(clk, NULL, "rng");
 }
-- 
1.7.10

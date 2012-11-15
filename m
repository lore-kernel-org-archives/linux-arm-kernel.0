From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 15 Nov 2012 14:55:29 +0100
Subject: [PATCH 1/2] clk: ux500: Register mtu apb_pclocks
Message-ID: <1352987729-9387-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Mike Turquette <mturquette@ti.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/clk/ux500/u8500_clk.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/ux500/u8500_clk.c b/drivers/clk/ux500/u8500_clk.c
index ab30ce8..1f6bfb8 100644
--- a/drivers/clk/ux500/u8500_clk.c
+++ b/drivers/clk/ux500/u8500_clk.c
@@ -160,12 +160,6 @@ void u8500_clk_init(void)
 	clk = clk_reg_prcmu_gate("uiccclk", NULL, PRCMU_UICCCLK, CLK_IS_ROOT);
 	clk_register_clkdev(clk, NULL, "uicc");
 
-	/*
-	 * FIXME: The MTU clocks might need some kind of "parent muxed join"
-	 * and these have no K-clocks. For now, we ignore the missing
-	 * connection to the corresponding P-clocks, p6_mtu0_clk and
-	 * p6_mtu1_clk. Instead timclk is used which is the valid parent.
-	 */
 	clk = clk_reg_prcmu_gate("timclk", NULL, PRCMU_TIMCLK, CLK_IS_ROOT);
 	clk_register_clkdev(clk, NULL, "mtu0");
 	clk_register_clkdev(clk, NULL, "mtu1");
@@ -379,8 +373,11 @@ void u8500_clk_init(void)
 
 	clk = clk_reg_prcc_pclk("p6_pclk6", "per6clk", U8500_CLKRST6_BASE,
 				BIT(6), 0);
+	clk_register_clkdev(clk, "apb_pclk", "mtu0");
+
 	clk = clk_reg_prcc_pclk("p6_pclk7", "per6clk", U8500_CLKRST6_BASE,
 				BIT(7), 0);
+	clk_register_clkdev(clk, "apb_pclk", "mtu1");
 
 	/* PRCC K-clocks
 	 *
-- 
1.7.11.3

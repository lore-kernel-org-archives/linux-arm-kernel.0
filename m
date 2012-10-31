From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Wed, 31 Oct 2012 14:40:53 +0100
Subject: [PATCH 2/2] clk: ux500: Register nomadik keypad clock lookups for
 u8500
In-Reply-To: <1351690853-13021-1-git-send-email-ulf.hansson@stericsson.com>
References: <1351690853-13021-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1351690853-13021-3-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/clk/ux500/u8500_clk.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/ux500/u8500_clk.c b/drivers/clk/ux500/u8500_clk.c
index 6390486..8575096 100644
--- a/drivers/clk/ux500/u8500_clk.c
+++ b/drivers/clk/ux500/u8500_clk.c
@@ -343,6 +343,8 @@ void u8500_clk_init(void)
 
 	clk = clk_reg_prcc_pclk("p3_pclk5", "per3clk", U8500_CLKRST3_BASE,
 				BIT(5), 0);
+	clk_register_clkdev(clk, "apb_pclk", "ske");
+	clk_register_clkdev(clk, "apb_pclk", "nmk-ske-keypad");
 
 	clk = clk_reg_prcc_pclk("p3_pclk6", "per3clk", U8500_CLKRST3_BASE,
 				BIT(6), 0);
@@ -503,6 +505,8 @@ void u8500_clk_init(void)
 
 	clk = clk_reg_prcc_kclk("p3_ske_kclk", "rtc32k",
 			U8500_CLKRST3_BASE, BIT(5), CLK_SET_RATE_GATE);
+	clk_register_clkdev(clk, NULL, "ske");
+	clk_register_clkdev(clk, NULL, "nmk-ske-keypad");
 
 	clk = clk_reg_prcc_kclk("p3_uart2_kclk", "uartclk",
 			U8500_CLKRST3_BASE, BIT(6), CLK_SET_RATE_GATE);
-- 
1.7.10

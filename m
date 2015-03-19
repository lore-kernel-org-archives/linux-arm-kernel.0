From: sr@denx.de (Stefan Roese)
Date: Thu, 19 Mar 2015 14:34:03 +0100
Subject: [PATCH] clk: spear600: Fix adc clock device name
Message-ID: <1426772043-12267-1-git-send-email-sr@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The device name for the adc clock is incorrect. This results in the
IIO ADC driver to fail while probing for the clock. This patch
fixes the name and the ADC driver is now started correctly.

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Viresh Kumar <viresh.linux@gmail.com>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: spear-devel at list.st.com
---
 drivers/clk/spear/spear6xx_clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/spear/spear6xx_clock.c b/drivers/clk/spear/spear6xx_clock.c
index 4f649c9..3e43244 100644
--- a/drivers/clk/spear/spear6xx_clock.c
+++ b/drivers/clk/spear/spear6xx_clock.c
@@ -316,7 +316,7 @@ void __init spear6xx_clk_init(void __iomem *misc_base)
 	/* clock derived from apb clk */
 	clk = clk_register_gate(NULL, "adc_clk", "apb_clk", 0, PERIP1_CLK_ENB,
 			ADC_CLK_ENB, 0, &_lock);
-	clk_register_clkdev(clk, NULL, "adc");
+	clk_register_clkdev(clk, NULL, "d8200000.adc");
 
 	clk = clk_register_fixed_factor(NULL, "gpio0_clk", "apb_clk", 0, 1, 1);
 	clk_register_clkdev(clk, NULL, "f0100000.gpio");
-- 
2.3.3

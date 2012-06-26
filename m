From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 26 Jun 2012 17:00:10 +0800
Subject: [PATCH] clk: mxs: add clkdev lookup for pwm
Message-ID: <1340701210-8547-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pwm clock lookup for imx23 and imx28 booting from device tree.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/clk/mxs/clk-imx23.c |    1 +
 drivers/clk/mxs/clk-imx28.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/mxs/clk-imx23.c b/drivers/clk/mxs/clk-imx23.c
index db2391c..7e03d41 100644
--- a/drivers/clk/mxs/clk-imx23.c
+++ b/drivers/clk/mxs/clk-imx23.c
@@ -189,6 +189,7 @@ int __init mx23_clocks_init(void)
 		}
 
 	clk_register_clkdev(clks[clk32k], NULL, "timrot");
+	clk_register_clkdev(clks[pwm], NULL, "80064000.pwm");
 	clk_register_clkdevs(clks[hbus], hbus_lookups, ARRAY_SIZE(hbus_lookups));
 	clk_register_clkdevs(clks[xbus], xbus_lookups, ARRAY_SIZE(xbus_lookups));
 	clk_register_clkdevs(clks[uart], uart_lookups, ARRAY_SIZE(uart_lookups));
diff --git a/drivers/clk/mxs/clk-imx28.c b/drivers/clk/mxs/clk-imx28.c
index 7fad6c8..e3f6ea9 100644
--- a/drivers/clk/mxs/clk-imx28.c
+++ b/drivers/clk/mxs/clk-imx28.c
@@ -314,6 +314,7 @@ int __init mx28_clocks_init(void)
 
 	clk_register_clkdev(clks[clk32k], NULL, "timrot");
 	clk_register_clkdev(clks[enet_out], NULL, "enet_out");
+	clk_register_clkdev(clks[pwm], NULL, "80064000.pwm");
 	clk_register_clkdevs(clks[hbus], hbus_lookups, ARRAY_SIZE(hbus_lookups));
 	clk_register_clkdevs(clks[xbus], xbus_lookups, ARRAY_SIZE(xbus_lookups));
 	clk_register_clkdevs(clks[uart], uart_lookups, ARRAY_SIZE(uart_lookups));
-- 
1.7.5.4

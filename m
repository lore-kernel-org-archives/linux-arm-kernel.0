From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat,  4 Jun 2016 10:10:08 +0300
Subject: [PATCH 16/22] clk: clps711x: Remove board support
In-Reply-To: <1465024214-22120-1-git-send-email-shc_work@mail.ru>
References: <1465024214-22120-1-git-send-email-shc_work@mail.ru>
Message-ID: <1465024214-22120-17-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since board support for the CLPS711X platform was removed,
remove the board support from the driver.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/clk/clk-clps711x.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/clk/clk-clps711x.c b/drivers/clk/clk-clps711x.c
index adaf109..7690a03 100644
--- a/drivers/clk/clk-clps711x.c
+++ b/drivers/clk/clk-clps711x.c
@@ -144,30 +144,6 @@ static struct clps711x_clk * __init _clps711x_clk_init(void __iomem *base,
 	return clps711x_clk;
 }
 
-void __init clps711x_clk_init(void __iomem *base)
-{
-	struct clps711x_clk *clps711x_clk;
-
-	clps711x_clk = _clps711x_clk_init(base, 73728000);
-
-	BUG_ON(IS_ERR(clps711x_clk));
-
-	/* Clocksource */
-	clk_register_clkdev(clps711x_clk->clks[CLPS711X_CLK_TIMER1],
-			    NULL, "clps711x-timer.0");
-	clk_register_clkdev(clps711x_clk->clks[CLPS711X_CLK_TIMER2],
-			    NULL, "clps711x-timer.1");
-
-	/* Drivers */
-	clk_register_clkdev(clps711x_clk->clks[CLPS711X_CLK_PWM],
-			    NULL, "clps711x-pwm");
-	clk_register_clkdev(clps711x_clk->clks[CLPS711X_CLK_UART],
-			    NULL, "clps711x-uart.0");
-	clk_register_clkdev(clps711x_clk->clks[CLPS711X_CLK_UART],
-			    NULL, "clps711x-uart.1");
-}
-
-#ifdef CONFIG_OF
 static void __init clps711x_clk_init_dt(struct device_node *np)
 {
 	void __iomem *base = of_iomap(np, 0);
@@ -185,4 +161,3 @@ static void __init clps711x_clk_init_dt(struct device_node *np)
 			    &clps711x_clk->clk_data);
 }
 CLK_OF_DECLARE(clps711x, "cirrus,ep7209-clk", clps711x_clk_init_dt);
-#endif
-- 
2.4.9

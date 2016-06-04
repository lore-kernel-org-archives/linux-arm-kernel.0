From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat,  4 Jun 2016 10:10:09 +0300
Subject: [PATCH 17/22] clocksource: clps711x: Remove board support
In-Reply-To: <1465024214-22120-1-git-send-email-shc_work@mail.ru>
References: <1465024214-22120-1-git-send-email-shc_work@mail.ru>
Message-ID: <1465024214-22120-18-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since board support for the CLPS711X platform was removed,
remove the board support from the driver.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/clocksource/clps711x-timer.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/clocksource/clps711x-timer.c b/drivers/clocksource/clps711x-timer.c
index 7c65f9e..32ae672 100644
--- a/drivers/clocksource/clps711x-timer.c
+++ b/drivers/clocksource/clps711x-timer.c
@@ -93,17 +93,6 @@ static int __init _clps711x_clkevt_init(struct clk *clock, void __iomem *base,
 			   "clps711x-timer", clkevt);
 }
 
-void __init clps711x_clksrc_init(void __iomem *tc1_base, void __iomem *tc2_base,
-				 unsigned int irq)
-{
-	struct clk *tc1 = clk_get_sys("clps711x-timer.0", NULL);
-	struct clk *tc2 = clk_get_sys("clps711x-timer.1", NULL);
-
-	BUG_ON(_clps711x_clksrc_init(tc1, tc1_base));
-	BUG_ON(_clps711x_clkevt_init(tc2, tc2_base, irq));
-}
-
-#ifdef CONFIG_CLKSRC_OF
 static void __init clps711x_timer_init(struct device_node *np)
 {
 	unsigned int irq = irq_of_parse_and_map(np, 0);
@@ -122,4 +111,3 @@ static void __init clps711x_timer_init(struct device_node *np)
 	}
 }
 CLOCKSOURCE_OF_DECLARE(clps711x, "cirrus,ep7209-timer", clps711x_timer_init);
-#endif
-- 
2.4.9

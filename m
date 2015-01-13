From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Jan 2015 15:22:06 +0100
Subject: [PATCH] clocksource: sirf: remove unused variable
Message-ID: <1599190.ZYSE4SrQSK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A recent rework of the driver left an obviously unused variable
around, and now the compiler complains:

clocksource/timer-marco.c: In function 'sirfsoc_marco_timer_init':
clocksource/timer-marco.c:260:6: warning: unused variable 'timer_div' [-Wunused-variable]

Remove it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: ef89af1f4380b92 ("clocksource: sirf: Remove hard-coded clock rate")

diff --git a/drivers/clocksource/timer-marco.c b/drivers/clocksource/timer-marco.c
index 361a789d4bee..3ddb81f7ee66 100644
--- a/drivers/clocksource/timer-marco.c
+++ b/drivers/clocksource/timer-marco.c
@@ -257,7 +257,6 @@ static void __init sirfsoc_clockevent_init(void)
 /* initialize the kernel jiffy timer source */
 static void __init sirfsoc_marco_timer_init(struct device_node *np)
 {
-	u32 timer_div;
 	struct clk *clk;
 
 	clk = of_clk_get(np, 0);

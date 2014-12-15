From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 15 Dec 2014 16:59:20 +0100
Subject: [PATCH] clocksource: sirf: Remove unused variable
Message-ID: <1418659160-2115-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Commit ef89af1f4380 ("clocksource: sirf: Remove hard-coded clock rate")
removes all uses of the timer_div variable. Since the variable is no
longer used it should be removed.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/clocksource/timer-marco.c | 1 -
 1 file changed, 1 deletion(-)

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
-- 
2.1.3

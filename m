From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 29 Jan 2015 14:08:11 +0100
Subject: [PATCH 1/9] clocksource: sirf: Remove unused variable
In-Reply-To: <54CA3044.6070501@linaro.org>
References: <54CA3044.6070501@linaro.org>
Message-ID: <1422536899-16609-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Commit ef89af1f4380 ("clocksource: sirf: Remove hard-coded clock rate")
removes all uses of the timer_div variable. Since the variable is no
longer used it should be removed.

Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-marco.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/timer-marco.c b/drivers/clocksource/timer-marco.c
index 361a789..3ddb81f 100644
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
1.9.1

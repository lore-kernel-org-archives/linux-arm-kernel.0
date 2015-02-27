From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 27 Feb 2015 11:12:33 +0530
Subject: [PATCH] clocksource: efm32: Use CLOCK_EVT_FEAT_PERIODIC for defining
 features
Message-ID: <3fac202ead48b50c0967c62eae92fe9786fd24a1.1425015704.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have used CLOCK_EVT_MODE_PERIODIC instead of CLOCK_EVT_FEAT_PERIODIC while
defining features. Fix it.

Cc: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clocksource/time-efm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/time-efm32.c b/drivers/clocksource/time-efm32.c
index bba62f9deefb..9edeab37a14b 100644
--- a/drivers/clocksource/time-efm32.c
+++ b/drivers/clocksource/time-efm32.c
@@ -111,7 +111,7 @@ static irqreturn_t efm32_clock_event_handler(int irq, void *dev_id)
 static struct efm32_clock_event_ddata clock_event_ddata = {
 	.evtdev = {
 		.name = "efm32 clockevent",
-		.features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_MODE_PERIODIC,
+		.features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,
 		.set_mode = efm32_clock_event_set_mode,
 		.set_next_event = efm32_clock_event_set_next_event,
 		.rating = 200,
-- 
2.3.0.rc0.44.ga94655d

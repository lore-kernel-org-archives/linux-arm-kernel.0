From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 30 Mar 2015 22:17:13 +0200
Subject: [PATCH 11/11] clocksource: efm32: Use CLOCK_EVT_FEAT_PERIODIC for
 defining features
In-Reply-To: <1427746633-9137-1-git-send-email-daniel.lezcano@linaro.org>
References: <5519AEB2.8050306@linaro.org>
 <1427746633-9137-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1427746633-9137-11-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Viresh Kumar <viresh.kumar@linaro.org>

We have used CLOCK_EVT_MODE_PERIODIC instead of CLOCK_EVT_FEAT_PERIODIC while
defining features. Fix it.

Acked-by: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/time-efm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/time-efm32.c b/drivers/clocksource/time-efm32.c
index ec57ba2..5b6e3d5 100644
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
1.9.1

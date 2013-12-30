From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 30 Dec 2013 11:19:22 +0100
Subject: [PATCH 03/20] clocksource: sun4i: Increase a bit the clock event and
 sources rating
In-Reply-To: <1388398779-11222-1-git-send-email-daniel.lezcano@linaro.org>
References: <52C1479E.80808@linaro.org>
 <1388398779-11222-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1388398779-11222-3-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Ripard <maxime.ripard@free-electrons.com>

We want to keep this driver as the default provider of the clock events
and source, yet some other driver might fit in the "desired" category of
ratings. Hence, we need to increase a bit the rating so that we can have
more flexibility in the ratings we choose.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Tested-by: Emilio L?pez <emilio@elopez.com.ar>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/sun4i_timer.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/sun4i_timer.c b/drivers/clocksource/sun4i_timer.c
index 6a76b4e..d7a1a1a 100644
--- a/drivers/clocksource/sun4i_timer.c
+++ b/drivers/clocksource/sun4i_timer.c
@@ -114,7 +114,7 @@ static int sun4i_clkevt_next_event(unsigned long evt,
 
 static struct clock_event_device sun4i_clockevent = {
 	.name = "sun4i_tick",
-	.rating = 300,
+	.rating = 350,
 	.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
 	.set_mode = sun4i_clkevt_mode,
 	.set_next_event = sun4i_clkevt_next_event,
@@ -172,7 +172,7 @@ static void __init sun4i_timer_init(struct device_node *node)
 
 	setup_sched_clock(sun4i_timer_sched_read, 32, rate);
 	clocksource_mmio_init(timer_base + TIMER_CNTVAL_REG(1), node->name,
-			      rate, 300, 32, clocksource_mmio_readl_down);
+			      rate, 350, 32, clocksource_mmio_readl_down);
 
 	ticks_per_jiffy = DIV_ROUND_UP(rate, HZ);
 
-- 
1.7.9.5

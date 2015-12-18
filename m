From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:17:18 +0100
Subject: [PATCH 05/69] clocksource/drivers/rockchip: Make the driver more
 readable
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-5-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Caesar Wang <wxt@rock-chips.com>

Let's checkstyle to clean up the macros with such trivial details.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/rockchip_timer.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/clocksource/rockchip_timer.c b/drivers/clocksource/rockchip_timer.c
index d3c1742..b14716b6 100644
--- a/drivers/clocksource/rockchip_timer.c
+++ b/drivers/clocksource/rockchip_timer.c
@@ -17,16 +17,16 @@
 
 #define TIMER_NAME "rk_timer"
 
-#define TIMER_LOAD_COUNT0 0x00
-#define TIMER_LOAD_COUNT1 0x04
-#define TIMER_CONTROL_REG 0x10
-#define TIMER_INT_STATUS 0x18
+#define TIMER_LOAD_COUNT0	0x00
+#define TIMER_LOAD_COUNT1	0x04
+#define TIMER_CONTROL_REG	0x10
+#define TIMER_INT_STATUS	0x18
 
-#define TIMER_DISABLE 0x0
-#define TIMER_ENABLE 0x1
-#define TIMER_MODE_FREE_RUNNING (0 << 1)
-#define TIMER_MODE_USER_DEFINED_COUNT (1 << 1)
-#define TIMER_INT_UNMASK (1 << 2)
+#define TIMER_DISABLE		0x0
+#define TIMER_ENABLE		0x1
+#define TIMER_MODE_FREE_RUNNING			(0 << 1)
+#define TIMER_MODE_USER_DEFINED_COUNT		(1 << 1)
+#define TIMER_INT_UNMASK			(1 << 2)
 
 struct bc_timer {
 	struct clock_event_device ce;
@@ -173,4 +173,5 @@ static void __init rk_timer_init(struct device_node *np)
 
 	clockevents_config_and_register(ce, bc_timer.freq, 1, UINT_MAX);
 }
+
 CLOCKSOURCE_OF_DECLARE(rk_timer, "rockchip,rk3288-timer", rk_timer_init);
-- 
1.9.1

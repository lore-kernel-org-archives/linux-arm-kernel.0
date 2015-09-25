From: wxt@rock-chips.com (Caesar Wang)
Date: Fri, 25 Sep 2015 10:14:56 +0800
Subject: [PATCH v2 2/4] clocksource: rockchip: trivial: Make the driver more
 readability
In-Reply-To: <1443147298-12603-1-git-send-email-wxt@rock-chips.com>
References: <1443147298-12603-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1443147298-12603-3-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's checkstyle to clean up the macros with such trivial details.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

Changes in v2: None
Changes in v1: None

 drivers/clocksource/rockchip_timer.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/clocksource/rockchip_timer.c b/drivers/clocksource/rockchip_timer.c
index 3ace7ac..9ed662a 100644
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

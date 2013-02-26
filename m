From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 26 Feb 2013 23:17:26 +0100
Subject: [PATCH 3/4] ARM: nomadik: add dynamic irq flag to the timer
In-Reply-To: <1361917047-29230-1-git-send-email-daniel.lezcano@linaro.org>
References: <1361917047-29230-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1361917047-29230-4-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the dynamic irq affinity feature to the timer clock device.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/nomadik-mtu.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/nomadik-mtu.c b/drivers/clocksource/nomadik-mtu.c
index 7cbcaa0..73dc540 100644
--- a/drivers/clocksource/nomadik-mtu.c
+++ b/drivers/clocksource/nomadik-mtu.c
@@ -136,7 +136,8 @@ static void nmdk_clkevt_mode(enum clock_event_mode mode,
 
 static struct clock_event_device nmdk_clkevt = {
 	.name		= "mtu_1",
-	.features	= CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,
+	.features	= CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC |
+	                  CLOCK_EVT_FEAT_DYNIRQ,
 	.rating		= 200,
 	.set_mode	= nmdk_clkevt_mode,
 	.set_next_event	= nmdk_clkevt_next,
-- 
1.7.9.5

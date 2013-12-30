From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 30 Dec 2013 11:19:38 +0100
Subject: [PATCH 19/20] clocksource: bcm_kona_timer: Remove unused bcm_timer_ids
In-Reply-To: <1388398779-11222-1-git-send-email-daniel.lezcano@linaro.org>
References: <52C1479E.80808@linaro.org>
 <1388398779-11222-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1388398779-11222-19-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Axel Lin <axel.lin@ingics.com>

bcm_timer_ids is no longer used after converting to CLOCKSOURCE_OF_DECLARE.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/bcm_kona_timer.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/clocksource/bcm_kona_timer.c b/drivers/clocksource/bcm_kona_timer.c
index 0d7d8c3..5176e76 100644
--- a/drivers/clocksource/bcm_kona_timer.c
+++ b/drivers/clocksource/bcm_kona_timer.c
@@ -98,12 +98,6 @@ kona_timer_get_counter(void *timer_base, uint32_t *msw, uint32_t *lsw)
 	return;
 }
 
-static const struct of_device_id bcm_timer_ids[] __initconst = {
-	{.compatible = "brcm,kona-timer"},
-	{.compatible = "bcm,kona-timer"}, /* deprecated name */
-	{},
-};
-
 static void __init kona_timers_init(struct device_node *node)
 {
 	u32 freq;
-- 
1.7.9.5

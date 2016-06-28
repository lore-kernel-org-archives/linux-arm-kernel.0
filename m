From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 28 Jun 2016 12:30:21 +0200
Subject: [PATCH 02/92] clocksource/drivers/digicolor: Fix warning of
 non-static function
In-Reply-To: <1467109911-11060-1-git-send-email-daniel.lezcano@linaro.org>
References: <577251A4.7030508@linaro.org>
 <1467109911-11060-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1467109911-11060-2-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ben Dooks <ben.dooks@codethink.co.uk>

Change the dc_timer function to be static as it is not used outside
this driver. This fixes the following warning:

drivers/clocksource/timer-digicolor.c:66:24: warning: symbol 'dc_timer' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/clocksource/timer-digicolor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-digicolor.c b/drivers/clocksource/timer-digicolor.c
index a536eeb..96bb222 100644
--- a/drivers/clocksource/timer-digicolor.c
+++ b/drivers/clocksource/timer-digicolor.c
@@ -63,7 +63,7 @@ struct digicolor_timer {
 	int timer_id; /* one of TIMER_* */
 };
 
-struct digicolor_timer *dc_timer(struct clock_event_device *ce)
+static struct digicolor_timer *dc_timer(struct clock_event_device *ce)
 {
 	return container_of(ce, struct digicolor_timer, ce);
 }
-- 
1.9.1

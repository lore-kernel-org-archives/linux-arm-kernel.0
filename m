From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu,  7 Jul 2016 10:00:35 +0200
Subject: [PATCH 02/93] clocksource/drivers/digicolor: Fix warning of
 non-static function
In-Reply-To: <1467878526-1238-1-git-send-email-daniel.lezcano@linaro.org>
References: <577E0BED.3020608@linaro.org>
 <1467878526-1238-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1467878526-1238-2-git-send-email-daniel.lezcano@linaro.org>
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

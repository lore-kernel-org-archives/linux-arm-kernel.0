From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue,  7 Jun 2016 15:11:50 +0100
Subject: [PATCH] clocksource/drivers/digicolor: fix warning of non-static
 function
Message-ID: <1465308710-18297-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the dc_timer function to be static as it is not used outside
this driver. This fixes the following warning:

drivers/clocksource/timer-digicolor.c:66:24: warning: symbol 'dc_timer' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Baruch Siach <baruch@tkos.co.il>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
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
2.8.1

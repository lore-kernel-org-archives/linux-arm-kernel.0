From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon,  8 Jan 2018 14:28:41 +0100
Subject: [PATCH 02/20] clocksource/drivers/owl: Adopt TIMER_OF_DECLARE()
In-Reply-To: <1515418139-23276-1-git-send-email-daniel.lezcano@linaro.org>
References: <1bbaef2e-4080-3f54-7db3-a8989acfd691@free.fr>
 <1515418139-23276-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1515418139-23276-2-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andreas F?rber <afaerber@suse.de>

Commit 1727339590fdb5a1ded881b540cd32121278d414 ("clocksource/drivers:
Rename CLOCKSOURCE_OF_DECLARE to TIMER_OF_DECLARE") deprecated
CLOCKSOURCE_OF_DECLARE(), so adopt the new macro TIMER_OF_DECLARE().

Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/owl-timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/owl-timer.c b/drivers/clocksource/owl-timer.c
index c686305..9fb4333 100644
--- a/drivers/clocksource/owl-timer.c
+++ b/drivers/clocksource/owl-timer.c
@@ -168,5 +168,5 @@ static int __init owl_timer_init(struct device_node *node)
 
 	return 0;
 }
-CLOCKSOURCE_OF_DECLARE(owl_s500, "actions,s500-timer", owl_timer_init);
-CLOCKSOURCE_OF_DECLARE(owl_s900, "actions,s900-timer", owl_timer_init);
+TIMER_OF_DECLARE(owl_s500, "actions,s500-timer", owl_timer_init);
+TIMER_OF_DECLARE(owl_s900, "actions,s900-timer", owl_timer_init);
-- 
2.7.4

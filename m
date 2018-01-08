From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon,  8 Jan 2018 14:28:42 +0100
Subject: [PATCH 03/20] clocksource/drivers/owl: Add the S700
In-Reply-To: <1515418139-23276-1-git-send-email-daniel.lezcano@linaro.org>
References: <1bbaef2e-4080-3f54-7db3-a8989acfd691@free.fr>
 <1515418139-23276-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1515418139-23276-3-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andreas F?rber <afaerber@suse.de>

Actions S700 has two 2Hz timers like S500, and four TIMx timers like S900.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/owl-timer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/owl-timer.c b/drivers/clocksource/owl-timer.c
index 9fb4333..ea00a5e 100644
--- a/drivers/clocksource/owl-timer.c
+++ b/drivers/clocksource/owl-timer.c
@@ -169,4 +169,5 @@ static int __init owl_timer_init(struct device_node *node)
 	return 0;
 }
 TIMER_OF_DECLARE(owl_s500, "actions,s500-timer", owl_timer_init);
+TIMER_OF_DECLARE(owl_s700, "actions,s700-timer", owl_timer_init);
 TIMER_OF_DECLARE(owl_s900, "actions,s900-timer", owl_timer_init);
-- 
2.7.4

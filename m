From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue, 14 Nov 2017 00:34:23 +0100
Subject: [PATCH v2 4/8] clocksource: owl: Prepare S700
In-Reply-To: <20171113233427.5386-1-afaerber@suse.de>
References: <20171113233427.5386-1-afaerber@suse.de>
Message-ID: <20171113233427.5386-5-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Actions S700 has two 2Hz timers like S500, and four TIMx timers like S900.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v1 -> v2:
 * Adopted TIMER_OF_DECLARE() (Daniel)
 
 drivers/clocksource/owl-timer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/owl-timer.c b/drivers/clocksource/owl-timer.c
index 9fb4333cfb8a..ea00a5e8f95d 100644
--- a/drivers/clocksource/owl-timer.c
+++ b/drivers/clocksource/owl-timer.c
@@ -169,4 +169,5 @@ static int __init owl_timer_init(struct device_node *node)
 	return 0;
 }
 TIMER_OF_DECLARE(owl_s500, "actions,s500-timer", owl_timer_init);
+TIMER_OF_DECLARE(owl_s700, "actions,s700-timer", owl_timer_init);
 TIMER_OF_DECLARE(owl_s900, "actions,s900-timer", owl_timer_init);
-- 
2.13.6

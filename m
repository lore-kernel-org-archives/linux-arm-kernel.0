From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Mon, 11 Sep 2017 04:22:40 +0200
Subject: [PATCH 3/4] clocksource: owl: Prepare S700
In-Reply-To: <20170911022241.11603-1-afaerber@suse.de>
References: <20170911022241.11603-1-afaerber@suse.de>
Message-ID: <20170911022241.11603-4-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

S700 has two 2Hz timers like S500, and four TIMx timers like S900.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 drivers/clocksource/owl-timer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/owl-timer.c b/drivers/clocksource/owl-timer.c
index d19c53c11094..d5f3f72c10ee 100644
--- a/drivers/clocksource/owl-timer.c
+++ b/drivers/clocksource/owl-timer.c
@@ -169,4 +169,5 @@ static int __init owl_timer_init(struct device_node *node)
 	return 0;
 }
 CLOCKSOURCE_OF_DECLARE(owl_s500, "actions,s500-timer", owl_timer_init);
+CLOCKSOURCE_OF_DECLARE(owl_s700, "actions,s700-timer", owl_timer_init);
 CLOCKSOURCE_OF_DECLARE(owl_s900, "actions,s900-timer", owl_timer_init);
-- 
2.13.5

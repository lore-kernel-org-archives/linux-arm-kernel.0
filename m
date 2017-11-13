From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue, 14 Nov 2017 00:34:22 +0100
Subject: [PATCH v2 3/8] clocksource: owl: Adopt TIMER_OF_DECLARE()
In-Reply-To: <20171113233427.5386-1-afaerber@suse.de>
References: <20171113233427.5386-1-afaerber@suse.de>
Message-ID: <20171113233427.5386-4-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 1727339590fdb5a1ded881b540cd32121278d414 ("clocksource/drivers:
Rename CLOCKSOURCE_OF_DECLARE to TIMER_OF_DECLARE") deprecated
CLOCKSOURCE_OF_DECLARE(), so adopt the new macro TIMER_OF_DECLARE().

Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2: New (Daniel)
 
 drivers/clocksource/owl-timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/owl-timer.c b/drivers/clocksource/owl-timer.c
index c68630565079..9fb4333cfb8a 100644
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
2.13.6

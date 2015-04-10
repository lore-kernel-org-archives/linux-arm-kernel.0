From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Fri, 10 Apr 2015 21:55:50 +0800
Subject: [PATCH] time: Remove nonexistent function prototype.
Message-ID: <1428674150-1780-1-git-send-email-yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function clocksource_get_next() was removed in commit 75c5158f70
(timekeeping: Update clocksource with stop_machine), but the
prototype is not removed with it. Remove the prototype.

Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
---
 include/linux/clocksource.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 9c78d15..450695d 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -181,7 +181,6 @@ static inline s64 clocksource_cyc2ns(cycle_t cycles, u32 mult, u32 shift)
 extern int clocksource_register(struct clocksource*);
 extern int clocksource_unregister(struct clocksource*);
 extern void clocksource_touch_watchdog(void);
-extern struct clocksource* clocksource_get_next(void);
 extern void clocksource_change_rating(struct clocksource *cs, int rating);
 extern void clocksource_suspend(void);
 extern void clocksource_resume(void);
-- 
1.8.1.1.dirty

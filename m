From: j-keerthy@ti.com (Keerthy)
Date: Thu, 15 Feb 2018 11:31:45 +0530
Subject: [PATCH v11 04/10] clocksource: timer-ti-dm: Replace architecture
In-Reply-To: <1518674511-26421-1-git-send-email-j-keerthy@ti.com>
References: <1518674511-26421-1-git-send-email-j-keerthy@ti.com>
Message-ID: <1518674511-26421-5-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace architecture specific guard with clocksource guard.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Replace architecture specific defines with clocksource
---
 include/clocksource/timer-ti-dm.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/clocksource/timer-ti-dm.h b/include/clocksource/timer-ti-dm.h
index 831174f..4f31095 100644
--- a/include/clocksource/timer-ti-dm.h
+++ b/include/clocksource/timer-ti-dm.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/plat-omap/include/plat/dmtimer.h
- *
  * OMAP Dual-Mode Timers
  *
  * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com/
@@ -36,8 +34,8 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 
-#ifndef __ASM_ARCH_DMTIMER_H
-#define __ASM_ARCH_DMTIMER_H
+#ifndef __CLOCKSOURCE_DMTIMER_H
+#define __CLOCKSOURCE_DMTIMER_H
 
 /* clock sources */
 #define OMAP_TIMER_SRC_SYS_CLK			0x00
@@ -426,4 +424,4 @@ static inline void __omap_dm_timer_write_status(struct omap_dm_timer *timer,
 	writel_relaxed(value, timer->irq_stat);
 }
 #endif /* CONFIG_ARCH_OMAP1 || CONFIG_ARCH_OMAP2PLUS */
-#endif /* __ASM_ARCH_DMTIMER_H */
+#endif /* __CLOCKSOURCE_DMTIMER_H */
-- 
1.9.1

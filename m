From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  2 Mar 2011 16:53:08 +0000
Subject: [RFC PATCH 02/20] ARM: omap2: remove stubbed twd_timer_setup call
In-Reply-To: <1299084806-16546-1-git-send-email-marc.zyngier@arm.com>
References: <1299084806-16546-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1299084806-16546-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-omap2/timer-mpu.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/timer-mpu.c b/arch/arm/mach-omap2/timer-mpu.c
index 31c0ac4..02feaff 100644
--- a/arch/arm/mach-omap2/timer-mpu.c
+++ b/arch/arm/mach-omap2/timer-mpu.c
@@ -17,10 +17,8 @@
  * published by the Free Software Foundation.
  */
 #include <linux/init.h>
-#include <linux/smp.h>
 #include <linux/clockchips.h>
 #include <asm/irq.h>
-#include <asm/smp_twd.h>
 #include <asm/localtimer.h>
 
 /*
@@ -33,7 +31,6 @@ int __cpuinit local_timer_setup(struct clock_event_device *evt)
 		return -ENXIO;
 
 	evt->irq = OMAP44XX_IRQ_LOCALTIMER;
-	twd_timer_setup(evt);
 	return 0;
 }
 
-- 
1.7.0.4

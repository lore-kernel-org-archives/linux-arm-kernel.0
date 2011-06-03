From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  3 Jun 2011 15:57:18 +0100
Subject: [PATCH v1 03/18] ARM: omap2: remove stubbed twd_timer_setup call
In-Reply-To: <1307113053-30209-1-git-send-email-marc.zyngier@arm.com>
References: <1307113053-30209-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1307113053-30209-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-omap2/timer-mpu.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/timer-mpu.c b/arch/arm/mach-omap2/timer-mpu.c
index 1fd5ca5..c91b1c1 100644
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
 #include <asm/hardware/gic.h>
 
@@ -34,7 +32,6 @@ int __cpuinit local_timer_setup(struct clock_event_device *evt)
 		return -ENXIO;
 
 	evt->irq = gic_ppi_to_vppi(OMAP44XX_IRQ_LOCALTIMER);
-	twd_timer_setup(evt);
 	return 0;
 }
 
-- 
1.7.0.4

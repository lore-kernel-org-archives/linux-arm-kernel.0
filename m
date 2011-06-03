From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  3 Jun 2011 15:57:23 +0100
Subject: [PATCH v1 08/18] ARM: versatile: remove stubbed twd_timer_setup call
In-Reply-To: <1307113053-30209-1-git-send-email-marc.zyngier@arm.com>
References: <1307113053-30209-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1307113053-30209-9-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/plat-versatile/localtimer.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-versatile/localtimer.c b/arch/arm/plat-versatile/localtimer.c
index a76daf4..a8e8b85 100644
--- a/arch/arm/plat-versatile/localtimer.c
+++ b/arch/arm/plat-versatile/localtimer.c
@@ -9,10 +9,8 @@
  * published by the Free Software Foundation.
  */
 #include <linux/init.h>
-#include <linux/smp.h>
 #include <linux/clockchips.h>
 
-#include <asm/smp_twd.h>
 #include <asm/localtimer.h>
 #include <asm/hardware/gic.h>
 #include <mach/irqs.h>
@@ -23,6 +21,5 @@
 int __cpuinit local_timer_setup(struct clock_event_device *evt)
 {
 	evt->irq = gic_ppi_to_vppi(IRQ_LOCALTIMER);
-	twd_timer_setup(evt);
 	return 0;
 }
-- 
1.7.0.4

From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 05 Feb 2013 16:30:49 +0900
Subject: [PATCH] ARM: shmobile: Register ARM architected timer
Message-ID: <20130205073049.7576.51324.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Register ARM architected timer by default for all mach-shmobile
systems using late timer.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/timer.c |    3 +++
 1 file changed, 3 insertions(+)

--- 0001/arch/arm/mach-shmobile/timer.c
+++ work/arch/arm/mach-shmobile/timer.c	2013-02-05 16:17:04.000000000 +0900
@@ -20,6 +20,7 @@
  */
 #include <linux/platform_device.h>
 #include <linux/delay.h>
+#include <asm/arch_timer.h>
 #include <asm/mach/time.h>
 #include <asm/smp_twd.h>
 
@@ -62,4 +63,6 @@ void __init shmobile_earlytimer_init(voi
 
 void __init shmobile_timer_init(void)
 {
+	arch_timer_of_register();
+	arch_timer_sched_clock_init();
 }

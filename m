From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 01 Aug 2013 04:03:09 +0900
Subject: [PATCH 13/13] ARM: shmobile: Remove unused shmobile_init_time()
In-Reply-To: <20130731190110.31796.96552.sendpatchset@w520>
References: <20130731190110.31796.96552.sendpatchset@w520>
Message-ID: <20130731190309.31796.78310.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove shmobile_timer_init() since it now is unused.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/common.h |    1 -
 arch/arm/mach-shmobile/timer.c               |    4 ----
 2 files changed, 5 deletions(-)

--- 0009/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2013-08-01 03:19:38.000000000 +0900
@@ -2,7 +2,6 @@
 #define __ARCH_MACH_COMMON_H
 
 extern void shmobile_earlytimer_init(void);
-extern void shmobile_timer_init(void);
 extern void shmobile_setup_delay(unsigned int max_cpu_core_mhz,
 			 unsigned int mult, unsigned int div);
 struct twd_local_timer;
--- 0001/arch/arm/mach-shmobile/timer.c
+++ work/arch/arm/mach-shmobile/timer.c	2013-08-01 03:19:19.000000000 +0900
@@ -59,7 +59,3 @@ void __init shmobile_earlytimer_init(voi
 	late_time_init = shmobile_late_time_init;
 }
 
-void __init shmobile_timer_init(void)
-{
-	clocksource_of_init();
-}

From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 08 Aug 2013 07:27:01 +0900
Subject: [PATCH 02/02] ARM: shmobile: Rename to r8a7790_init_early()
In-Reply-To: <20130807222638.22283.78607.sendpatchset@w520>
References: <20130807222638.22283.78607.sendpatchset@w520>
Message-ID: <20130807222701.22283.75763.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Rename r8a7790_init_delay() into r8a7790_init_early()
to make the function name show that more than just
delay setup may happen in the future.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-lager-reference.c |    2 +-
 arch/arm/mach-shmobile/board-lager.c           |    2 +-
 arch/arm/mach-shmobile/include/mach/r8a7790.h  |    2 +-
 arch/arm/mach-shmobile/setup-r8a7790.c         |    4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

--- 0001/arch/arm/mach-shmobile/board-lager-reference.c
+++ work/arch/arm/mach-shmobile/board-lager-reference.c	2013-08-07 19:46:28.000000000 +0900
@@ -38,7 +38,7 @@ static const char *lager_boards_compat_d
 };
 
 DT_MACHINE_START(LAGER_DT, "lager")
-	.init_early	= r8a7790_init_delay,
+	.init_early	= r8a7790_init_early,
 	.init_machine	= lager_add_standard_devices,
 	.init_time	= r8a7790_timer_init,
 	.dt_compat	= lager_boards_compat_dt,
--- 0001/arch/arm/mach-shmobile/board-lager.c
+++ work/arch/arm/mach-shmobile/board-lager.c	2013-08-07 19:46:18.000000000 +0900
@@ -162,7 +162,7 @@ static const char *lager_boards_compat_d
 };
 
 DT_MACHINE_START(LAGER_DT, "lager")
-	.init_early	= r8a7790_init_delay,
+	.init_early	= r8a7790_init_early,
 	.init_time	= r8a7790_timer_init,
 	.init_machine	= lager_add_standard_devices,
 	.dt_compat	= lager_boards_compat_dt,
--- 0001/arch/arm/mach-shmobile/include/mach/r8a7790.h
+++ work/arch/arm/mach-shmobile/include/mach/r8a7790.h	2013-08-07 19:46:48.000000000 +0900
@@ -5,7 +5,7 @@ void r8a7790_add_standard_devices(void);
 void r8a7790_add_dt_devices(void);
 void r8a7790_clock_init(void);
 void r8a7790_pinmux_init(void);
-void r8a7790_init_delay(void);
+void r8a7790_init_early(void);
 void r8a7790_timer_init(void);
 
 #define MD(nr) BIT(nr)
--- 0001/arch/arm/mach-shmobile/setup-r8a7790.c
+++ work/arch/arm/mach-shmobile/setup-r8a7790.c	2013-08-07 19:47:12.000000000 +0900
@@ -267,7 +267,7 @@ void __init r8a7790_timer_init(void)
 	clocksource_of_init();
 }
 
-void __init r8a7790_init_delay(void)
+void __init r8a7790_init_early(void)
 {
 #ifndef CONFIG_ARM_ARCH_TIMER
 	shmobile_setup_delay(1300, 2, 4); /* Cortex-A15 @ 1300MHz */
@@ -282,7 +282,7 @@ static const char *r8a7790_boards_compat
 };
 
 DT_MACHINE_START(R8A7790_DT, "Generic R8A7790 (Flattened Device Tree)")
-	.init_early	= r8a7790_init_delay,
+	.init_early	= r8a7790_init_early,
 	.init_time	= r8a7790_timer_init,
 	.dt_compat	= r8a7790_boards_compat_dt,
 MACHINE_END

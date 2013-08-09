From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 09 Aug 2013 18:50:10 +0900
Subject: [PATCH 13/14] ARM: shmobile: Rename to r8a7778_init_early()
In-Reply-To: <20130809094748.6530.16511.sendpatchset@w520>
References: <20130809094748.6530.16511.sendpatchset@w520>
Message-ID: <20130809095010.6530.87879.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Rename r8a7778_init_delay() into r8a7778_init_early()
to make the function name show that more than just
delay setup may happen in the future.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-bockw-reference.c |    2 +-
 arch/arm/mach-shmobile/board-bockw.c           |    2 +-
 arch/arm/mach-shmobile/include/mach/r8a7778.h  |    2 +-
 arch/arm/mach-shmobile/setup-r8a7778.c         |    4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

--- 0001/arch/arm/mach-shmobile/board-bockw-reference.c
+++ work/arch/arm/mach-shmobile/board-bockw-reference.c	2013-08-09 17:21:15.000000000 +0900
@@ -54,7 +54,7 @@ static const char *bockw_boards_compat_d
 };
 
 DT_MACHINE_START(BOCKW_DT, "bockw")
-	.init_early	= r8a7778_init_delay,
+	.init_early	= r8a7778_init_early,
 	.init_irq	= r8a7778_init_irq_dt,
 	.init_machine	= bockw_init,
 	.dt_compat	= bockw_boards_compat_dt,
--- 0001/arch/arm/mach-shmobile/board-bockw.c
+++ work/arch/arm/mach-shmobile/board-bockw.c	2013-08-09 17:21:01.000000000 +0900
@@ -276,7 +276,7 @@ static const char *bockw_boards_compat_d
 };
 
 DT_MACHINE_START(BOCKW_DT, "bockw")
-	.init_early	= r8a7778_init_delay,
+	.init_early	= r8a7778_init_early,
 	.init_irq	= r8a7778_init_irq_dt,
 	.init_machine	= bockw_init,
 	.dt_compat	= bockw_boards_compat_dt,
--- 0001/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ work/arch/arm/mach-shmobile/include/mach/r8a7778.h	2013-08-09 17:21:43.000000000 +0900
@@ -26,7 +26,7 @@ extern void r8a7778_add_ether_device(str
 extern void r8a7778_add_dt_devices(void);
 
 extern void r8a7778_init_late(void);
-extern void r8a7778_init_delay(void);
+extern void r8a7778_init_early(void);
 extern void r8a7778_init_irq_dt(void);
 extern void r8a7778_clock_init(void);
 extern void r8a7778_init_irq_extpin(int irlm);
--- 0001/arch/arm/mach-shmobile/setup-r8a7778.c
+++ work/arch/arm/mach-shmobile/setup-r8a7778.c	2013-08-09 17:20:46.000000000 +0900
@@ -368,7 +368,7 @@ void __init r8a7778_init_irq_extpin(int
 			&irqpin_platform_data, sizeof(irqpin_platform_data));
 }
 
-void __init r8a7778_init_delay(void)
+void __init r8a7778_init_early(void)
 {
 	shmobile_setup_delay(800, 1, 3); /* Cortex-A9 @ 800MHz */
 }
@@ -404,7 +404,7 @@ static const char *r8a7778_compat_dt[] _
 };
 
 DT_MACHINE_START(R8A7778_DT, "Generic R8A7778 (Flattened Device Tree)")
-	.init_early	= r8a7778_init_delay,
+	.init_early	= r8a7778_init_early,
 	.init_irq	= r8a7778_init_irq_dt,
 	.dt_compat	= r8a7778_compat_dt,
 	.init_late      = r8a7778_init_late,

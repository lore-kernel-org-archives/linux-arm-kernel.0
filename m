From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  1 Oct 2013 11:28:22 +0900
Subject: [PATCH 2/3] ARM: shmobile: Rename to r8a7790_init_early()
In-Reply-To: <cover.1380523393.git.horms+renesas@verge.net.au>
References: <cover.1380523393.git.horms+renesas@verge.net.au>
Message-ID: <0efd7faa6c611dab4ab8105473d2ffde7918cb69.1380523393.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Rename r8a7790_init_delay() into r8a7790_init_early()
to make the function name show that more than just
delay setup may happen in the future.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-lager-reference.c | 2 +-
 arch/arm/mach-shmobile/board-lager.c           | 2 +-
 arch/arm/mach-shmobile/include/mach/r8a7790.h  | 2 +-
 arch/arm/mach-shmobile/setup-r8a7790.c         | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index 9c316a1..2856f51 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -38,7 +38,7 @@ static const char *lager_boards_compat_dt[] __initdata = {
 };
 
 DT_MACHINE_START(LAGER_DT, "lager")
-	.init_early	= r8a7790_init_delay,
+	.init_early	= r8a7790_init_early,
 	.init_machine	= lager_add_standard_devices,
 	.init_time	= r8a7790_timer_init,
 	.dt_compat	= lager_boards_compat_dt,
diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index ffb6f0a..4047fac 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -161,7 +161,7 @@ static const char *lager_boards_compat_dt[] __initdata = {
 };
 
 DT_MACHINE_START(LAGER_DT, "lager")
-	.init_early	= r8a7790_init_delay,
+	.init_early	= r8a7790_init_early,
 	.init_time	= r8a7790_timer_init,
 	.init_machine	= lager_add_standard_devices,
 	.dt_compat	= lager_boards_compat_dt,
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7790.h b/arch/arm/mach-shmobile/include/mach/r8a7790.h
index 788d559..177a837 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7790.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7790.h
@@ -5,7 +5,7 @@ void r8a7790_add_standard_devices(void);
 void r8a7790_add_dt_devices(void);
 void r8a7790_clock_init(void);
 void r8a7790_pinmux_init(void);
-void r8a7790_init_delay(void);
+void r8a7790_init_early(void);
 void r8a7790_timer_init(void);
 
 #define MD(nr) BIT(nr)
diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index d0f5c9f..a42d1f6 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -267,7 +267,7 @@ void __init r8a7790_timer_init(void)
 	clocksource_of_init();
 }
 
-void __init r8a7790_init_delay(void)
+void __init r8a7790_init_early(void)
 {
 #ifndef CONFIG_ARM_ARCH_TIMER
 	shmobile_setup_delay(1300, 2, 4); /* Cortex-A15 @ 1300MHz */
@@ -282,7 +282,7 @@ static const char *r8a7790_boards_compat_dt[] __initdata = {
 };
 
 DT_MACHINE_START(R8A7790_DT, "Generic R8A7790 (Flattened Device Tree)")
-	.init_early	= r8a7790_init_delay,
+	.init_early	= r8a7790_init_early,
 	.init_time	= r8a7790_timer_init,
 	.dt_compat	= r8a7790_boards_compat_dt,
 MACHINE_END
-- 
1.8.4

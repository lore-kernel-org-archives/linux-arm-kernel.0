From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 08 Nov 2013 19:09:34 +0900
Subject: [PATCH] ARM: shmobile: Select USE_OF on EMEV2
Message-ID: <20131108100934.24755.56317.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Now when the legacy KZM9D board code is gone, make sure
USE_OF is selected in case of the EMEV2 SoC.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Built on top of "renesas-devel-v3.12-rc7-20131101" and
 [PATCH 00/04] ARM: shmobile: KZM9D legacy board code removal

 arch/arm/mach-shmobile/Kconfig       |    1 +
 arch/arm/mach-shmobile/setup-emev2.c |    4 ----
 2 files changed, 1 insertion(+), 4 deletions(-)

--- 0017/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2013-11-08 19:04:48.000000000 +0900
@@ -123,6 +123,7 @@ config ARCH_EMEV2
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select CPU_V7
+	select USE_OF
 
 config ARCH_R7S72100
 	bool "RZ/A1H (R7S72100)"
--- 0005/arch/arm/mach-shmobile/setup-emev2.c
+++ work/arch/arm/mach-shmobile/setup-emev2.c	2013-11-08 19:05:00.000000000 +0900
@@ -48,8 +48,6 @@ void __init emev2_init_delay(void)
 	shmobile_setup_delay(533, 1, 3); /* Cortex-A9 @ 533MHz */
 }
 
-#ifdef CONFIG_USE_OF
-
 static void __init emev2_add_standard_devices_dt(void)
 {
 #ifdef CONFIG_COMMON_CLK
@@ -73,5 +71,3 @@ DT_MACHINE_START(EMEV2_DT, "Generic Emma
 	.init_late	= shmobile_init_late,
 	.dt_compat	= emev2_boards_compat_dt,
 MACHINE_END
-
-#endif /* CONFIG_USE_OF */

From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:29:53 +0900
Subject: [PATCH 20/33] ARM: shmobile: Select USE_OF on EMEV2
In-Reply-To: <cover.1386897180.git.horms+renesas@verge.net.au>
References: <cover.1386897180.git.horms+renesas@verge.net.au>
Message-ID: <81fd1b68796aadae70751ba8805b34b20df09e1b.1386897180.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Now when the legacy KZM9D board code is gone, make sure
USE_OF is selected in case of the EMEV2 SoC.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig       | 1 +
 arch/arm/mach-shmobile/setup-emev2.c | 4 ----
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 564e0ad..180b71f 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -108,6 +108,7 @@ config ARCH_EMEV2
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select CPU_V7
+	select USE_OF
 
 config ARCH_R7S72100
 	bool "RZ/A1H (R7S72100)"
diff --git a/arch/arm/mach-shmobile/setup-emev2.c b/arch/arm/mach-shmobile/setup-emev2.c
index e7031b0..c8f2a1a 100644
--- a/arch/arm/mach-shmobile/setup-emev2.c
+++ b/arch/arm/mach-shmobile/setup-emev2.c
@@ -48,8 +48,6 @@ void __init emev2_init_delay(void)
 	shmobile_setup_delay(533, 1, 3); /* Cortex-A9 @ 533MHz */
 }
 
-#ifdef CONFIG_USE_OF
-
 static void __init emev2_add_standard_devices_dt(void)
 {
 #ifdef CONFIG_COMMON_CLK
@@ -73,5 +71,3 @@ DT_MACHINE_START(EMEV2_DT, "Generic Emma Mobile EV2 (Flattened Device Tree)")
 	.init_late	= shmobile_init_late,
 	.dt_compat	= emev2_boards_compat_dt,
 MACHINE_END
-
-#endif /* CONFIG_USE_OF */
-- 
1.8.4

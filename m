From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 27 Jan 2012 10:44:20 +0900
Subject: [PATCH 02/13] ARM: SAMSUNG: allow the configuration of KERNEL HZ in
 plat-samsung
Message-ID: <016f01ccdc95$30279500$9076bf00$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/Kconfig              |    4 ++--
 arch/arm/plat-samsung/Kconfig |    7 +++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 24626b0..f9d7c47 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1590,8 +1590,8 @@ source kernel/Kconfig.preempt
 
 config HZ
 	int
-	default 200 if ARCH_EBSA110 || ARCH_S3C2410 || ARCH_S5P64X0 || \
-		ARCH_S5PV210 || ARCH_EXYNOS4
+	default 200 if ARCH_EBSA110
+	default SAMSUNG_TIMER_HZ if PLAT_SAMSUNG
 	default OMAP_32K_TIMER_HZ if ARCH_OMAP && OMAP_32K_TIMER
 	default AT91_TIMER_HZ if ARCH_AT91
 	default SHMOBILE_TIMER_HZ if ARCH_SHMOBILE
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 6a2abe6..0a23b52 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -50,6 +50,13 @@ config S3C_LOWLEVEL_UART_PORT
 	  this configuration should be between zero and two. The port
 	  must have been initialised by the boot-loader before use.
 
+config SAMSUNG_TIMER_HZ
+	int "Kernel HZ for Samsung Platform"
+	range 32 1024
+	default "200"
+	help
+	  Allows the configuration of the timer frequency for Samsung SoCs.
+
 # clock options
 
 config SAMSUNG_CLKSRC
-- 
1.7.1

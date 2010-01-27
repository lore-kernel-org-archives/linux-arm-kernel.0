From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 27 Jan 2010 19:04:08 +0900
Subject: [PATCH v4 4/8] ARM: S5PV210: Update Kconfig and Makefiles
Message-ID: <1264586648-22963-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Updates arch/arm Kconfig and Makefile for building the S5PV210 support.
Also modifies the plat-s5p Kconfig file to include the support for plat-s5p
for S5PV210.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/Kconfig          |   12 +++++++++++-
 arch/arm/Makefile         |    1 +
 arch/arm/mm/Kconfig       |    2 +-
 arch/arm/plat-s5p/Kconfig |    2 +-
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3bc5169..a5602ec 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -649,6 +649,14 @@ config ARCH_S5PC1XX
 	help
 	  Samsung S5PC1XX series based systems
 
+config ARCH_S5PV210
+	bool "Samsung S5PV210/S5PC110"
+	select CPU_V7
+	select GENERIC_GPIO
+	select HAVE_CLK
+	help
+	  Samsung S5PV210/S5PC110 series based systems
+
 config ARCH_SHARK
 	bool "Shark"
 	select CPU_SA110
@@ -811,6 +819,8 @@ if ARCH_S5PC1XX
 source "arch/arm/mach-s5pc100/Kconfig"
 endif
 
+source "arch/arm/mach-s5pv210/Kconfig"
+
 source "arch/arm/mach-lh7a40x/Kconfig"
 
 source "arch/arm/mach-h720x/Kconfig"
@@ -1085,7 +1095,7 @@ source kernel/Kconfig.preempt
 config HZ
 	int
 	default 128 if ARCH_L7200
-	default 200 if ARCH_EBSA110 || ARCH_S3C2410 || ARCH_S5P6440
+	default 200 if ARCH_EBSA110 || ARCH_S3C2410 || ARCH_S5P6440 || ARCH_S5PV210
 	default OMAP_32K_TIMER_HZ if ARCH_OMAP && OMAP_32K_TIMER
 	default AT91_TIMER_HZ if ARCH_AT91
 	default 100
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index bbcd512..c968bde 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -163,6 +163,7 @@ machine-$(CONFIG_ARCH_S3C24A0)		:= s3c24a0
 machine-$(CONFIG_ARCH_S3C64XX)		:= s3c6400 s3c6410
 machine-$(CONFIG_ARCH_S5P6440)		:= s5p6440
 machine-$(CONFIG_ARCH_S5PC1XX)		:= s5pc100
+machine-$(CONFIG_ARCH_S5PV210)		:= s5pv210
 machine-$(CONFIG_ARCH_SA1100)		:= sa1100
 machine-$(CONFIG_ARCH_SHARK)		:= shark
 machine-$(CONFIG_ARCH_STMP378X)		:= stmp378x
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index baf6384..91617f7 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -779,5 +779,5 @@ config CACHE_XSC3L2
 
 config ARM_L1_CACHE_SHIFT
 	int
-	default 6 if ARCH_OMAP3 || ARCH_S5PC1XX
+	default 6 if ARCH_OMAP3 || ARCH_S5PC1XX || ARCH_S5PV210
 	default 5
diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
index fca6dad..225ab11 100644
--- a/arch/arm/plat-s5p/Kconfig
+++ b/arch/arm/plat-s5p/Kconfig
@@ -7,7 +7,7 @@
 
 config PLAT_S5P
 	bool
-	depends on ARCH_S5P6440
+	depends on (ARCH_S5P6440 || ARCH_S5PV210)
 	default y
 	select PLAT_S3C
 	select ARM_VIC
-- 
1.6.2.5

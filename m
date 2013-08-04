From: rnayak@ti.com (Rajendra Nayak)
Date: Sun, 4 Aug 2013 21:57:37 +0530
Subject: [PATCH v3 9/9] ARM: DRA7: Add the build support in omap2plus
In-Reply-To: <1375633657-6835-1-git-send-email-rnayak@ti.com>
References: <1375633657-6835-1-git-send-email-rnayak@ti.com>
Message-ID: <1375633657-6835-10-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: R Sricharan <r.sricharan@ti.com>

Now that the needed pieces for DRA7 based SoCs' is present, enable
the build support in omap2plus_defconfig

Signed-off-by: R Sricharan <r.sricharan@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    1 +
 arch/arm/mach-omap2/Kconfig          |   10 +++++++++-
 arch/arm/plat-omap/Kconfig           |    2 +-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 5339e6a..1da7cf9 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -306,3 +306,4 @@ CONFIG_TI_DAVINCI_MDIO=y
 CONFIG_TI_DAVINCI_CPDMA=y
 CONFIG_TI_CPSW=y
 CONFIG_AT803X_PHY=y
+CONFIG_SOC_DRA7XX=y
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index fc6ec23..740f41b 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -118,7 +118,7 @@ config ARCH_OMAP2PLUS_TYPICAL
 	select I2C
 	select I2C_OMAP
 	select MENELAUS if ARCH_OMAP2
-	select NEON if ARCH_OMAP3 || ARCH_OMAP4 || SOC_OMAP5
+	select NEON if CPU_V7
 	select PM_RUNTIME
 	select REGULATOR
 	select TWL4030_CORE if ARCH_OMAP3 || ARCH_OMAP4
@@ -135,6 +135,14 @@ config SOC_HAS_REALTIME_COUNTER
 	depends on SOC_OMAP5 || SOC_DRA7XX
 	default y
 
+config SOC_DRA7XX
+	bool "TI DRA7XX"
+	select ARM_ARCH_TIMER
+	select CPU_V7
+	select ARM_GIC
+	select HAVE_SMP
+	select COMMON_CLK
+
 comment "OMAP Core Type"
 	depends on ARCH_OMAP2
 
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index f82bae2..436ea97 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -106,7 +106,7 @@ config OMAP_32K_TIMER
 	  This timer saves power compared to the OMAP_MPU_TIMER, and has
 	  support for no tick during idle. The 32KHz timer provides less
 	  intra-tick resolution than OMAP_MPU_TIMER. The 32KHz timer is
-	  currently only available for OMAP16XX, 24XX, 34XX and OMAP4/5.
+	  currently only available for OMAP16XX, 24XX, 34XX, OMAP4/5 and DRA7XX.
 
 	  On OMAP2PLUS this value is only used for CONFIG_HZ and
 	  CLOCK_TICK_RATE compile time calculation.
-- 
1.7.9.5

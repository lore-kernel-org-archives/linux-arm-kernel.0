From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Sep 2014 10:12:39 +0900
Subject: [PATCH 8/9] ARM: shmobile: Consolidate Legacy SH_CLK_CPG Kconfig
In-Reply-To: <cover.1409792454.git.horms+renesas@verge.net.au>
References: <cover.1409792454.git.horms+renesas@verge.net.au>
Message-ID: <0cdc23df6e4014a6dafe351da436dcc453f203b1.1409792454.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Consolidate SH_CLK_CPG under ARCH_SHMOBILE_LEGACY so it can
be shared by the legacy ARM mach-shmobile support code.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/Kconfig               | 1 +
 arch/arm/mach-shmobile/Kconfig | 8 --------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 93efc9a..bd8beae 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -661,6 +661,7 @@ config ARCH_SHMOBILE_LEGACY
 	select NO_IOPORT_MAP
 	select PINCTRL
 	select PM_GENERIC_DOMAINS if PM
+	select SH_CLK_CPG
 	select SPARSE_IRQ
 	help
 	  Support for Renesas ARM SoC platforms using a non-multiplatform
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index d4cf8bf..6283ff2 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -95,7 +95,6 @@ config ARCH_SH7372
 	select ARCH_RMOBILE
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_CPU_SUSPEND if PM || CPU_IDLE
-	select SH_CLK_CPG
 	select SH_INTC
 
 config ARCH_SH73A0
@@ -104,7 +103,6 @@ config ARCH_SH73A0
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select I2C
-	select SH_CLK_CPG
 	select SH_INTC
 	select RENESAS_INTC_IRQPIN
 
@@ -113,7 +111,6 @@ config ARCH_R8A73A4
 	select ARCH_RMOBILE
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
-	select SH_CLK_CPG
 	select RENESAS_IRQC
 
 config ARCH_R8A7740
@@ -121,14 +118,12 @@ config ARCH_R8A7740
 	select ARCH_RMOBILE
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
-	select SH_CLK_CPG
 	select RENESAS_INTC_IRQPIN
 
 config ARCH_R8A7778
 	bool "R-Car M1A (R8A77781)"
 	select ARCH_RCAR_GEN1
 	select ARCH_WANT_OPTIONAL_GPIOLIB
-	select SH_CLK_CPG
 	select ARM_GIC
 
 config ARCH_R8A7779
@@ -136,7 +131,6 @@ config ARCH_R8A7779
 	select ARCH_RCAR_GEN1
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
-	select SH_CLK_CPG
 
 config ARCH_R8A7790
 	bool "R-Car H2 (R8A77900)"
@@ -144,7 +138,6 @@ config ARCH_R8A7790
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select MIGHT_HAVE_PCI
-	select SH_CLK_CPG
 	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
 
 config ARCH_R8A7791
@@ -153,7 +146,6 @@ config ARCH_R8A7791
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select MIGHT_HAVE_PCI
-	select SH_CLK_CPG
 	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
 
 config ARCH_R7S72100
-- 
2.0.1

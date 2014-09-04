From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Sep 2014 10:12:38 +0900
Subject: [PATCH 7/9] ARM: shmobile: Consolidate Legacy CPU_V7 Kconfig
In-Reply-To: <cover.1409792454.git.horms+renesas@verge.net.au>
References: <cover.1409792454.git.horms+renesas@verge.net.au>
Message-ID: <0ed82bc9895daad86966d53e561330929774f92d.1409792454.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Consolidate CPU_V7 under ARCH_SHMOBILE_LEGACY so it can
be shared by the legacy ARM mach-shmobile support code.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/Kconfig               | 1 +
 arch/arm/mach-shmobile/Kconfig | 8 --------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c49a775..93efc9a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -650,6 +650,7 @@ config ARCH_SHMOBILE_LEGACY
 	select ARCH_SHMOBILE
 	select ARM_PATCH_PHYS_VIRT if MMU
 	select CLKDEV_LOOKUP
+	select CPU_V7
 	select GENERIC_CLOCKEVENTS
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 42d9de0..d4cf8bf 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -95,7 +95,6 @@ config ARCH_SH7372
 	select ARCH_RMOBILE
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_CPU_SUSPEND if PM || CPU_IDLE
-	select CPU_V7
 	select SH_CLK_CPG
 	select SH_INTC
 
@@ -104,7 +103,6 @@ config ARCH_SH73A0
 	select ARCH_RMOBILE
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
-	select CPU_V7
 	select I2C
 	select SH_CLK_CPG
 	select SH_INTC
@@ -115,7 +113,6 @@ config ARCH_R8A73A4
 	select ARCH_RMOBILE
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
-	select CPU_V7
 	select SH_CLK_CPG
 	select RENESAS_IRQC
 
@@ -124,7 +121,6 @@ config ARCH_R8A7740
 	select ARCH_RMOBILE
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
-	select CPU_V7
 	select SH_CLK_CPG
 	select RENESAS_INTC_IRQPIN
 
@@ -132,7 +128,6 @@ config ARCH_R8A7778
 	bool "R-Car M1A (R8A77781)"
 	select ARCH_RCAR_GEN1
 	select ARCH_WANT_OPTIONAL_GPIOLIB
-	select CPU_V7
 	select SH_CLK_CPG
 	select ARM_GIC
 
@@ -141,7 +136,6 @@ config ARCH_R8A7779
 	select ARCH_RCAR_GEN1
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
-	select CPU_V7
 	select SH_CLK_CPG
 
 config ARCH_R8A7790
@@ -149,7 +143,6 @@ config ARCH_R8A7790
 	select ARCH_RCAR_GEN2
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
-	select CPU_V7
 	select MIGHT_HAVE_PCI
 	select SH_CLK_CPG
 	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
@@ -159,7 +152,6 @@ config ARCH_R8A7791
 	select ARCH_RCAR_GEN2
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
-	select CPU_V7
 	select MIGHT_HAVE_PCI
 	select SH_CLK_CPG
 	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
-- 
2.0.1

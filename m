From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Sep 2014 10:12:33 +0900
Subject: [PATCH 2/9] ARM: shmobile: Introduce a Kconfig entry for R-Car Gen1
In-Reply-To: <cover.1409792454.git.horms+renesas@verge.net.au>
References: <cover.1409792454.git.horms+renesas@verge.net.au>
Message-ID: <57cc67d1422ebee313a62ff7b30981d945728094.1409792454.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Add a Kconfig entry for R-Car Generation 1 SoCs that
enables TMU timer and the INTC IRQPIN driver.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 6de3058..258d730 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -1,6 +1,11 @@
 config ARCH_SHMOBILE
 	bool
 
+config ARCH_RCAR_GEN1
+	bool
+	select RENESAS_INTC_IRQPIN
+	select SYS_SUPPORTS_SH_TMU
+
 config ARCH_RMOBILE
 	bool
 	select SYS_SUPPORTS_SH_CMT
@@ -33,8 +38,7 @@ config ARCH_R7S72100
 
 config ARCH_R8A7779
 	bool "R-Car H1 (R8A77790)"
-	select RENESAS_INTC_IRQPIN
-	select SYS_SUPPORTS_SH_TMU
+	select ARCH_RCAR_GEN1
 
 config ARCH_R8A7790
 	bool "R-Car H2 (R8A77900)"
@@ -114,21 +118,19 @@ config ARCH_R8A7740
 
 config ARCH_R8A7778
 	bool "R-Car M1A (R8A77781)"
+	select ARCH_RCAR_GEN1
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select CPU_V7
 	select SH_CLK_CPG
 	select ARM_GIC
-	select SYS_SUPPORTS_SH_TMU
-	select RENESAS_INTC_IRQPIN
 
 config ARCH_R8A7779
 	bool "R-Car H1 (R8A77790)"
+	select ARCH_RCAR_GEN1
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select CPU_V7
 	select SH_CLK_CPG
-	select RENESAS_INTC_IRQPIN
-	select SYS_SUPPORTS_SH_TMU
 
 config ARCH_R8A7790
 	bool "R-Car H2 (R8A77900)"
-- 
2.0.1

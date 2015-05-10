From: vishnupatekar0510@gmail.com (Vishnu Patekar)
Date: Sun, 10 May 2015 12:16:18 +0530
Subject: [PATCH 1/6] ARM: sunxi: Add Machine support for A33
In-Reply-To: <1431240383-12763-1-git-send-email-vishnupatekar0510@gmail.com>
References: <1431240383-12763-1-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <1431240383-12763-2-git-send-email-vishnupatekar0510@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinnner A33 quad core cortex-a7 based SOC.
It is similar to A23.

Renamed cpu method to "allwinner,sun8i" for common sun8i smp.
smp code is generic for A23, A33 and hopefully H3.

Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
---
 Documentation/devicetree/bindings/arm/sunxi.txt | 1 +
 arch/arm/mach-sunxi/Kconfig                     | 2 +-
 arch/arm/mach-sunxi/platsmp.c                   | 2 +-
 arch/arm/mach-sunxi/sunxi.c                     | 4 ++--
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.txt b/Documentation/devicetree/bindings/arm/sunxi.txt
index 42941fd..e32f082 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.txt
+++ b/Documentation/devicetree/bindings/arm/sunxi.txt
@@ -9,4 +9,5 @@ using one of the following compatible strings:
   allwinner,sun6i-a31
   allwinner,sun7i-a20
   allwinner,sun8i-a23
+  allwinner,sun8i-a33
   allwinner,sun9i-a80
diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 81502b9..38bedd8 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -35,7 +35,7 @@ config MACH_SUN7I
 	select SUN5I_HSTIMER
 
 config MACH_SUN8I
-	bool "Allwinner A23 (sun8i) SoCs support"
+	bool "Allwinner (sun8i) SoCs support"
 	default ARCH_SUNXI
 	select ARM_GIC
 	select MFD_SUN6I_PRCM
diff --git a/arch/arm/mach-sunxi/platsmp.c b/arch/arm/mach-sunxi/platsmp.c
index e8483ec..c56b501 100644
--- a/arch/arm/mach-sunxi/platsmp.c
+++ b/arch/arm/mach-sunxi/platsmp.c
@@ -189,4 +189,4 @@ struct smp_operations sun8i_smp_ops __initdata = {
 	.smp_prepare_cpus	= sun8i_smp_prepare_cpus,
 	.smp_boot_secondary	= sun8i_smp_boot_secondary,
 };
-CPU_METHOD_OF_DECLARE(sun8i_a23_smp, "allwinner,sun8i-a23", &sun8i_smp_ops);
+CPU_METHOD_OF_DECLARE(sun8i_smp, "allwinner,sun8i", &sun8i_smp_ops);
diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index 1bc811a..8937d0d 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -66,11 +66,11 @@ DT_MACHINE_START(SUN7I_DT, "Allwinner sun7i (A20) Family")
 MACHINE_END
 
 static const char * const sun8i_board_dt_compat[] = {
-	"allwinner,sun8i-a23",
+	"allwinner,sun8i",
 	NULL,
 };
 
-DT_MACHINE_START(SUN8I_DT, "Allwinner sun8i (A23) Family")
+DT_MACHINE_START(SUN8I_DT, "Allwinner sun8i Family")
 	.dt_compat	= sun8i_board_dt_compat,
 	.init_late	= sunxi_dt_cpufreq_init,
 MACHINE_END
-- 
1.9.1

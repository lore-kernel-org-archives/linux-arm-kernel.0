From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:46:52 -0400
Subject: [PATCH 07/52] ARM: mach-ep93xx: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-7-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-ep93xx/adssphere.c   |    2 +-
 arch/arm/mach-ep93xx/edb93xx.c     |   16 ++++++++--------
 arch/arm/mach-ep93xx/gesbc9312.c   |    2 +-
 arch/arm/mach-ep93xx/micro9.c      |    8 ++++----
 arch/arm/mach-ep93xx/simone.c      |    2 +-
 arch/arm/mach-ep93xx/snappercl15.c |    2 +-
 arch/arm/mach-ep93xx/ts72xx.c      |    2 +-
 7 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-ep93xx/adssphere.c b/arch/arm/mach-ep93xx/adssphere.c
index 61b98ce..0713448 100644
--- a/arch/arm/mach-ep93xx/adssphere.c
+++ b/arch/arm/mach-ep93xx/adssphere.c
@@ -33,7 +33,7 @@ static void __init adssphere_init_machine(void)
 
 MACHINE_START(ADSSPHERE, "ADS Sphere board")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
-	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
index 9969bb1..257175e 100644
--- a/arch/arm/mach-ep93xx/edb93xx.c
+++ b/arch/arm/mach-ep93xx/edb93xx.c
@@ -240,7 +240,7 @@ static void __init edb93xx_init_machine(void)
 #ifdef CONFIG_MACH_EDB9301
 MACHINE_START(EDB9301, "Cirrus Logic EDB9301 Evaluation Board")
 	/* Maintainer: H Hartley Sweeten <hsweeten@visionengravers.com> */
-	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
@@ -251,7 +251,7 @@ MACHINE_END
 #ifdef CONFIG_MACH_EDB9302
 MACHINE_START(EDB9302, "Cirrus Logic EDB9302 Evaluation Board")
 	/* Maintainer: George Kashperko <george@chas.com.ua> */
-	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
@@ -262,7 +262,7 @@ MACHINE_END
 #ifdef CONFIG_MACH_EDB9302A
 MACHINE_START(EDB9302A, "Cirrus Logic EDB9302A Evaluation Board")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
-	.boot_params	= EP93XX_SDCE0_PHYS_BASE + 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
@@ -273,7 +273,7 @@ MACHINE_END
 #ifdef CONFIG_MACH_EDB9307
 MACHINE_START(EDB9307, "Cirrus Logic EDB9307 Evaluation Board")
 	/* Maintainer: Herbert Valerio Riedel <hvr@gnu.org> */
-	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
@@ -284,7 +284,7 @@ MACHINE_END
 #ifdef CONFIG_MACH_EDB9307A
 MACHINE_START(EDB9307A, "Cirrus Logic EDB9307A Evaluation Board")
 	/* Maintainer: H Hartley Sweeten <hsweeten@visionengravers.com> */
-	.boot_params	= EP93XX_SDCE0_PHYS_BASE + 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
@@ -295,7 +295,7 @@ MACHINE_END
 #ifdef CONFIG_MACH_EDB9312
 MACHINE_START(EDB9312, "Cirrus Logic EDB9312 Evaluation Board")
 	/* Maintainer: Toufeeq Hussain <toufeeq_hussain@infosys.com> */
-	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
@@ -306,7 +306,7 @@ MACHINE_END
 #ifdef CONFIG_MACH_EDB9315
 MACHINE_START(EDB9315, "Cirrus Logic EDB9315 Evaluation Board")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
-	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
@@ -317,7 +317,7 @@ MACHINE_END
 #ifdef CONFIG_MACH_EDB9315A
 MACHINE_START(EDB9315A, "Cirrus Logic EDB9315A Evaluation Board")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
-	.boot_params	= EP93XX_SDCE0_PHYS_BASE + 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
diff --git a/arch/arm/mach-ep93xx/gesbc9312.c b/arch/arm/mach-ep93xx/gesbc9312.c
index 9bd3152..45ee205 100644
--- a/arch/arm/mach-ep93xx/gesbc9312.c
+++ b/arch/arm/mach-ep93xx/gesbc9312.c
@@ -33,7 +33,7 @@ static void __init gesbc9312_init_machine(void)
 
 MACHINE_START(GESBC9312, "Glomation GESBC-9312-sx")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
-	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
diff --git a/arch/arm/mach-ep93xx/micro9.c b/arch/arm/mach-ep93xx/micro9.c
index 7adea62..e72f736 100644
--- a/arch/arm/mach-ep93xx/micro9.c
+++ b/arch/arm/mach-ep93xx/micro9.c
@@ -77,7 +77,7 @@ static void __init micro9_init_machine(void)
 #ifdef CONFIG_MACH_MICRO9H
 MACHINE_START(MICRO9, "Contec Micro9-High")
 	/* Maintainer: Hubert Feurstein <hubert.feurstein@contec.at> */
-	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
@@ -88,7 +88,7 @@ MACHINE_END
 #ifdef CONFIG_MACH_MICRO9M
 MACHINE_START(MICRO9M, "Contec Micro9-Mid")
 	/* Maintainer: Hubert Feurstein <hubert.feurstein@contec.at> */
-	.boot_params	= EP93XX_SDCE3_PHYS_BASE_ASYNC + 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
@@ -99,7 +99,7 @@ MACHINE_END
 #ifdef CONFIG_MACH_MICRO9L
 MACHINE_START(MICRO9L, "Contec Micro9-Lite")
 	/* Maintainer: Hubert Feurstein <hubert.feurstein@contec.at> */
-	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
@@ -110,7 +110,7 @@ MACHINE_END
 #ifdef CONFIG_MACH_MICRO9S
 MACHINE_START(MICRO9S, "Contec Micro9-Slim")
 	/* Maintainer: Hubert Feurstein <hubert.feurstein@contec.at> */
-	.boot_params	= EP93XX_SDCE3_PHYS_BASE_ASYNC + 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
diff --git a/arch/arm/mach-ep93xx/simone.c b/arch/arm/mach-ep93xx/simone.c
index d96dc1c..ac66758 100644
--- a/arch/arm/mach-ep93xx/simone.c
+++ b/arch/arm/mach-ep93xx/simone.c
@@ -66,7 +66,7 @@ static void __init simone_init_machine(void)
 
 MACHINE_START(SIM_ONE, "Simplemachines Sim.One Board")
 /* Maintainer: Ryan Mallon <ryan@bluewatersys.com> */
-	.boot_params	= EP93XX_SDCE0_PHYS_BASE + 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
diff --git a/arch/arm/mach-ep93xx/snappercl15.c b/arch/arm/mach-ep93xx/snappercl15.c
index ac601fe..1b54039 100644
--- a/arch/arm/mach-ep93xx/snappercl15.c
+++ b/arch/arm/mach-ep93xx/snappercl15.c
@@ -163,7 +163,7 @@ static void __init snappercl15_init_machine(void)
 
 MACHINE_START(SNAPPER_CL15, "Bluewater Systems Snapper CL15")
 	/* Maintainer: Ryan Mallon <ryan@bluewatersys.com> */
-	.boot_params	= EP93XX_SDCE0_PHYS_BASE + 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= ep93xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.timer 		= &ep93xx_timer,
diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index c2d2cf4..1ade3c3 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -257,7 +257,7 @@ static void __init ts72xx_init_machine(void)
 
 MACHINE_START(TS72XX, "Technologic Systems TS-72xx SBC")
 	/* Maintainer: Lennert Buytenhek <buytenh@wantstofly.org> */
-	.boot_params	= EP93XX_SDCE3_PHYS_BASE_SYNC + 0x100,
+	.atag_offset	= 0x100,
 	.map_io		= ts72xx_map_io,
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
-- 
1.7.4

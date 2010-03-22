From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 22 Mar 2010 13:39:14 -0500
Subject: [PATCH 3/3] ep93xx: hookup /proc/cpuinfo extension
Message-ID: <0D753D10438DA54287A00B02708426976368DDCD3B@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This implements the arm /proc/cpuinfo extension in the various
ep93xx platforms.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

---

diff --git a/arch/arm/mach-ep93xx/adssphere.c b/arch/arm/mach-ep93xx/adssphere.c
index caf6d51..ffa7d9f 100644
--- a/arch/arm/mach-ep93xx/adssphere.c
+++ b/arch/arm/mach-ep93xx/adssphere.c
@@ -62,4 +62,5 @@ MACHINE_START(ADSSPHERE, "ADS Sphere board")
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= adssphere_init_machine,
+	.arch_cpuinfo	= ep93xx_cpuinfo,
 MACHINE_END
diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
index d22d67a..d2adb96 100644
--- a/arch/arm/mach-ep93xx/edb93xx.c
+++ b/arch/arm/mach-ep93xx/edb93xx.c
@@ -158,6 +158,7 @@ MACHINE_START(EDB9301, "Cirrus Logic EDB9301 Evaluation Board")
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
+	.arch_cpuinfo	= ep93xx_cpuinfo,
 MACHINE_END
 #endif
 
@@ -171,6 +172,7 @@ MACHINE_START(EDB9302, "Cirrus Logic EDB9302 Evaluation Board")
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
+	.arch_cpuinfo	= ep93xx_cpuinfo,
 MACHINE_END
 #endif
 
@@ -184,6 +186,7 @@ MACHINE_START(EDB9302A, "Cirrus Logic EDB9302A Evaluation Board")
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
+	.arch_cpuinfo	= ep93xx_cpuinfo,
 MACHINE_END
 #endif
 
@@ -197,6 +200,7 @@ MACHINE_START(EDB9307, "Cirrus Logic EDB9307 Evaluation Board")
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
+	.arch_cpuinfo	= ep93xx_cpuinfo,
 MACHINE_END
 #endif
 
@@ -210,6 +214,7 @@ MACHINE_START(EDB9307A, "Cirrus Logic EDB9307A Evaluation Board")
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
+	.arch_cpuinfo	= ep93xx_cpuinfo,
 MACHINE_END
 #endif
 
@@ -223,6 +228,7 @@ MACHINE_START(EDB9312, "Cirrus Logic EDB9312 Evaluation Board")
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
+	.arch_cpuinfo	= ep93xx_cpuinfo,
 MACHINE_END
 #endif
 
@@ -236,6 +242,7 @@ MACHINE_START(EDB9315, "Cirrus Logic EDB9315 Evaluation Board")
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
+	.arch_cpuinfo	= ep93xx_cpuinfo,
 MACHINE_END
 #endif
 
@@ -249,5 +256,6 @@ MACHINE_START(EDB9315A, "Cirrus Logic EDB9315A Evaluation Board")
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= edb93xx_init_machine,
+	.arch_cpuinfo	= ep93xx_cpuinfo,
 MACHINE_END
 #endif
diff --git a/arch/arm/mach-ep93xx/gesbc9312.c b/arch/arm/mach-ep93xx/gesbc9312.c
index 3da7ca8..8b32403 100644
--- a/arch/arm/mach-ep93xx/gesbc9312.c
+++ b/arch/arm/mach-ep93xx/gesbc9312.c
@@ -62,4 +62,5 @@ MACHINE_START(GESBC9312, "Glomation GESBC-9312-sx")
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= gesbc9312_init_machine,
+	.arch_cpuinfo	= ep93xx_cpuinfo,
 MACHINE_END
diff --git a/arch/arm/mach-ep93xx/micro9.c b/arch/arm/mach-ep93xx/micro9.c
index c33360e..801a9a3 100644
--- a/arch/arm/mach-ep93xx/micro9.c
+++ b/arch/arm/mach-ep93xx/micro9.c
@@ -103,6 +103,7 @@ MACHINE_START(MICRO9, "Contec Micro9-High")
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= micro9_init_machine,
+	.arch_cpuinfo	= ep93xx_cpuinfo,
 MACHINE_END
 #endif
 
@@ -116,6 +117,7 @@ MACHINE_START(MICRO9M, "Contec Micro9-Mid")
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= micro9_init_machine,
+	.arch_cpuinfo	= ep93xx_cpuinfo,
 MACHINE_END
 #endif
 
@@ -129,6 +131,7 @@ MACHINE_START(MICRO9L, "Contec Micro9-Lite")
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= micro9_init_machine,
+	.arch_cpuinfo	= ep93xx_cpuinfo,
 MACHINE_END
 #endif
 
@@ -142,5 +145,6 @@ MACHINE_START(MICRO9S, "Contec Micro9-Slim")
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= micro9_init_machine,
+	.arch_cpuinfo	= ep93xx_cpuinfo,
 MACHINE_END
 #endif
diff --git a/arch/arm/mach-ep93xx/simone.c b/arch/arm/mach-ep93xx/simone.c
index cd93990..26dd155 100644
--- a/arch/arm/mach-ep93xx/simone.c
+++ b/arch/arm/mach-ep93xx/simone.c
@@ -94,4 +94,5 @@ MACHINE_START(SIM_ONE, "Simplemachines Sim.One Board")
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= simone_init_machine,
+	.arch_cpuinfo	= ep93xx_cpuinfo,
 MACHINE_END
diff --git a/arch/arm/mach-ep93xx/snappercl15.c b/arch/arm/mach-ep93xx/snappercl15.c
index 51134b0..c6ad03b 100644
--- a/arch/arm/mach-ep93xx/snappercl15.c
+++ b/arch/arm/mach-ep93xx/snappercl15.c
@@ -169,4 +169,5 @@ MACHINE_START(SNAPPER_CL15, "Bluewater Systems Snapper CL15")
 	.init_irq	= ep93xx_init_irq,
 	.timer 		= &ep93xx_timer,
 	.init_machine	= snappercl15_init_machine,
+	.arch_cpuinfo	= ep93xx_cpuinfo,
 MACHINE_END
diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index fac1ec7..9ca7215 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -209,4 +209,5 @@ MACHINE_START(TS72XX, "Technologic Systems TS-72xx SBC")
 	.init_irq	= ep93xx_init_irq,
 	.timer		= &ep93xx_timer,
 	.init_machine	= ts72xx_init_machine,
+	.arch_cpuinfo	= ep93xx_cpuinfo,
 MACHINE_END

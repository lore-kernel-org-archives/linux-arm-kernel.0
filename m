From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:47:19 -0400
Subject: =?UTF-8?q?=5BPATCH=2034/52=5D=20ARM=3A=20mach-pxa=3A=20convert=20boot=5Fparams=20to=20atag=5Foffset?=
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-34-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-pxa/balloon3.c       |    2 +-
 arch/arm/mach-pxa/capc7117.c       |    2 +-
 arch/arm/mach-pxa/cm-x2xx.c        |    2 +-
 arch/arm/mach-pxa/cm-x300.c        |    2 +-
 arch/arm/mach-pxa/colibri-pxa270.c |    4 ++--
 arch/arm/mach-pxa/colibri-pxa300.c |    2 +-
 arch/arm/mach-pxa/colibri-pxa320.c |    2 +-
 arch/arm/mach-pxa/csb726.c         |    2 +-
 arch/arm/mach-pxa/em-x270.c        |    4 ++--
 arch/arm/mach-pxa/eseries.c        |   12 ++++++------
 arch/arm/mach-pxa/ezx.c            |   12 ++++++------
 arch/arm/mach-pxa/gumstix.c        |    2 +-
 arch/arm/mach-pxa/h5000.c          |    2 +-
 arch/arm/mach-pxa/himalaya.c       |    2 +-
 arch/arm/mach-pxa/hx4700.c         |    2 +-
 arch/arm/mach-pxa/icontrol.c       |    2 +-
 arch/arm/mach-pxa/littleton.c      |    2 +-
 arch/arm/mach-pxa/lpd270.c         |    2 +-
 arch/arm/mach-pxa/magician.c       |    2 +-
 arch/arm/mach-pxa/mainstone.c      |    2 +-
 arch/arm/mach-pxa/mioa701.c        |    2 +-
 arch/arm/mach-pxa/mp900.c          |    2 +-
 arch/arm/mach-pxa/palmld.c         |    2 +-
 arch/arm/mach-pxa/palmt5.c         |    2 +-
 arch/arm/mach-pxa/palmtc.c         |    2 +-
 arch/arm/mach-pxa/palmte2.c        |    2 +-
 arch/arm/mach-pxa/palmtreo.c       |    4 ++--
 arch/arm/mach-pxa/palmtx.c         |    2 +-
 arch/arm/mach-pxa/palmz72.c        |    2 +-
 arch/arm/mach-pxa/pcm027.c         |    2 +-
 arch/arm/mach-pxa/raumfeld.c       |    6 +++---
 arch/arm/mach-pxa/saar.c           |    2 +-
 arch/arm/mach-pxa/saarb.c          |    2 +-
 arch/arm/mach-pxa/stargate2.c      |    4 ++--
 arch/arm/mach-pxa/tavorevb.c       |    2 +-
 arch/arm/mach-pxa/tavorevb3.c      |    2 +-
 arch/arm/mach-pxa/trizeps4.c       |    4 ++--
 arch/arm/mach-pxa/viper.c          |    2 +-
 arch/arm/mach-pxa/vpac270.c        |    2 +-
 arch/arm/mach-pxa/xcep.c           |    2 +-
 arch/arm/mach-pxa/z2.c             |    2 +-
 arch/arm/mach-pxa/zeus.c           |    2 +-
 arch/arm/mach-pxa/zylonite.c       |    2 +-
 43 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index 810a982..07c055e 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -827,5 +827,5 @@ MACHINE_START(BALLOON3, "Balloon3")
 	.init_irq	= balloon3_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= balloon3_init,
-	.boot_params	= PLAT_PHYS_OFFSET + 0x100,
+	.atag_offset	= 0x100,
 MACHINE_END
diff --git a/arch/arm/mach-pxa/capc7117.c b/arch/arm/mach-pxa/capc7117.c
index 4284513..4846dd4 100644
--- a/arch/arm/mach-pxa/capc7117.c
+++ b/arch/arm/mach-pxa/capc7117.c
@@ -148,7 +148,7 @@ static void __init capc7117_init(void)
 
 MACHINE_START(CAPC7117,
 	      "Embedian CAPC-7117 evaluation kit based on the MXM-8x10 CoM")
-	.boot_params = 0xa0000100,
+	.atag_offset = 0x100,
 	.map_io = pxa3xx_map_io,
 	.init_irq = pxa3xx_init_irq,
 	.timer = &pxa_timer,
diff --git a/arch/arm/mach-pxa/cm-x2xx.c b/arch/arm/mach-pxa/cm-x2xx.c
index bc55d07..9d921cb 100644
--- a/arch/arm/mach-pxa/cm-x2xx.c
+++ b/arch/arm/mach-pxa/cm-x2xx.c
@@ -512,7 +512,7 @@ static void __init cmx2xx_map_io(void)
 #endif
 
 MACHINE_START(ARMCORE, "Compulab CM-X2XX")
-	.boot_params	= 0xa0000100,
+	.atag_offset	= 0x100,
 	.map_io		= cmx2xx_map_io,
 	.nr_irqs	= CMX2XX_NR_IRQS,
 	.init_irq	= cmx2xx_init_irq,
diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index b2248e7..0bd0c15 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -856,7 +856,7 @@ static void __init cm_x300_fixup(struct machine_desc *mdesc, struct tag *tags,
 }
 
 MACHINE_START(CM_X300, "CM-X300 module")
-	.boot_params	= 0xa0000100,
+	.atag_offset	= 0x100,
 	.map_io		= pxa3xx_map_io,
 	.init_irq	= pxa3xx_init_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/colibri-pxa270.c b/arch/arm/mach-pxa/colibri-pxa270.c
index 7545a48..5f2d30b 100644
--- a/arch/arm/mach-pxa/colibri-pxa270.c
+++ b/arch/arm/mach-pxa/colibri-pxa270.c
@@ -306,7 +306,7 @@ static void __init colibri_pxa270_income_init(void)
 }
 
 MACHINE_START(COLIBRI, "Toradex Colibri PXA270")
-	.boot_params	= COLIBRI_SDRAM_BASE + 0x100,
+	.atag_offset	= 0x100,
 	.init_machine	= colibri_pxa270_init,
 	.map_io		= pxa27x_map_io,
 	.init_irq	= pxa27x_init_irq,
@@ -314,7 +314,7 @@ MACHINE_START(COLIBRI, "Toradex Colibri PXA270")
 MACHINE_END
 
 MACHINE_START(INCOME, "Income s.r.o. SH-Dmaster PXA270 SBC")
-	.boot_params	= 0xa0000100,
+	.atag_offset	= 0x100,
 	.init_machine	= colibri_pxa270_income_init,
 	.map_io		= pxa27x_map_io,
 	.init_irq	= pxa27x_init_irq,
diff --git a/arch/arm/mach-pxa/colibri-pxa300.c b/arch/arm/mach-pxa/colibri-pxa300.c
index 66dd81c..e6f3cd9 100644
--- a/arch/arm/mach-pxa/colibri-pxa300.c
+++ b/arch/arm/mach-pxa/colibri-pxa300.c
@@ -183,7 +183,7 @@ void __init colibri_pxa300_init(void)
 }
 
 MACHINE_START(COLIBRI300, "Toradex Colibri PXA300")
-	.boot_params	= COLIBRI_SDRAM_BASE + 0x100,
+	.atag_offset	= 0x100,
 	.init_machine	= colibri_pxa300_init,
 	.map_io		= pxa3xx_map_io,
 	.init_irq	= pxa3xx_init_irq,
diff --git a/arch/arm/mach-pxa/colibri-pxa320.c b/arch/arm/mach-pxa/colibri-pxa320.c
index ff9ff5f..de99efa 100644
--- a/arch/arm/mach-pxa/colibri-pxa320.c
+++ b/arch/arm/mach-pxa/colibri-pxa320.c
@@ -254,7 +254,7 @@ void __init colibri_pxa320_init(void)
 }
 
 MACHINE_START(COLIBRI320, "Toradex Colibri PXA320")
-	.boot_params	= COLIBRI_SDRAM_BASE + 0x100,
+	.atag_offset	= 0x100,
 	.init_machine	= colibri_pxa320_init,
 	.map_io		= pxa3xx_map_io,
 	.init_irq	= pxa3xx_init_irq,
diff --git a/arch/arm/mach-pxa/csb726.c b/arch/arm/mach-pxa/csb726.c
index 0481c29..9cbd37b 100644
--- a/arch/arm/mach-pxa/csb726.c
+++ b/arch/arm/mach-pxa/csb726.c
@@ -273,7 +273,7 @@ static void __init csb726_init(void)
 }
 
 MACHINE_START(CSB726, "Cogent CSB726")
-	.boot_params	= 0xa0000100,
+	.atag_offset	= 0x100,
 	.map_io         = pxa27x_map_io,
 	.init_irq       = pxa27x_init_irq,
 	.init_machine   = csb726_init,
diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
index f8a6e9d..677a435 100644
--- a/arch/arm/mach-pxa/em-x270.c
+++ b/arch/arm/mach-pxa/em-x270.c
@@ -1299,7 +1299,7 @@ static void __init em_x270_init(void)
 }
 
 MACHINE_START(EM_X270, "Compulab EM-X270")
-	.boot_params	= 0xa0000100,
+	.atag_offset	= 0x100,
 	.map_io		= pxa27x_map_io,
 	.init_irq	= pxa27x_init_irq,
 	.timer		= &pxa_timer,
@@ -1307,7 +1307,7 @@ MACHINE_START(EM_X270, "Compulab EM-X270")
 MACHINE_END
 
 MACHINE_START(EXEDA, "Compulab eXeda")
-	.boot_params	= 0xa0000100,
+	.atag_offset	= 0x100,
 	.map_io		= pxa27x_map_io,
 	.init_irq	= pxa27x_init_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/eseries.c b/arch/arm/mach-pxa/eseries.c
index 2e3970f..2d827d9 100644
--- a/arch/arm/mach-pxa/eseries.c
+++ b/arch/arm/mach-pxa/eseries.c
@@ -189,7 +189,7 @@ static void __init e330_init(void)
 
 MACHINE_START(E330, "Toshiba e330")
 	/* Maintainer: Ian Molton (spyro at f2s.com) */
-	.boot_params	= 0xa0000100,
+	.atag_offset	= 0x100,
 	.map_io		= pxa25x_map_io,
 	.nr_irqs	= ESERIES_NR_IRQS,
 	.init_irq	= pxa25x_init_irq,
@@ -238,7 +238,7 @@ static void __init e350_init(void)
 
 MACHINE_START(E350, "Toshiba e350")
 	/* Maintainer: Ian Molton (spyro at f2s.com) */
-	.boot_params	= 0xa0000100,
+	.atag_offset	= 0x100,
 	.map_io		= pxa25x_map_io,
 	.nr_irqs	= ESERIES_NR_IRQS,
 	.init_irq	= pxa25x_init_irq,
@@ -360,7 +360,7 @@ static void __init e400_init(void)
 
 MACHINE_START(E400, "Toshiba e400")
 	/* Maintainer: Ian Molton (spyro at f2s.com) */
-	.boot_params	= 0xa0000100,
+	.atag_offset	= 0x100,
 	.map_io		= pxa25x_map_io,
 	.nr_irqs	= ESERIES_NR_IRQS,
 	.init_irq	= pxa25x_init_irq,
@@ -548,7 +548,7 @@ static void __init e740_init(void)
 
 MACHINE_START(E740, "Toshiba e740")
 	/* Maintainer: Ian Molton (spyro at f2s.com) */
-	.boot_params	= 0xa0000100,
+	.atag_offset	= 0x100,
 	.map_io		= pxa25x_map_io,
 	.nr_irqs	= ESERIES_NR_IRQS,
 	.init_irq	= pxa25x_init_irq,
@@ -739,7 +739,7 @@ static void __init e750_init(void)
 
 MACHINE_START(E750, "Toshiba e750")
 	/* Maintainer: Ian Molton (spyro at f2s.com) */
-	.boot_params	= 0xa0000100,
+	.atag_offset	= 0x100,
 	.map_io		= pxa25x_map_io,
 	.nr_irqs	= ESERIES_NR_IRQS,
 	.init_irq	= pxa25x_init_irq,
@@ -943,7 +943,7 @@ static void __init e800_init(void)
 
 MACHINE_START(E800, "Toshiba e800")
 	/* Maintainer: Ian Molton (spyro at f2s.com) */
-	.boot_params	= 0xa0000100,
+	.atag_offset	= 0x100,
 	.map_io		= pxa25x_map_io,
 	.nr_irqs	= ESERIES_NR_IRQS,
 	.init_irq	= pxa25x_init_irq,
diff --git a/arch/arm/mach-pxa/ezx.c b/arch/arm/mach-pxa/ezx.c
index d88aed8..0d263e0 100644
--- a/arch/arm/mach-pxa/ezx.c
+++ b/arch/arm/mach-pxa/ezx.c
@@ -797,7 +797,7 @@ static void __init a780_init(void)
 }
 
 MACHINE_START(EZX_A780, "Motorola EZX A780")
-	.boot_params    = 0xa0000100,
+	.atag_offset    = 0x100,
 	.map_io         = pxa27x_map_io,
 	.nr_irqs	= EZX_NR_IRQS,
 	.init_irq       = pxa27x_init_irq,
@@ -862,7 +862,7 @@ static void __init e680_init(void)
 }
 
 MACHINE_START(EZX_E680, "Motorola EZX E680")
-	.boot_params    = 0xa0000100,
+	.atag_offset    = 0x100,
 	.map_io         = pxa27x_map_io,
 	.nr_irqs	= EZX_NR_IRQS,
 	.init_irq       = pxa27x_init_irq,
@@ -927,7 +927,7 @@ static void __init a1200_init(void)
 }
 
 MACHINE_START(EZX_A1200, "Motorola EZX A1200")
-	.boot_params    = 0xa0000100,
+	.atag_offset    = 0x100,
 	.map_io         = pxa27x_map_io,
 	.nr_irqs	= EZX_NR_IRQS,
 	.init_irq       = pxa27x_init_irq,
@@ -1117,7 +1117,7 @@ static void __init a910_init(void)
 }
 
 MACHINE_START(EZX_A910, "Motorola EZX A910")
-	.boot_params    = 0xa0000100,
+	.atag_offset    = 0x100,
 	.map_io         = pxa27x_map_io,
 	.nr_irqs	= EZX_NR_IRQS,
 	.init_irq       = pxa27x_init_irq,
@@ -1182,7 +1182,7 @@ static void __init e6_init(void)
 }
 
 MACHINE_START(EZX_E6, "Motorola EZX E6")
-	.boot_params    = 0xa0000100,
+	.atag_offset    = 0x100,
 	.map_io         = pxa27x_map_io,
 	.nr_irqs	= EZX_NR_IRQS,
 	.init_irq       = pxa27x_init_irq,
@@ -1221,7 +1221,7 @@ static void __init e2_init(void)
 }
 
 MACHINE_START(EZX_E2, "Motorola EZX E2")
-	.boot_params    = 0xa0000100,
+	.atag_offset    = 0x100,
 	.map_io         = pxa27x_map_io,
 	.nr_irqs	= EZX_NR_IRQS,
 	.init_irq       = pxa27x_init_irq,
diff --git a/arch/arm/mach-pxa/gumstix.c b/arch/arm/mach-pxa/gumstix.c
index d65e4bd..c7753ae 100644
--- a/arch/arm/mach-pxa/gumstix.c
+++ b/arch/arm/mach-pxa/gumstix.c
@@ -233,7 +233,7 @@ static void __init gumstix_init(void)
 }
 
 MACHINE_START(GUMSTIX, "Gumstix")
-	.boot_params	= 0xa0000100, /* match u-boot bi_boot_params */
+	.atag_offset	= 0x100, /* match u-boot bi_boot_params */
 	.map_io		= pxa25x_map_io,
 	.init_irq	= pxa25x_init_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/h5000.c b/arch/arm/mach-pxa/h5000.c
index 657db46..3b994f7 100644
--- a/arch/arm/mach-pxa/h5000.c
+++ b/arch/arm/mach-pxa/h5000.c
@@ -202,7 +202,7 @@ static void __init h5000_init(void)
 }
 
 MACHINE_START(H5400, "HP iPAQ H5000")
-	.boot_params = 0xa0000100,
+	.atag_offset = 0x100,
 	.map_io = pxa25x_map_io,
 	.init_irq = pxa25x_init_irq,
 	.timer = &pxa_timer,
diff --git a/arch/arm/mach-pxa/himalaya.c b/arch/arm/mach-pxa/himalaya.c
index e8603eb..7161340 100644
--- a/arch/arm/mach-pxa/himalaya.c
+++ b/arch/arm/mach-pxa/himalaya.c
@@ -159,7 +159,7 @@ static void __init himalaya_init(void)
 
 
 MACHINE_START(HIMALAYA, "HTC Himalaya")
-	.boot_params = 0xa0000100,
+	.atag_offset = 0x100,
 	.map_io = pxa25x_map_io,
 	.init_irq = pxa25x_init_irq,
 	.init_machine = himalaya_init,
diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index f941a49..322ea99 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -870,7 +870,7 @@ static void __init hx4700_init(void)
 }
 
 MACHINE_START(H4700, "HP iPAQ HX4700")
-	.boot_params  = 0xa0000100,
+	.atag_offset  = 0x100,
 	.map_io       = pxa27x_map_io,
 	.nr_irqs      = HX4700_NR_IRQS,
 	.init_irq     = pxa27x_init_irq,
diff --git a/arch/arm/mach-pxa/icontrol.c b/arch/arm/mach-pxa/icontrol.c
index 6cedc81..8c08bcf 100644
--- a/arch/arm/mach-pxa/icontrol.c
+++ b/arch/arm/mach-pxa/icontrol.c
@@ -191,7 +191,7 @@ static void __init icontrol_init(void)
 }
 
 MACHINE_START(ICONTROL, "iControl/SafeTcam boards using Embedian MXM-8x10 CoM")
-	.boot_params	= 0xa0000100,
+	.atag_offset	= 0x100,
 	.map_io		= pxa3xx_map_io,
 	.init_irq	= pxa3xx_init_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
index e5e326d..ebc3b7f 100644
--- a/arch/arm/mach-pxa/littleton.c
+++ b/arch/arm/mach-pxa/littleton.c
@@ -437,7 +437,7 @@ static void __init littleton_init(void)
 }
 
 MACHINE_START(LITTLETON, "Marvell Form Factor Development Platform (aka Littleton)")
-	.boot_params	= 0xa0000100,
+	.atag_offset	= 0x100,
 	.map_io		= pxa3xx_map_io,
 	.nr_irqs	= LITTLETON_NR_IRQS,
 	.init_irq	= pxa3xx_init_irq,
diff --git a/arch/arm/mach-pxa/lpd270.c b/arch/arm/mach-pxa/lpd270.c
index 6cf8180..3fb82e4 100644
--- a/arch/arm/mach-pxa/lpd270.c
+++ b/arch/arm/mach-pxa/lpd270.c
@@ -499,7 +499,7 @@ static void __init lpd270_map_io(void)
 
 MACHINE_START(LOGICPD_PXA270, "LogicPD PXA270 Card Engine")
 	/* Maintainer: Peter Barada */
-	.boot_params	= 0xa0000100,
+	.atag_offset	= 0x100,
 	.map_io		= lpd270_map_io,
 	.nr_irqs	= LPD270_NR_IRQS,
 	.init_irq	= lpd270_init_irq,
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index e192057..f14c3c7 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -764,7 +764,7 @@ static void __init magician_init(void)
 
 
 MACHINE_START(MAGICIAN, "HTC Magician")
-	.boot_params = 0xa0000100,
+	.atag_offset = 0x100,
 	.map_io = pxa27x_map_io,
 	.nr_irqs = MAGICIAN_NR_IRQS,
 	.init_irq = pxa27x_init_irq,
diff --git a/arch/arm/mach-pxa/mainstone.c b/arch/arm/mach-pxa/mainstone.c
index 3479e2b..92227ff 100644
--- a/arch/arm/mach-pxa/mainstone.c
+++ b/arch/arm/mach-pxa/mainstone.c
@@ -616,7 +616,7 @@ static void __init mainstone_map_io(void)
 
 MACHINE_START(MAINSTONE, "Intel HCDDBBVA0 Development Platform (aka Mainstone)")
 	/* Maintainer: MontaVista Software Inc. */
-	.boot_params	= 0xa0000100,	/* BLOB boot parameter setting */
+	.atag_offset	= 0x100,	/* BLOB boot parameter setting */
 	.map_io		= mainstone_map_io,
 	.nr_irqs	= MAINSTONE_NR_IRQS,
 	.init_irq	= mainstone_init_irq,
diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index e347013..918589c 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -791,7 +791,7 @@ static void mioa701_machine_exit(void)
 }
 
 MACHINE_START(MIOA701, "MIO A701")
-	.boot_params	= 0xa0000100,
+	.atag_offset	= 0x100,
 	.map_io		= &pxa27x_map_io,
 	.init_irq	= &pxa27x_init_irq,
 	.init_machine	= mioa701_machine_init,
diff --git a/arch/arm/mach-pxa/mp900.c b/arch/arm/mach-pxa/mp900.c
index 59cce78..3acd0c4 100644
--- a/arch/arm/mach-pxa/mp900.c
+++ b/arch/arm/mach-pxa/mp900.c
@@ -92,7 +92,7 @@ static void __init mp900c_init(void)
 
 /* Maintainer - Michael Petchkovsky <mkpetch@internode.on.net> */
 MACHINE_START(NEC_MP900, "MobilePro900/C")
-	.boot_params	= 0xa0220100,
+	.atag_offset	= 0x220100,
 	.timer		= &pxa_timer,
 	.map_io		= pxa25x_map_io,
 	.init_irq	= pxa25x_init_irq,
diff --git a/arch/arm/mach-pxa/palmld.c b/arch/arm/mach-pxa/palmld.c
index 4061ecd..e4ccdf7 100644
--- a/arch/arm/mach-pxa/palmld.c
+++ b/arch/arm/mach-pxa/palmld.c
@@ -342,7 +342,7 @@ static void __init palmld_init(void)
 }
 
 MACHINE_START(PALMLD, "Palm LifeDrive")
-	.boot_params	= 0xa0000100,
+	.atag_offset	= 0x100,
 	.map_io		= palmld_map_io,
 	.init_irq	= pxa27x_init_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/palmt5.c b/arch/arm/mach-pxa/palmt5.c
index df4d7d0..651c6ff 100644
--- a/arch/arm/mach-pxa/palmt5.c
+++ b/arch/arm/mach-pxa/palmt5.c
@@ -202,7 +202,7 @@ static void __init palmt5_init(void)
 }
 
 MACHINE_START(PALMT5, "Palm Tungsten|T5")
-	.boot_params	= 0xa0000100,
+	.atag_offset	= 0x100,
 	.map_io		= pxa27x_map_io,
 	.reserve	= palmt5_reserve,
 	.init_irq	= pxa27x_init_irq,
diff --git a/arch/arm/mach-pxa/palmtc.c b/arch/arm/mach-pxa/palmtc.c
index fb06bd0..991c65c 100644
--- a/arch/arm/mach-pxa/palmtc.c
+++ b/arch/arm/mach-pxa/palmtc.c
@@ -538,7 +538,7 @@ static void __init palmtc_init(void)
 };
 
 MACHINE_START(PALMTC, "Palm Tungsten|C")
-	.boot_params 	= 0xa0000100,
+	.atag_offset 	= 0x100,
 	.map_io		= pxa25x_map_io,
 	.init_irq	= pxa25x_init_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/palmte2.c b/arch/arm/mach-pxa/palmte2.c
index 726f5b9..03dfe5e 100644
--- a/arch/arm/mach-pxa/palmte2.c
+++ b/arch/arm/mach-pxa/palmte2.c
@@ -356,7 +356,7 @@ static void __init palmte2_init(void)
 }
 
 MACHINE_START(PALMTE2, "Palm Tungsten|E2")
-	.boot_params	= 0xa0000100,
+	.atag_offset	= 0x100,
 	.map_io		= pxa25x_map_io,
 	.init_irq	= pxa25x_init_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/palmtreo.c b/arch/arm/mach-pxa/palmtreo.c
index 20d1b18..bda7f28 100644
--- a/arch/arm/mach-pxa/palmtreo.c
+++ b/arch/arm/mach-pxa/palmtreo.c
@@ -440,7 +440,7 @@ static void __init centro_init(void)
 }
 
 MACHINE_START(TREO680, "Palm Treo 680")
-	.boot_params    = 0xa0000100,
+	.atag_offset    = 0x100,
 	.map_io         = pxa27x_map_io,
 	.reserve	= treo_reserve,
 	.init_irq       = pxa27x_init_irq,
@@ -449,7 +449,7 @@ MACHINE_START(TREO680, "Palm Treo 680")
 MACHINE_END
 
 MACHINE_START(CENTRO, "Palm Centro 685")
-	.boot_params    = 0xa0000100,
+	.atag_offset    = 0x100,
 	.map_io         = pxa27x_map_io,
 	.reserve	= treo_reserve,
 	.init_irq       = pxa27x_init_irq,
diff --git a/arch/arm/mach-pxa/palmtx.c b/arch/arm/mach-pxa/palmtx.c
index 595f002..8718f06 100644
--- a/arch/arm/mach-pxa/palmtx.c
+++ b/arch/arm/mach-pxa/palmtx.c
@@ -364,7 +364,7 @@ static void __init palmtx_init(void)
 }
 
 MACHINE_START(PALMTX, "Palm T|X")
-	.boot_params	= 0xa0000100,
+	.atag_offset	= 0x100,
 	.map_io		= palmtx_map_io,
 	.init_irq	= pxa27x_init_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/palmz72.c b/arch/arm/mach-pxa/palmz72.c
index 65f24f0..1587aa4 100644
--- a/arch/arm/mach-pxa/palmz72.c
+++ b/arch/arm/mach-pxa/palmz72.c
@@ -398,7 +398,7 @@ static void __init palmz72_init(void)
 }
 
 MACHINE_START(PALMZ72, "Palm Zire72")
-	.boot_params	= 0xa0000100,
+	.atag_offset	= 0x100,
 	.map_io		= pxa27x_map_io,
 	.init_irq	= pxa27x_init_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/pcm027.c b/arch/arm/mach-pxa/pcm027.c
index 1fc8a66..b487337 100644
--- a/arch/arm/mach-pxa/pcm027.c
+++ b/arch/arm/mach-pxa/pcm027.c
@@ -258,7 +258,7 @@ static void __init pcm027_map_io(void)
 
 MACHINE_START(PCM027, "Phytec Messtechnik GmbH phyCORE-PXA270")
 	/* Maintainer: Pengutronix */
-	.boot_params	= 0xa0000100,
+	.atag_offset	= 0x100,
 	.map_io		= pcm027_map_io,
 	.nr_irqs	= PCM027_NR_IRQS,
 	.init_irq	= pxa27x_init_irq,
diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index d130f77..32cc3ea 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -1087,7 +1087,7 @@ static void __init raumfeld_speaker_init(void)
 
 #ifdef CONFIG_MACH_RAUMFELD_RC
 MACHINE_START(RAUMFELD_RC, "Raumfeld Controller")
-	.boot_params	= RAUMFELD_SDRAM_BASE + 0x100,
+	.atag_offset	= 0x100,
 	.init_machine	= raumfeld_controller_init,
 	.map_io		= pxa3xx_map_io,
 	.init_irq	= pxa3xx_init_irq,
@@ -1097,7 +1097,7 @@ MACHINE_END
 
 #ifdef CONFIG_MACH_RAUMFELD_CONNECTOR
 MACHINE_START(RAUMFELD_CONNECTOR, "Raumfeld Connector")
-	.boot_params	= RAUMFELD_SDRAM_BASE + 0x100,
+	.atag_offset	= 0x100,
 	.init_machine	= raumfeld_connector_init,
 	.map_io		= pxa3xx_map_io,
 	.init_irq	= pxa3xx_init_irq,
@@ -1107,7 +1107,7 @@ MACHINE_END
 
 #ifdef CONFIG_MACH_RAUMFELD_SPEAKER
 MACHINE_START(RAUMFELD_SPEAKER, "Raumfeld Speaker")
-	.boot_params	= RAUMFELD_SDRAM_BASE + 0x100,
+	.atag_offset	= 0x100,
 	.init_machine	= raumfeld_speaker_init,
 	.map_io		= pxa3xx_map_io,
 	.init_irq	= pxa3xx_init_irq,
diff --git a/arch/arm/mach-pxa/saar.c b/arch/arm/mach-pxa/saar.c
index fee97a9..2e7ae07 100644
--- a/arch/arm/mach-pxa/saar.c
+++ b/arch/arm/mach-pxa/saar.c
@@ -596,7 +596,7 @@ static void __init saar_init(void)
 
 MACHINE_START(SAAR, "PXA930 Handheld Platform (aka SAAR)")
 	/* Maintainer: Eric Miao <eric.miao@marvell.com> */
-	.boot_params    = 0xa0000100,
+	.atag_offset    = 0x100,
 	.map_io         = pxa3xx_map_io,
 	.init_irq       = pxa3xx_init_irq,
 	.timer          = &pxa_timer,
diff --git a/arch/arm/mach-pxa/saarb.c b/arch/arm/mach-pxa/saarb.c
index 9322fe5..d34b5c8 100644
--- a/arch/arm/mach-pxa/saarb.c
+++ b/arch/arm/mach-pxa/saarb.c
@@ -103,7 +103,7 @@ static void __init saarb_init(void)
 }
 
 MACHINE_START(SAARB, "PXA955 Handheld Platform (aka SAARB)")
-	.boot_params    = 0xa0000100,
+	.atag_offset    = 0x100,
 	.map_io         = pxa_map_io,
 	.nr_irqs	= SAARB_NR_IRQS,
 	.init_irq       = pxa95x_init_irq,
diff --git a/arch/arm/mach-pxa/stargate2.c b/arch/arm/mach-pxa/stargate2.c
index cb5611d..c4c5c3c 100644
--- a/arch/arm/mach-pxa/stargate2.c
+++ b/arch/arm/mach-pxa/stargate2.c
@@ -1003,7 +1003,7 @@ MACHINE_START(INTELMOTE2, "IMOTE 2")
 	.init_irq	= pxa27x_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= imote2_init,
-	.boot_params	= 0xA0000100,
+	.atag_offset	= 0x100,
 MACHINE_END
 #endif
 
@@ -1014,6 +1014,6 @@ MACHINE_START(STARGATE2, "Stargate 2")
 	.init_irq = pxa27x_init_irq,
 	.timer = &pxa_timer,
 	.init_machine = stargate2_init,
-	.boot_params = 0xA0000100,
+	.atag_offset = 0x100,
 MACHINE_END
 #endif
diff --git a/arch/arm/mach-pxa/tavorevb.c b/arch/arm/mach-pxa/tavorevb.c
index 53d4a47..105bd36 100644
--- a/arch/arm/mach-pxa/tavorevb.c
+++ b/arch/arm/mach-pxa/tavorevb.c
@@ -489,7 +489,7 @@ static void __init tavorevb_init(void)
 
 MACHINE_START(TAVOREVB, "PXA930 Evaluation Board (aka TavorEVB)")
 	/* Maintainer: Eric Miao <eric.miao@marvell.com> */
-	.boot_params    = 0xa0000100,
+	.atag_offset    = 0x100,
 	.map_io         = pxa3xx_map_io,
 	.init_irq       = pxa3xx_init_irq,
 	.timer          = &pxa_timer,
diff --git a/arch/arm/mach-pxa/tavorevb3.c b/arch/arm/mach-pxa/tavorevb3.c
index 79f4422..a47bcf5 100644
--- a/arch/arm/mach-pxa/tavorevb3.c
+++ b/arch/arm/mach-pxa/tavorevb3.c
@@ -125,7 +125,7 @@ static void __init evb3_init(void)
 }
 
 MACHINE_START(TAVOREVB3, "PXA950 Evaluation Board (aka TavorEVB3)")
-	.boot_params	= 0xa0000100,
+	.atag_offset	= 0x100,
 	.map_io         = pxa3xx_map_io,
 	.nr_irqs	= TAVOREVB3_NR_IRQS,
 	.init_irq       = pxa3xx_init_irq,
diff --git a/arch/arm/mach-pxa/trizeps4.c b/arch/arm/mach-pxa/trizeps4.c
index 687417a..1bac844 100644
--- a/arch/arm/mach-pxa/trizeps4.c
+++ b/arch/arm/mach-pxa/trizeps4.c
@@ -554,7 +554,7 @@ static void __init trizeps4_map_io(void)
 
 MACHINE_START(TRIZEPS4, "Keith und Koep Trizeps IV module")
 	/* MAINTAINER("J?rgen Schindele") */
-	.boot_params	= TRIZEPS4_SDRAM_BASE + 0x100,
+	.atag_offset	= 0x100,
 	.init_machine	= trizeps4_init,
 	.map_io		= trizeps4_map_io,
 	.init_irq	= pxa27x_init_irq,
@@ -563,7 +563,7 @@ MACHINE_END
 
 MACHINE_START(TRIZEPS4WL, "Keith und Koep Trizeps IV-WL module")
 	/* MAINTAINER("J?rgen Schindele") */
-	.boot_params	= TRIZEPS4_SDRAM_BASE + 0x100,
+	.atag_offset	= 0x100,
 	.init_machine	= trizeps4_init,
 	.map_io		= trizeps4_map_io,
 	.init_irq	= pxa27x_init_irq,
diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
index 903218e..e879382 100644
--- a/arch/arm/mach-pxa/viper.c
+++ b/arch/arm/mach-pxa/viper.c
@@ -992,7 +992,7 @@ static void __init viper_map_io(void)
 
 MACHINE_START(VIPER, "Arcom/Eurotech VIPER SBC")
 	/* Maintainer: Marc Zyngier <maz@misterjones.org> */
-	.boot_params	= 0xa0000100,
+	.atag_offset	= 0x100,
 	.map_io		= viper_map_io,
 	.init_irq	= viper_init_irq,
 	.timer          = &pxa_timer,
diff --git a/arch/arm/mach-pxa/vpac270.c b/arch/arm/mach-pxa/vpac270.c
index 67bd414..6fc0f08 100644
--- a/arch/arm/mach-pxa/vpac270.c
+++ b/arch/arm/mach-pxa/vpac270.c
@@ -716,7 +716,7 @@ static void __init vpac270_init(void)
 }
 
 MACHINE_START(VPAC270, "Voipac PXA270")
-	.boot_params	= 0xa0000100,
+	.atag_offset	= 0x100,
 	.map_io		= pxa27x_map_io,
 	.init_irq	= pxa27x_init_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/xcep.c b/arch/arm/mach-pxa/xcep.c
index f55f8f2..5b06203 100644
--- a/arch/arm/mach-pxa/xcep.c
+++ b/arch/arm/mach-pxa/xcep.c
@@ -181,7 +181,7 @@ static void __init xcep_init(void)
 }
 
 MACHINE_START(XCEP, "Iskratel XCEP")
-	.boot_params	= 0xa0000100,
+	.atag_offset	= 0x100,
 	.init_machine	= xcep_init,
 	.map_io		= pxa25x_map_io,
 	.init_irq	= pxa25x_init_irq,
diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index fbe9e02..ec91c4c 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -701,7 +701,7 @@ static void __init z2_init(void)
 }
 
 MACHINE_START(ZIPIT2, "Zipit Z2")
-	.boot_params	= 0xa0000100,
+	.atag_offset	= 0x100,
 	.map_io		= pxa27x_map_io,
 	.init_irq	= pxa27x_init_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index 00363c7..56fa747 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -904,7 +904,7 @@ static void __init zeus_map_io(void)
 
 MACHINE_START(ARCOM_ZEUS, "Arcom/Eurotech ZEUS")
 	/* Maintainer: Marc Zyngier <maz@misterjones.org> */
-	.boot_params	= 0xa0000100,
+	.atag_offset	= 0x100,
 	.map_io		= zeus_map_io,
 	.nr_irqs	= ZEUS_NR_IRQS,
 	.init_irq	= zeus_init_irq,
diff --git a/arch/arm/mach-pxa/zylonite.c b/arch/arm/mach-pxa/zylonite.c
index 5821185..0b41ff6 100644
--- a/arch/arm/mach-pxa/zylonite.c
+++ b/arch/arm/mach-pxa/zylonite.c
@@ -422,7 +422,7 @@ static void __init zylonite_init(void)
 }
 
 MACHINE_START(ZYLONITE, "PXA3xx Platform Development Kit (aka Zylonite)")
-	.boot_params	= 0xa0000100,
+	.atag_offset	= 0x100,
 	.map_io		= pxa3xx_map_io,
 	.nr_irqs	= ZYLONITE_NR_IRQS,
 	.init_irq	= pxa3xx_init_irq,
-- 
1.7.4

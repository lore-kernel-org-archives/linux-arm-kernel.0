From: robherring2@gmail.com (Rob Herring)
Date: Fri, 13 Jan 2012 10:34:08 -0600
Subject: [RFC PATCH 07/10] ARM: pxa: remove NR_IRQS
In-Reply-To: <1326472451-9002-1-git-send-email-robherring2@gmail.com>
References: <1326472451-9002-1-git-send-email-robherring2@gmail.com>
Message-ID: <1326472451-9002-8-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Remove NR_IRQS and add a per machine .nr_irqs setting.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-pxa/capc7117.c          |    1 +
 arch/arm/mach-pxa/cm-x300.c           |    1 +
 arch/arm/mach-pxa/colibri-pxa270.c    |    2 ++
 arch/arm/mach-pxa/colibri-pxa300.c    |    1 +
 arch/arm/mach-pxa/colibri-pxa320.c    |    1 +
 arch/arm/mach-pxa/corgi.c             |    3 +++
 arch/arm/mach-pxa/csb726.c            |    1 +
 arch/arm/mach-pxa/devices.c           |    1 +
 arch/arm/mach-pxa/em-x270.c           |    2 ++
 arch/arm/mach-pxa/gumstix.c           |    1 +
 arch/arm/mach-pxa/h5000.c             |    1 +
 arch/arm/mach-pxa/himalaya.c          |    1 +
 arch/arm/mach-pxa/icontrol.c          |    1 +
 arch/arm/mach-pxa/idp.c               |    1 +
 arch/arm/mach-pxa/include/mach/irqs.h |    2 +-
 arch/arm/mach-pxa/mioa701.c           |    1 +
 arch/arm/mach-pxa/mp900.c             |    1 +
 arch/arm/mach-pxa/palmld.c            |    1 +
 arch/arm/mach-pxa/palmt5.c            |    1 +
 arch/arm/mach-pxa/palmtc.c            |    1 +
 arch/arm/mach-pxa/palmte2.c           |    1 +
 arch/arm/mach-pxa/palmtreo.c          |    2 ++
 arch/arm/mach-pxa/palmtx.c            |    1 +
 arch/arm/mach-pxa/palmz72.c           |    1 +
 arch/arm/mach-pxa/raumfeld.c          |    3 +++
 arch/arm/mach-pxa/saar.c              |    1 +
 arch/arm/mach-pxa/spitz.c             |    3 +++
 arch/arm/mach-pxa/stargate2.c         |    1 +
 arch/arm/mach-pxa/tavorevb.c          |    1 +
 arch/arm/mach-pxa/time.c              |    1 +
 arch/arm/mach-pxa/trizeps4.c          |    2 ++
 arch/arm/mach-pxa/viper.c             |    1 +
 arch/arm/mach-pxa/vpac270.c           |    1 +
 arch/arm/mach-pxa/xcep.c              |    1 +
 arch/arm/mach-pxa/z2.c                |    1 +
 35 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/capc7117.c b/arch/arm/mach-pxa/capc7117.c
index c91727d..9a8760b 100644
--- a/arch/arm/mach-pxa/capc7117.c
+++ b/arch/arm/mach-pxa/capc7117.c
@@ -150,6 +150,7 @@ MACHINE_START(CAPC7117,
 	      "Embedian CAPC-7117 evaluation kit based on the MXM-8x10 CoM")
 	.atag_offset = 0x100,
 	.map_io = pxa3xx_map_io,
+	.nr_irqs = PXA_NR_IRQS,
 	.init_irq = pxa3xx_init_irq,
 	.handle_irq = pxa3xx_handle_irq,
 	.timer = &pxa_timer,
diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index 4b981b8..133ccee 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -853,6 +853,7 @@ static void __init cm_x300_fixup(struct tag *tags, char **cmdline,
 MACHINE_START(CM_X300, "CM-X300 module")
 	.atag_offset	= 0x100,
 	.map_io		= pxa3xx_map_io,
+	.nr_irqs	= PXA_NR_IRQS,
 	.init_irq	= pxa3xx_init_irq,
 	.handle_irq	= pxa3xx_handle_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/colibri-pxa270.c b/arch/arm/mach-pxa/colibri-pxa270.c
index 29d5d54..b2f227d 100644
--- a/arch/arm/mach-pxa/colibri-pxa270.c
+++ b/arch/arm/mach-pxa/colibri-pxa270.c
@@ -310,6 +310,7 @@ MACHINE_START(COLIBRI, "Toradex Colibri PXA270")
 	.atag_offset	= 0x100,
 	.init_machine	= colibri_pxa270_init,
 	.map_io		= pxa27x_map_io,
+	.nr_irqs	= PXA_NR_IRQS,
 	.init_irq	= pxa27x_init_irq,
 	.handle_irq	= pxa27x_handle_irq,
 	.timer		= &pxa_timer,
@@ -320,6 +321,7 @@ MACHINE_START(INCOME, "Income s.r.o. SH-Dmaster PXA270 SBC")
 	.atag_offset	= 0x100,
 	.init_machine	= colibri_pxa270_income_init,
 	.map_io		= pxa27x_map_io,
+	.nr_irqs	= PXA_NR_IRQS,
 	.init_irq	= pxa27x_init_irq,
 	.handle_irq	= pxa27x_handle_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/colibri-pxa300.c b/arch/arm/mach-pxa/colibri-pxa300.c
index 0846d21..bb6def8 100644
--- a/arch/arm/mach-pxa/colibri-pxa300.c
+++ b/arch/arm/mach-pxa/colibri-pxa300.c
@@ -186,6 +186,7 @@ MACHINE_START(COLIBRI300, "Toradex Colibri PXA300")
 	.atag_offset	= 0x100,
 	.init_machine	= colibri_pxa300_init,
 	.map_io		= pxa3xx_map_io,
+	.nr_irqs	= PXA_NR_IRQS,
 	.init_irq	= pxa3xx_init_irq,
 	.handle_irq	= pxa3xx_handle_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/colibri-pxa320.c b/arch/arm/mach-pxa/colibri-pxa320.c
index 6ad3359..d88e7b3 100644
--- a/arch/arm/mach-pxa/colibri-pxa320.c
+++ b/arch/arm/mach-pxa/colibri-pxa320.c
@@ -256,6 +256,7 @@ MACHINE_START(COLIBRI320, "Toradex Colibri PXA320")
 	.atag_offset	= 0x100,
 	.init_machine	= colibri_pxa320_init,
 	.map_io		= pxa3xx_map_io,
+	.nr_irqs	= PXA_NR_IRQS,
 	.init_irq	= pxa3xx_init_irq,
 	.handle_irq	= pxa3xx_handle_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
index 66600f0..e6285c8 100644
--- a/arch/arm/mach-pxa/corgi.c
+++ b/arch/arm/mach-pxa/corgi.c
@@ -721,6 +721,7 @@ static void __init fixup_corgi(struct tag *tags, char **cmdline,
 MACHINE_START(CORGI, "SHARP Corgi")
 	.fixup		= fixup_corgi,
 	.map_io		= pxa25x_map_io,
+	.nr_irqs	= PXA_NR_IRQS,
 	.init_irq	= pxa25x_init_irq,
 	.handle_irq	= pxa25x_handle_irq,
 	.init_machine	= corgi_init,
@@ -733,6 +734,7 @@ MACHINE_END
 MACHINE_START(SHEPHERD, "SHARP Shepherd")
 	.fixup		= fixup_corgi,
 	.map_io		= pxa25x_map_io,
+	.nr_irqs	= PXA_NR_IRQS,
 	.init_irq	= pxa25x_init_irq,
 	.handle_irq	= pxa25x_handle_irq,
 	.init_machine	= corgi_init,
@@ -745,6 +747,7 @@ MACHINE_END
 MACHINE_START(HUSKY, "SHARP Husky")
 	.fixup		= fixup_corgi,
 	.map_io		= pxa25x_map_io,
+	.nr_irqs	= PXA_NR_IRQS,
 	.init_irq	= pxa25x_init_irq,
 	.handle_irq	= pxa25x_handle_irq,
 	.init_machine	= corgi_init,
diff --git a/arch/arm/mach-pxa/csb726.c b/arch/arm/mach-pxa/csb726.c
index fb5a51d..67f0de3 100644
--- a/arch/arm/mach-pxa/csb726.c
+++ b/arch/arm/mach-pxa/csb726.c
@@ -274,6 +274,7 @@ static void __init csb726_init(void)
 MACHINE_START(CSB726, "Cogent CSB726")
 	.atag_offset	= 0x100,
 	.map_io         = pxa27x_map_io,
+	.nr_irqs	= PXA_NR_IRQS,
 	.init_irq       = pxa27x_init_irq,
 	.handle_irq       = pxa27x_handle_irq,
 	.init_machine   = csb726_init,
diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index 18fd177..72a15a6 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -12,6 +12,7 @@
 #include <mach/pxafb.h>
 #include <mach/mmc.h>
 #include <mach/irda.h>
+#include <mach/irqs.h>
 #include <mach/ohci.h>
 #include <plat/pxa27x_keypad.h>
 #include <mach/camera.h>
diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
index d80c0ba..c1b65da 100644
--- a/arch/arm/mach-pxa/em-x270.c
+++ b/arch/arm/mach-pxa/em-x270.c
@@ -1301,6 +1301,7 @@ static void __init em_x270_init(void)
 MACHINE_START(EM_X270, "Compulab EM-X270")
 	.atag_offset	= 0x100,
 	.map_io		= pxa27x_map_io,
+	.nr_irqs	= PXA_NR_IRQS,
 	.init_irq	= pxa27x_init_irq,
 	.handle_irq	= pxa27x_handle_irq,
 	.timer		= &pxa_timer,
@@ -1311,6 +1312,7 @@ MACHINE_END
 MACHINE_START(EXEDA, "Compulab eXeda")
 	.atag_offset	= 0x100,
 	.map_io		= pxa27x_map_io,
+	.nr_irqs	= PXA_NR_IRQS,
 	.init_irq	= pxa27x_init_irq,
 	.handle_irq	= pxa27x_handle_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/gumstix.c b/arch/arm/mach-pxa/gumstix.c
index ac3b1ce..e529a35 100644
--- a/arch/arm/mach-pxa/gumstix.c
+++ b/arch/arm/mach-pxa/gumstix.c
@@ -235,6 +235,7 @@ static void __init gumstix_init(void)
 MACHINE_START(GUMSTIX, "Gumstix")
 	.atag_offset	= 0x100, /* match u-boot bi_boot_params */
 	.map_io		= pxa25x_map_io,
+	.nr_irqs	= PXA_NR_IRQS,
 	.init_irq	= pxa25x_init_irq,
 	.handle_irq	= pxa25x_handle_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/h5000.c b/arch/arm/mach-pxa/h5000.c
index fde6b4c..e7dec58 100644
--- a/arch/arm/mach-pxa/h5000.c
+++ b/arch/arm/mach-pxa/h5000.c
@@ -205,6 +205,7 @@ static void __init h5000_init(void)
 MACHINE_START(H5400, "HP iPAQ H5000")
 	.atag_offset = 0x100,
 	.map_io = pxa25x_map_io,
+	.nr_irqs = PXA_NR_IRQS,
 	.init_irq = pxa25x_init_irq,
 	.handle_irq = pxa25x_handle_irq,
 	.timer = &pxa_timer,
diff --git a/arch/arm/mach-pxa/himalaya.c b/arch/arm/mach-pxa/himalaya.c
index 26d069a..2962de8 100644
--- a/arch/arm/mach-pxa/himalaya.c
+++ b/arch/arm/mach-pxa/himalaya.c
@@ -160,6 +160,7 @@ static void __init himalaya_init(void)
 MACHINE_START(HIMALAYA, "HTC Himalaya")
 	.atag_offset = 0x100,
 	.map_io = pxa25x_map_io,
+	.nr_irqs = PXA_NR_IRQS,
 	.init_irq = pxa25x_init_irq,
 	.handle_irq = pxa25x_handle_irq,
 	.init_machine = himalaya_init,
diff --git a/arch/arm/mach-pxa/icontrol.c b/arch/arm/mach-pxa/icontrol.c
index 6740019..1d02eab 100644
--- a/arch/arm/mach-pxa/icontrol.c
+++ b/arch/arm/mach-pxa/icontrol.c
@@ -193,6 +193,7 @@ static void __init icontrol_init(void)
 MACHINE_START(ICONTROL, "iControl/SafeTcam boards using Embedian MXM-8x10 CoM")
 	.atag_offset	= 0x100,
 	.map_io		= pxa3xx_map_io,
+	.nr_irqs	= PXA_NR_IRQS,
 	.init_irq	= pxa3xx_init_irq,
 	.handle_irq	= pxa3xx_handle_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/idp.c b/arch/arm/mach-pxa/idp.c
index 8af1840..6ff466b 100644
--- a/arch/arm/mach-pxa/idp.c
+++ b/arch/arm/mach-pxa/idp.c
@@ -195,6 +195,7 @@ static void __init idp_map_io(void)
 MACHINE_START(PXA_IDP, "Vibren PXA255 IDP")
 	/* Maintainer: Vibren Technologies */
 	.map_io		= idp_map_io,
+	.nr_irqs	= PXA_NR_IRQS,
 	.init_irq	= pxa25x_init_irq,
 	.handle_irq	= pxa25x_handle_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/include/mach/irqs.h b/arch/arm/mach-pxa/include/mach/irqs.h
index 32975ad..8765782 100644
--- a/arch/arm/mach-pxa/include/mach/irqs.h
+++ b/arch/arm/mach-pxa/include/mach/irqs.h
@@ -100,7 +100,7 @@
  */
 #define IRQ_BOARD_START		(PXA_GPIO_IRQ_BASE + PXA_NR_BUILTIN_GPIO)
 
-#define NR_IRQS			(IRQ_BOARD_START)
+#define PXA_NR_IRQS		(IRQ_BOARD_START)
 
 #ifndef __ASSEMBLY__
 struct irq_data;
diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index e80a3db..061d570 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -758,6 +758,7 @@ MACHINE_START(MIOA701, "MIO A701")
 	.atag_offset	= 0x100,
 	.restart_mode	= 's',
 	.map_io		= &pxa27x_map_io,
+	.nr_irqs	= PXA_NR_IRQS,
 	.init_irq	= &pxa27x_init_irq,
 	.handle_irq	= &pxa27x_handle_irq,
 	.init_machine	= mioa701_machine_init,
diff --git a/arch/arm/mach-pxa/mp900.c b/arch/arm/mach-pxa/mp900.c
index 169bf8f..152efbf 100644
--- a/arch/arm/mach-pxa/mp900.c
+++ b/arch/arm/mach-pxa/mp900.c
@@ -95,6 +95,7 @@ MACHINE_START(NEC_MP900, "MobilePro900/C")
 	.atag_offset	= 0x220100,
 	.timer		= &pxa_timer,
 	.map_io		= pxa25x_map_io,
+	.nr_irqs	= PXA_NR_IRQS,
 	.init_irq	= pxa25x_init_irq,
 	.handle_irq	= pxa25x_handle_irq,
 	.init_machine	= mp900c_init,
diff --git a/arch/arm/mach-pxa/palmld.c b/arch/arm/mach-pxa/palmld.c
index 1fa80f4f..31e0433 100644
--- a/arch/arm/mach-pxa/palmld.c
+++ b/arch/arm/mach-pxa/palmld.c
@@ -344,6 +344,7 @@ static void __init palmld_init(void)
 MACHINE_START(PALMLD, "Palm LifeDrive")
 	.atag_offset	= 0x100,
 	.map_io		= palmld_map_io,
+	.nr_irqs	= PXA_NR_IRQS,
 	.init_irq	= pxa27x_init_irq,
 	.handle_irq	= pxa27x_handle_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/palmt5.c b/arch/arm/mach-pxa/palmt5.c
index 5ba1431..0f6bd4f 100644
--- a/arch/arm/mach-pxa/palmt5.c
+++ b/arch/arm/mach-pxa/palmt5.c
@@ -205,6 +205,7 @@ MACHINE_START(PALMT5, "Palm Tungsten|T5")
 	.atag_offset	= 0x100,
 	.map_io		= pxa27x_map_io,
 	.reserve	= palmt5_reserve,
+	.nr_irqs	= PXA_NR_IRQS,
 	.init_irq	= pxa27x_init_irq,
 	.handle_irq	= pxa27x_handle_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/palmtc.c b/arch/arm/mach-pxa/palmtc.c
index 29b51b4..e2d97ee 100644
--- a/arch/arm/mach-pxa/palmtc.c
+++ b/arch/arm/mach-pxa/palmtc.c
@@ -539,6 +539,7 @@ static void __init palmtc_init(void)
 MACHINE_START(PALMTC, "Palm Tungsten|C")
 	.atag_offset 	= 0x100,
 	.map_io		= pxa25x_map_io,
+	.nr_irqs	= PXA_NR_IRQS,
 	.init_irq	= pxa25x_init_irq,
 	.handle_irq	= pxa25x_handle_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/palmte2.c b/arch/arm/mach-pxa/palmte2.c
index 5ebf49acb..c054827 100644
--- a/arch/arm/mach-pxa/palmte2.c
+++ b/arch/arm/mach-pxa/palmte2.c
@@ -358,6 +358,7 @@ static void __init palmte2_init(void)
 MACHINE_START(PALMTE2, "Palm Tungsten|E2")
 	.atag_offset	= 0x100,
 	.map_io		= pxa25x_map_io,
+	.nr_irqs	= PXA_NR_IRQS,
 	.init_irq	= pxa25x_init_irq,
 	.handle_irq	= pxa25x_handle_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/palmtreo.c b/arch/arm/mach-pxa/palmtreo.c
index ec82491..fbdebee 100644
--- a/arch/arm/mach-pxa/palmtreo.c
+++ b/arch/arm/mach-pxa/palmtreo.c
@@ -448,6 +448,7 @@ MACHINE_START(TREO680, "Palm Treo 680")
 	.atag_offset    = 0x100,
 	.map_io         = pxa27x_map_io,
 	.reserve	= treo_reserve,
+	.nr_irqs	= PXA_NR_IRQS,
 	.init_irq       = pxa27x_init_irq,
 	.handle_irq       = pxa27x_handle_irq,
 	.timer          = &pxa_timer,
@@ -461,6 +462,7 @@ MACHINE_START(CENTRO, "Palm Centro 685")
 	.atag_offset    = 0x100,
 	.map_io         = pxa27x_map_io,
 	.reserve	= treo_reserve,
+	.nr_irqs	= PXA_NR_IRQS,
 	.init_irq       = pxa27x_init_irq,
 	.handle_irq       = pxa27x_handle_irq,
 	.timer          = &pxa_timer,
diff --git a/arch/arm/mach-pxa/palmtx.c b/arch/arm/mach-pxa/palmtx.c
index 6170d76..9507605 100644
--- a/arch/arm/mach-pxa/palmtx.c
+++ b/arch/arm/mach-pxa/palmtx.c
@@ -366,6 +366,7 @@ static void __init palmtx_init(void)
 MACHINE_START(PALMTX, "Palm T|X")
 	.atag_offset	= 0x100,
 	.map_io		= palmtx_map_io,
+	.nr_irqs	= PXA_NR_IRQS,
 	.init_irq	= pxa27x_init_irq,
 	.handle_irq	= pxa27x_handle_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/palmz72.c b/arch/arm/mach-pxa/palmz72.c
index b2dff9d..a97b599 100644
--- a/arch/arm/mach-pxa/palmz72.c
+++ b/arch/arm/mach-pxa/palmz72.c
@@ -401,6 +401,7 @@ static void __init palmz72_init(void)
 MACHINE_START(PALMZ72, "Palm Zire72")
 	.atag_offset	= 0x100,
 	.map_io		= pxa27x_map_io,
+	.nr_irqs	= PXA_NR_IRQS,
 	.init_irq	= pxa27x_init_irq,
 	.handle_irq	= pxa27x_handle_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index 22818c7..7d691e5 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -1090,6 +1090,7 @@ MACHINE_START(RAUMFELD_RC, "Raumfeld Controller")
 	.atag_offset	= 0x100,
 	.init_machine	= raumfeld_controller_init,
 	.map_io		= pxa3xx_map_io,
+	.nr_irqs	= PXA_NR_IRQS,
 	.init_irq	= pxa3xx_init_irq,
 	.handle_irq	= pxa3xx_handle_irq,
 	.timer		= &pxa_timer,
@@ -1102,6 +1103,7 @@ MACHINE_START(RAUMFELD_CONNECTOR, "Raumfeld Connector")
 	.atag_offset	= 0x100,
 	.init_machine	= raumfeld_connector_init,
 	.map_io		= pxa3xx_map_io,
+	.nr_irqs	= PXA_NR_IRQS,
 	.init_irq	= pxa3xx_init_irq,
 	.handle_irq	= pxa3xx_handle_irq,
 	.timer		= &pxa_timer,
@@ -1114,6 +1116,7 @@ MACHINE_START(RAUMFELD_SPEAKER, "Raumfeld Speaker")
 	.atag_offset	= 0x100,
 	.init_machine	= raumfeld_speaker_init,
 	.map_io		= pxa3xx_map_io,
+	.nr_irqs	= PXA_NR_IRQS,
 	.init_irq	= pxa3xx_init_irq,
 	.handle_irq	= pxa3xx_handle_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/saar.c b/arch/arm/mach-pxa/saar.c
index 0fe354e..86c95a5 100644
--- a/arch/arm/mach-pxa/saar.c
+++ b/arch/arm/mach-pxa/saar.c
@@ -598,6 +598,7 @@ MACHINE_START(SAAR, "PXA930 Handheld Platform (aka SAAR)")
 	/* Maintainer: Eric Miao <eric.miao@marvell.com> */
 	.atag_offset    = 0x100,
 	.map_io         = pxa3xx_map_io,
+	.nr_irqs	= PXA_NR_IRQS,
 	.init_irq       = pxa3xx_init_irq,
 	.handle_irq       = pxa3xx_handle_irq,
 	.timer          = &pxa_timer,
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index abf355d..df2ab0f 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -984,6 +984,7 @@ MACHINE_START(SPITZ, "SHARP Spitz")
 	.restart_mode	= 'g',
 	.fixup		= spitz_fixup,
 	.map_io		= pxa27x_map_io,
+	.nr_irqs	= PXA_NR_IRQS,
 	.init_irq	= pxa27x_init_irq,
 	.handle_irq	= pxa27x_handle_irq,
 	.init_machine	= spitz_init,
@@ -997,6 +998,7 @@ MACHINE_START(BORZOI, "SHARP Borzoi")
 	.restart_mode	= 'g',
 	.fixup		= spitz_fixup,
 	.map_io		= pxa27x_map_io,
+	.nr_irqs	= PXA_NR_IRQS,
 	.init_irq	= pxa27x_init_irq,
 	.handle_irq	= pxa27x_handle_irq,
 	.init_machine	= spitz_init,
@@ -1010,6 +1012,7 @@ MACHINE_START(AKITA, "SHARP Akita")
 	.restart_mode	= 'g',
 	.fixup		= spitz_fixup,
 	.map_io		= pxa27x_map_io,
+	.nr_irqs	= PXA_NR_IRQS,
 	.init_irq	= pxa27x_init_irq,
 	.handle_irq	= pxa27x_handle_irq,
 	.init_machine	= spitz_init,
diff --git a/arch/arm/mach-pxa/stargate2.c b/arch/arm/mach-pxa/stargate2.c
index d8a2467..1c1bbb7 100644
--- a/arch/arm/mach-pxa/stargate2.c
+++ b/arch/arm/mach-pxa/stargate2.c
@@ -1000,6 +1000,7 @@ static void __init stargate2_init(void)
 #ifdef CONFIG_MACH_INTELMOTE2
 MACHINE_START(INTELMOTE2, "IMOTE 2")
 	.map_io		= pxa27x_map_io,
+	.nr_irqs	= PXA_NR_IRQS,
 	.init_irq	= pxa27x_init_irq,
 	.handle_irq	= pxa27x_handle_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/tavorevb.c b/arch/arm/mach-pxa/tavorevb.c
index 9fb38e8..736bfdc 100644
--- a/arch/arm/mach-pxa/tavorevb.c
+++ b/arch/arm/mach-pxa/tavorevb.c
@@ -491,6 +491,7 @@ MACHINE_START(TAVOREVB, "PXA930 Evaluation Board (aka TavorEVB)")
 	/* Maintainer: Eric Miao <eric.miao@marvell.com> */
 	.atag_offset    = 0x100,
 	.map_io         = pxa3xx_map_io,
+	.nr_irqs	= PXA_NR_IRQS,
 	.init_irq       = pxa3xx_init_irq,
 	.handle_irq       = pxa3xx_handle_irq,
 	.timer          = &pxa_timer,
diff --git a/arch/arm/mach-pxa/time.c b/arch/arm/mach-pxa/time.c
index b503049..3d6c9bd 100644
--- a/arch/arm/mach-pxa/time.c
+++ b/arch/arm/mach-pxa/time.c
@@ -22,6 +22,7 @@
 #include <asm/mach/time.h>
 #include <asm/sched_clock.h>
 #include <mach/regs-ost.h>
+#include <mach/irqs.h>
 
 /*
  * This is PXA's sched_clock implementation. This has a resolution
diff --git a/arch/arm/mach-pxa/trizeps4.c b/arch/arm/mach-pxa/trizeps4.c
index 0f30af6..2b6ac00 100644
--- a/arch/arm/mach-pxa/trizeps4.c
+++ b/arch/arm/mach-pxa/trizeps4.c
@@ -558,6 +558,7 @@ MACHINE_START(TRIZEPS4, "Keith und Koep Trizeps IV module")
 	.atag_offset	= 0x100,
 	.init_machine	= trizeps4_init,
 	.map_io		= trizeps4_map_io,
+	.nr_irqs	= PXA_NR_IRQS,
 	.init_irq	= pxa27x_init_irq,
 	.handle_irq	= pxa27x_handle_irq,
 	.timer		= &pxa_timer,
@@ -569,6 +570,7 @@ MACHINE_START(TRIZEPS4WL, "Keith und Koep Trizeps IV-WL module")
 	.atag_offset	= 0x100,
 	.init_machine	= trizeps4_init,
 	.map_io		= trizeps4_map_io,
+	.nr_irqs	= PXA_NR_IRQS,
 	.init_irq	= pxa27x_init_irq,
 	.handle_irq	= pxa27x_handle_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
index 023d6ca..3143c39 100644
--- a/arch/arm/mach-pxa/viper.c
+++ b/arch/arm/mach-pxa/viper.c
@@ -994,6 +994,7 @@ MACHINE_START(VIPER, "Arcom/Eurotech VIPER SBC")
 	/* Maintainer: Marc Zyngier <maz@misterjones.org> */
 	.atag_offset	= 0x100,
 	.map_io		= viper_map_io,
+	.nr_irqs	= PXA_NR_IRQS,
 	.init_irq	= viper_init_irq,
 	.handle_irq	= pxa25x_handle_irq,
 	.timer          = &pxa_timer,
diff --git a/arch/arm/mach-pxa/vpac270.c b/arch/arm/mach-pxa/vpac270.c
index 1f5cfa9..c57ab63 100644
--- a/arch/arm/mach-pxa/vpac270.c
+++ b/arch/arm/mach-pxa/vpac270.c
@@ -718,6 +718,7 @@ static void __init vpac270_init(void)
 MACHINE_START(VPAC270, "Voipac PXA270")
 	.atag_offset	= 0x100,
 	.map_io		= pxa27x_map_io,
+	.nr_irqs	= PXA_NR_IRQS,
 	.init_irq	= pxa27x_init_irq,
 	.handle_irq	= pxa27x_handle_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/xcep.c b/arch/arm/mach-pxa/xcep.c
index 4bbe9a3..4275713 100644
--- a/arch/arm/mach-pxa/xcep.c
+++ b/arch/arm/mach-pxa/xcep.c
@@ -182,6 +182,7 @@ MACHINE_START(XCEP, "Iskratel XCEP")
 	.atag_offset	= 0x100,
 	.init_machine	= xcep_init,
 	.map_io		= pxa25x_map_io,
+	.nr_irqs	= PXA_NR_IRQS,
 	.init_irq	= pxa25x_init_irq,
 	.handle_irq	= pxa25x_handle_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index b647684..fa86199 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -721,6 +721,7 @@ static void __init z2_init(void)
 MACHINE_START(ZIPIT2, "Zipit Z2")
 	.atag_offset	= 0x100,
 	.map_io		= pxa27x_map_io,
+	.nr_irqs	= PXA_NR_IRQS,
 	.init_irq	= pxa27x_init_irq,
 	.handle_irq	= pxa27x_handle_irq,
 	.timer		= &pxa_timer,
-- 
1.7.5.4

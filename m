From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 11 Oct 2010 02:20:19 +0200
Subject: [PATCH] ARM: pxa: Introduce pxa{25x,27x,3xx}_map_io()
Message-ID: <mailman.0.1287976085.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces pxa2xx_map_io() and pxa3xx_map_io() to distinguish
between PXA25x/PXA27x and PXA3xx memory mapping.

Also, fixup for platforms broken after introducing pxa{25x,27x}_map_io()
and pxa3xx_map_io() is included.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
Acked-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/balloon3.c       |    2 +-
 arch/arm/mach-pxa/capc7117.c       |    2 +-
 arch/arm/mach-pxa/cm-x2xx.c        |   13 +++++++++++--
 arch/arm/mach-pxa/cm-x300.c        |    2 +-
 arch/arm/mach-pxa/colibri-pxa270.c |    4 ++--
 arch/arm/mach-pxa/colibri-pxa300.c |    2 +-
 arch/arm/mach-pxa/colibri-pxa320.c |    2 +-
 arch/arm/mach-pxa/corgi.c          |    6 +++---
 arch/arm/mach-pxa/csb726.c         |    2 +-
 arch/arm/mach-pxa/em-x270.c        |    4 ++--
 arch/arm/mach-pxa/eseries.c        |   12 ++++++------
 arch/arm/mach-pxa/ezx.c            |   12 ++++++------
 arch/arm/mach-pxa/generic.c        |   21 ++++-----------------
 arch/arm/mach-pxa/generic.h        |    4 ++++
 arch/arm/mach-pxa/gumstix.c        |    2 +-
 arch/arm/mach-pxa/h5000.c          |    2 +-
 arch/arm/mach-pxa/himalaya.c       |    2 +-
 arch/arm/mach-pxa/hx4700.c         |    2 +-
 arch/arm/mach-pxa/icontrol.c       |    2 +-
 arch/arm/mach-pxa/idp.c            |    2 +-
 arch/arm/mach-pxa/littleton.c      |    2 +-
 arch/arm/mach-pxa/lpd270.c         |    2 +-
 arch/arm/mach-pxa/lubbock.c        |    2 +-
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
 arch/arm/mach-pxa/poodle.c         |    2 +-
 arch/arm/mach-pxa/pxa25x.c         |   16 ++++++++++++++++
 arch/arm/mach-pxa/pxa27x.c         |   21 +++++++++++++++++++++
 arch/arm/mach-pxa/pxa3xx.c         |   16 ++++++++++++++++
 arch/arm/mach-pxa/raumfeld.c       |    6 +++---
 arch/arm/mach-pxa/saar.c           |    2 +-
 arch/arm/mach-pxa/spitz.c          |    7 ++++---
 arch/arm/mach-pxa/stargate2.c      |    4 ++--
 arch/arm/mach-pxa/tavorevb.c       |    2 +-
 arch/arm/mach-pxa/tavorevb3.c      |    2 +-
 arch/arm/mach-pxa/tosa.c           |    2 +-
 arch/arm/mach-pxa/trizeps4.c       |    2 +-
 arch/arm/mach-pxa/viper.c          |    2 +-
 arch/arm/mach-pxa/vpac270.c        |    2 +-
 arch/arm/mach-pxa/xcep.c           |    2 +-
 arch/arm/mach-pxa/z2.c             |    2 +-
 arch/arm/mach-pxa/zeus.c           |    2 +-
 arch/arm/mach-pxa/zylonite.c       |    2 +-
 53 files changed, 140 insertions(+), 86 deletions(-)

diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index 21e1889..adb8e9f 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -802,7 +802,7 @@ static struct map_desc balloon3_io_desc[] __initdata = {

 static void __init balloon3_map_io(void)
 {
-	pxa_map_io();
+	pxa27x_map_io();
 	iotable_init(balloon3_io_desc, ARRAY_SIZE(balloon3_io_desc));
 }

diff --git a/arch/arm/mach-pxa/capc7117.c b/arch/arm/mach-pxa/capc7117.c
index 4bd7a3c..4284513 100644
--- a/arch/arm/mach-pxa/capc7117.c
+++ b/arch/arm/mach-pxa/capc7117.c
@@ -149,7 +149,7 @@ static void __init capc7117_init(void)
 MACHINE_START(CAPC7117,
 	      "Embedian CAPC-7117 evaluation kit based on the MXM-8x10 CoM")
 	.boot_params = 0xa0000100,
-	.map_io = pxa_map_io,
+	.map_io = pxa3xx_map_io,
 	.init_irq = pxa3xx_init_irq,
 	.timer = &pxa_timer,
 	.init_machine = capc7117_init
diff --git a/arch/arm/mach-pxa/cm-x2xx.c b/arch/arm/mach-pxa/cm-x2xx.c
index ac5598c..ca8ad86 100644
--- a/arch/arm/mach-pxa/cm-x2xx.c
+++ b/arch/arm/mach-pxa/cm-x2xx.c
@@ -500,7 +500,12 @@ static struct map_desc cmx2xx_io_desc[] __initdata = {

 static void __init cmx2xx_map_io(void)
 {
-	pxa_map_io();
+	if (cpu_is_pxa25x())
+		pxa25x_map_io();
+
+	if (cpu_is_pxa27x())
+		pxa27x_map_io();
+
 	iotable_init(cmx2xx_io_desc, ARRAY_SIZE(cmx2xx_io_desc));

 	it8152_base_address = CMX2XX_IT8152_VIRT;
@@ -508,7 +513,11 @@ static void __init cmx2xx_map_io(void)
 #else
 static void __init cmx2xx_map_io(void)
 {
-	pxa_map_io();
+	if (cpu_is_pxa25x())
+		pxa25x_map_io();
+
+	if (cpu_is_pxa27x())
+		pxa27x_map_io();
 }
 #endif

diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index 922b107..7984268 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -857,7 +857,7 @@ static void __init cm_x300_fixup(struct
machine_desc *mdesc, struct tag *tags,

 MACHINE_START(CM_X300, "CM-X300 module")
 	.boot_params	= 0xa0000100,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa3xx_map_io,
 	.init_irq	= pxa3xx_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= cm_x300_init,
diff --git a/arch/arm/mach-pxa/colibri-pxa270.c
b/arch/arm/mach-pxa/colibri-pxa270.c
index bc04510..73205bc 100644
--- a/arch/arm/mach-pxa/colibri-pxa270.c
+++ b/arch/arm/mach-pxa/colibri-pxa270.c
@@ -209,7 +209,7 @@ static void __init colibri_pxa270_income_init(void)
 MACHINE_START(COLIBRI, "Toradex Colibri PXA270")
 	.boot_params	= COLIBRI_SDRAM_BASE + 0x100,
 	.init_machine	= colibri_pxa270_init,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa27x_map_io,
 	.init_irq	= pxa27x_init_irq,
 	.timer		= &pxa_timer,
 MACHINE_END
@@ -217,7 +217,7 @@ MACHINE_END
 MACHINE_START(INCOME, "Income s.r.o. SH-Dmaster PXA270 SBC")
 	.boot_params	= 0xa0000100,
 	.init_machine	= colibri_pxa270_income_init,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa27x_map_io,
 	.init_irq	= pxa27x_init_irq,
 	.timer		= &pxa_timer,
 MACHINE_END
diff --git a/arch/arm/mach-pxa/colibri-pxa300.c
b/arch/arm/mach-pxa/colibri-pxa300.c
index a70b256..d039bd1 100644
--- a/arch/arm/mach-pxa/colibri-pxa300.c
+++ b/arch/arm/mach-pxa/colibri-pxa300.c
@@ -188,7 +188,7 @@ void __init colibri_pxa300_init(void)
 MACHINE_START(COLIBRI300, "Toradex Colibri PXA300")
 	.boot_params	= COLIBRI_SDRAM_BASE + 0x100,
 	.init_machine	= colibri_pxa300_init,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa3xx_map_io,
 	.init_irq	= pxa3xx_init_irq,
 	.timer		= &pxa_timer,
 MACHINE_END
diff --git a/arch/arm/mach-pxa/colibri-pxa320.c
b/arch/arm/mach-pxa/colibri-pxa320.c
index ca5f29e..ccb2c59 100644
--- a/arch/arm/mach-pxa/colibri-pxa320.c
+++ b/arch/arm/mach-pxa/colibri-pxa320.c
@@ -257,7 +257,7 @@ void __init colibri_pxa320_init(void)
 MACHINE_START(COLIBRI320, "Toradex Colibri PXA320")
 	.boot_params	= COLIBRI_SDRAM_BASE + 0x100,
 	.init_machine	= colibri_pxa320_init,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa3xx_map_io,
 	.init_irq	= pxa3xx_init_irq,
 	.timer		= &pxa_timer,
 MACHINE_END
diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
index 821229a..9f3e5af 100644
--- a/arch/arm/mach-pxa/corgi.c
+++ b/arch/arm/mach-pxa/corgi.c
@@ -721,7 +721,7 @@ static void __init fixup_corgi(struct machine_desc *desc,
 #ifdef CONFIG_MACH_CORGI
 MACHINE_START(CORGI, "SHARP Corgi")
 	.fixup		= fixup_corgi,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa25x_map_io,
 	.init_irq	= pxa25x_init_irq,
 	.init_machine	= corgi_init,
 	.timer		= &pxa_timer,
@@ -731,7 +731,7 @@ MACHINE_END
 #ifdef CONFIG_MACH_SHEPHERD
 MACHINE_START(SHEPHERD, "SHARP Shepherd")
 	.fixup		= fixup_corgi,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa25x_map_io,
 	.init_irq	= pxa25x_init_irq,
 	.init_machine	= corgi_init,
 	.timer		= &pxa_timer,
@@ -741,7 +741,7 @@ MACHINE_END
 #ifdef CONFIG_MACH_HUSKY
 MACHINE_START(HUSKY, "SHARP Husky")
 	.fixup		= fixup_corgi,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa25x_map_io,
 	.init_irq	= pxa25x_init_irq,
 	.init_machine	= corgi_init,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/csb726.c b/arch/arm/mach-pxa/csb726.c
index 57cacaf..225a2a1 100644
--- a/arch/arm/mach-pxa/csb726.c
+++ b/arch/arm/mach-pxa/csb726.c
@@ -273,7 +273,7 @@ static void __init csb726_init(void)

 MACHINE_START(CSB726, "Cogent CSB726")
 	.boot_params	= 0xa0000100,
-	.map_io         = pxa_map_io,
+	.map_io         = pxa27x_map_io,
 	.init_irq       = pxa27x_init_irq,
 	.init_machine   = csb726_init,
 	.timer          = &pxa_timer,
diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
index ab48bb8..74fcb57 100644
--- a/arch/arm/mach-pxa/em-x270.c
+++ b/arch/arm/mach-pxa/em-x270.c
@@ -1301,7 +1301,7 @@ static void __init em_x270_init(void)

 MACHINE_START(EM_X270, "Compulab EM-X270")
 	.boot_params	= 0xa0000100,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa27x_map_io,
 	.init_irq	= pxa27x_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= em_x270_init,
@@ -1309,7 +1309,7 @@ MACHINE_END

 MACHINE_START(EXEDA, "Compulab eXeda")
 	.boot_params	= 0xa0000100,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa27x_map_io,
 	.init_irq	= pxa27x_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= em_x270_init,
diff --git a/arch/arm/mach-pxa/eseries.c b/arch/arm/mach-pxa/eseries.c
index b25690c..edca0a0 100644
--- a/arch/arm/mach-pxa/eseries.c
+++ b/arch/arm/mach-pxa/eseries.c
@@ -181,7 +181,7 @@ static void __init e330_init(void)
 MACHINE_START(E330, "Toshiba e330")
 	/* Maintainer: Ian Molton (spyro at f2s.com) */
 	.boot_params	= 0xa0000100,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa25x_map_io,
 	.nr_irqs	= ESERIES_NR_IRQS,
 	.init_irq	= pxa25x_init_irq,
 	.fixup		= eseries_fixup,
@@ -230,7 +230,7 @@ static void __init e350_init(void)
 MACHINE_START(E350, "Toshiba e350")
 	/* Maintainer: Ian Molton (spyro at f2s.com) */
 	.boot_params	= 0xa0000100,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa25x_map_io,
 	.nr_irqs	= ESERIES_NR_IRQS,
 	.init_irq	= pxa25x_init_irq,
 	.fixup		= eseries_fixup,
@@ -352,7 +352,7 @@ static void __init e400_init(void)
 MACHINE_START(E400, "Toshiba e400")
 	/* Maintainer: Ian Molton (spyro at f2s.com) */
 	.boot_params	= 0xa0000100,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa25x_map_io,
 	.nr_irqs	= ESERIES_NR_IRQS,
 	.init_irq	= pxa25x_init_irq,
 	.fixup		= eseries_fixup,
@@ -540,7 +540,7 @@ static void __init e740_init(void)
 MACHINE_START(E740, "Toshiba e740")
 	/* Maintainer: Ian Molton (spyro at f2s.com) */
 	.boot_params	= 0xa0000100,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa25x_map_io,
 	.nr_irqs	= ESERIES_NR_IRQS,
 	.init_irq	= pxa25x_init_irq,
 	.fixup		= eseries_fixup,
@@ -731,7 +731,7 @@ static void __init e750_init(void)
 MACHINE_START(E750, "Toshiba e750")
 	/* Maintainer: Ian Molton (spyro at f2s.com) */
 	.boot_params	= 0xa0000100,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa25x_map_io,
 	.nr_irqs	= ESERIES_NR_IRQS,
 	.init_irq	= pxa25x_init_irq,
 	.fixup		= eseries_fixup,
@@ -926,7 +926,7 @@ static void __init e800_init(void)
 MACHINE_START(E800, "Toshiba e800")
 	/* Maintainer: Ian Molton (spyro at f2s.com) */
 	.boot_params	= 0xa0000100,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa25x_map_io,
 	.nr_irqs	= ESERIES_NR_IRQS,
 	.init_irq	= pxa25x_init_irq,
 	.fixup		= eseries_fixup,
diff --git a/arch/arm/mach-pxa/ezx.c b/arch/arm/mach-pxa/ezx.c
index 80a9352..049258b 100644
--- a/arch/arm/mach-pxa/ezx.c
+++ b/arch/arm/mach-pxa/ezx.c
@@ -799,7 +799,7 @@ static void __init a780_init(void)

 MACHINE_START(EZX_A780, "Motorola EZX A780")
 	.boot_params    = 0xa0000100,
-	.map_io         = pxa_map_io,
+	.map_io         = pxa27x_map_io,
 	.nr_irqs	= EZX_NR_IRQS,
 	.init_irq       = pxa27x_init_irq,
 	.timer          = &pxa_timer,
@@ -864,7 +864,7 @@ static void __init e680_init(void)

 MACHINE_START(EZX_E680, "Motorola EZX E680")
 	.boot_params    = 0xa0000100,
-	.map_io         = pxa_map_io,
+	.map_io         = pxa27x_map_io,
 	.nr_irqs	= EZX_NR_IRQS,
 	.init_irq       = pxa27x_init_irq,
 	.timer          = &pxa_timer,
@@ -929,7 +929,7 @@ static void __init a1200_init(void)

 MACHINE_START(EZX_A1200, "Motorola EZX A1200")
 	.boot_params    = 0xa0000100,
-	.map_io         = pxa_map_io,
+	.map_io         = pxa27x_map_io,
 	.nr_irqs	= EZX_NR_IRQS,
 	.init_irq       = pxa27x_init_irq,
 	.timer          = &pxa_timer,
@@ -1120,7 +1120,7 @@ static void __init a910_init(void)

 MACHINE_START(EZX_A910, "Motorola EZX A910")
 	.boot_params    = 0xa0000100,
-	.map_io         = pxa_map_io,
+	.map_io         = pxa27x_map_io,
 	.nr_irqs	= EZX_NR_IRQS,
 	.init_irq       = pxa27x_init_irq,
 	.timer          = &pxa_timer,
@@ -1185,7 +1185,7 @@ static void __init e6_init(void)

 MACHINE_START(EZX_E6, "Motorola EZX E6")
 	.boot_params    = 0xa0000100,
-	.map_io         = pxa_map_io,
+	.map_io         = pxa27x_map_io,
 	.nr_irqs	= EZX_NR_IRQS,
 	.init_irq       = pxa27x_init_irq,
 	.timer          = &pxa_timer,
@@ -1224,7 +1224,7 @@ static void __init e2_init(void)

 MACHINE_START(EZX_E2, "Motorola EZX E2")
 	.boot_params    = 0xa0000100,
-	.map_io         = pxa_map_io,
+	.map_io         = pxa27x_map_io,
 	.nr_irqs	= EZX_NR_IRQS,
 	.init_irq       = pxa27x_init_irq,
 	.timer          = &pxa_timer,
diff --git a/arch/arm/mach-pxa/generic.c b/arch/arm/mach-pxa/generic.c
index 69a89fe..6a5f379 100644
--- a/arch/arm/mach-pxa/generic.c
+++ b/arch/arm/mach-pxa/generic.c
@@ -86,27 +86,15 @@ EXPORT_SYMBOL(get_memclk_frequency_10khz);
 /*
  * Intel PXA2xx internal register mapping.
  *
- * Note 1: not all PXA2xx variants implement all those addresses.
- *
- * Note 2: virtual 0xfffe0000-0xffffffff is reserved for the vector table
- *         and cache flush area.
+ * Note: virtual 0xfffe0000-0xffffffff is reserved for the vector table
+ *       and cache flush area.
  */
-static struct map_desc standard_io_desc[] __initdata = {
+static struct map_desc common_io_desc[] __initdata = {
   	{	/* Devs */
 		.virtual	=  0xf2000000,
 		.pfn		= __phys_to_pfn(0x40000000),
 		.length		= 0x02000000,
 		.type		= MT_DEVICE
-	}, {	/* Mem Ctl */
-		.virtual	=  0xf6000000,
-		.pfn		= __phys_to_pfn(0x48000000),
-		.length		= 0x00200000,
-		.type		= MT_DEVICE
-	}, {	/* IMem ctl */
-		.virtual	=  0xfe000000,
-		.pfn		= __phys_to_pfn(0x58000000),
-		.length		= 0x00100000,
-		.type		= MT_DEVICE
 	}, {	/* UNCACHED_PHYS_0 */
 		.virtual	= 0xff000000,
 		.pfn		= __phys_to_pfn(0x00000000),
@@ -117,6 +105,5 @@ static struct map_desc standard_io_desc[] __initdata = {

 void __init pxa_map_io(void)
 {
-	iotable_init(standard_io_desc, ARRAY_SIZE(standard_io_desc));
-	get_clk_frequency_khz(1);
+	iotable_init(ARRAY_AND_SIZE(common_io_desc));
 }
diff --git a/arch/arm/mach-pxa/generic.h b/arch/arm/mach-pxa/generic.h
index 4b1ad27..d2e8bc3 100644
--- a/arch/arm/mach-pxa/generic.h
+++ b/arch/arm/mach-pxa/generic.h
@@ -20,7 +20,11 @@ extern void __init pxa26x_init_irq(void);
 #endif
 extern void __init pxa27x_init_irq(void);
 extern void __init pxa3xx_init_irq(void);
+
 extern void __init pxa_map_io(void);
+extern void __init pxa25x_map_io(void);
+extern void __init pxa27x_map_io(void);
+extern void __init pxa3xx_map_io(void);

 extern unsigned int get_clk_frequency_khz(int info);

diff --git a/arch/arm/mach-pxa/gumstix.c b/arch/arm/mach-pxa/gumstix.c
index 1e2a9a1..6fd319e 100644
--- a/arch/arm/mach-pxa/gumstix.c
+++ b/arch/arm/mach-pxa/gumstix.c
@@ -225,7 +225,7 @@ static void __init gumstix_init(void)

 MACHINE_START(GUMSTIX, "Gumstix")
 	.boot_params	= 0xa0000100, /* match u-boot bi_boot_params */
-	.map_io		= pxa_map_io,
+	.map_io		= pxa25x_map_io,
 	.init_irq	= pxa25x_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= gumstix_init,
diff --git a/arch/arm/mach-pxa/h5000.c b/arch/arm/mach-pxa/h5000.c
index 7057a1f..0ef1635 100644
--- a/arch/arm/mach-pxa/h5000.c
+++ b/arch/arm/mach-pxa/h5000.c
@@ -202,7 +202,7 @@ static void __init h5000_init(void)

 MACHINE_START(H5400, "HP iPAQ H5000")
 	.boot_params = 0xa0000100,
-	.map_io = pxa_map_io,
+	.map_io = pxa25x_map_io,
 	.init_irq = pxa25x_init_irq,
 	.timer = &pxa_timer,
 	.init_machine = h5000_init,
diff --git a/arch/arm/mach-pxa/himalaya.c b/arch/arm/mach-pxa/himalaya.c
index 01b7f07..e8603eb 100644
--- a/arch/arm/mach-pxa/himalaya.c
+++ b/arch/arm/mach-pxa/himalaya.c
@@ -160,7 +160,7 @@ static void __init himalaya_init(void)

 MACHINE_START(HIMALAYA, "HTC Himalaya")
 	.boot_params = 0xa0000100,
-	.map_io = pxa_map_io,
+	.map_io = pxa25x_map_io,
 	.init_irq = pxa25x_init_irq,
 	.init_machine = himalaya_init,
 	.timer = &pxa_timer,
diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index 76d93a2..cacb21b 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -871,7 +871,7 @@ static void __init hx4700_init(void)

 MACHINE_START(H4700, "HP iPAQ HX4700")
 	.boot_params  = 0xa0000100,
-	.map_io       = pxa_map_io,
+	.map_io       = pxa27x_map_io,
 	.nr_irqs      = HX4700_NR_IRQS,
 	.init_irq     = pxa27x_init_irq,
 	.init_machine = hx4700_init,
diff --git a/arch/arm/mach-pxa/icontrol.c b/arch/arm/mach-pxa/icontrol.c
index d51ee3d..ac6ee12 100644
--- a/arch/arm/mach-pxa/icontrol.c
+++ b/arch/arm/mach-pxa/icontrol.c
@@ -192,7 +192,7 @@ static void __init icontrol_init(void)

 MACHINE_START(ICONTROL, "iControl/SafeTcam boards using Embedian MXM-8x10 CoM")
 	.boot_params	= 0xa0000100,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa3xx_map_io,
 	.init_irq	= pxa3xx_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= icontrol_init
diff --git a/arch/arm/mach-pxa/idp.c b/arch/arm/mach-pxa/idp.c
index e773dce..dd40e4a 100644
--- a/arch/arm/mach-pxa/idp.c
+++ b/arch/arm/mach-pxa/idp.c
@@ -187,7 +187,7 @@ static struct map_desc idp_io_desc[] __initdata = {

 static void __init idp_map_io(void)
 {
-	pxa_map_io();
+	pxa25x_map_io();
 	iotable_init(idp_io_desc, ARRAY_SIZE(idp_io_desc));
 }

diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
index 41aa89e..719c260 100644
--- a/arch/arm/mach-pxa/littleton.c
+++ b/arch/arm/mach-pxa/littleton.c
@@ -438,7 +438,7 @@ static void __init littleton_init(void)

 MACHINE_START(LITTLETON, "Marvell Form Factor Development Platform
(aka Littleton)")
 	.boot_params	= 0xa0000100,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa3xx_map_io,
 	.nr_irqs	= LITTLETON_NR_IRQS,
 	.init_irq	= pxa3xx_init_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/lpd270.c b/arch/arm/mach-pxa/lpd270.c
index 623af02..db615d5 100644
--- a/arch/arm/mach-pxa/lpd270.c
+++ b/arch/arm/mach-pxa/lpd270.c
@@ -495,7 +495,7 @@ static struct map_desc lpd270_io_desc[] __initdata = {

 static void __init lpd270_map_io(void)
 {
-	pxa_map_io();
+	pxa27x_map_io();
 	iotable_init(lpd270_io_desc, ARRAY_SIZE(lpd270_io_desc));

 	/* for use I SRAM as framebuffer.  */
diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index 1499493..5b1cc1c 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -549,7 +549,7 @@ static struct map_desc lubbock_io_desc[] __initdata = {

 static void __init lubbock_map_io(void)
 {
-	pxa_map_io();
+	pxa25x_map_io();
 	iotable_init(lubbock_io_desc, ARRAY_SIZE(lubbock_io_desc));

 	PCFR |= PCFR_OPDE;
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 9066376..41198f0 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -765,7 +765,7 @@ static void __init magician_init(void)

 MACHINE_START(MAGICIAN, "HTC Magician")
 	.boot_params = 0xa0000100,
-	.map_io = pxa_map_io,
+	.map_io = pxa27x_map_io,
 	.nr_irqs = MAGICIAN_NR_IRQS,
 	.init_irq = pxa27x_init_irq,
 	.init_machine = magician_init,
diff --git a/arch/arm/mach-pxa/mainstone.c b/arch/arm/mach-pxa/mainstone.c
index a980a5c..8bef7c8 100644
--- a/arch/arm/mach-pxa/mainstone.c
+++ b/arch/arm/mach-pxa/mainstone.c
@@ -614,7 +614,7 @@ static struct map_desc mainstone_io_desc[] __initdata = {

 static void __init mainstone_map_io(void)
 {
-	pxa_map_io();
+	pxa27x_map_io();
 	iotable_init(mainstone_io_desc, ARRAY_SIZE(mainstone_io_desc));

  	/*	for use I SRAM as framebuffer.	*/
diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index 0c31fab..5709482 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -820,7 +820,7 @@ static void mioa701_machine_exit(void)

 MACHINE_START(MIOA701, "MIO A701")
 	.boot_params	= 0xa0000100,
-	.map_io		= &pxa_map_io,
+	.map_io		= &pxa27x_map_io,
 	.init_irq	= &pxa27x_init_irq,
 	.init_machine	= mioa701_machine_init,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/mp900.c b/arch/arm/mach-pxa/mp900.c
index 116167a..59cce78 100644
--- a/arch/arm/mach-pxa/mp900.c
+++ b/arch/arm/mach-pxa/mp900.c
@@ -94,7 +94,7 @@ static void __init mp900c_init(void)
 MACHINE_START(NEC_MP900, "MobilePro900/C")
 	.boot_params	= 0xa0220100,
 	.timer		= &pxa_timer,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa25x_map_io,
 	.init_irq	= pxa25x_init_irq,
 	.init_machine	= mp900c_init,
 MACHINE_END
diff --git a/arch/arm/mach-pxa/palmld.c b/arch/arm/mach-pxa/palmld.c
index ce092c5..a6f898c 100644
--- a/arch/arm/mach-pxa/palmld.c
+++ b/arch/arm/mach-pxa/palmld.c
@@ -313,7 +313,7 @@ static struct map_desc palmld_io_desc[] __initdata = {

 static void __init palmld_map_io(void)
 {
-	pxa_map_io();
+	pxa27x_map_io();
 	iotable_init(palmld_io_desc, ARRAY_SIZE(palmld_io_desc));
 }

diff --git a/arch/arm/mach-pxa/palmt5.c b/arch/arm/mach-pxa/palmt5.c
index 862da81..df4d7d0 100644
--- a/arch/arm/mach-pxa/palmt5.c
+++ b/arch/arm/mach-pxa/palmt5.c
@@ -203,7 +203,7 @@ static void __init palmt5_init(void)

 MACHINE_START(PALMT5, "Palm Tungsten|T5")
 	.boot_params	= 0xa0000100,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa27x_map_io,
 	.reserve	= palmt5_reserve,
 	.init_irq	= pxa27x_init_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/palmtc.c b/arch/arm/mach-pxa/palmtc.c
index 2131d58..b8cda11 100644
--- a/arch/arm/mach-pxa/palmtc.c
+++ b/arch/arm/mach-pxa/palmtc.c
@@ -413,7 +413,7 @@ static void __init palmtc_init(void)

 MACHINE_START(PALMTC, "Palm Tungsten|C")
 	.boot_params 	= 0xa0000100,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa25x_map_io,
 	.init_irq	= pxa25x_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= palmtc_init
diff --git a/arch/arm/mach-pxa/palmte2.c b/arch/arm/mach-pxa/palmte2.c
index a9dae7b..3f25014 100644
--- a/arch/arm/mach-pxa/palmte2.c
+++ b/arch/arm/mach-pxa/palmte2.c
@@ -374,7 +374,7 @@ static void __init palmte2_init(void)

 MACHINE_START(PALMTE2, "Palm Tungsten|E2")
 	.boot_params	= 0xa0000100,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa25x_map_io,
 	.init_irq	= pxa25x_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= palmte2_init
diff --git a/arch/arm/mach-pxa/palmtreo.c b/arch/arm/mach-pxa/palmtreo.c
index 00e2d7b..8aadad5 100644
--- a/arch/arm/mach-pxa/palmtreo.c
+++ b/arch/arm/mach-pxa/palmtreo.c
@@ -442,7 +442,7 @@ static void __init centro_init(void)

 MACHINE_START(TREO680, "Palm Treo 680")
 	.boot_params    = 0xa0000100,
-	.map_io         = pxa_map_io,
+	.map_io         = pxa27x_map_io,
 	.reserve	= treo_reserve,
 	.init_irq       = pxa27x_init_irq,
 	.timer          = &pxa_timer,
@@ -451,7 +451,7 @@ MACHINE_END

 MACHINE_START(CENTRO, "Palm Centro 685")
 	.boot_params    = 0xa0000100,
-	.map_io         = pxa_map_io,
+	.map_io         = pxa27x_map_io,
 	.reserve	= treo_reserve,
 	.init_irq       = pxa27x_init_irq,
 	.timer          = &pxa_timer,
diff --git a/arch/arm/mach-pxa/palmtx.c b/arch/arm/mach-pxa/palmtx.c
index d2060a1..8943296 100644
--- a/arch/arm/mach-pxa/palmtx.c
+++ b/arch/arm/mach-pxa/palmtx.c
@@ -333,7 +333,7 @@ static struct map_desc palmtx_io_desc[] __initdata = {

 static void __init palmtx_map_io(void)
 {
-	pxa_map_io();
+	pxa27x_map_io();
 	iotable_init(palmtx_io_desc, ARRAY_SIZE(palmtx_io_desc));
 }

diff --git a/arch/arm/mach-pxa/palmz72.c b/arch/arm/mach-pxa/palmz72.c
index af6203f..7bf4017 100644
--- a/arch/arm/mach-pxa/palmz72.c
+++ b/arch/arm/mach-pxa/palmz72.c
@@ -280,7 +280,7 @@ static void __init palmz72_init(void)

 MACHINE_START(PALMZ72, "Palm Zire72")
 	.boot_params	= 0xa0000100,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa27x_map_io,
 	.init_irq	= pxa27x_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= palmz72_init
diff --git a/arch/arm/mach-pxa/pcm027.c b/arch/arm/mach-pxa/pcm027.c
index c77e8f3..8547c9a 100644
--- a/arch/arm/mach-pxa/pcm027.c
+++ b/arch/arm/mach-pxa/pcm027.c
@@ -244,7 +244,7 @@ static void __init pcm027_init(void)

 static void __init pcm027_map_io(void)
 {
-	pxa_map_io();
+	pxa27x_map_io();

 	/* initialize sleep mode regs (wake-up sources, etc) */
 	PGSR0 = 0x01308000;
diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
index 93a191c..8451790 100644
--- a/arch/arm/mach-pxa/poodle.c
+++ b/arch/arm/mach-pxa/poodle.c
@@ -466,7 +466,7 @@ static void __init fixup_poodle(struct machine_desc *desc,

 MACHINE_START(POODLE, "SHARP Poodle")
 	.fixup		= fixup_poodle,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa25x_map_io,
 	.nr_irqs	= POODLE_NR_IRQS,	/* 4 for LoCoMo */
 	.init_irq	= pxa25x_init_irq,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index de53f2e..4596b98 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -320,6 +320,22 @@ void __init pxa26x_init_irq(void)
 }
 #endif

+static struct map_desc pxa25x_io_desc[] __initdata = {
+	{	/* Mem Ctl */
+		.virtual	=  0xf6000000,
+		.pfn		= __phys_to_pfn(0x48000000),
+		.length		= 0x00200000,
+		.type		= MT_DEVICE
+	},
+};
+
+void __init pxa25x_map_io(void)
+{
+	pxa_map_io();
+	iotable_init(ARRAY_AND_SIZE(pxa25x_io_desc));
+	pxa25x_get_clk_frequency_khz(1);
+}
+
 static struct platform_device *pxa25x_devices[] __initdata = {
 	&pxa25x_device_udc,
 	&pxa_device_pmu,
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 12e5b9f..a061cef 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -370,6 +370,27 @@ void __init pxa27x_init_irq(void)
 	pxa_init_gpio(IRQ_GPIO_2_x, 2, 120, pxa27x_set_wake);
 }

+static struct map_desc pxa27x_io_desc[] __initdata = {
+	{	/* Mem Ctl */
+		.virtual	=  0xf6000000,
+		.pfn		= __phys_to_pfn(0x48000000),
+		.length		= 0x00200000,
+		.type		= MT_DEVICE
+	}, {	/* IMem ctl */
+		.virtual	=  0xfe000000,
+		.pfn		= __phys_to_pfn(0x58000000),
+		.length		= 0x00100000,
+		.type		= MT_DEVICE
+	},
+};
+
+void __init pxa27x_map_io(void)
+{
+	pxa_map_io();
+	iotable_init(ARRAY_AND_SIZE(pxa27x_io_table));
+	pxa27x_get_clk_frequency_khz(1);
+}
+
 /*
  * device registration specific to PXA27x.
  */
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index c85c3a7..877acd8 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -580,6 +580,22 @@ void __init pxa3xx_init_irq(void)
 	pxa_init_gpio(IRQ_GPIO_2_x, 2, 127, NULL);
 }

+static struct map_desc pxa3xx_io_desc[] __initdata = {
+	{	/* Mem Ctl */
+		.virtual	=  0xf6000000,
+		.pfn		= __phys_to_pfn(0x4a000000),
+		.length		= 0x00200000,
+		.type		= MT_DEVICE
+	}
+};
+
+void __init pxa3xx_map_io(void)
+{
+	pxa_map_io();
+	iotable_init(ARRAY_AND_SIZE(common_io_desc));
+	pxa3xx_get_clk_frequency_khz(1);
+}
+
 /*
  * device registration specific to PXA3xx.
  */
diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index 4121d03..117c703 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -1085,7 +1085,7 @@ static void __init raumfeld_speaker_init(void)
 MACHINE_START(RAUMFELD_RC, "Raumfeld Controller")
 	.boot_params	= RAUMFELD_SDRAM_BASE + 0x100,
 	.init_machine	= raumfeld_controller_init,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa3xx_map_io,
 	.init_irq	= pxa3xx_init_irq,
 	.timer		= &pxa_timer,
 MACHINE_END
@@ -1095,7 +1095,7 @@ MACHINE_END
 MACHINE_START(RAUMFELD_CONNECTOR, "Raumfeld Connector")
 	.boot_params	= RAUMFELD_SDRAM_BASE + 0x100,
 	.init_machine	= raumfeld_connector_init,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa3xx_map_io,
 	.init_irq	= pxa3xx_init_irq,
 	.timer		= &pxa_timer,
 MACHINE_END
@@ -1105,7 +1105,7 @@ MACHINE_END
 MACHINE_START(RAUMFELD_SPEAKER, "Raumfeld Speaker")
 	.boot_params	= RAUMFELD_SDRAM_BASE + 0x100,
 	.init_machine	= raumfeld_speaker_init,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa3xx_map_io,
 	.init_irq	= pxa3xx_init_irq,
 	.timer		= &pxa_timer,
 MACHINE_END
diff --git a/arch/arm/mach-pxa/saar.c b/arch/arm/mach-pxa/saar.c
index 4b521e0..2e2f5a3 100644
--- a/arch/arm/mach-pxa/saar.c
+++ b/arch/arm/mach-pxa/saar.c
@@ -597,7 +597,7 @@ static void __init saar_init(void)
 MACHINE_START(SAAR, "PXA930 Handheld Platform (aka SAAR)")
 	/* Maintainer: Eric Miao <eric.miao@marvell.com> */
 	.boot_params    = 0xa0000100,
-	.map_io         = pxa_map_io,
+	.map_io         = pxa3xx_map_io,
 	.init_irq       = pxa3xx_init_irq,
 	.timer          = &pxa_timer,
 	.init_machine   = saar_init,
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index f736119..38bcc2a 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -27,6 +27,7 @@
 #include <linux/mtd/sharpsl.h>
 #include <linux/input/matrix_keypad.h>
 #include <linux/regulator/machine.h>
+#include <linux/io.h>

 #include <asm/setup.h>
 #include <asm/mach-types.h>
@@ -980,7 +981,7 @@ static void __init spitz_fixup(struct machine_desc *desc,
 #ifdef CONFIG_MACH_SPITZ
 MACHINE_START(SPITZ, "SHARP Spitz")
 	.fixup		= spitz_fixup,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa27x_map_io,
 	.init_irq	= pxa27x_init_irq,
 	.init_machine	= spitz_init,
 	.timer		= &pxa_timer,
@@ -990,7 +991,7 @@ MACHINE_END
 #ifdef CONFIG_MACH_BORZOI
 MACHINE_START(BORZOI, "SHARP Borzoi")
 	.fixup		= spitz_fixup,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa27x_map_io,
 	.init_irq	= pxa27x_init_irq,
 	.init_machine	= spitz_init,
 	.timer		= &pxa_timer,
@@ -1000,7 +1001,7 @@ MACHINE_END
 #ifdef CONFIG_MACH_AKITA
 MACHINE_START(AKITA, "SHARP Akita")
 	.fixup		= spitz_fixup,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa27x_map_io,
 	.init_irq	= pxa27x_init_irq,
 	.init_machine	= spitz_init,
 	.timer		= &pxa_timer,
diff --git a/arch/arm/mach-pxa/stargate2.c b/arch/arm/mach-pxa/stargate2.c
index 738adc1..19f5378 100644
--- a/arch/arm/mach-pxa/stargate2.c
+++ b/arch/arm/mach-pxa/stargate2.c
@@ -998,7 +998,7 @@ static void __init stargate2_init(void)

 #ifdef CONFIG_MACH_INTELMOTE2
 MACHINE_START(INTELMOTE2, "IMOTE 2")
-	.map_io		= pxa_map_io,
+	.map_io		= pxa27x_map_io,
 	.init_irq	= pxa27x_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= imote2_init,
@@ -1008,7 +1008,7 @@ MACHINE_END

 #ifdef CONFIG_MACH_STARGATE2
 MACHINE_START(STARGATE2, "Stargate 2")
-	.map_io = pxa_map_io,
+	.map_io = pxa27x_map_io,
 	.nr_irqs = STARGATE_NR_IRQS,
 	.init_irq = pxa27x_init_irq,
 	.timer = &pxa_timer,
diff --git a/arch/arm/mach-pxa/tavorevb.c b/arch/arm/mach-pxa/tavorevb.c
index 2ea7545..9cecf83 100644
--- a/arch/arm/mach-pxa/tavorevb.c
+++ b/arch/arm/mach-pxa/tavorevb.c
@@ -490,7 +490,7 @@ static void __init tavorevb_init(void)
 MACHINE_START(TAVOREVB, "PXA930 Evaluation Board (aka TavorEVB)")
 	/* Maintainer: Eric Miao <eric.miao@marvell.com> */
 	.boot_params    = 0xa0000100,
-	.map_io         = pxa_map_io,
+	.map_io         = pxa3xx_map_io,
 	.init_irq       = pxa3xx_init_irq,
 	.timer          = &pxa_timer,
 	.init_machine   = tavorevb_init,
diff --git a/arch/arm/mach-pxa/tavorevb3.c b/arch/arm/mach-pxa/tavorevb3.c
index 5eeba64..551e6a4 100644
--- a/arch/arm/mach-pxa/tavorevb3.c
+++ b/arch/arm/mach-pxa/tavorevb3.c
@@ -128,7 +128,7 @@ static void __init evb3_init(void)
 MACHINE_START(TAVOREVB3, "PXA950 Evaluation Board (aka TavorEVB3)")
 	.phys_io	= 0x40000000,
 	.boot_params	= 0xa0000100,
-	.map_io         = pxa_map_io,
+	.map_io         = pxa3xx_map_io,
 	.nr_irqs	= TAVOREVB3_NR_IRQS,
 	.init_irq       = pxa3xx_init_irq,
 	.timer          = &pxa_timer,
diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
index 0ee1df4..3883385 100644
--- a/arch/arm/mach-pxa/tosa.c
+++ b/arch/arm/mach-pxa/tosa.c
@@ -953,7 +953,7 @@ static void __init fixup_tosa(struct machine_desc *desc,

 MACHINE_START(TOSA, "SHARP Tosa")
 	.fixup          = fixup_tosa,
-	.map_io         = pxa_map_io,
+	.map_io         = pxa25x_map_io,
 	.nr_irqs	= TOSA_NR_IRQS,
 	.init_irq       = pxa25x_init_irq,
 	.init_machine   = tosa_init,
diff --git a/arch/arm/mach-pxa/trizeps4.c b/arch/arm/mach-pxa/trizeps4.c
index 565d062..ab3b933 100644
--- a/arch/arm/mach-pxa/trizeps4.c
+++ b/arch/arm/mach-pxa/trizeps4.c
@@ -539,7 +539,7 @@ static void __init trizeps4_init(void)

 static void __init trizeps4_map_io(void)
 {
-	pxa_map_io();
+	pxa27x_map_io();
 	iotable_init(trizeps4_io_desc, ARRAY_SIZE(trizeps4_io_desc));

 	if ((MSC0 & 0x8) && (BOOT_DEF & 0x1)) {
diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
index 438fc9a..de69b20 100644
--- a/arch/arm/mach-pxa/viper.c
+++ b/arch/arm/mach-pxa/viper.c
@@ -983,7 +983,7 @@ static struct map_desc viper_io_desc[] __initdata = {

 static void __init viper_map_io(void)
 {
-	pxa_map_io();
+	pxa25x_map_io();

 	iotable_init(viper_io_desc, ARRAY_SIZE(viper_io_desc));

diff --git a/arch/arm/mach-pxa/vpac270.c b/arch/arm/mach-pxa/vpac270.c
index f45ac09..b9b5797 100644
--- a/arch/arm/mach-pxa/vpac270.c
+++ b/arch/arm/mach-pxa/vpac270.c
@@ -719,7 +719,7 @@ static void __init vpac270_init(void)

 MACHINE_START(VPAC270, "Voipac PXA270")
 	.boot_params	= 0xa0000100,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa27x_map_io,
 	.init_irq	= pxa27x_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= vpac270_init
diff --git a/arch/arm/mach-pxa/xcep.c b/arch/arm/mach-pxa/xcep.c
index 3260ce7..99744f4 100644
--- a/arch/arm/mach-pxa/xcep.c
+++ b/arch/arm/mach-pxa/xcep.c
@@ -183,7 +183,7 @@ static void __init xcep_init(void)
 MACHINE_START(XCEP, "Iskratel XCEP")
 	.boot_params	= 0xa0000100,
 	.init_machine	= xcep_init,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa25x_map_io,
 	.init_irq	= pxa25x_init_irq,
 	.timer		= &pxa_timer,
 MACHINE_END
diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index fefde98..527c2a1 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -704,7 +704,7 @@ static void __init z2_init(void)

 MACHINE_START(ZIPIT2, "Zipit Z2")
 	.boot_params	= 0xa0000100,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa27x_map_io,
 	.init_irq	= pxa27x_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= z2_init,
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index dea46a2..0909df2 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -883,7 +883,7 @@ static struct map_desc zeus_io_desc[] __initdata = {

 static void __init zeus_map_io(void)
 {
-	pxa_map_io();
+	pxa27x_map_io();

 	iotable_init(zeus_io_desc, ARRAY_SIZE(zeus_io_desc));

diff --git a/arch/arm/mach-pxa/zylonite.c b/arch/arm/mach-pxa/zylonite.c
index f25fb62..df6c58d 100644
--- a/arch/arm/mach-pxa/zylonite.c
+++ b/arch/arm/mach-pxa/zylonite.c
@@ -412,7 +412,7 @@ static void __init zylonite_init(void)

 MACHINE_START(ZYLONITE, "PXA3xx Platform Development Kit (aka Zylonite)")
 	.boot_params	= 0xa0000100,
-	.map_io		= pxa_map_io,
+	.map_io		= pxa3xx_map_io,
 	.nr_irqs	= ZYLONITE_NR_IRQS,
 	.init_irq	= pxa3xx_init_irq,
 	.timer		= &pxa_timer,
-- 
1.7.0.4

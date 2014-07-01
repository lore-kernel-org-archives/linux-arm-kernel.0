From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  1 Jul 2014 09:28:37 +0900
Subject: [PATCH 6/7] ARM: shmobile: Move sh73a0.h
In-Reply-To: <cover.1404173049.git.horms+renesas@verge.net.au>
References: <cover.1404173049.git.horms+renesas@verge.net.au>
Message-ID: <ded59d6dfc47683d1b810c069ed637e1e60e75fd.1404173049.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Change location of sh73a0.h so it can be included as "sh73a0.h"
instead of the old style <mach/sh73a0.h>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-kzm9g-reference.c |  4 +-
 arch/arm/mach-shmobile/board-kzm9g.c           |  4 +-
 arch/arm/mach-shmobile/include/mach/sh73a0.h   | 91 --------------------------
 arch/arm/mach-shmobile/intc-sh73a0.c           |  4 +-
 arch/arm/mach-shmobile/setup-sh73a0.c          |  4 +-
 arch/arm/mach-shmobile/sh73a0.h                | 91 ++++++++++++++++++++++++++
 arch/arm/mach-shmobile/smp-sh73a0.c            |  4 +-
 7 files changed, 106 insertions(+), 96 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/include/mach/sh73a0.h
 create mode 100644 arch/arm/mach-shmobile/sh73a0.h

diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
index e6285de..5d2621f 100644
--- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
@@ -25,11 +25,13 @@
 #include <linux/irq.h>
 #include <linux/input.h>
 #include <linux/of_platform.h>
-#include <mach/sh73a0.h>
+
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+
 #include "common.h"
+#include "sh73a0.h"
 
 static void __init kzm_init(void)
 {
diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index fff330f..1320e9d 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -41,15 +41,17 @@
 #include <linux/usb/r8a66597.h>
 #include <linux/usb/renesas_usbhs.h>
 #include <linux/videodev2.h>
+
 #include <sound/sh_fsi.h>
 #include <sound/simple_card.h>
-#include <mach/sh73a0.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <video/sh_mobile_lcdc.h>
+
 #include "common.h"
 #include "irqs.h"
+#include "sh73a0.h"
 
 /*
  * external GPIO
diff --git a/arch/arm/mach-shmobile/include/mach/sh73a0.h b/arch/arm/mach-shmobile/include/mach/sh73a0.h
deleted file mode 100644
index 359b582..0000000
--- a/arch/arm/mach-shmobile/include/mach/sh73a0.h
+++ /dev/null
@@ -1,91 +0,0 @@
-#ifndef __ASM_SH73A0_H__
-#define __ASM_SH73A0_H__
-
-/* DMA slave IDs */
-enum {
-	SHDMA_SLAVE_INVALID,
-	SHDMA_SLAVE_SCIF0_TX,
-	SHDMA_SLAVE_SCIF0_RX,
-	SHDMA_SLAVE_SCIF1_TX,
-	SHDMA_SLAVE_SCIF1_RX,
-	SHDMA_SLAVE_SCIF2_TX,
-	SHDMA_SLAVE_SCIF2_RX,
-	SHDMA_SLAVE_SCIF3_TX,
-	SHDMA_SLAVE_SCIF3_RX,
-	SHDMA_SLAVE_SCIF4_TX,
-	SHDMA_SLAVE_SCIF4_RX,
-	SHDMA_SLAVE_SCIF5_TX,
-	SHDMA_SLAVE_SCIF5_RX,
-	SHDMA_SLAVE_SCIF6_TX,
-	SHDMA_SLAVE_SCIF6_RX,
-	SHDMA_SLAVE_SCIF7_TX,
-	SHDMA_SLAVE_SCIF7_RX,
-	SHDMA_SLAVE_SCIF8_TX,
-	SHDMA_SLAVE_SCIF8_RX,
-	SHDMA_SLAVE_SDHI0_TX,
-	SHDMA_SLAVE_SDHI0_RX,
-	SHDMA_SLAVE_SDHI1_TX,
-	SHDMA_SLAVE_SDHI1_RX,
-	SHDMA_SLAVE_SDHI2_TX,
-	SHDMA_SLAVE_SDHI2_RX,
-	SHDMA_SLAVE_MMCIF_TX,
-	SHDMA_SLAVE_MMCIF_RX,
-	SHDMA_SLAVE_FSI2A_TX,
-	SHDMA_SLAVE_FSI2A_RX,
-	SHDMA_SLAVE_FSI2B_TX,
-	SHDMA_SLAVE_FSI2B_RX,
-	SHDMA_SLAVE_FSI2C_TX,
-	SHDMA_SLAVE_FSI2C_RX,
-	SHDMA_SLAVE_FSI2D_RX,
-};
-
-/*
- *		SH73A0 IRQ LOCATION TABLE
- *
- * 416	-----------------------------------------
- *		IRQ0-IRQ15
- * 431	-----------------------------------------
- * ...
- * 448	-----------------------------------------
- *		sh73a0-intcs
- *		sh73a0-intca-irq-pins
- * 680	-----------------------------------------
- * ...
- * 700	-----------------------------------------
- *		sh73a0-pint0
- * 731	-----------------------------------------
- * 732	-----------------------------------------
- *		sh73a0-pint1
- * 739	-----------------------------------------
- * ...
- * 800	-----------------------------------------
- *		IRQ16-IRQ31
- * 815	-----------------------------------------
- * ...
- * 928	-----------------------------------------
- *		sh73a0-intca-irq-pins
- * 943	-----------------------------------------
- */
-
-/* PINT interrupts are located at Linux IRQ 700 and up */
-#define SH73A0_PINT0_IRQ(irq) ((irq) + 700)
-#define SH73A0_PINT1_IRQ(irq) ((irq) + 732)
-
-extern void sh73a0_init_delay(void);
-extern void sh73a0_init_irq(void);
-extern void sh73a0_init_irq_dt(void);
-extern void sh73a0_map_io(void);
-extern void sh73a0_earlytimer_init(void);
-extern void sh73a0_add_early_devices(void);
-extern void sh73a0_add_standard_devices(void);
-extern void sh73a0_add_standard_devices_dt(void);
-extern void sh73a0_clock_init(void);
-extern void sh73a0_pinmux_init(void);
-extern void sh73a0_pm_init(void);
-extern struct clk sh73a0_extal1_clk;
-extern struct clk sh73a0_extal2_clk;
-extern struct clk sh73a0_extcki_clk;
-extern struct clk sh73a0_extalr_clk;
-extern struct smp_operations sh73a0_smp_ops;
-
-#endif /* __ASM_SH73A0_H__ */
diff --git a/arch/arm/mach-shmobile/intc-sh73a0.c b/arch/arm/mach-shmobile/intc-sh73a0.c
index 1a8f9a7..44457a9 100644
--- a/arch/arm/mach-shmobile/intc-sh73a0.c
+++ b/arch/arm/mach-shmobile/intc-sh73a0.c
@@ -24,11 +24,13 @@
 #include <linux/io.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/arm-gic.h>
-#include <mach/sh73a0.h>
+
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+
 #include "intc.h"
 #include "irqs.h"
+#include "sh73a0.h"
 
 enum {
 	UNUSED = 0,
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index b30bbee..2248821 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -32,14 +32,16 @@
 #include <linux/sh_timer.h>
 #include <linux/platform_data/sh_ipmmu.h>
 #include <linux/platform_data/irq-renesas-intc-irqpin.h>
-#include <mach/sh73a0.h>
+
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
+
 #include "common.h"
 #include "dma-register.h"
 #include "irqs.h"
+#include "sh73a0.h"
 
 static struct map_desc sh73a0_io_desc[] __initdata = {
 	/* create a 1:1 entity map for 0xe6xxxxxx
diff --git a/arch/arm/mach-shmobile/sh73a0.h b/arch/arm/mach-shmobile/sh73a0.h
new file mode 100644
index 0000000..359b582
--- /dev/null
+++ b/arch/arm/mach-shmobile/sh73a0.h
@@ -0,0 +1,91 @@
+#ifndef __ASM_SH73A0_H__
+#define __ASM_SH73A0_H__
+
+/* DMA slave IDs */
+enum {
+	SHDMA_SLAVE_INVALID,
+	SHDMA_SLAVE_SCIF0_TX,
+	SHDMA_SLAVE_SCIF0_RX,
+	SHDMA_SLAVE_SCIF1_TX,
+	SHDMA_SLAVE_SCIF1_RX,
+	SHDMA_SLAVE_SCIF2_TX,
+	SHDMA_SLAVE_SCIF2_RX,
+	SHDMA_SLAVE_SCIF3_TX,
+	SHDMA_SLAVE_SCIF3_RX,
+	SHDMA_SLAVE_SCIF4_TX,
+	SHDMA_SLAVE_SCIF4_RX,
+	SHDMA_SLAVE_SCIF5_TX,
+	SHDMA_SLAVE_SCIF5_RX,
+	SHDMA_SLAVE_SCIF6_TX,
+	SHDMA_SLAVE_SCIF6_RX,
+	SHDMA_SLAVE_SCIF7_TX,
+	SHDMA_SLAVE_SCIF7_RX,
+	SHDMA_SLAVE_SCIF8_TX,
+	SHDMA_SLAVE_SCIF8_RX,
+	SHDMA_SLAVE_SDHI0_TX,
+	SHDMA_SLAVE_SDHI0_RX,
+	SHDMA_SLAVE_SDHI1_TX,
+	SHDMA_SLAVE_SDHI1_RX,
+	SHDMA_SLAVE_SDHI2_TX,
+	SHDMA_SLAVE_SDHI2_RX,
+	SHDMA_SLAVE_MMCIF_TX,
+	SHDMA_SLAVE_MMCIF_RX,
+	SHDMA_SLAVE_FSI2A_TX,
+	SHDMA_SLAVE_FSI2A_RX,
+	SHDMA_SLAVE_FSI2B_TX,
+	SHDMA_SLAVE_FSI2B_RX,
+	SHDMA_SLAVE_FSI2C_TX,
+	SHDMA_SLAVE_FSI2C_RX,
+	SHDMA_SLAVE_FSI2D_RX,
+};
+
+/*
+ *		SH73A0 IRQ LOCATION TABLE
+ *
+ * 416	-----------------------------------------
+ *		IRQ0-IRQ15
+ * 431	-----------------------------------------
+ * ...
+ * 448	-----------------------------------------
+ *		sh73a0-intcs
+ *		sh73a0-intca-irq-pins
+ * 680	-----------------------------------------
+ * ...
+ * 700	-----------------------------------------
+ *		sh73a0-pint0
+ * 731	-----------------------------------------
+ * 732	-----------------------------------------
+ *		sh73a0-pint1
+ * 739	-----------------------------------------
+ * ...
+ * 800	-----------------------------------------
+ *		IRQ16-IRQ31
+ * 815	-----------------------------------------
+ * ...
+ * 928	-----------------------------------------
+ *		sh73a0-intca-irq-pins
+ * 943	-----------------------------------------
+ */
+
+/* PINT interrupts are located at Linux IRQ 700 and up */
+#define SH73A0_PINT0_IRQ(irq) ((irq) + 700)
+#define SH73A0_PINT1_IRQ(irq) ((irq) + 732)
+
+extern void sh73a0_init_delay(void);
+extern void sh73a0_init_irq(void);
+extern void sh73a0_init_irq_dt(void);
+extern void sh73a0_map_io(void);
+extern void sh73a0_earlytimer_init(void);
+extern void sh73a0_add_early_devices(void);
+extern void sh73a0_add_standard_devices(void);
+extern void sh73a0_add_standard_devices_dt(void);
+extern void sh73a0_clock_init(void);
+extern void sh73a0_pinmux_init(void);
+extern void sh73a0_pm_init(void);
+extern struct clk sh73a0_extal1_clk;
+extern struct clk sh73a0_extal2_clk;
+extern struct clk sh73a0_extcki_clk;
+extern struct clk sh73a0_extalr_clk;
+extern struct smp_operations sh73a0_smp_ops;
+
+#endif /* __ASM_SH73A0_H__ */
diff --git a/arch/arm/mach-shmobile/smp-sh73a0.c b/arch/arm/mach-shmobile/smp-sh73a0.c
index bf4aff9..22d8f87 100644
--- a/arch/arm/mach-shmobile/smp-sh73a0.c
+++ b/arch/arm/mach-shmobile/smp-sh73a0.c
@@ -22,10 +22,12 @@
 #include <linux/smp.h>
 #include <linux/io.h>
 #include <linux/delay.h>
-#include <mach/sh73a0.h>
+
 #include <asm/smp_plat.h>
 #include <asm/smp_twd.h>
+
 #include "common.h"
+#include "sh73a0.h"
 
 #define WUPCR		IOMEM(0xe6151010)
 #define SRESCR		IOMEM(0xe6151018)
-- 
2.0.0.rc2

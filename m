From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  1 Jul 2014 09:28:38 +0900
Subject: [PATCH 7/7] ARM: shmobile: Move sh7372.h
In-Reply-To: <cover.1404173049.git.horms+renesas@verge.net.au>
References: <cover.1404173049.git.horms+renesas@verge.net.au>
Message-ID: <113522ee3034427472bcb4b8665833719809b31a.1404173049.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Change location of sh7372.h so it can be included as "sh7372.h"
instead of the old style <mach/sh7372.h>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-mackerel.c      |  4 +-
 arch/arm/mach-shmobile/include/mach/sh7372.h | 84 ----------------------------
 arch/arm/mach-shmobile/pm-sh7372.c           |  4 +-
 arch/arm/mach-shmobile/setup-sh7372.c        |  4 +-
 arch/arm/mach-shmobile/sh7372.h              | 84 ++++++++++++++++++++++++++++
 5 files changed, 93 insertions(+), 87 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/include/mach/sh7372.h
 create mode 100644 arch/arm/mach-shmobile/sh7372.h

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 0ece865..304b76f 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -51,6 +51,7 @@
 #include <linux/tca6416_keypad.h>
 #include <linux/usb/renesas_usbhs.h>
 #include <linux/dma-mapping.h>
+
 #include <video/sh_mobile_hdmi.h>
 #include <video/sh_mobile_lcdc.h>
 #include <media/sh_mobile_ceu.h>
@@ -58,13 +59,14 @@
 #include <media/soc_camera_platform.h>
 #include <sound/sh_fsi.h>
 #include <sound/simple_card.h>
-#include <mach/sh7372.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
+
 #include "common.h"
 #include "irqs.h"
 #include "pm-rmobile.h"
 #include "sh-gpio.h"
+#include "sh7372.h"
 
 /*
  * Address	Interface		BusWidth	note
diff --git a/arch/arm/mach-shmobile/include/mach/sh7372.h b/arch/arm/mach-shmobile/include/mach/sh7372.h
deleted file mode 100644
index 4ad960d..0000000
--- a/arch/arm/mach-shmobile/include/mach/sh7372.h
+++ /dev/null
@@ -1,84 +0,0 @@
-/*
- * Copyright (C) 2010 Renesas Solutions Corp.
- *
- * Kuninori Morimoto <morimoto.kuninori@renesas.com>
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#ifndef __ASM_SH7372_H__
-#define __ASM_SH7372_H__
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
-	SHDMA_SLAVE_FLCTL0_TX,
-	SHDMA_SLAVE_FLCTL0_RX,
-	SHDMA_SLAVE_FLCTL1_TX,
-	SHDMA_SLAVE_FLCTL1_RX,
-	SHDMA_SLAVE_SDHI0_RX,
-	SHDMA_SLAVE_SDHI0_TX,
-	SHDMA_SLAVE_SDHI1_RX,
-	SHDMA_SLAVE_SDHI1_TX,
-	SHDMA_SLAVE_SDHI2_RX,
-	SHDMA_SLAVE_SDHI2_TX,
-	SHDMA_SLAVE_FSIA_RX,
-	SHDMA_SLAVE_FSIA_TX,
-	SHDMA_SLAVE_MMCIF_RX,
-	SHDMA_SLAVE_MMCIF_TX,
-	SHDMA_SLAVE_USB0_TX,
-	SHDMA_SLAVE_USB0_RX,
-	SHDMA_SLAVE_USB1_TX,
-	SHDMA_SLAVE_USB1_RX,
-};
-
-extern struct clk sh7372_extal1_clk;
-extern struct clk sh7372_extal2_clk;
-extern struct clk sh7372_dv_clki_clk;
-extern struct clk sh7372_dv_clki_div2_clk;
-extern struct clk sh7372_pllc2_clk;
-
-extern void sh7372_init_irq(void);
-extern void sh7372_map_io(void);
-extern void sh7372_earlytimer_init(void);
-extern void sh7372_add_early_devices(void);
-extern void sh7372_add_standard_devices(void);
-extern void sh7372_add_early_devices_dt(void);
-extern void sh7372_add_standard_devices_dt(void);
-extern void sh7372_clock_init(void);
-extern void sh7372_pinmux_init(void);
-extern void sh7372_pm_init(void);
-extern void sh7372_resume_core_standby_sysc(void);
-extern int  sh7372_do_idle_sysc(unsigned long sleep_mode);
-extern void sh7372_intcs_suspend(void);
-extern void sh7372_intcs_resume(void);
-extern void sh7372_intca_suspend(void);
-extern void sh7372_intca_resume(void);
-
-extern unsigned long sh7372_cpu_resume;
-
-#ifdef CONFIG_PM
-extern void __init sh7372_init_pm_domains(void);
-#else
-static inline void sh7372_init_pm_domains(void) {}
-#endif
-
-extern void __init sh7372_pm_init_late(void);
-
-#endif /* __ASM_SH7372_H__ */
diff --git a/arch/arm/mach-shmobile/pm-sh7372.c b/arch/arm/mach-shmobile/pm-sh7372.c
index 7ef9a01..7e5c267 100644
--- a/arch/arm/mach-shmobile/pm-sh7372.c
+++ b/arch/arm/mach-shmobile/pm-sh7372.c
@@ -21,13 +21,15 @@
 #include <linux/irq.h>
 #include <linux/bitrev.h>
 #include <linux/console.h>
+
 #include <asm/cpuidle.h>
 #include <asm/io.h>
 #include <asm/tlbflush.h>
 #include <asm/suspend.h>
-#include <mach/sh7372.h>
+
 #include "common.h"
 #include "pm-rmobile.h"
+#include "sh7372.h"
 
 /* DBG */
 #define DBGREG1 IOMEM(0xe6100020)
diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index 5571f86..9cdfcdfd 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -33,15 +33,17 @@
 #include <linux/pm_domain.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_data/sh_ipmmu.h>
-#include <mach/sh7372.h>
+
 #include <asm/mach/map.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
+
 #include "common.h"
 #include "dma-register.h"
 #include "irqs.h"
 #include "pm-rmobile.h"
+#include "sh7372.h"
 
 static struct map_desc sh7372_io_desc[] __initdata = {
 	/* create a 1:1 entity map for 0xe6xxxxxx
diff --git a/arch/arm/mach-shmobile/sh7372.h b/arch/arm/mach-shmobile/sh7372.h
new file mode 100644
index 0000000..4ad960d
--- /dev/null
+++ b/arch/arm/mach-shmobile/sh7372.h
@@ -0,0 +1,84 @@
+/*
+ * Copyright (C) 2010 Renesas Solutions Corp.
+ *
+ * Kuninori Morimoto <morimoto.kuninori@renesas.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#ifndef __ASM_SH7372_H__
+#define __ASM_SH7372_H__
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
+	SHDMA_SLAVE_FLCTL0_TX,
+	SHDMA_SLAVE_FLCTL0_RX,
+	SHDMA_SLAVE_FLCTL1_TX,
+	SHDMA_SLAVE_FLCTL1_RX,
+	SHDMA_SLAVE_SDHI0_RX,
+	SHDMA_SLAVE_SDHI0_TX,
+	SHDMA_SLAVE_SDHI1_RX,
+	SHDMA_SLAVE_SDHI1_TX,
+	SHDMA_SLAVE_SDHI2_RX,
+	SHDMA_SLAVE_SDHI2_TX,
+	SHDMA_SLAVE_FSIA_RX,
+	SHDMA_SLAVE_FSIA_TX,
+	SHDMA_SLAVE_MMCIF_RX,
+	SHDMA_SLAVE_MMCIF_TX,
+	SHDMA_SLAVE_USB0_TX,
+	SHDMA_SLAVE_USB0_RX,
+	SHDMA_SLAVE_USB1_TX,
+	SHDMA_SLAVE_USB1_RX,
+};
+
+extern struct clk sh7372_extal1_clk;
+extern struct clk sh7372_extal2_clk;
+extern struct clk sh7372_dv_clki_clk;
+extern struct clk sh7372_dv_clki_div2_clk;
+extern struct clk sh7372_pllc2_clk;
+
+extern void sh7372_init_irq(void);
+extern void sh7372_map_io(void);
+extern void sh7372_earlytimer_init(void);
+extern void sh7372_add_early_devices(void);
+extern void sh7372_add_standard_devices(void);
+extern void sh7372_add_early_devices_dt(void);
+extern void sh7372_add_standard_devices_dt(void);
+extern void sh7372_clock_init(void);
+extern void sh7372_pinmux_init(void);
+extern void sh7372_pm_init(void);
+extern void sh7372_resume_core_standby_sysc(void);
+extern int  sh7372_do_idle_sysc(unsigned long sleep_mode);
+extern void sh7372_intcs_suspend(void);
+extern void sh7372_intcs_resume(void);
+extern void sh7372_intca_suspend(void);
+extern void sh7372_intca_resume(void);
+
+extern unsigned long sh7372_cpu_resume;
+
+#ifdef CONFIG_PM
+extern void __init sh7372_init_pm_domains(void);
+#else
+static inline void sh7372_init_pm_domains(void) {}
+#endif
+
+extern void __init sh7372_pm_init_late(void);
+
+#endif /* __ASM_SH7372_H__ */
-- 
2.0.0.rc2

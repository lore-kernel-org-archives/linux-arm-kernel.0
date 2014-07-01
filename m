From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  1 Jul 2014 09:28:34 +0900
Subject: [PATCH 3/7] ARM: shmobile: Move r8a7740.h
In-Reply-To: <cover.1404173049.git.horms+renesas@verge.net.au>
References: <cover.1404173049.git.horms+renesas@verge.net.au>
Message-ID: <9e38b84b456ab7b2abd28257eec5caee4fb1f5ea.1404173049.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Change location of r8a7740.h so it can be included as "r8a7740.h"
instead of the old style <mach/r8a7740.h>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 .../board-armadillo800eva-reference.c              |  4 +-
 arch/arm/mach-shmobile/board-armadillo800eva.c     |  4 +-
 arch/arm/mach-shmobile/clock-r8a7740.c             |  3 +-
 arch/arm/mach-shmobile/include/mach/r8a7740.h      | 63 ----------------------
 arch/arm/mach-shmobile/r8a7740.h                   | 63 ++++++++++++++++++++++
 arch/arm/mach-shmobile/setup-r8a7740.c             |  4 +-
 6 files changed, 74 insertions(+), 67 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/include/mach/r8a7740.h
 create mode 100644 arch/arm/mach-shmobile/r8a7740.h

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
index 368518b..2085766 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
@@ -24,10 +24,12 @@
 #include <linux/kernel.h>
 #include <linux/gpio.h>
 #include <linux/io.h>
-#include <mach/r8a7740.h>
+
 #include <asm/mach/arch.h>
 #include <asm/hardware/cache-l2x0.h>
+
 #include "common.h"
+#include "r8a7740.h"
 
 /*
  * CON1		Camera Module
diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 53d03e8..32339cf 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -45,7 +45,7 @@
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/i2c-gpio.h>
 #include <linux/reboot.h>
-#include <mach/r8a7740.h>
+
 #include <media/mt9t112.h>
 #include <media/sh_mobile_ceu.h>
 #include <media/soc_camera.h>
@@ -59,9 +59,11 @@
 #include <video/sh_mobile_hdmi.h>
 #include <sound/sh_fsi.h>
 #include <sound/simple_card.h>
+
 #include "common.h"
 #include "irqs.h"
 #include "pm-rmobile.h"
+#include "r8a7740.h"
 #include "sh-gpio.h"
 
 /*
diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index ffefec5..789091c 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -22,9 +22,10 @@
 #include <linux/io.h>
 #include <linux/sh_clk.h>
 #include <linux/clkdev.h>
-#include <mach/r8a7740.h>
+
 #include "clock.h"
 #include "common.h"
+#include "r8a7740.h"
 
 /*
  *        |  MDx  |  XTAL1/EXTAL1   |  System   | EXTALR |
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7740.h b/arch/arm/mach-shmobile/include/mach/r8a7740.h
deleted file mode 100644
index 1d1a5fd..0000000
--- a/arch/arm/mach-shmobile/include/mach/r8a7740.h
+++ /dev/null
@@ -1,63 +0,0 @@
-/*
- * Copyright (C) 2011  Renesas Solutions Corp.
- * Copyright (C) 2011  Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#ifndef __ASM_R8A7740_H__
-#define __ASM_R8A7740_H__
-
-/*
- * MD_CKx pin
- */
-#define MD_CK2	(1 << 2)
-#define MD_CK1	(1 << 1)
-#define MD_CK0	(1 << 0)
-
-/* DMA slave IDs */
-enum {
-	SHDMA_SLAVE_INVALID,
-	SHDMA_SLAVE_SDHI0_RX,
-	SHDMA_SLAVE_SDHI0_TX,
-	SHDMA_SLAVE_SDHI1_RX,
-	SHDMA_SLAVE_SDHI1_TX,
-	SHDMA_SLAVE_SDHI2_RX,
-	SHDMA_SLAVE_SDHI2_TX,
-	SHDMA_SLAVE_FSIA_RX,
-	SHDMA_SLAVE_FSIA_TX,
-	SHDMA_SLAVE_FSIB_TX,
-	SHDMA_SLAVE_USBHS_TX,
-	SHDMA_SLAVE_USBHS_RX,
-	SHDMA_SLAVE_MMCIF_TX,
-	SHDMA_SLAVE_MMCIF_RX,
-};
-
-extern void r8a7740_meram_workaround(void);
-extern void r8a7740_init_irq_of(void);
-extern void r8a7740_map_io(void);
-extern void r8a7740_add_early_devices(void);
-extern void r8a7740_add_standard_devices(void);
-extern void r8a7740_add_standard_devices_dt(void);
-extern void r8a7740_clock_init(u8 md_ck);
-extern void r8a7740_pinmux_init(void);
-extern void r8a7740_pm_init(void);
-
-#ifdef CONFIG_PM
-extern void __init r8a7740_init_pm_domains(void);
-#else
-static inline void r8a7740_init_pm_domains(void) {}
-#endif /* CONFIG_PM */
-
-#endif /* __ASM_R8A7740_H__ */
diff --git a/arch/arm/mach-shmobile/r8a7740.h b/arch/arm/mach-shmobile/r8a7740.h
new file mode 100644
index 0000000..1d1a5fd
--- /dev/null
+++ b/arch/arm/mach-shmobile/r8a7740.h
@@ -0,0 +1,63 @@
+/*
+ * Copyright (C) 2011  Renesas Solutions Corp.
+ * Copyright (C) 2011  Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef __ASM_R8A7740_H__
+#define __ASM_R8A7740_H__
+
+/*
+ * MD_CKx pin
+ */
+#define MD_CK2	(1 << 2)
+#define MD_CK1	(1 << 1)
+#define MD_CK0	(1 << 0)
+
+/* DMA slave IDs */
+enum {
+	SHDMA_SLAVE_INVALID,
+	SHDMA_SLAVE_SDHI0_RX,
+	SHDMA_SLAVE_SDHI0_TX,
+	SHDMA_SLAVE_SDHI1_RX,
+	SHDMA_SLAVE_SDHI1_TX,
+	SHDMA_SLAVE_SDHI2_RX,
+	SHDMA_SLAVE_SDHI2_TX,
+	SHDMA_SLAVE_FSIA_RX,
+	SHDMA_SLAVE_FSIA_TX,
+	SHDMA_SLAVE_FSIB_TX,
+	SHDMA_SLAVE_USBHS_TX,
+	SHDMA_SLAVE_USBHS_RX,
+	SHDMA_SLAVE_MMCIF_TX,
+	SHDMA_SLAVE_MMCIF_RX,
+};
+
+extern void r8a7740_meram_workaround(void);
+extern void r8a7740_init_irq_of(void);
+extern void r8a7740_map_io(void);
+extern void r8a7740_add_early_devices(void);
+extern void r8a7740_add_standard_devices(void);
+extern void r8a7740_add_standard_devices_dt(void);
+extern void r8a7740_clock_init(u8 md_ck);
+extern void r8a7740_pinmux_init(void);
+extern void r8a7740_pm_init(void);
+
+#ifdef CONFIG_PM
+extern void __init r8a7740_init_pm_domains(void);
+#else
+static inline void r8a7740_init_pm_domains(void) {}
+#endif /* CONFIG_PM */
+
+#endif /* __ASM_R8A7740_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 10170b3..348af35 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -31,15 +31,17 @@
 #include <linux/sh_dma.h>
 #include <linux/sh_timer.h>
 #include <linux/platform_data/sh_ipmmu.h>
-#include <mach/r8a7740.h>
+
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
+
 #include "common.h"
 #include "dma-register.h"
 #include "irqs.h"
 #include "pm-rmobile.h"
+#include "r8a7740.h"
 
 static struct map_desc r8a7740_io_desc[] __initdata = {
 	 /*
-- 
2.0.0.rc2

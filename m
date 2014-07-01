From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  1 Jul 2014 09:28:35 +0900
Subject: [PATCH 4/7] ARM: shmobile: Move r8a7778.h
In-Reply-To: <cover.1404173049.git.horms+renesas@verge.net.au>
References: <cover.1404173049.git.horms+renesas@verge.net.au>
Message-ID: <02c94f38bf3bcdaaceb1f3486b4dbee1ab550793.1404173049.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Change location of r8a7778.h so it can be included as "r8a7778.h"
instead of the old style <mach/r8a7778.h>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-bockw-reference.c |  4 +-
 arch/arm/mach-shmobile/board-bockw.c           |  4 +-
 arch/arm/mach-shmobile/include/mach/r8a7778.h  | 83 --------------------------
 arch/arm/mach-shmobile/r8a7778.h               | 83 ++++++++++++++++++++++++++
 arch/arm/mach-shmobile/setup-r8a7778.c         |  4 +-
 5 files changed, 92 insertions(+), 86 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/include/mach/r8a7778.h
 create mode 100644 arch/arm/mach-shmobile/r8a7778.h

diff --git a/arch/arm/mach-shmobile/board-bockw-reference.c b/arch/arm/mach-shmobile/board-bockw-reference.c
index 91ff3a2..ba840cd 100644
--- a/arch/arm/mach-shmobile/board-bockw-reference.c
+++ b/arch/arm/mach-shmobile/board-bockw-reference.c
@@ -19,9 +19,11 @@
  */
 
 #include <linux/of_platform.h>
-#include <mach/r8a7778.h>
+
 #include <asm/mach/arch.h>
+
 #include "common.h"
+#include "r8a7778.h"
 
 /*
  *	see board-bock.c for checking detail of dip-switch
diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index 8cb057f..b4e4789 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -34,13 +34,15 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/flash.h>
 #include <linux/usb/renesas_usbhs.h>
+
 #include <media/soc_camera.h>
-#include <mach/r8a7778.h>
 #include <asm/mach/arch.h>
 #include <sound/rcar_snd.h>
 #include <sound/simple_card.h>
+
 #include "common.h"
 #include "irqs.h"
+#include "r8a7778.h"
 
 #define FPGA	0x18200000
 #define IRQ0MR	0x30
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
deleted file mode 100644
index f4076a5..0000000
--- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ /dev/null
@@ -1,83 +0,0 @@
-/*
- * Copyright (C) 2013  Renesas Solutions Corp.
- * Copyright (C) 2013  Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
- * Copyright (C) 2013  Cogent Embedded, Inc.
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
-#ifndef __ASM_R8A7778_H__
-#define __ASM_R8A7778_H__
-
-#include <linux/sh_eth.h>
-
-/* HPB-DMA slave IDs */
-enum {
-	HPBDMA_SLAVE_DUMMY,
-	HPBDMA_SLAVE_SDHI0_TX,
-	HPBDMA_SLAVE_SDHI0_RX,
-	HPBDMA_SLAVE_SSI0_TX,
-	HPBDMA_SLAVE_SSI0_RX,
-	HPBDMA_SLAVE_SSI1_TX,
-	HPBDMA_SLAVE_SSI1_RX,
-	HPBDMA_SLAVE_SSI2_TX,
-	HPBDMA_SLAVE_SSI2_RX,
-	HPBDMA_SLAVE_SSI3_TX,
-	HPBDMA_SLAVE_SSI3_RX,
-	HPBDMA_SLAVE_SSI4_TX,
-	HPBDMA_SLAVE_SSI4_RX,
-	HPBDMA_SLAVE_SSI5_TX,
-	HPBDMA_SLAVE_SSI5_RX,
-	HPBDMA_SLAVE_SSI6_TX,
-	HPBDMA_SLAVE_SSI6_RX,
-	HPBDMA_SLAVE_SSI7_TX,
-	HPBDMA_SLAVE_SSI7_RX,
-	HPBDMA_SLAVE_SSI8_TX,
-	HPBDMA_SLAVE_SSI8_RX,
-	HPBDMA_SLAVE_HPBIF0_TX,
-	HPBDMA_SLAVE_HPBIF0_RX,
-	HPBDMA_SLAVE_HPBIF1_TX,
-	HPBDMA_SLAVE_HPBIF1_RX,
-	HPBDMA_SLAVE_HPBIF2_TX,
-	HPBDMA_SLAVE_HPBIF2_RX,
-	HPBDMA_SLAVE_HPBIF3_TX,
-	HPBDMA_SLAVE_HPBIF3_RX,
-	HPBDMA_SLAVE_HPBIF4_TX,
-	HPBDMA_SLAVE_HPBIF4_RX,
-	HPBDMA_SLAVE_HPBIF5_TX,
-	HPBDMA_SLAVE_HPBIF5_RX,
-	HPBDMA_SLAVE_HPBIF6_TX,
-	HPBDMA_SLAVE_HPBIF6_RX,
-	HPBDMA_SLAVE_HPBIF7_TX,
-	HPBDMA_SLAVE_HPBIF7_RX,
-	HPBDMA_SLAVE_HPBIF8_TX,
-	HPBDMA_SLAVE_HPBIF8_RX,
-	HPBDMA_SLAVE_USBFUNC_TX,
-	HPBDMA_SLAVE_USBFUNC_RX,
-};
-
-extern void r8a7778_add_standard_devices(void);
-extern void r8a7778_add_standard_devices_dt(void);
-extern void r8a7778_add_dt_devices(void);
-
-extern void r8a7778_init_late(void);
-extern void r8a7778_init_delay(void);
-extern void r8a7778_init_irq_dt(void);
-extern void r8a7778_clock_init(void);
-extern void r8a7778_init_irq_extpin(int irlm);
-extern void r8a7778_init_irq_extpin_dt(int irlm);
-extern void r8a7778_pinmux_init(void);
-
-extern int r8a7778_usb_phy_power(bool enable);
-
-#endif /* __ASM_R8A7778_H__ */
diff --git a/arch/arm/mach-shmobile/r8a7778.h b/arch/arm/mach-shmobile/r8a7778.h
new file mode 100644
index 0000000..f4076a5
--- /dev/null
+++ b/arch/arm/mach-shmobile/r8a7778.h
@@ -0,0 +1,83 @@
+/*
+ * Copyright (C) 2013  Renesas Solutions Corp.
+ * Copyright (C) 2013  Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+ * Copyright (C) 2013  Cogent Embedded, Inc.
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
+#ifndef __ASM_R8A7778_H__
+#define __ASM_R8A7778_H__
+
+#include <linux/sh_eth.h>
+
+/* HPB-DMA slave IDs */
+enum {
+	HPBDMA_SLAVE_DUMMY,
+	HPBDMA_SLAVE_SDHI0_TX,
+	HPBDMA_SLAVE_SDHI0_RX,
+	HPBDMA_SLAVE_SSI0_TX,
+	HPBDMA_SLAVE_SSI0_RX,
+	HPBDMA_SLAVE_SSI1_TX,
+	HPBDMA_SLAVE_SSI1_RX,
+	HPBDMA_SLAVE_SSI2_TX,
+	HPBDMA_SLAVE_SSI2_RX,
+	HPBDMA_SLAVE_SSI3_TX,
+	HPBDMA_SLAVE_SSI3_RX,
+	HPBDMA_SLAVE_SSI4_TX,
+	HPBDMA_SLAVE_SSI4_RX,
+	HPBDMA_SLAVE_SSI5_TX,
+	HPBDMA_SLAVE_SSI5_RX,
+	HPBDMA_SLAVE_SSI6_TX,
+	HPBDMA_SLAVE_SSI6_RX,
+	HPBDMA_SLAVE_SSI7_TX,
+	HPBDMA_SLAVE_SSI7_RX,
+	HPBDMA_SLAVE_SSI8_TX,
+	HPBDMA_SLAVE_SSI8_RX,
+	HPBDMA_SLAVE_HPBIF0_TX,
+	HPBDMA_SLAVE_HPBIF0_RX,
+	HPBDMA_SLAVE_HPBIF1_TX,
+	HPBDMA_SLAVE_HPBIF1_RX,
+	HPBDMA_SLAVE_HPBIF2_TX,
+	HPBDMA_SLAVE_HPBIF2_RX,
+	HPBDMA_SLAVE_HPBIF3_TX,
+	HPBDMA_SLAVE_HPBIF3_RX,
+	HPBDMA_SLAVE_HPBIF4_TX,
+	HPBDMA_SLAVE_HPBIF4_RX,
+	HPBDMA_SLAVE_HPBIF5_TX,
+	HPBDMA_SLAVE_HPBIF5_RX,
+	HPBDMA_SLAVE_HPBIF6_TX,
+	HPBDMA_SLAVE_HPBIF6_RX,
+	HPBDMA_SLAVE_HPBIF7_TX,
+	HPBDMA_SLAVE_HPBIF7_RX,
+	HPBDMA_SLAVE_HPBIF8_TX,
+	HPBDMA_SLAVE_HPBIF8_RX,
+	HPBDMA_SLAVE_USBFUNC_TX,
+	HPBDMA_SLAVE_USBFUNC_RX,
+};
+
+extern void r8a7778_add_standard_devices(void);
+extern void r8a7778_add_standard_devices_dt(void);
+extern void r8a7778_add_dt_devices(void);
+
+extern void r8a7778_init_late(void);
+extern void r8a7778_init_delay(void);
+extern void r8a7778_init_irq_dt(void);
+extern void r8a7778_clock_init(void);
+extern void r8a7778_init_irq_extpin(int irlm);
+extern void r8a7778_init_irq_extpin_dt(int irlm);
+extern void r8a7778_pinmux_init(void);
+
+extern int r8a7778_usb_phy_power(bool enable);
+
+#endif /* __ASM_R8A7778_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index d9f4529..2ccc012 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -37,11 +37,13 @@
 #include <linux/usb/ehci_pdriver.h>
 #include <linux/usb/ohci_pdriver.h>
 #include <linux/dma-mapping.h>
-#include <mach/r8a7778.h>
+
 #include <asm/mach/arch.h>
 #include <asm/hardware/cache-l2x0.h>
+
 #include "common.h"
 #include "irqs.h"
+#include "r8a7778.h"
 
 /* SCIF */
 #define R8A7778_SCIF(index, baseaddr, irq)			\
-- 
2.0.0.rc2

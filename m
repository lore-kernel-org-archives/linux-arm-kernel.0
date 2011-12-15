From: manjunath.hadli@ti.com (Manjunath Hadli)
Date: Thu, 15 Dec 2011 17:41:54 +0530
Subject: [PATCH v6 05/11] ARM: davinci: create new common platform header for
 davinci
In-Reply-To: <1323951120-15876-1-git-send-email-manjunath.hadli@ti.com>
References: <1323951120-15876-1-git-send-email-manjunath.hadli@ti.com>
Message-ID: <1323951120-15876-6-git-send-email-manjunath.hadli@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

remove the code from individual platform header files for
dm365, dm355, dm644x and dm646x and consolidate it into a
single and common header file davinci.h.

This reduces the pollution in the include/mach and is consistent
with Russel's suggestions as part of his "pet peaves" mail.

The further patches in the series take  advantage of this consolidation
for easy implementation of IO_ADDRESS elimination.

Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
---
 arch/arm/mach-davinci/board-dm355-evm.c     |    2 +-
 arch/arm/mach-davinci/board-dm355-leopard.c |    2 +-
 arch/arm/mach-davinci/board-dm365-evm.c     |    2 +-
 arch/arm/mach-davinci/board-dm644x-evm.c    |    2 +-
 arch/arm/mach-davinci/board-dm646x-evm.c    |    2 +-
 arch/arm/mach-davinci/board-neuros-osd2.c   |    2 +-
 arch/arm/mach-davinci/board-sffsdr.c        |    2 +-
 arch/arm/mach-davinci/davinci.h             |   87 +++++++++++++++++++++++++++
 arch/arm/mach-davinci/dm355.c               |    2 +-
 arch/arm/mach-davinci/dm365.c               |    2 +-
 arch/arm/mach-davinci/dm644x.c              |    2 +-
 arch/arm/mach-davinci/dm646x.c              |    2 +-
 arch/arm/mach-davinci/include/mach/dm355.h  |   32 ----------
 arch/arm/mach-davinci/include/mach/dm365.h  |   36 -----------
 arch/arm/mach-davinci/include/mach/dm644x.h |   40 ------------
 arch/arm/mach-davinci/include/mach/dm646x.h |   34 ----------
 16 files changed, 98 insertions(+), 153 deletions(-)
 create mode 100644 arch/arm/mach-davinci/davinci.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/dm355.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/dm365.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/dm644x.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/dm646x.h

diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index 4e0e707..7ae0d15 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -26,7 +26,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/dm355.h>
+#include "davinci.h"
 #include <mach/i2c.h>
 #include <mach/serial.h>
 #include <mach/nand.h>
diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-davinci/board-dm355-leopard.c
index ff2d241..56f88de 100644
--- a/arch/arm/mach-davinci/board-dm355-leopard.c
+++ b/arch/arm/mach-davinci/board-dm355-leopard.c
@@ -23,7 +23,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/dm355.h>
+#include "davinci.h"
 #include <mach/i2c.h>
 #include <mach/serial.h>
 #include <mach/nand.h>
diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index 1918ae7..613ed00 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -32,7 +32,7 @@
 #include <asm/mach/arch.h>
 
 #include <mach/mux.h>
-#include <mach/dm365.h>
+#include "davinci.h"
 #include <mach/common.h>
 #include <mach/i2c.h>
 #include <mach/serial.h>
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 0cf8abf..00e8599 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -30,7 +30,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/dm644x.h>
+#include "davinci.h"
 #include <mach/common.h>
 #include <mach/i2c.h>
 #include <mach/serial.h>
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index e574d7f..c0f9ea2 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -36,7 +36,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/dm646x.h>
+#include "davinci.h"
 #include <mach/common.h>
 #include <mach/serial.h>
 #include <mach/i2c.h>
diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
index e5f231a..edc6ff7 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -30,7 +30,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/dm644x.h>
+#include "davinci.h"
 #include <mach/common.h>
 #include <mach/i2c.h>
 #include <mach/serial.h>
diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
index 5dd4da9..122c7aa 100644
--- a/arch/arm/mach-davinci/board-sffsdr.c
+++ b/arch/arm/mach-davinci/board-sffsdr.c
@@ -35,7 +35,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 
-#include <mach/dm644x.h>
+#include "davinci.h"
 #include <mach/common.h>
 #include <mach/i2c.h>
 #include <mach/serial.h>
diff --git a/arch/arm/mach-davinci/davinci.h b/arch/arm/mach-davinci/davinci.h
new file mode 100644
index 0000000..3e6def4
--- /dev/null
+++ b/arch/arm/mach-davinci/davinci.h
@@ -0,0 +1,87 @@
+/*
+ * This file contains the processor specific definitions
+ * of the TI DM644x, DM355, DM365, and DM646x.
+ *
+ * Copyright (C) 2011 Texas Instruments Incorporated
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#ifndef __DAVINCI_H
+#define __DAVINCI_H
+
+#include <mach/asp.h>
+#include <linux/clk.h>
+#include <linux/i2c.h>
+#include <mach/keyscan.h>
+#include <linux/videodev2.h>
+#include <linux/davinci_emac.h>
+#include <linux/platform_device.h>
+#include <media/davinci/vpfe_capture.h>
+#include <media/davinci/vpif_types.h>
+
+/* DM355 base addresses */
+#define DM355_ASYNC_EMIF_CONTROL_BASE	0x01e10000
+#define DM355_ASYNC_EMIF_DATA_CE0_BASE	0x02000000
+
+#define ASP1_TX_EVT_EN	1
+#define ASP1_RX_EVT_EN	2
+
+/* DM365 base addresses */
+#define DM365_ASYNC_EMIF_CONTROL_BASE	0x01d10000
+#define DM365_ASYNC_EMIF_DATA_CE0_BASE	0x02000000
+#define DM365_ASYNC_EMIF_DATA_CE1_BASE	0x04000000
+
+/* DM644x base addresses */
+#define DM644X_ASYNC_EMIF_CONTROL_BASE	0x01e00000
+#define DM644X_ASYNC_EMIF_DATA_CE0_BASE 0x02000000
+#define DM644X_ASYNC_EMIF_DATA_CE1_BASE 0x04000000
+#define DM644X_ASYNC_EMIF_DATA_CE2_BASE 0x06000000
+#define DM644X_ASYNC_EMIF_DATA_CE3_BASE 0x08000000
+
+/* DM646x base addresses */
+#define DM646X_ASYNC_EMIF_CONTROL_BASE	0x20008000
+#define DM646X_ASYNC_EMIF_CS2_SPACE_BASE 0x42000000
+
+/* DM355 function declarations */
+struct spi_board_info;
+
+void __init dm355_init(void);
+void dm355_init_spi0(unsigned chipselect_mask,
+		struct spi_board_info *info, unsigned len);
+void __init dm355_init_asp1(u32 evt_enable, struct snd_platform_data *pdata);
+void dm355_set_vpfe_config(struct vpfe_config *cfg);
+
+/* DM365 function declarations */
+void __init dm365_init(void);
+void __init dm365_init_asp(struct snd_platform_data *pdata);
+void __init dm365_init_vc(struct snd_platform_data *pdata);
+void __init dm365_init_ks(struct davinci_ks_platform_data *pdata);
+void __init dm365_init_rtc(void);
+void dm365_init_spi0(unsigned chipselect_mask,
+			struct spi_board_info *info, unsigned len);
+
+void dm365_set_vpfe_config(struct vpfe_config *cfg);
+
+/* DM644x function declarations */
+void __init dm644x_init(void);
+void __init dm644x_init_asp(struct snd_platform_data *pdata);
+void dm644x_set_vpfe_config(struct vpfe_config *cfg);
+
+/* DM646x function declarations */
+void __init dm646x_init(void);
+void __init dm646x_init_mcasp0(struct snd_platform_data *pdata);
+void __init dm646x_init_mcasp1(struct snd_platform_data *pdata);
+int __init dm646x_init_edma(struct edma_rsv_info *rsv);
+
+void dm646x_video_init(void);
+
+void dm646x_setup_vpif(struct vpif_display_config *,
+		       struct vpif_capture_config *);
+#endif /*__DAVINCI_H */
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index fe520d4..36744ff 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -18,7 +18,7 @@
 
 #include <asm/mach/map.h>
 
-#include <mach/dm355.h>
+#include "davinci.h"
 #include <mach/cputype.h>
 #include <mach/edma.h>
 #include <mach/psc.h>
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 77edee8..3171cd1 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -21,7 +21,7 @@
 
 #include <asm/mach/map.h>
 
-#include <mach/dm365.h>
+#include "davinci.h"
 #include <mach/cputype.h>
 #include <mach/edma.h>
 #include <mach/psc.h>
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 27d1371..b84b220 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -15,7 +15,7 @@
 
 #include <asm/mach/map.h>
 
-#include <mach/dm644x.h>
+#include "davinci.h"
 #include <mach/cputype.h>
 #include <mach/edma.h>
 #include <mach/irqs.h>
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 0560e82..a6a9cde 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -16,7 +16,7 @@
 
 #include <asm/mach/map.h>
 
-#include <mach/dm646x.h>
+#include "davinci.h"
 #include <mach/cputype.h>
 #include <mach/edma.h>
 #include <mach/irqs.h>
diff --git a/arch/arm/mach-davinci/include/mach/dm355.h b/arch/arm/mach-davinci/include/mach/dm355.h
deleted file mode 100644
index 36dff4a..0000000
--- a/arch/arm/mach-davinci/include/mach/dm355.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/*
- * Chip specific defines for DM355 SoC
- *
- * Author: Kevin Hilman, Deep Root Systems, LLC
- *
- * 2007 (c) Deep Root Systems, LLC. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-#ifndef __ASM_ARCH_DM355_H
-#define __ASM_ARCH_DM355_H
-
-#include <mach/hardware.h>
-#include <mach/asp.h>
-#include <media/davinci/vpfe_capture.h>
-
-#define DM355_ASYNC_EMIF_CONTROL_BASE	0x01E10000
-#define DM355_ASYNC_EMIF_DATA_CE0_BASE	0x02000000
-
-#define ASP1_TX_EVT_EN	1
-#define ASP1_RX_EVT_EN	2
-
-struct spi_board_info;
-
-void __init dm355_init(void);
-void dm355_init_spi0(unsigned chipselect_mask,
-		struct spi_board_info *info, unsigned len);
-void __init dm355_init_asp1(u32 evt_enable, struct snd_platform_data *pdata);
-void dm355_set_vpfe_config(struct vpfe_config *cfg);
-
-#endif /* __ASM_ARCH_DM355_H */
diff --git a/arch/arm/mach-davinci/include/mach/dm365.h b/arch/arm/mach-davinci/include/mach/dm365.h
deleted file mode 100644
index 51924de..0000000
--- a/arch/arm/mach-davinci/include/mach/dm365.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/*
- * Copyright (C) 2009 Texas Instruments Incorporated
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation version 2.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-#ifndef __ASM_ARCH_DM365_H
-#define __ASM_ARCH_DM665_H
-
-#include <linux/platform_device.h>
-#include <linux/davinci_emac.h>
-#include <mach/hardware.h>
-#include <mach/asp.h>
-#include <mach/keyscan.h>
-#include <media/davinci/vpfe_capture.h>
-
-#define DM365_ASYNC_EMIF_CONTROL_BASE	0x01D10000
-#define DM365_ASYNC_EMIF_DATA_CE0_BASE	0x02000000
-#define DM365_ASYNC_EMIF_DATA_CE1_BASE	0x04000000
-
-void __init dm365_init(void);
-void __init dm365_init_asp(struct snd_platform_data *pdata);
-void __init dm365_init_vc(struct snd_platform_data *pdata);
-void __init dm365_init_ks(struct davinci_ks_platform_data *pdata);
-void __init dm365_init_rtc(void);
-void dm365_init_spi0(unsigned chipselect_mask,
-			struct spi_board_info *info, unsigned len);
-
-void dm365_set_vpfe_config(struct vpfe_config *cfg);
-#endif /* __ASM_ARCH_DM365_H */
diff --git a/arch/arm/mach-davinci/include/mach/dm644x.h b/arch/arm/mach-davinci/include/mach/dm644x.h
deleted file mode 100644
index 724377f..0000000
--- a/arch/arm/mach-davinci/include/mach/dm644x.h
+++ /dev/null
@@ -1,40 +0,0 @@
-/*
- * This file contains the processor specific definitions
- * of the TI DM644x.
- *
- * Copyright (C) 2008 Texas Instruments.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
- */
-#ifndef __ASM_ARCH_DM644X_H
-#define __ASM_ARCH_DM644X_H
-
-#include <linux/davinci_emac.h>
-#include <mach/hardware.h>
-#include <mach/asp.h>
-#include <media/davinci/vpfe_capture.h>
-
-#define DM644X_ASYNC_EMIF_CONTROL_BASE	0x01E00000
-#define DM644X_ASYNC_EMIF_DATA_CE0_BASE 0x02000000
-#define DM644X_ASYNC_EMIF_DATA_CE1_BASE 0x04000000
-#define DM644X_ASYNC_EMIF_DATA_CE2_BASE 0x06000000
-#define DM644X_ASYNC_EMIF_DATA_CE3_BASE 0x08000000
-
-void __init dm644x_init(void);
-void __init dm644x_init_asp(struct snd_platform_data *pdata);
-void dm644x_set_vpfe_config(struct vpfe_config *cfg);
-
-#endif /* __ASM_ARCH_DM644X_H */
diff --git a/arch/arm/mach-davinci/include/mach/dm646x.h b/arch/arm/mach-davinci/include/mach/dm646x.h
deleted file mode 100644
index eb95864..0000000
--- a/arch/arm/mach-davinci/include/mach/dm646x.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/*
- * Chip specific defines for DM646x SoC
- *
- * Author: Kevin Hilman, Deep Root Systems, LLC
- *
- * 2007 (c) Deep Root Systems, LLC. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-#ifndef __ASM_ARCH_DM646X_H
-#define __ASM_ARCH_DM646X_H
-
-#include <mach/hardware.h>
-#include <mach/asp.h>
-#include <linux/i2c.h>
-#include <linux/videodev2.h>
-#include <linux/davinci_emac.h>
-#include <media/davinci/vpif_types.h>
-
-#define DM646X_ASYNC_EMIF_CONTROL_BASE	0x20008000
-#define DM646X_ASYNC_EMIF_CS2_SPACE_BASE 0x42000000
-
-void __init dm646x_init(void);
-void __init dm646x_init_mcasp0(struct snd_platform_data *pdata);
-void __init dm646x_init_mcasp1(struct snd_platform_data *pdata);
-int __init dm646x_init_edma(struct edma_rsv_info *rsv);
-
-void dm646x_video_init(void);
-
-void dm646x_setup_vpif(struct vpif_display_config *,
-		       struct vpif_capture_config *);
-
-#endif /* __ASM_ARCH_DM646X_H */
-- 
1.6.2.4

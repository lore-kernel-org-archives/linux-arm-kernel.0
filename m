From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:03 +0200
Subject: [PATCH 07/61] ARM: mx3/kzm_arm11_01: fold board header in its only
	user
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-8-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/mach-kzm_arm11_01.c           |   18 ++++++++++-
 arch/arm/plat-mxc/include/mach/board-kzmarm11.h |   39 -----------------------
 2 files changed, 17 insertions(+), 40 deletions(-)
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-kzmarm11.h

diff --git a/arch/arm/mach-mx3/mach-kzm_arm11_01.c b/arch/arm/mach-mx3/mach-kzm_arm11_01.c
index f085d5d..e60f5da 100644
--- a/arch/arm/mach-mx3/mach-kzm_arm11_01.c
+++ b/arch/arm/mach-mx3/mach-kzm_arm11_01.c
@@ -37,7 +37,6 @@
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 
-#include <mach/board-kzmarm11.h>
 #include <mach/clock.h>
 #include <mach/common.h>
 #include <mach/imx-uart.h>
@@ -51,6 +50,23 @@
 	IMX_IO_ADDRESS(x, MX31_CS5) ?:					\
 	MX31_IO_ADDRESS(x))
 
+/*
+ *  KZM-ARM11-01 Board Control Registers on FPGA
+ */
+#define KZM_ARM11_CTL1		(MX31_CS4_BASE_ADDR + 0x1000)
+#define KZM_ARM11_CTL2		(MX31_CS4_BASE_ADDR + 0x1001)
+#define KZM_ARM11_RSW1		(MX31_CS4_BASE_ADDR + 0x1002)
+#define KZM_ARM11_BACK_LIGHT	(MX31_CS4_BASE_ADDR + 0x1004)
+#define KZM_ARM11_FPGA_REV	(MX31_CS4_BASE_ADDR + 0x1008)
+#define KZM_ARM11_7SEG_LED	(MX31_CS4_BASE_ADDR + 0x1010)
+#define KZM_ARM11_LEDS		(MX31_CS4_BASE_ADDR + 0x1020)
+#define KZM_ARM11_DIPSW2	(MX31_CS4_BASE_ADDR + 0x1003)
+
+/*
+ * External UART for touch panel on FPGA
+ */
+#define KZM_ARM11_16550		(MX31_CS4_BASE_ADDR + 0x1050)
+
 #if defined(CONFIG_SERIAL_8250) || defined(CONFIG_SERIAL_8250_MODULE)
 /*
  * KZM-ARM11-01 has an external UART on FPGA
diff --git a/arch/arm/plat-mxc/include/mach/board-kzmarm11.h b/arch/arm/plat-mxc/include/mach/board-kzmarm11.h
deleted file mode 100644
index 93cc66f..0000000
--- a/arch/arm/plat-mxc/include/mach/board-kzmarm11.h
+++ /dev/null
@@ -1,39 +0,0 @@
-/*
- *  Copyright (C) 2009  Yoichi Yuasa <yuasa@linux-mips.org>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-#ifndef __ARM_ARCH_BOARD_KZM_ARM11_H
-#define __ARM_ARCH_BOARD_KZM_ARM11_H
-
-/*
- *  KZM-ARM11-01 Board Control Registers on FPGA
- */
-#define KZM_ARM11_CTL1		(MX31_CS4_BASE_ADDR + 0x1000)
-#define KZM_ARM11_CTL2		(MX31_CS4_BASE_ADDR + 0x1001)
-#define KZM_ARM11_RSW1		(MX31_CS4_BASE_ADDR + 0x1002)
-#define KZM_ARM11_BACK_LIGHT	(MX31_CS4_BASE_ADDR + 0x1004)
-#define KZM_ARM11_FPGA_REV	(MX31_CS4_BASE_ADDR + 0x1008)
-#define KZM_ARM11_7SEG_LED	(MX31_CS4_BASE_ADDR + 0x1010)
-#define KZM_ARM11_LEDS		(MX31_CS4_BASE_ADDR + 0x1020)
-#define KZM_ARM11_DIPSW2	(MX31_CS4_BASE_ADDR + 0x1003)
-
-/*
- * External UART for touch panel on FPGA
- */
-#define KZM_ARM11_16550		(MX31_CS4_BASE_ADDR + 0x1050)
-
-#endif /* __ARM_ARCH_BOARD_KZM_ARM11_H */
-
-- 
1.7.1

From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Wed, 18 Aug 2010 16:40:59 -0700
Subject: [PATCH 6/6] ARM: LPC32XX: Add board.h for platform_data structures
In-Reply-To: <1282174859-8780-1-git-send-email-wellsk40@gmail.com>
References: <1282174859-8780-1-git-send-email-wellsk40@gmail.com>
Message-ID: <1282174859-8780-7-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

Add the initial board.h file to support platform data for
some drivers.

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 arch/arm/mach-lpc32xx/include/mach/board.h |   47 ++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-lpc32xx/include/mach/board.h

diff --git a/arch/arm/mach-lpc32xx/include/mach/board.h b/arch/arm/mach-lpc32xx/include/mach/board.h
new file mode 100644
index 0000000..a810c78
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/include/mach/board.h
@@ -0,0 +1,47 @@
+/*
+ * arch/arm/mach-lpc32xx/include/mach/board.h
+ *
+ * Author: Kevin Wells <kevin.wells@nxp.com>
+ *
+ * Copyright (C) 2010 NXP Semiconductors
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __ASM_ARCH_BOARD_H
+#define __ASM_ARCH_BOARD_H
+
+#include <linux/types.h>
+
+/*
+ * lpc32xx touchscreen controller timing platform data.
+ * All timing values are based on a 32KHz clock.
+ */
+struct lpc32xx_tsc_data {
+	u32	dtr_clocks;	/* Clocks to delay start after pen detect */
+	u32	rtr_clocks;	/* Number of settling clocks after mux */
+	u32	dxp_clocks;	/* Number of drain plate discharge clocks */
+	u32	ttr_clocks;	/* Clocks to delay next pen status check */
+	u32	utr_clocks;	/* Interval clocks between scans */
+};
+
+/*
+ * lpc32xx key scanner timing platform data.
+ * All timing values are based on a 32KHz clock.
+ */
+struct lpc32XX_kscan_data {
+	const u32 *keymap_data;	/* Mapped key data to scanner */
+	u8	matrix_sz;	/* Size of matrix in XxY, ie. 3 = 3x3 */
+	u32	deb_clks;	/* Number of debounce clocks */
+	u32	scan_delay;	/* Number of scan delay clocks */
+};
+
+#endif /* __ASM_ARCH_BOARD_H */
-- 
1.7.1.1

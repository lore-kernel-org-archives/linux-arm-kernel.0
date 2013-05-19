From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sun, 19 May 2013 23:39:34 +0200
Subject: [RFC PATCH 1/5] ARM: mv78x00: Add generic support for the Device Tree
 boards
In-Reply-To: <1368999578-19938-1-git-send-email-gregory.clement@free-electrons.com>
References: <1368999578-19938-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1368999578-19938-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit add the generic support for the MV78X00 based boards
converted to the device tree.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mv78xx0/board-dt.c | 46 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 arch/arm/mach-mv78xx0/board-dt.c

diff --git a/arch/arm/mach-mv78xx0/board-dt.c b/arch/arm/mach-mv78xx0/board-dt.c
new file mode 100644
index 0000000..4995fee
--- /dev/null
+++ b/arch/arm/mach-mv78xx0/board-dt.c
@@ -0,0 +1,46 @@
+/*
+ * arch/arm/mach-mv78xx0/board-dt.c
+ *
+ * Flattened Device Tree board initialization
+ *
+ * Copyright (C) 2013  Gregory CLEMENT <gregory.clement@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <mach/mv78xx0.h>
+#include <plat/irq.h>
+#include <asm/mach/arch.h>
+#include "common.h"
+
+static void __init mv78x00_dt_init(void)
+{
+	/*
+	 * Basic MV78xx0 setup. Needs to be called early.
+	 */
+	mv78xx0_init();
+
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
+static const char *mv78x00_dt_compat[] = {
+	"marvell,mv78x00",
+	NULL,
+};
+
+DT_MACHINE_START(MV78X00_DT, "Marvell MV78x00 (Flattened Device Tree)")
+	/* Maintainer: Gregory CLEMENT <gregory.clement@free-electrons.com> */
+	.init_machine	= mv78x00_dt_init,
+	.map_io		= mv78xx0_map_io,
+	.init_early	= mv78xx0_init_early,
+	.init_irq	= orion_dt_init_irq,
+	.init_time	= mv78xx0_timer_init,
+	.restart	= mv78xx0_restart,
+	.dt_compat	= mv78x00_dt_compat,
+MACHINE_END
-- 
1.8.1.2

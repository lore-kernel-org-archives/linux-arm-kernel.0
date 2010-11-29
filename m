From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 29 Nov 2010 19:59:12 +0800
Subject: [PATCH v2 02/15] ARM: mxs: Add helper definition and function
In-Reply-To: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1291031956-30314-2-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add helper definition and function for MXS-based.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
Changes for v2:
 - Remove cpu.c and reference to mxs_set_cpu_type() from common.h

 arch/arm/mach-mxs/include/mach/common.h  |   32 ++++++++++++++++++++++++++++++
 arch/arm/mach-mxs/include/mach/io.h      |   22 ++++++++++++++++++++
 arch/arm/mach-mxs/include/mach/timex.h   |   21 +++++++++++++++++++
 arch/arm/mach-mxs/include/mach/vmalloc.h |   22 ++++++++++++++++++++
 4 files changed, 97 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mxs/include/mach/common.h
 create mode 100644 arch/arm/mach-mxs/include/mach/io.h
 create mode 100644 arch/arm/mach-mxs/include/mach/timex.h
 create mode 100644 arch/arm/mach-mxs/include/mach/vmalloc.h

diff --git a/arch/arm/mach-mxs/include/mach/common.h b/arch/arm/mach-mxs/include/mach/common.h
new file mode 100644
index 0000000..dca0460
--- /dev/null
+++ b/arch/arm/mach-mxs/include/mach/common.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __MACH_MXS_COMMON_H__
+#define __MACH_MXS_COMMON_H__
+
+struct clk;
+
+extern int mxs_reset_block(void __iomem *);
+extern void mxs_arch_reset_init(void __iomem *);
+extern void mxs_timer_init(struct clk *, void __iomem *, int);
+
+extern int mx23_register_gpios(void);
+extern int mx23_clocks_init(void);
+extern void mx23_map_io(void);
+extern void mx23_init_irq(void);
+
+extern int mx28_register_gpios(void);
+extern int mx28_clocks_init(void);
+extern void mx28_map_io(void);
+extern void mx28_init_irq(void);
+
+extern void icoll_init_irq(void __iomem *);
+
+#endif /* __MACH_MXS_COMMON_H__ */
diff --git a/arch/arm/mach-mxs/include/mach/io.h b/arch/arm/mach-mxs/include/mach/io.h
new file mode 100644
index 0000000..289b722
--- /dev/null
+++ b/arch/arm/mach-mxs/include/mach/io.h
@@ -0,0 +1,22 @@
+/*
+ *  Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __MACH_MXS_IO_H__
+#define __MACH_MXS_IO_H__
+
+/* Allow IO space to be anywhere in the memory */
+#define IO_SPACE_LIMIT 0xffffffff
+
+/* io address mapping macro */
+#define __io(a)		__typesafe_io(a)
+
+#define __mem_pci(a)	(a)
+
+#endif /* __MACH_MXS_IO_H__ */
diff --git a/arch/arm/mach-mxs/include/mach/timex.h b/arch/arm/mach-mxs/include/mach/timex.h
new file mode 100644
index 0000000..734ce89
--- /dev/null
+++ b/arch/arm/mach-mxs/include/mach/timex.h
@@ -0,0 +1,21 @@
+/*
+ *  Copyright (C) 1999 ARM Limited
+ * Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
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
+#ifndef __MACH_MXS_TIMEX_H__
+#define __MACH_MXS_TIMEX_H__
+
+#define CLOCK_TICK_RATE		32000	/* 32K */
+
+#endif /* __MACH_MXS_TIMEX_H__ */
diff --git a/arch/arm/mach-mxs/include/mach/vmalloc.h b/arch/arm/mach-mxs/include/mach/vmalloc.h
new file mode 100644
index 0000000..103b016
--- /dev/null
+++ b/arch/arm/mach-mxs/include/mach/vmalloc.h
@@ -0,0 +1,22 @@
+/*
+ *  Copyright (C) 2000 Russell King.
+ *  Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
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
+#ifndef __MACH_MXS_VMALLOC_H__
+#define __MACH_MXS_VMALLOC_H__
+
+/* vmalloc ending address */
+#define VMALLOC_END       0xf4000000UL
+
+#endif /* __MACH_MXS_VMALLOC_H__ */
-- 
1.7.1

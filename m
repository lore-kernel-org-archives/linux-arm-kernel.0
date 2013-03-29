From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 29 Mar 2013 16:55:47 +0800
Subject: [PATCH 11/13] ARM: mxs: remove common.h
In-Reply-To: <1364547350-30498-1-git-send-email-shawn.guo@linaro.org>
References: <1364547350-30498-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1364547350-30498-12-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All three remaining functions declared in common.h are implemented by
clock driver.  Create header include/linux/clk/mxs.h to contain them
and remove common.h.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-mxs/include/mach/common.h |   20 --------------------
 arch/arm/mach-mxs/mach-mxs.c            |    2 +-
 include/linux/clk/mxs.h                 |   16 ++++++++++++++++
 3 files changed, 17 insertions(+), 21 deletions(-)
 delete mode 100644 arch/arm/mach-mxs/include/mach/common.h
 create mode 100644 include/linux/clk/mxs.h

diff --git a/arch/arm/mach-mxs/include/mach/common.h b/arch/arm/mach-mxs/include/mach/common.h
deleted file mode 100644
index aca982c..0000000
--- a/arch/arm/mach-mxs/include/mach/common.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- * Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
- */
-
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __MACH_MXS_COMMON_H__
-#define __MACH_MXS_COMMON_H__
-
-extern int mxs_saif_clkmux_select(unsigned int clkmux);
-
-extern int mx23_clocks_init(void);
-
-extern int mx28_clocks_init(void);
-
-#endif /* __MACH_MXS_COMMON_H__ */
diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index f442b39..19f732f 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/clk/mxs.h>
 #include <linux/clkdev.h>
 #include <linux/clocksource.h>
 #include <linux/can/platform/flexcan.h>
@@ -30,7 +31,6 @@
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 #include <asm/system_misc.h>
-#include <mach/common.h>
 #include <mach/digctl.h>
 #include <mach/mxs.h>
 
diff --git a/include/linux/clk/mxs.h b/include/linux/clk/mxs.h
new file mode 100644
index 0000000..90c30dc
--- /dev/null
+++ b/include/linux/clk/mxs.h
@@ -0,0 +1,16 @@
+/*
+ * Copyright (C) 2013 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __LINUX_CLK_MXS_H
+#define __LINUX_CLK_MXS_H
+
+int mx23_clocks_init(void);
+int mx28_clocks_init(void);
+int mxs_saif_clkmux_select(unsigned int clkmux);
+
+#endif
-- 
1.7.9.5

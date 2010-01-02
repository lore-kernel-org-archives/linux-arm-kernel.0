From: mcuos.com@gmail.com (Wan ZongShun)
Date: Sat, 02 Jan 2010 23:44:45 +0800
Subject: [PATCH] NUC900: Add extern header file support for some driver
Message-ID: <4B3F69ED.2030404@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Wang Qiang,

This patch provides a API for your LCD driver or other drivers, if you
want to use those APIs, please include corresponding header file.

Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
---
 arch/arm/mach-w90x900/include/mach/clkdev.h |    3 +++
 arch/arm/mach-w90x900/include/mach/mfp.h    |   23 +++++++++++++++++++++++
 2 files changed, 26 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-w90x900/include/mach/mfp.h

diff --git a/arch/arm/mach-w90x900/include/mach/clkdev.h
b/arch/arm/mach-w90x900/include/mach/clkdev.h
index 04b37a8..b35f4bc 100644
--- a/arch/arm/mach-w90x900/include/mach/clkdev.h
+++ b/arch/arm/mach-w90x900/include/mach/clkdev.h
@@ -4,4 +4,7 @@
 #define __clk_get(clk) ({ 1; })
 #define __clk_put(clk) do { } while (0)

+extern void nuc900_driver_clksrc_div(struct device *dev, unsigned char
*src,
+							unsigned char divider);
+
 #endif
diff --git a/arch/arm/mach-w90x900/include/mach/mfp.h
b/arch/arm/mach-w90x900/include/mach/mfp.h
new file mode 100644
index 0000000..69a094a
--- /dev/null
+++ b/arch/arm/mach-w90x900/include/mach/mfp.h
@@ -0,0 +1,23 @@
+/*
+ * arch/arm/mach-w90x900/include/mach/mfp.h
+ *
+ * Copyright (c) 2008 Nuvoton technology corporation
+ * All rights reserved.
+ *
+ * Wan ZongShun <mcuos.com@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+#ifndef __ASM_ARM_MFP_H
+#define __ASM_ARM_MFP_H
+
+extern void mfp_set_groupf(struct device *dev);
+extern void mfp_set_groupc(struct device *dev);
+extern void mfp_set_groupi(struct device *dev);
+extern void mfp_set_groupg(struct device *dev);
+
+#endif /* __ASM_ARM_MFP_H */
-- 
1.5.6.3

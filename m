From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 17 May 2010 08:29:54 +0200
Subject: [PATCH 2/3] ARM: Samsung: move common I2C0 device helpers to machine
	directories
In-Reply-To: <1274077795-30873-1-git-send-email-m.szyprowski@samsung.com>
References: <1274077795-30873-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1274077795-30873-3-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I2C0 device helper depend on GPIO pin defines that are SoC specific.
This patch copies the dummy i2c0 setup code to the respective mach-s5p*
directories, so each SoC will be able to implement using its own
defines.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5p6440/Makefile     |    1 +
 arch/arm/mach-s5p6440/setup-i2c0.c |   25 +++++++++++++++++++++++++
 arch/arm/mach-s5p6442/Makefile     |    1 +
 arch/arm/mach-s5p6442/setup-i2c0.c |   25 +++++++++++++++++++++++++
 arch/arm/mach-s5pv210/Makefile     |    1 +
 arch/arm/mach-s5pv210/setup-i2c0.c |   25 +++++++++++++++++++++++++
 arch/arm/plat-s5p/Makefile         |    1 -
 arch/arm/plat-s5p/setup-i2c0.c     |   25 -------------------------
 8 files changed, 78 insertions(+), 26 deletions(-)
 create mode 100644 arch/arm/mach-s5p6440/setup-i2c0.c
 create mode 100644 arch/arm/mach-s5p6442/setup-i2c0.c
 create mode 100644 arch/arm/mach-s5pv210/setup-i2c0.c
 delete mode 100644 arch/arm/plat-s5p/setup-i2c0.c

diff --git a/arch/arm/mach-s5p6440/Makefile b/arch/arm/mach-s5p6440/Makefile
index 1ad894b..9646cdf 100644
--- a/arch/arm/mach-s5p6440/Makefile
+++ b/arch/arm/mach-s5p6440/Makefile
@@ -13,6 +13,7 @@ obj-				:=
 # Core support for S5P6440 system
 
 obj-$(CONFIG_CPU_S5P6440)	+= cpu.o init.o clock.o gpio.o
+obj-$(CONFIG_CPU_S5P6440)	+= setup-i2c0.o
 
 # machine support
 
diff --git a/arch/arm/mach-s5p6440/setup-i2c0.c b/arch/arm/mach-s5p6440/setup-i2c0.c
new file mode 100644
index 0000000..69e8a66
--- /dev/null
+++ b/arch/arm/mach-s5p6440/setup-i2c0.c
@@ -0,0 +1,25 @@
+/* linux/arch/arm/mach-s5p6440/setup-i2c0.c
+ *
+ * Copyright (c) 2009 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * I2C0 GPIO configuration.
+ *
+ * Based on plat-s3c64xx/setup-i2c0.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+
+struct platform_device; /* don't need the contents */
+
+#include <plat/iic.h>
+
+void s3c_i2c0_cfg_gpio(struct platform_device *dev)
+{
+	/* Will be populated later */
+}
diff --git a/arch/arm/mach-s5p6442/Makefile b/arch/arm/mach-s5p6442/Makefile
index dde39a6..4942c14 100644
--- a/arch/arm/mach-s5p6442/Makefile
+++ b/arch/arm/mach-s5p6442/Makefile
@@ -13,6 +13,7 @@ obj-				:=
 # Core support for S5P6442 system
 
 obj-$(CONFIG_CPU_S5P6442)	+= cpu.o init.o clock.o
+obj-$(CONFIG_CPU_S5P6442)	+= setup-i2c0.o
 
 # machine support
 
diff --git a/arch/arm/mach-s5p6442/setup-i2c0.c b/arch/arm/mach-s5p6442/setup-i2c0.c
new file mode 100644
index 0000000..662695d
--- /dev/null
+++ b/arch/arm/mach-s5p6442/setup-i2c0.c
@@ -0,0 +1,25 @@
+/* linux/arch/arm/mach-s5p6442/setup-i2c0.c
+ *
+ * Copyright (c) 2009 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * I2C0 GPIO configuration.
+ *
+ * Based on plat-s3c64xx/setup-i2c0.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+
+struct platform_device; /* don't need the contents */
+
+#include <plat/iic.h>
+
+void s3c_i2c0_cfg_gpio(struct platform_device *dev)
+{
+	/* Will be populated later */
+}
diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
index 8ebf51c..1a972a5 100644
--- a/arch/arm/mach-s5pv210/Makefile
+++ b/arch/arm/mach-s5pv210/Makefile
@@ -13,6 +13,7 @@ obj-				:=
 # Core support for S5PV210 system
 
 obj-$(CONFIG_CPU_S5PV210)	+= cpu.o init.o clock.o
+obj-$(CONFIG_CPU_S5PV210)	+= setup-i2c0.o
 
 # machine support
 
diff --git a/arch/arm/mach-s5pv210/setup-i2c0.c b/arch/arm/mach-s5pv210/setup-i2c0.c
new file mode 100644
index 0000000..27de0c1
--- /dev/null
+++ b/arch/arm/mach-s5pv210/setup-i2c0.c
@@ -0,0 +1,25 @@
+/*
+ * linux/arch/arm/mach-s5pv210/setup-i2c2.c
+ *
+ * Copyright 2009 Samsung Electronics Co.
+ *
+ * Base S5PV210 I2C bus 0 gpio configuration
+ *
+ * Based on mach-s3c64xx/setup-i2c0.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+
+struct platform_device; /* don't need the contents */
+
+#include <plat/iic.h>
+
+void s3c_i2c0_cfg_gpio(struct platform_device *dev)
+{
+	/* Will be populated later */
+}
diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
index a7c54b3..0ec09a9 100644
--- a/arch/arm/plat-s5p/Makefile
+++ b/arch/arm/plat-s5p/Makefile
@@ -16,4 +16,3 @@ obj-y				+= dev-uart.o
 obj-y				+= cpu.o
 obj-y				+= clock.o
 obj-y				+= irq.o
-obj-y				+= setup-i2c0.o
diff --git a/arch/arm/plat-s5p/setup-i2c0.c b/arch/arm/plat-s5p/setup-i2c0.c
deleted file mode 100644
index 67a66e0..0000000
--- a/arch/arm/plat-s5p/setup-i2c0.c
+++ /dev/null
@@ -1,25 +0,0 @@
-/* linux/arch/arm/plat-s5p/setup-i2c0.c
- *
- * Copyright (c) 2009 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * I2C0 GPIO configuration.
- *
- * Based on plat-s3c64xx/setup-i2c0.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-
-struct platform_device; /* don't need the contents */
-
-#include <plat/iic.h>
-
-void s3c_i2c0_cfg_gpio(struct platform_device *dev)
-{
-	/* Will be populated later */
-}
-- 
1.6.4

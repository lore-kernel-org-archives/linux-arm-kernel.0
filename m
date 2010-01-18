From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 18 Jan 2010 08:45:14 +0000
Subject: [PATCH] ARM: SAMSUNG: Make UART device code common
In-Reply-To: <1263804317-8996-1-git-send-email-ben-linux@fluff.org>
References: <1263804317-8996-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1263804317-8996-5-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move s3c24xx_uart_devs, s3c24xx_uart_src and the platform devices to a
common entry in plat-samsung since they are the same in all the current
implementations.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-s3c24xx/devs.c     |   28 ------------------------
 arch/arm/plat-s3c64xx/dev-uart.c |   29 -------------------------
 arch/arm/plat-s5p/dev-uart.c     |   28 ------------------------
 arch/arm/plat-s5pc1xx/dev-uart.c |   29 -------------------------
 arch/arm/plat-samsung/Makefile   |    1 +
 arch/arm/plat-samsung/dev-uart.c |   44 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 45 insertions(+), 114 deletions(-)
 create mode 100644 arch/arm/plat-samsung/dev-uart.c

diff --git a/arch/arm/plat-s3c24xx/devs.c b/arch/arm/plat-s3c24xx/devs.c
index 7f686a3..38c358c 100644
--- a/arch/arm/plat-s3c24xx/devs.c
+++ b/arch/arm/plat-s3c24xx/devs.c
@@ -112,34 +112,6 @@ struct s3c24xx_uart_resources s3c2410_uart_resources[] __initdata = {
 	},
 };
 
-/* yart devices */
-
-static struct platform_device s3c24xx_uart_device0 = {
-	.id		= 0,
-};
-
-static struct platform_device s3c24xx_uart_device1 = {
-	.id		= 1,
-};
-
-static struct platform_device s3c24xx_uart_device2 = {
-	.id		= 2,
-};
-
-static struct platform_device s3c24xx_uart_device3 = {
-	.id		= 3,
-};
-
-struct platform_device *s3c24xx_uart_src[4] = {
-	&s3c24xx_uart_device0,
-	&s3c24xx_uart_device1,
-	&s3c24xx_uart_device2,
-	&s3c24xx_uart_device3,
-};
-
-struct platform_device *s3c24xx_uart_devs[4] = {
-};
-
 /* LCD Controller */
 
 static struct resource s3c_lcd_resource[] = {
diff --git a/arch/arm/plat-s3c64xx/dev-uart.c b/arch/arm/plat-s3c64xx/dev-uart.c
index 62c11a6..f797f74 100644
--- a/arch/arm/plat-s3c64xx/dev-uart.c
+++ b/arch/arm/plat-s3c64xx/dev-uart.c
@@ -145,32 +145,3 @@ struct s3c24xx_uart_resources s3c64xx_uart_resources[] __initdata = {
 		.nr_resources	= ARRAY_SIZE(s3c64xx_uart3_resource),
 	},
 };
-
-/* uart devices */
-
-static struct platform_device s3c24xx_uart_device0 = {
-	.id		= 0,
-};
-
-static struct platform_device s3c24xx_uart_device1 = {
-	.id		= 1,
-};
-
-static struct platform_device s3c24xx_uart_device2 = {
-	.id		= 2,
-};
-
-static struct platform_device s3c24xx_uart_device3 = {
-	.id		= 3,
-};
-
-struct platform_device *s3c24xx_uart_src[4] = {
-	&s3c24xx_uart_device0,
-	&s3c24xx_uart_device1,
-	&s3c24xx_uart_device2,
-	&s3c24xx_uart_device3,
-};
-
-struct platform_device *s3c24xx_uart_devs[4] = {
-};
-
diff --git a/arch/arm/plat-s5p/dev-uart.c b/arch/arm/plat-s5p/dev-uart.c
index af726f4..23c7531 100644
--- a/arch/arm/plat-s5p/dev-uart.c
+++ b/arch/arm/plat-s5p/dev-uart.c
@@ -135,31 +135,3 @@ struct s3c24xx_uart_resources s5p_uart_resources[] __initdata = {
 		.nr_resources	= ARRAY_SIZE(s5p_uart3_resource),
 	},
 };
-
-/* uart devices */
-
-static struct platform_device s5p_uart_device0 = {
-	.id		= 0,
-};
-
-static struct platform_device s5p_uart_device1 = {
-	.id		= 1,
-};
-
-static struct platform_device s5p_uart_device2 = {
-	.id		= 2,
-};
-
-static struct platform_device s5p_uart_device3 = {
-	.id		= 3,
-};
-
-struct platform_device *s3c24xx_uart_src[4] = {
-	&s5p_uart_device0,
-	&s5p_uart_device1,
-	&s5p_uart_device2,
-	&s5p_uart_device3,
-};
-
-struct platform_device *s3c24xx_uart_devs[4] = {
-};
diff --git a/arch/arm/plat-s5pc1xx/dev-uart.c b/arch/arm/plat-s5pc1xx/dev-uart.c
index f749bc5..586c95c 100644
--- a/arch/arm/plat-s5pc1xx/dev-uart.c
+++ b/arch/arm/plat-s5pc1xx/dev-uart.c
@@ -143,32 +143,3 @@ struct s3c24xx_uart_resources s5pc1xx_uart_resources[] __initdata = {
 		.nr_resources	= ARRAY_SIZE(s5pc1xx_uart3_resource),
 	},
 };
-
-/* uart devices */
-
-static struct platform_device s3c24xx_uart_device0 = {
-	.id		= 0,
-};
-
-static struct platform_device s3c24xx_uart_device1 = {
-	.id		= 1,
-};
-
-static struct platform_device s3c24xx_uart_device2 = {
-	.id		= 2,
-};
-
-static struct platform_device s3c24xx_uart_device3 = {
-	.id		= 3,
-};
-
-struct platform_device *s3c24xx_uart_src[4] = {
-	&s3c24xx_uart_device0,
-	&s3c24xx_uart_device1,
-	&s3c24xx_uart_device2,
-	&s3c24xx_uart_device3,
-};
-
-struct platform_device *s3c24xx_uart_devs[4] = {
-};
-
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index aeb7e12..f834e42 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_S3C_DEV_HSMMC2)	+= dev-hsmmc2.o
 obj-y				+= dev-i2c0.o
 obj-$(CONFIG_S3C_DEV_I2C1)	+= dev-i2c1.o
 obj-$(CONFIG_S3C_DEV_FB)	+= dev-fb.o
+obj-y				+= dev-uart.o
 obj-$(CONFIG_S3C_DEV_USB_HOST)	+= dev-usb.o
 obj-$(CONFIG_S3C_DEV_USB_HSOTG)	+= dev-usb-hsotg.o
 obj-$(CONFIG_S3C_DEV_NAND)	+= dev-nand.o
diff --git a/arch/arm/plat-samsung/dev-uart.c b/arch/arm/plat-samsung/dev-uart.c
new file mode 100644
index 0000000..3776cd9
--- /dev/null
+++ b/arch/arm/plat-samsung/dev-uart.c
@@ -0,0 +1,44 @@
+/* linux/arch/arm/plat-samsung/dev-uart.c
+ *	originally from arch/arm/plat-s3c24xx/devs.c
+ *x
+ * Copyright (c) 2004 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * Base S3C24XX platform device definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+*/
+
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+
+/* uart devices */
+
+static struct platform_device s3c24xx_uart_device0 = {
+	.id		= 0,
+};
+
+static struct platform_device s3c24xx_uart_device1 = {
+	.id		= 1,
+};
+
+static struct platform_device s3c24xx_uart_device2 = {
+	.id		= 2,
+};
+
+static struct platform_device s3c24xx_uart_device3 = {
+	.id		= 3,
+};
+
+struct platform_device *s3c24xx_uart_src[4] = {
+	&s3c24xx_uart_device0,
+	&s3c24xx_uart_device1,
+	&s3c24xx_uart_device2,
+	&s3c24xx_uart_device3,
+};
+
+struct platform_device *s3c24xx_uart_devs[4] = {
+};
-- 
1.6.0.4

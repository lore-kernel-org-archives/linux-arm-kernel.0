From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Fri, 22 Jan 2010 23:47:08 +0100
Subject: [PATCH 1/4] ARM: SAMSUNG: Move mach/ts.h to plat/ts.h
Message-ID: <b2e8f9f71001221447r7feb098fx2e5b06126c1556da@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: SAMSUNG: Move mach/ts.h to plat/ts.h

This moves mach-s3c2410/include/mach/ts.h to plat-samsung/include/plat/ts.h in
order to prepare for s3c64xx support in the touchscreen driver.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 arch/arm/mach-s3c2410/include/mach/ts.h |   21 ---------------------
 arch/arm/mach-s3c2410/mach-h1940.c      |    2 +-
 arch/arm/plat-s3c24xx/devs.c            |    3 +--
 arch/arm/plat-samsung/include/plat/ts.h |   21 +++++++++++++++++++++
 drivers/input/touchscreen/s3c2410_ts.c  |    2 +-
 5 files changed, 24 insertions(+), 25 deletions(-)
 delete mode 100644 arch/arm/mach-s3c2410/include/mach/ts.h
 create mode 100644 arch/arm/plat-samsung/include/plat/ts.h

diff --git a/arch/arm/mach-s3c2410/include/mach/ts.h
b/arch/arm/mach-s3c2410/include/mach/ts.h
deleted file mode 100644
index dc36170..0000000
--- a/arch/arm/mach-s3c2410/include/mach/ts.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* linux/include/asm/arch-s3c2410/ts.h
- *
- * Copyright (c) 2005 Arnaud Patard <arnaud.patard@rtp-net.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARM_TS_H
-#define __ASM_ARM_TS_H
-
-struct s3c2410_ts_mach_info {
-       int             delay;
-       int             presc;
-       int             oversampling_shift;
-};
-
-extern void s3c24xx_ts_set_platdata(struct s3c2410_ts_mach_info *);
-
-#endif /* __ASM_ARM_TS_H */
diff --git a/arch/arm/mach-s3c2410/mach-h1940.c
b/arch/arm/mach-s3c2410/mach-h1940.c
index fbedd07..75e3ffb 100644
--- a/arch/arm/mach-s3c2410/mach-h1940.c
+++ b/arch/arm/mach-s3c2410/mach-h1940.c
@@ -46,7 +46,6 @@
 #include <mach/h1940.h>
 #include <mach/h1940-latch.h>
 #include <mach/fb.h>
-#include <mach/ts.h>
 #include <plat/udc.h>
 #include <plat/iic.h>

@@ -56,6 +55,7 @@
 #include <plat/pll.h>
 #include <plat/pm.h>
 #include <plat/mci.h>
+#include <plat/ts.h>

 static struct map_desc h1940_iodesc[] __initdata = {
 	[0] = {
diff --git a/arch/arm/plat-s3c24xx/devs.c b/arch/arm/plat-s3c24xx/devs.c
index 986d4e5..3e55bdd 100644
--- a/arch/arm/plat-s3c24xx/devs.c
+++ b/arch/arm/plat-s3c24xx/devs.c
@@ -37,8 +37,7 @@
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <plat/regs-spi.h>
-
-#include <mach/ts.h>
+#include <plat/ts.h>

 /* Serial port registrations */

diff --git a/arch/arm/plat-samsung/include/plat/ts.h
b/arch/arm/plat-samsung/include/plat/ts.h
new file mode 100644
index 0000000..8a51675
--- /dev/null
+++ b/arch/arm/plat-samsung/include/plat/ts.h
@@ -0,0 +1,21 @@
+/* arch/arm/plat-samsung/include/plat/ts.h
+ *
+ * Copyright (c) 2005 Arnaud Patard <arnaud.patard@rtp-net.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARM_TS_H
+#define __ASM_ARM_TS_H
+
+struct s3c2410_ts_mach_info {
+       int             delay;
+       int             presc;
+       int             oversampling_shift;
+};
+
+extern void s3c24xx_ts_set_platdata(struct s3c2410_ts_mach_info *);
+
+#endif /* __ASM_ARM_TS_H */
diff --git a/drivers/input/touchscreen/s3c2410_ts.c
b/drivers/input/touchscreen/s3c2410_ts.c
index 6386b44..0cd0ca6 100644
--- a/drivers/input/touchscreen/s3c2410_ts.c
+++ b/drivers/input/touchscreen/s3c2410_ts.c
@@ -38,9 +38,9 @@

 #include <plat/adc.h>
 #include <plat/regs-adc.h>
+#include <plat/ts.h>

 #include <mach/regs-gpio.h>
-#include <mach/ts.h>

 #define TSC_SLEEP  (S3C2410_ADCTSC_PULL_UP_DISABLE | S3C2410_ADCTSC_XY_PST(0))

-- 
1.6.6.1

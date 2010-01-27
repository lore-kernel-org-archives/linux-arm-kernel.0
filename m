From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Wed, 27 Jan 2010 01:19:21 +0100
Subject: [PATCH 1/4 v2] ARM: SAMSUNG: Move mach/ts.h to plat/ts.h
In-Reply-To: <20100126145249.GD9153@trinity.fluff.org>
References: <b2e8f9f71001221447r7feb098fx2e5b06126c1556da@mail.gmail.com>
	<20100126145249.GD9153@trinity.fluff.org>
Message-ID: <b2e8f9f71001261619x59555c05w2afac67a47547f87@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves mach-s3c2410/include/mach/ts.h to plat-samsung/include/plat/ts.h in
order to prepare for s3c64xx support in the touchscreen driver.
---
 arch/arm/mach-s3c2410/mach-h1940.c                 |    2 +-
 arch/arm/plat-s3c24xx/devs.c                       |    3 +--
 .../mach => plat-samsung/include/plat}/ts.h        |    2 +-
 drivers/input/touchscreen/s3c2410_ts.c             |    2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)
 rename arch/arm/{mach-s3c2410/include/mach =>
plat-samsung/include/plat}/ts.h (92%)

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

diff --git a/arch/arm/mach-s3c2410/include/mach/ts.h
b/arch/arm/plat-samsung/include/plat/ts.h
similarity index 92%
rename from arch/arm/mach-s3c2410/include/mach/ts.h
rename to arch/arm/plat-samsung/include/plat/ts.h
index dc36170..8a51675 100644
--- a/arch/arm/mach-s3c2410/include/mach/ts.h
+++ b/arch/arm/plat-samsung/include/plat/ts.h
@@ -1,4 +1,4 @@
-/* linux/include/asm/arch-s3c2410/ts.h
+/* arch/arm/plat-samsung/include/plat/ts.h
  *
  * Copyright (c) 2005 Arnaud Patard <arnaud.patard@rtp-net.org>
  *
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

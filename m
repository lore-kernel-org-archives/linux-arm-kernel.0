From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 30 Sep 2011 21:55:31 +0900
Subject: [PATCH 1/3] ARM: SAMSUNG: Moving each SoC support header files
Message-ID: <019401cc7f70$3ca060f0$b5e122d0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves SoC header files for supporting each SoCs to
plat-samsung directory. This is required to make one plat-
directory for Samsung SoCs.

Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c64xx/cpu.c                        |    4 ++--
 arch/arm/mach-s3c64xx/mach-anw6410.c               |    2 +-
 arch/arm/mach-s3c64xx/mach-crag6410.c              |    2 +-
 arch/arm/mach-s3c64xx/mach-hmt.c                   |    2 +-
 arch/arm/mach-s3c64xx/mach-mini6410.c              |    2 +-
 arch/arm/mach-s3c64xx/mach-ncp.c                   |    2 +-
 arch/arm/mach-s3c64xx/mach-real6410.c              |    2 +-
 arch/arm/mach-s3c64xx/mach-smartq5.c               |    2 +-
 arch/arm/mach-s3c64xx/mach-smartq7.c               |    2 +-
 arch/arm/mach-s3c64xx/mach-smdk6400.c              |    2 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c              |    2 +-
 arch/arm/mach-s3c64xx/s3c6400.c                    |    2 +-
 arch/arm/mach-s3c64xx/s3c6410.c                    |    4 ++--
 .../include/plat/exynos4.h                         |    2 +-
 .../include/plat/s3c2410.h                         |    2 +-
 .../include/plat/s3c2412.h                         |    2 +-
 .../include/plat/s3c2416.h                         |    2 +-
 .../include/plat/s3c2443.h                         |    2 +-
 .../include/plat/s3c244x.h                         |    2 +-
 .../mach => plat-samsung/include/plat}/s3c6400.h   |    2 +-
 .../mach => plat-samsung/include/plat}/s3c6410.h   |    2 +-
 .../include/plat/s5p6440.h                         |    2 +-
 .../include/plat/s5p6450.h                         |    2 +-
 .../include/plat/s5pc100.h                         |    2 +-
 .../include/plat/s5pv210.h                         |    2 +-
 25 files changed, 27 insertions(+), 27 deletions(-)
 rename arch/arm/{plat-s5p => plat-samsung}/include/plat/exynos4.h (94%)
 rename arch/arm/{plat-s3c24xx => plat-samsung}/include/plat/s3c2410.h (93%)
 rename arch/arm/{plat-s3c24xx => plat-samsung}/include/plat/s3c2412.h (92%)
 rename arch/arm/{plat-s3c24xx => plat-samsung}/include/plat/s3c2416.h (92%)
 rename arch/arm/{plat-s3c24xx => plat-samsung}/include/plat/s3c2443.h (96%)
 rename arch/arm/{plat-s3c24xx => plat-samsung}/include/plat/s3c244x.h (94%)
 rename arch/arm/{mach-s3c64xx/include/mach => plat-samsung/include/plat}/s3c6400.h (94%)
 rename arch/arm/{mach-s3c64xx/include/mach => plat-samsung/include/plat}/s3c6410.h (93%)
 rename arch/arm/{plat-s5p => plat-samsung}/include/plat/s5p6440.h (94%)
 rename arch/arm/{plat-s5p => plat-samsung}/include/plat/s5p6450.h (94%)
 rename arch/arm/{plat-s5p => plat-samsung}/include/plat/s5pc100.h (94%)
 rename arch/arm/{plat-s5p => plat-samsung}/include/plat/s5pv210.h (94%)

diff --git a/arch/arm/mach-s3c64xx/cpu.c b/arch/arm/mach-s3c64xx/cpu.c
index 374e45e..f06f33c 100644
--- a/arch/arm/mach-s3c64xx/cpu.c
+++ b/arch/arm/mach-s3c64xx/cpu.c
@@ -33,8 +33,8 @@
 #include <plat/devs.h>
 #include <plat/clock.h>
 
-#include <mach/s3c6400.h>
-#include <mach/s3c6410.h>
+#include <plat/s3c6400.h>
+#include <plat/s3c6410.h>
 
 /* table of supported CPUs */
 
diff --git a/arch/arm/mach-s3c64xx/mach-anw6410.c b/arch/arm/mach-s3c64xx/mach-anw6410.c
index cb88643..d2a68d2 100644
--- a/arch/arm/mach-s3c64xx/mach-anw6410.c
+++ b/arch/arm/mach-s3c64xx/mach-anw6410.c
@@ -45,7 +45,7 @@
 #include <plat/fb.h>
 #include <plat/regs-fb-v4.h>
 
-#include <mach/s3c6410.h>
+#include <plat/s3c6410.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index af0c2fe..45ae2a2 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -43,13 +43,13 @@
 #include <mach/hardware.h>
 #include <mach/map.h>
 
-#include <mach/s3c6410.h>
 #include <mach/regs-sys.h>
 #include <mach/regs-gpio.h>
 #include <mach/regs-modem.h>
 
 #include <mach/regs-gpio-memport.h>
 
+#include <plat/s3c6410.h>
 #include <plat/regs-serial.h>
 #include <plat/regs-fb-v4.h>
 #include <plat/fb.h>
diff --git a/arch/arm/mach-s3c64xx/mach-hmt.c b/arch/arm/mach-s3c64xx/mach-hmt.c
index b3d93cc..61f4fde 100644
--- a/arch/arm/mach-s3c64xx/mach-hmt.c
+++ b/arch/arm/mach-s3c64xx/mach-hmt.c
@@ -37,7 +37,7 @@
 #include <plat/fb.h>
 #include <plat/nand.h>
 
-#include <mach/s3c6410.h>
+#include <plat/s3c6410.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-s3c64xx/mach-mini6410.c
index 527f49b..5233a27 100644
--- a/arch/arm/mach-s3c64xx/mach-mini6410.c
+++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
@@ -32,8 +32,8 @@
 #include <mach/regs-gpio.h>
 #include <mach/regs-modem.h>
 #include <mach/regs-srom.h>
-#include <mach/s3c6410.h>
 
+#include <plat/s3c6410.h>
 #include <plat/adc.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
diff --git a/arch/arm/mach-s3c64xx/mach-ncp.c b/arch/arm/mach-s3c64xx/mach-ncp.c
index 01c6857..0f4316a 100644
--- a/arch/arm/mach-s3c64xx/mach-ncp.c
+++ b/arch/arm/mach-s3c64xx/mach-ncp.c
@@ -39,7 +39,7 @@
 #include <plat/iic.h>
 #include <plat/fb.h>
 
-#include <mach/s3c6410.h>
+#include <plat/s3c6410.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-s3c64xx/mach-real6410.c
index 95b04b1..56b5852 100644
--- a/arch/arm/mach-s3c64xx/mach-real6410.c
+++ b/arch/arm/mach-s3c64xx/mach-real6410.c
@@ -33,8 +33,8 @@
 #include <mach/regs-gpio.h>
 #include <mach/regs-modem.h>
 #include <mach/regs-srom.h>
-#include <mach/s3c6410.h>
 
+#include <plat/s3c6410.h>
 #include <plat/adc.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
diff --git a/arch/arm/mach-s3c64xx/mach-smartq5.c b/arch/arm/mach-s3c64xx/mach-smartq5.c
index 342e8df..30e906b 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq5.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq5.c
@@ -22,8 +22,8 @@
 
 #include <mach/map.h>
 #include <mach/regs-gpio.h>
-#include <mach/s3c6410.h>
 
+#include <plat/s3c6410.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/fb.h>
diff --git a/arch/arm/mach-s3c64xx/mach-smartq7.c b/arch/arm/mach-s3c64xx/mach-smartq7.c
index 5796397..9a71c2b 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq7.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq7.c
@@ -22,8 +22,8 @@
 
 #include <mach/map.h>
 #include <mach/regs-gpio.h>
-#include <mach/s3c6410.h>
 
+#include <plat/s3c6410.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/fb.h>
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6400.c b/arch/arm/mach-s3c64xx/mach-smdk6400.c
index 3cca642..fc7cb03 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6400.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6400.c
@@ -31,7 +31,7 @@
 
 #include <plat/regs-serial.h>
 
-#include <mach/s3c6400.h>
+#include <plat/s3c6400.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index a9f3183..227f414 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -63,7 +63,7 @@
 #include <plat/fb.h>
 #include <plat/gpio-cfg.h>
 
-#include <mach/s3c6410.h>
+#include <plat/s3c6410.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
diff --git a/arch/arm/mach-s3c64xx/s3c6400.c b/arch/arm/mach-s3c64xx/s3c6400.c
index 5e93fe3..7a3bc32 100644
--- a/arch/arm/mach-s3c64xx/s3c6400.c
+++ b/arch/arm/mach-s3c64xx/s3c6400.c
@@ -38,7 +38,7 @@
 #include <plat/sdhci.h>
 #include <plat/iic-core.h>
 #include <plat/onenand-core.h>
-#include <mach/s3c6400.h>
+#include <plat/s3c6400.h>
 
 void __init s3c6400_map_io(void)
 {
diff --git a/arch/arm/mach-s3c64xx/s3c6410.c b/arch/arm/mach-s3c64xx/s3c6410.c
index 312aa6b..4117003 100644
--- a/arch/arm/mach-s3c64xx/s3c6410.c
+++ b/arch/arm/mach-s3c64xx/s3c6410.c
@@ -41,8 +41,8 @@
 #include <plat/adc-core.h>
 #include <plat/iic-core.h>
 #include <plat/onenand-core.h>
-#include <mach/s3c6400.h>
-#include <mach/s3c6410.h>
+#include <plat/s3c6400.h>
+#include <plat/s3c6410.h>
 
 void __init s3c6410_map_io(void)
 {
diff --git a/arch/arm/plat-s5p/include/plat/exynos4.h b/arch/arm/plat-samsung/include/plat/exynos4.h
similarity index 94%
rename from arch/arm/plat-s5p/include/plat/exynos4.h
rename to arch/arm/plat-samsung/include/plat/exynos4.h
index 907caab..691a711 100644
--- a/arch/arm/plat-s5p/include/plat/exynos4.h
+++ b/arch/arm/plat-samsung/include/plat/exynos4.h
@@ -1,4 +1,4 @@
-/* linux/arch/arm/plat-s5p/include/plat/exynos4.h
+/* linux/arch/arm/plat-samsung/include/plat/exynos4.h
  *
  * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
diff --git a/arch/arm/plat-s3c24xx/include/plat/s3c2410.h b/arch/arm/plat-samsung/include/plat/s3c2410.h
similarity index 93%
rename from arch/arm/plat-s3c24xx/include/plat/s3c2410.h
rename to arch/arm/plat-samsung/include/plat/s3c2410.h
index 82ab4aa..3986497 100644
--- a/arch/arm/plat-s3c24xx/include/plat/s3c2410.h
+++ b/arch/arm/plat-samsung/include/plat/s3c2410.h
@@ -1,4 +1,4 @@
-/* linux/include/asm-arm/plat-s3c24xx/s3c2410.h
+/* linux/arch/arm/plat-samsung/include/plat/s3c2410.h
  *
  * Copyright (c) 2004 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
diff --git a/arch/arm/plat-s3c24xx/include/plat/s3c2412.h b/arch/arm/plat-samsung/include/plat/s3c2412.h
similarity index 92%
rename from arch/arm/plat-s3c24xx/include/plat/s3c2412.h
rename to arch/arm/plat-samsung/include/plat/s3c2412.h
index bb15d3b..5bcfd14 100644
--- a/arch/arm/plat-s3c24xx/include/plat/s3c2412.h
+++ b/arch/arm/plat-samsung/include/plat/s3c2412.h
@@ -1,4 +1,4 @@
-/* linux/include/asm-arm/plat-s3c24xx/s3c2412.h
+/* linux/arch/arm/plat-samsung/include/plat/s3c2412.h
  *
  * Copyright (c) 2006 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
diff --git a/arch/arm/plat-s3c24xx/include/plat/s3c2416.h b/arch/arm/plat-samsung/include/plat/s3c2416.h
similarity index 92%
rename from arch/arm/plat-s3c24xx/include/plat/s3c2416.h
rename to arch/arm/plat-samsung/include/plat/s3c2416.h
index dc3c090..a764f85 100644
--- a/arch/arm/plat-s3c24xx/include/plat/s3c2416.h
+++ b/arch/arm/plat-samsung/include/plat/s3c2416.h
@@ -1,4 +1,4 @@
-/* linux/include/asm-arm/plat-s3c24xx/s3c2443.h
+/* linux/arch/arm/plat-samsung/include/plat/s3c2416.h
  *
  * Copyright (c) 2009 Yauhen Kharuzhy <jekhor@gmail.com>
  *
diff --git a/arch/arm/plat-s3c24xx/include/plat/s3c2443.h b/arch/arm/plat-samsung/include/plat/s3c2443.h
similarity index 96%
rename from arch/arm/plat-s3c24xx/include/plat/s3c2443.h
rename to arch/arm/plat-samsung/include/plat/s3c2443.h
index a19715f..4b2ac9a 100644
--- a/arch/arm/plat-s3c24xx/include/plat/s3c2443.h
+++ b/arch/arm/plat-samsung/include/plat/s3c2443.h
@@ -1,4 +1,4 @@
-/* linux/include/asm-arm/plat-s3c24xx/s3c2443.h
+/* linux/arch/arm/plat-samsung/include/plat/s3c2443.h
  *
  * Copyright (c) 2004-2005 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
diff --git a/arch/arm/plat-s3c24xx/include/plat/s3c244x.h b/arch/arm/plat-samsung/include/plat/s3c244x.h
similarity index 94%
rename from arch/arm/plat-s3c24xx/include/plat/s3c244x.h
rename to arch/arm/plat-samsung/include/plat/s3c244x.h
index 89e8d0a..ea0c961 100644
--- a/arch/arm/plat-s3c24xx/include/plat/s3c244x.h
+++ b/arch/arm/plat-samsung/include/plat/s3c244x.h
@@ -1,4 +1,4 @@
-/* linux/arch/arm/plat-s3c24xx/include/plat/s3c244x.h
+/* linux/arch/arm/plat-samsung/include/plat/s3c244x.h
  *
  * Copyright (c) 2004-2005 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
diff --git a/arch/arm/mach-s3c64xx/include/mach/s3c6400.h b/arch/arm/plat-samsung/include/plat/s3c6400.h
similarity index 94%
rename from arch/arm/mach-s3c64xx/include/mach/s3c6400.h
rename to arch/arm/plat-samsung/include/plat/s3c6400.h
index f86958d..37d428a 100644
--- a/arch/arm/mach-s3c64xx/include/mach/s3c6400.h
+++ b/arch/arm/plat-samsung/include/plat/s3c6400.h
@@ -1,4 +1,4 @@
-/* arch/arm/mach-s3c64xx/include/macht/s3c6400.h
+/* linux/arch/arm/plat-samsung/include/plat/s3c6400.h
  *
  * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
diff --git a/arch/arm/mach-s3c64xx/include/mach/s3c6410.h b/arch/arm/plat-samsung/include/plat/s3c6410.h
similarity index 93%
rename from arch/arm/mach-s3c64xx/include/mach/s3c6410.h
rename to arch/arm/plat-samsung/include/plat/s3c6410.h
index 24f1141..20a6675 100644
--- a/arch/arm/mach-s3c64xx/include/mach/s3c6410.h
+++ b/arch/arm/plat-samsung/include/plat/s3c6410.h
@@ -1,4 +1,4 @@
-/* arch/arm/mach-s3c64xx/include/mach/s3c6410.h
+/* linux/arch/arm/plat-samsung/include/plat/s3c6410.h
  *
  * Copyright 2008 Openmoko,  Inc.
  * Copyright 2008 Simtec Electronics
diff --git a/arch/arm/plat-s5p/include/plat/s5p6440.h b/arch/arm/plat-samsung/include/plat/s5p6440.h
similarity index 94%
rename from arch/arm/plat-s5p/include/plat/s5p6440.h
rename to arch/arm/plat-samsung/include/plat/s5p6440.h
index 528585d..bf85ebb 100644
--- a/arch/arm/plat-s5p/include/plat/s5p6440.h
+++ b/arch/arm/plat-samsung/include/plat/s5p6440.h
@@ -1,4 +1,4 @@
-/* arch/arm/plat-s5p/include/plat/s5p6440.h
+/* linux/arch/arm/plat-samsung/include/plat/s5p6440.h
  *
  * Copyright (c) 2009 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
diff --git a/arch/arm/plat-s5p/include/plat/s5p6450.h b/arch/arm/plat-samsung/include/plat/s5p6450.h
similarity index 94%
rename from arch/arm/plat-s5p/include/plat/s5p6450.h
rename to arch/arm/plat-samsung/include/plat/s5p6450.h
index 640a41c..da25f9a 100644
--- a/arch/arm/plat-s5p/include/plat/s5p6450.h
+++ b/arch/arm/plat-samsung/include/plat/s5p6450.h
@@ -1,4 +1,4 @@
-/* arch/arm/plat-s5p/include/plat/s5p6450.h
+/* linux/arch/arm/plat-samsung/include/plat/s5p6450.h
  *
  * Copyright (c) 2010 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
diff --git a/arch/arm/plat-s5p/include/plat/s5pc100.h b/arch/arm/plat-samsung/include/plat/s5pc100.h
similarity index 94%
rename from arch/arm/plat-s5p/include/plat/s5pc100.h
rename to arch/arm/plat-samsung/include/plat/s5pc100.h
index 5f6099d..9a21aea 100644
--- a/arch/arm/plat-s5p/include/plat/s5pc100.h
+++ b/arch/arm/plat-samsung/include/plat/s5pc100.h
@@ -1,4 +1,4 @@
-/* arch/arm/plat-s5p/include/plat/s5pc100.h
+/* linux/arch/arm/plat-samsung/include/plat/s5pc100.h
  *
  * Copyright (c) 2010 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
diff --git a/arch/arm/plat-s5p/include/plat/s5pv210.h b/arch/arm/plat-samsung/include/plat/s5pv210.h
similarity index 94%
rename from arch/arm/plat-s5p/include/plat/s5pv210.h
rename to arch/arm/plat-samsung/include/plat/s5pv210.h
index 6c93a0c..b4bc6be 100644
--- a/arch/arm/plat-s5p/include/plat/s5pv210.h
+++ b/arch/arm/plat-samsung/include/plat/s5pv210.h
@@ -1,4 +1,4 @@
-/* linux/arch/arm/plat-s5p/include/plat/s5pv210.h
+/* linux/arch/arm/plat-samsung/include/plat/s5pv210.h
  *
  * Copyright (c) 2010 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
-- 
1.7.1

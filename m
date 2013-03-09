From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat,  9 Mar 2013 21:23:13 +0100
Subject: [PATCH v3 04/12] ARM: SAMSUNG: Move samsung-time.h header to
 inlude/clocksource
In-Reply-To: <1362860601-18464-1-git-send-email-tomasz.figa@gmail.com>
References: <1362860601-18464-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1362860601-18464-5-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves the samsung-time.h header file to include/clocksource
directory and fixes all references to it.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/mach-exynos/mach-universal_c210.c        |  2 +-
 arch/arm/mach-s3c24xx/common.c                    |  2 +-
 arch/arm/mach-s3c24xx/mach-amlm5900.c             |  2 +-
 arch/arm/mach-s3c24xx/mach-anubis.c               |  2 +-
 arch/arm/mach-s3c24xx/mach-at2440evb.c            |  2 +-
 arch/arm/mach-s3c24xx/mach-bast.c                 |  2 +-
 arch/arm/mach-s3c24xx/mach-gta02.c                |  2 +-
 arch/arm/mach-s3c24xx/mach-h1940.c                |  2 +-
 arch/arm/mach-s3c24xx/mach-jive.c                 |  2 +-
 arch/arm/mach-s3c24xx/mach-mini2440.c             |  2 +-
 arch/arm/mach-s3c24xx/mach-n30.c                  |  2 +-
 arch/arm/mach-s3c24xx/mach-nexcoder.c             |  2 +-
 arch/arm/mach-s3c24xx/mach-osiris.c               |  2 +-
 arch/arm/mach-s3c24xx/mach-otom.c                 |  2 +-
 arch/arm/mach-s3c24xx/mach-qt2410.c               |  2 +-
 arch/arm/mach-s3c24xx/mach-rx1950.c               |  2 +-
 arch/arm/mach-s3c24xx/mach-rx3715.c               |  2 +-
 arch/arm/mach-s3c24xx/mach-smdk2410.c             |  2 +-
 arch/arm/mach-s3c24xx/mach-smdk2413.c             |  2 +-
 arch/arm/mach-s3c24xx/mach-smdk2416.c             |  2 +-
 arch/arm/mach-s3c24xx/mach-smdk2440.c             |  2 +-
 arch/arm/mach-s3c24xx/mach-smdk2443.c             |  2 +-
 arch/arm/mach-s3c24xx/mach-tct_hammer.c           |  2 +-
 arch/arm/mach-s3c24xx/mach-vr1000.c               |  2 +-
 arch/arm/mach-s3c24xx/mach-vstms.c                |  2 +-
 arch/arm/mach-s3c64xx/common.c                    |  2 +-
 arch/arm/mach-s3c64xx/mach-anw6410.c              |  2 +-
 arch/arm/mach-s3c64xx/mach-crag6410.c             |  2 +-
 arch/arm/mach-s3c64xx/mach-hmt.c                  |  2 +-
 arch/arm/mach-s3c64xx/mach-mini6410.c             |  2 +-
 arch/arm/mach-s3c64xx/mach-ncp.c                  |  2 +-
 arch/arm/mach-s3c64xx/mach-real6410.c             |  2 +-
 arch/arm/mach-s3c64xx/mach-smartq.c               |  2 +-
 arch/arm/mach-s3c64xx/mach-smartq5.c              |  2 +-
 arch/arm/mach-s3c64xx/mach-smartq7.c              |  2 +-
 arch/arm/mach-s3c64xx/mach-smdk6400.c             |  2 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c             |  2 +-
 arch/arm/mach-s5p64x0/common.c                    |  2 +-
 arch/arm/mach-s5p64x0/mach-smdk6440.c             |  2 +-
 arch/arm/mach-s5p64x0/mach-smdk6450.c             |  2 +-
 arch/arm/mach-s5pc100/common.c                    |  2 +-
 arch/arm/mach-s5pc100/mach-smdkc100.c             |  2 +-
 arch/arm/mach-s5pv210/common.c                    |  2 +-
 arch/arm/mach-s5pv210/mach-aquila.c               |  2 +-
 arch/arm/mach-s5pv210/mach-goni.c                 |  2 +-
 arch/arm/mach-s5pv210/mach-smdkc110.c             |  2 +-
 arch/arm/mach-s5pv210/mach-smdkv210.c             |  2 +-
 arch/arm/mach-s5pv210/mach-torbreck.c             |  2 +-
 arch/arm/plat-samsung/include/plat/samsung-time.h | 49 -----------------------
 drivers/clocksource/samsung-time.c                |  3 +-
 include/clocksource/samsung-time.h                | 49 +++++++++++++++++++++++
 51 files changed, 99 insertions(+), 98 deletions(-)
 delete mode 100644 arch/arm/plat-samsung/include/plat/samsung-time.h
 create mode 100644 include/clocksource/samsung-time.h

diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/mach-exynos/mach-universal_c210.c
index 00554fe..8ce1206 100644
--- a/arch/arm/mach-exynos/mach-universal_c210.c
+++ b/arch/arm/mach-exynos/mach-universal_c210.c
@@ -41,7 +41,7 @@
 #include <plat/mfc.h>
 #include <plat/sdhci.h>
 #include <plat/fimc-core.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 #include <plat/camport.h>
 
 #include <mach/map.h>
diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
index 816428f..fe054d6 100644
--- a/arch/arm/mach-s3c24xx/common.c
+++ b/arch/arm/mach-s3c24xx/common.c
@@ -49,7 +49,7 @@
 #include <plat/clock.h>
 #include <plat/cpu-freq.h>
 #include <plat/pll.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-s3c24xx/mach-amlm5900.c b/arch/arm/mach-s3c24xx/mach-amlm5900.c
index e27b5c9..dc720ad 100644
--- a/arch/arm/mach-s3c24xx/mach-amlm5900.c
+++ b/arch/arm/mach-s3c24xx/mach-amlm5900.c
@@ -63,7 +63,7 @@
 #include <linux/mtd/map.h>
 #include <linux/mtd/physmap.h>
 
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-s3c24xx/mach-anubis.c b/arch/arm/mach-s3c24xx/mach-anubis.c
index c1fb6c3..47a7bc3 100644
--- a/arch/arm/mach-s3c24xx/mach-anubis.c
+++ b/arch/arm/mach-s3c24xx/mach-anubis.c
@@ -49,7 +49,7 @@
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <linux/platform_data/asoc-s3c24xx_simtec.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 
 #include "anubis.h"
 #include "common.h"
diff --git a/arch/arm/mach-s3c24xx/mach-at2440evb.c b/arch/arm/mach-s3c24xx/mach-at2440evb.c
index 6dfeeb7..756fed4 100644
--- a/arch/arm/mach-s3c24xx/mach-at2440evb.c
+++ b/arch/arm/mach-s3c24xx/mach-at2440evb.c
@@ -48,7 +48,7 @@
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <linux/platform_data/mmc-s3cmci.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-s3c24xx/mach-bast.c b/arch/arm/mach-s3c24xx/mach-bast.c
index 22d6ae9..82ed39e 100644
--- a/arch/arm/mach-s3c24xx/mach-bast.c
+++ b/arch/arm/mach-s3c24xx/mach-bast.c
@@ -55,7 +55,7 @@
 #include <plat/devs.h>
 #include <plat/gpio-cfg.h>
 #include <plat/regs-serial.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 
 #include "bast.h"
 #include "common.h"
diff --git a/arch/arm/mach-s3c24xx/mach-gta02.c b/arch/arm/mach-s3c24xx/mach-gta02.c
index 13d8d07..b3d5c89 100644
--- a/arch/arm/mach-s3c24xx/mach-gta02.c
+++ b/arch/arm/mach-s3c24xx/mach-gta02.c
@@ -81,7 +81,7 @@
 #include <plat/gpio-cfg.h>
 #include <plat/pm.h>
 #include <plat/regs-serial.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 
 #include "common.h"
 #include "gta02.h"
diff --git a/arch/arm/mach-s3c24xx/mach-h1940.c b/arch/arm/mach-s3c24xx/mach-h1940.c
index af4334d..c0c24e9 100644
--- a/arch/arm/mach-s3c24xx/mach-h1940.c
+++ b/arch/arm/mach-s3c24xx/mach-h1940.c
@@ -62,7 +62,7 @@
 #include <plat/pll.h>
 #include <plat/pm.h>
 #include <plat/regs-serial.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 
 #include "common.h"
 #include "h1940.h"
diff --git a/arch/arm/mach-s3c24xx/mach-jive.c b/arch/arm/mach-s3c24xx/mach-jive.c
index a45fcd8..63b7359 100644
--- a/arch/arm/mach-s3c24xx/mach-jive.c
+++ b/arch/arm/mach-s3c24xx/mach-jive.c
@@ -52,7 +52,7 @@
 #include <plat/cpu.h>
 #include <plat/pm.h>
 #include <linux/platform_data/usb-s3c2410_udc.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 
 #include "common.h"
 #include "s3c2412-power.h"
diff --git a/arch/arm/mach-s3c24xx/mach-mini2440.c b/arch/arm/mach-s3c24xx/mach-mini2440.c
index a83db46..be78d62 100644
--- a/arch/arm/mach-s3c24xx/mach-mini2440.c
+++ b/arch/arm/mach-s3c24xx/mach-mini2440.c
@@ -56,7 +56,7 @@
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 
 #include <sound/s3c24xx_uda134x.h>
 
diff --git a/arch/arm/mach-s3c24xx/mach-n30.c b/arch/arm/mach-s3c24xx/mach-n30.c
index 2cb46c3..c19e6a5 100644
--- a/arch/arm/mach-s3c24xx/mach-n30.c
+++ b/arch/arm/mach-s3c24xx/mach-n30.c
@@ -49,7 +49,7 @@
 #include <plat/devs.h>
 #include <linux/platform_data/mmc-s3cmci.h>
 #include <linux/platform_data/usb-s3c2410_udc.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-s3c24xx/mach-nexcoder.c b/arch/arm/mach-s3c24xx/mach-nexcoder.c
index 01f4354..7ef69a7 100644
--- a/arch/arm/mach-s3c24xx/mach-nexcoder.c
+++ b/arch/arm/mach-s3c24xx/mach-nexcoder.c
@@ -44,7 +44,7 @@
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-s3c24xx/mach-osiris.c b/arch/arm/mach-s3c24xx/mach-osiris.c
index 58d6fbe..7edd42d 100644
--- a/arch/arm/mach-s3c24xx/mach-osiris.c
+++ b/arch/arm/mach-s3c24xx/mach-osiris.c
@@ -45,7 +45,7 @@
 #include <plat/devs.h>
 #include <plat/gpio-cfg.h>
 #include <plat/regs-serial.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 
 #include <mach/hardware.h>
 #include <mach/regs-gpio.h>
diff --git a/arch/arm/mach-s3c24xx/mach-otom.c b/arch/arm/mach-s3c24xx/mach-otom.c
index 7e16b07..1491c6d 100644
--- a/arch/arm/mach-s3c24xx/mach-otom.c
+++ b/arch/arm/mach-s3c24xx/mach-otom.c
@@ -33,7 +33,7 @@
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/regs-serial.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 
 #include "common.h"
 #include "otom.h"
diff --git a/arch/arm/mach-s3c24xx/mach-qt2410.c b/arch/arm/mach-s3c24xx/mach-qt2410.c
index f8feaea..ef29d6a 100644
--- a/arch/arm/mach-s3c24xx/mach-qt2410.c
+++ b/arch/arm/mach-s3c24xx/mach-qt2410.c
@@ -59,7 +59,7 @@
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <plat/pm.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 
 #include "common.h"
 #include "common-smdk.h"
diff --git a/arch/arm/mach-s3c24xx/mach-rx1950.c b/arch/arm/mach-s3c24xx/mach-rx1950.c
index e4d67a3..6900654 100644
--- a/arch/arm/mach-s3c24xx/mach-rx1950.c
+++ b/arch/arm/mach-s3c24xx/mach-rx1950.c
@@ -58,7 +58,7 @@
 #include <plat/pm.h>
 #include <plat/regs-iic.h>
 #include <plat/regs-serial.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 
 #include "common.h"
 #include "h1940.h"
diff --git a/arch/arm/mach-s3c24xx/mach-rx3715.c b/arch/arm/mach-s3c24xx/mach-rx3715.c
index 3bc6231..922d517 100644
--- a/arch/arm/mach-s3c24xx/mach-rx3715.c
+++ b/arch/arm/mach-s3c24xx/mach-rx3715.c
@@ -49,7 +49,7 @@
 #include <plat/devs.h>
 #include <plat/pm.h>
 #include <plat/regs-serial.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 
 #include "common.h"
 #include "h1940.h"
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2410.c b/arch/arm/mach-s3c24xx/mach-smdk2410.c
index a773789..048553d 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2410.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2410.c
@@ -51,7 +51,7 @@
 
 #include <plat/devs.h>
 #include <plat/cpu.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 
 #include "common.h"
 #include "common-smdk.h"
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2413.c b/arch/arm/mach-s3c24xx/mach-smdk2413.c
index 8146e92..e3b3bcd 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2413.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2413.c
@@ -44,7 +44,7 @@
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 
 #include "common.h"
 #include "common-smdk.h"
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2416.c b/arch/arm/mach-s3c24xx/mach-smdk2416.c
index cb46847..b4ec1a0 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2416.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2416.c
@@ -50,7 +50,7 @@
 #include <plat/sdhci.h>
 #include <linux/platform_data/usb-s3c2410_udc.h>
 #include <linux/platform_data/s3c-hsudc.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 
 #include <plat/fb.h>
 
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2440.c b/arch/arm/mach-s3c24xx/mach-smdk2440.c
index de2e5d3..81dbeee 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2440.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2440.c
@@ -41,7 +41,7 @@
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 
 #include "common.h"
 #include "common-smdk.h"
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2443.c b/arch/arm/mach-s3c24xx/mach-smdk2443.c
index 9435c3b..aff1d3e 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2443.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2443.c
@@ -41,7 +41,7 @@
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 
 #include "common.h"
 #include "common-smdk.h"
diff --git a/arch/arm/mach-s3c24xx/mach-tct_hammer.c b/arch/arm/mach-s3c24xx/mach-tct_hammer.c
index 7fad8f0..d67c14d 100644
--- a/arch/arm/mach-s3c24xx/mach-tct_hammer.c
+++ b/arch/arm/mach-s3c24xx/mach-tct_hammer.c
@@ -53,7 +53,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/map.h>
 #include <linux/mtd/physmap.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-s3c24xx/mach-vr1000.c b/arch/arm/mach-s3c24xx/mach-vr1000.c
index 42e7187..c1cdd8c 100644
--- a/arch/arm/mach-s3c24xx/mach-vr1000.c
+++ b/arch/arm/mach-s3c24xx/mach-vr1000.c
@@ -45,7 +45,7 @@
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/regs-serial.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 
 #include "bast.h"
 #include "common.h"
diff --git a/arch/arm/mach-s3c24xx/mach-vstms.c b/arch/arm/mach-s3c24xx/mach-vstms.c
index b665884..dc6a5ee 100644
--- a/arch/arm/mach-s3c24xx/mach-vstms.c
+++ b/arch/arm/mach-s3c24xx/mach-vstms.c
@@ -44,7 +44,7 @@
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-s3c64xx/common.c b/arch/arm/mach-s3c64xx/common.c
index b6aa36d..0f7df6a 100644
--- a/arch/arm/mach-s3c64xx/common.c
+++ b/arch/arm/mach-s3c64xx/common.c
@@ -44,7 +44,7 @@
 #include <plat/irq-vic-timer.h>
 #include <plat/regs-irqtype.h>
 #include <plat/regs-serial.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 #include <plat/watchdog-reset.h>
 
 #include "common.h"
diff --git a/arch/arm/mach-s3c64xx/mach-anw6410.c b/arch/arm/mach-s3c64xx/mach-anw6410.c
index 35e3f54..d2ef383 100644
--- a/arch/arm/mach-s3c64xx/mach-anw6410.c
+++ b/arch/arm/mach-s3c64xx/mach-anw6410.c
@@ -49,7 +49,7 @@
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <mach/regs-gpio.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 
 #include "common.h"
 #include "regs-modem.h"
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index 8ad88ac..dc41db0 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -64,7 +64,7 @@
 #include <plat/adc.h>
 #include <linux/platform_data/i2c-s3c2410.h>
 #include <plat/pm.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 
 #include "common.h"
 #include "crag6410.h"
diff --git a/arch/arm/mach-s3c64xx/mach-hmt.c b/arch/arm/mach-s3c64xx/mach-hmt.c
index 5b7f357..e830ce9 100644
--- a/arch/arm/mach-s3c64xx/mach-hmt.c
+++ b/arch/arm/mach-s3c64xx/mach-hmt.c
@@ -41,7 +41,7 @@
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-s3c64xx/mach-mini6410.c
index fc043e3..c78fed4 100644
--- a/arch/arm/mach-s3c64xx/mach-mini6410.c
+++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
@@ -41,7 +41,7 @@
 
 #include <video/platform_lcd.h>
 #include <video/samsung_fimd.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 
 #include "common.h"
 #include "regs-modem.h"
diff --git a/arch/arm/mach-s3c64xx/mach-ncp.c b/arch/arm/mach-s3c64xx/mach-ncp.c
index 7e2c390..6d24391 100644
--- a/arch/arm/mach-s3c64xx/mach-ncp.c
+++ b/arch/arm/mach-s3c64xx/mach-ncp.c
@@ -43,7 +43,7 @@
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-s3c64xx/mach-real6410.c
index 8bed37b..cb105c7 100644
--- a/arch/arm/mach-s3c64xx/mach-real6410.c
+++ b/arch/arm/mach-s3c64xx/mach-real6410.c
@@ -42,7 +42,7 @@
 
 #include <video/platform_lcd.h>
 #include <video/samsung_fimd.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 
 #include "common.h"
 #include "regs-modem.h"
diff --git a/arch/arm/mach-s3c64xx/mach-smartq.c b/arch/arm/mach-s3c64xx/mach-smartq.c
index 58ac990..e76028d 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq.c
@@ -38,7 +38,7 @@
 #include <linux/platform_data/touchscreen-s3c2410.h>
 
 #include <video/platform_lcd.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 
 #include "common.h"
 #include "regs-modem.h"
diff --git a/arch/arm/mach-s3c64xx/mach-smartq5.c b/arch/arm/mach-s3c64xx/mach-smartq5.c
index 8aca5da..2f5eb2a 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq5.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq5.c
@@ -28,7 +28,7 @@
 #include <plat/devs.h>
 #include <plat/fb.h>
 #include <plat/gpio-cfg.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 
 #include "common.h"
 #include "mach-smartq.h"
diff --git a/arch/arm/mach-s3c64xx/mach-smartq7.c b/arch/arm/mach-s3c64xx/mach-smartq7.c
index a052e10..3b898f6 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq7.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq7.c
@@ -28,7 +28,7 @@
 #include <plat/devs.h>
 #include <plat/fb.h>
 #include <plat/gpio-cfg.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 
 #include "common.h"
 #include "mach-smartq.h"
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6400.c b/arch/arm/mach-s3c64xx/mach-smdk6400.c
index d70c084..3964e19 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6400.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6400.c
@@ -35,7 +35,7 @@
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <linux/platform_data/i2c-s3c2410.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index bd3295a..c58cb54 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -69,7 +69,7 @@
 #include <linux/platform_data/touchscreen-s3c2410.h>
 #include <plat/keypad.h>
 #include <plat/backlight.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 
 #include "common.h"
 #include "regs-modem.h"
diff --git a/arch/arm/mach-s5p64x0/common.c b/arch/arm/mach-s5p64x0/common.c
index a339fbb..2839022 100644
--- a/arch/arm/mach-s5p64x0/common.c
+++ b/arch/arm/mach-s5p64x0/common.c
@@ -48,7 +48,7 @@
 #include <plat/gpio-cfg.h>
 #include <plat/regs-irqtype.h>
 #include <plat/regs-serial.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 #include <plat/watchdog-reset.h>
 
 #include "common.h"
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6440.c b/arch/arm/mach-s5p64x0/mach-smdk6440.c
index 73f71a6..4f70ee7 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6440.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6440.c
@@ -48,7 +48,7 @@
 #include <plat/pll.h>
 #include <plat/adc.h>
 #include <linux/platform_data/touchscreen-s3c2410.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 #include <plat/backlight.h>
 #include <plat/fb.h>
 #include <plat/sdhci.h>
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6450.c b/arch/arm/mach-s5p64x0/mach-smdk6450.c
index 18303e1..7aa9175 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6450.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6450.c
@@ -48,7 +48,7 @@
 #include <plat/pll.h>
 #include <plat/adc.h>
 #include <linux/platform_data/touchscreen-s3c2410.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 #include <plat/backlight.h>
 #include <plat/fb.h>
 #include <plat/sdhci.h>
diff --git a/arch/arm/mach-s5pc100/common.c b/arch/arm/mach-s5pc100/common.c
index 09e76d4..0df9124 100644
--- a/arch/arm/mach-s5pc100/common.c
+++ b/arch/arm/mach-s5pc100/common.c
@@ -47,7 +47,7 @@
 #include <plat/onenand-core.h>
 #include <plat/spi-core.h>
 #include <plat/regs-serial.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 #include <plat/watchdog-reset.h>
 
 #include "common.h"
diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-s5pc100/mach-smdkc100.c
index 8c880f7..b19c571 100644
--- a/arch/arm/mach-s5pc100/mach-smdkc100.c
+++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
@@ -51,7 +51,7 @@
 #include <linux/platform_data/touchscreen-s3c2410.h>
 #include <linux/platform_data/asoc-s3c.h>
 #include <plat/backlight.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-s5pv210/common.c b/arch/arm/mach-s5pv210/common.c
index 44d3a5c..2d1bc6b 100644
--- a/arch/arm/mach-s5pv210/common.c
+++ b/arch/arm/mach-s5pv210/common.c
@@ -42,7 +42,7 @@
 #include <plat/fimc-core.h>
 #include <plat/iic-core.h>
 #include <plat/keypad-core.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 #include <plat/tv-core.h>
 #include <plat/spi-core.h>
 #include <plat/regs-serial.h>
diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-aquila.c
index ed2b854..d02665d 100644
--- a/arch/arm/mach-s5pv210/mach-aquila.c
+++ b/arch/arm/mach-s5pv210/mach-aquila.c
@@ -38,7 +38,7 @@
 #include <plat/fb.h>
 #include <plat/fimc-core.h>
 #include <plat/sdhci.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index 2564394..7ae9c4a 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -47,7 +47,7 @@
 #include <plat/keypad.h>
 #include <plat/sdhci.h>
 #include <plat/clock.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 #include <plat/mfc.h>
 #include <plat/camport.h>
 
diff --git a/arch/arm/mach-s5pv210/mach-smdkc110.c b/arch/arm/mach-s5pv210/mach-smdkc110.c
index 7c0ed07..1f1d588 100644
--- a/arch/arm/mach-s5pv210/mach-smdkc110.c
+++ b/arch/arm/mach-s5pv210/mach-smdkc110.c
@@ -29,7 +29,7 @@
 #include <linux/platform_data/ata-samsung_cf.h>
 #include <linux/platform_data/i2c-s3c2410.h>
 #include <plat/pm.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 #include <plat/mfc.h>
 
 #include "common.h"
diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
index d50b6f1..7d16418 100644
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
@@ -44,7 +44,7 @@
 #include <plat/keypad.h>
 #include <plat/pm.h>
 #include <plat/fb.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 #include <plat/backlight.h>
 #include <plat/mfc.h>
 #include <plat/clock.h>
diff --git a/arch/arm/mach-s5pv210/mach-torbreck.c b/arch/arm/mach-s5pv210/mach-torbreck.c
index 579afe8..be08b5c 100644
--- a/arch/arm/mach-s5pv210/mach-torbreck.c
+++ b/arch/arm/mach-s5pv210/mach-torbreck.c
@@ -26,7 +26,7 @@
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <linux/platform_data/i2c-s3c2410.h>
-#include <plat/samsung-time.h>
+#include <clocksource/samsung-time.h>
 
 #include "common.h"
 
diff --git a/arch/arm/plat-samsung/include/plat/samsung-time.h b/arch/arm/plat-samsung/include/plat/samsung-time.h
deleted file mode 100644
index d64d8a2..0000000
--- a/arch/arm/plat-samsung/include/plat/samsung-time.h
+++ /dev/null
@@ -1,49 +0,0 @@
-/* linux/arch/arm/plat-samsung/include/plat/samsung-time.h
- *
- * Copyright 2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * Header file for samsung s3c and s5p time support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_PLAT_SAMSUNG_TIME_H
-#define __ASM_PLAT_SAMSUNG_TIME_H __FILE__
-
-/* SAMSUNG HR-Timer Clock mode */
-enum samsung_timer_mode {
-	SAMSUNG_PWM0,
-	SAMSUNG_PWM1,
-	SAMSUNG_PWM2,
-	SAMSUNG_PWM3,
-	SAMSUNG_PWM4,
-};
-
-struct samsung_timer_source {
-	unsigned int event_id;
-	unsigned int source_id;
-};
-
-/**
- * struct samsung_timer_variant - SoC-specific parameters of Samsung PWM timers
- * @bits:	bit width of time counters
- * @prescale:	prescaler divisor
- * @divisor:	main divisor
- */
-struct samsung_timer_variant {
-	int bits;
-	u16 prescale;
-	u16 divisor;
-};
-
-extern void samsung_set_timer_source(enum samsung_timer_mode event,
-					enum samsung_timer_mode source);
-extern void samsung_timer_set_variant(
-				const struct samsung_timer_variant *variant);
-
-extern void __init samsung_timer_init(void);
-
-#endif /* __ASM_PLAT_SAMSUNG_TIME_H */
diff --git a/drivers/clocksource/samsung-time.c b/drivers/clocksource/samsung-time.c
index f1eacef..03955fb 100644
--- a/drivers/clocksource/samsung-time.c
+++ b/drivers/clocksource/samsung-time.c
@@ -16,6 +16,8 @@
 #include <linux/clockchips.h>
 #include <linux/platform_device.h>
 
+#include <clocksource/samsung-time.h>
+
 #include <asm/smp_twd.h>
 #include <asm/mach/time.h>
 #include <asm/mach/arch.h>
@@ -25,7 +27,6 @@
 #include <mach/map.h>
 #include <plat/devs.h>
 #include <plat/regs-timer.h>
-#include <plat/samsung-time.h>
 
 static struct clk *tin_event;
 static struct clk *tin_source;
diff --git a/include/clocksource/samsung-time.h b/include/clocksource/samsung-time.h
new file mode 100644
index 0000000..d64d8a2
--- /dev/null
+++ b/include/clocksource/samsung-time.h
@@ -0,0 +1,49 @@
+/* linux/arch/arm/plat-samsung/include/plat/samsung-time.h
+ *
+ * Copyright 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * Header file for samsung s3c and s5p time support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_PLAT_SAMSUNG_TIME_H
+#define __ASM_PLAT_SAMSUNG_TIME_H __FILE__
+
+/* SAMSUNG HR-Timer Clock mode */
+enum samsung_timer_mode {
+	SAMSUNG_PWM0,
+	SAMSUNG_PWM1,
+	SAMSUNG_PWM2,
+	SAMSUNG_PWM3,
+	SAMSUNG_PWM4,
+};
+
+struct samsung_timer_source {
+	unsigned int event_id;
+	unsigned int source_id;
+};
+
+/**
+ * struct samsung_timer_variant - SoC-specific parameters of Samsung PWM timers
+ * @bits:	bit width of time counters
+ * @prescale:	prescaler divisor
+ * @divisor:	main divisor
+ */
+struct samsung_timer_variant {
+	int bits;
+	u16 prescale;
+	u16 divisor;
+};
+
+extern void samsung_set_timer_source(enum samsung_timer_mode event,
+					enum samsung_timer_mode source);
+extern void samsung_timer_set_variant(
+				const struct samsung_timer_variant *variant);
+
+extern void __init samsung_timer_init(void);
+
+#endif /* __ASM_PLAT_SAMSUNG_TIME_H */
-- 
1.8.1.5

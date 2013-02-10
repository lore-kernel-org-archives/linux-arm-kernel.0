From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 10 Feb 2013 14:20:15 +0100
Subject: [PATCH 04/12] clocksource: samsung-time: Move samsung-time.h header
 to include/linux
In-Reply-To: <1360502423-2246-1-git-send-email-tomasz.figa@gmail.com>
References: <1360502423-2246-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1360502423-2246-5-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves the samsung-time.h header file to include/linux
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
 arch/arm/plat-samsung/include/plat/samsung-time.h | 41 -----------------------
 drivers/clocksource/samsung-time.c                |  2 +-
 include/linux/samsung-time.h                      | 41 +++++++++++++++++++++++
 51 files changed, 90 insertions(+), 90 deletions(-)
 delete mode 100644 arch/arm/plat-samsung/include/plat/samsung-time.h
 create mode 100644 include/linux/samsung-time.h

diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/mach-exynos/mach-universal_c210.c
index 5a8c0e1..284b66b 100644
--- a/arch/arm/mach-exynos/mach-universal_c210.c
+++ b/arch/arm/mach-exynos/mach-universal_c210.c
@@ -42,7 +42,7 @@
 #include <plat/mfc.h>
 #include <plat/sdhci.h>
 #include <plat/fimc-core.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 #include <plat/camport.h>
 
 #include <mach/map.h>
diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
index f720053..40b3c8f 100644
--- a/arch/arm/mach-s3c24xx/common.c
+++ b/arch/arm/mach-s3c24xx/common.c
@@ -54,7 +54,7 @@
 #include <plat/s3c2443.h>
 #include <plat/cpu-freq.h>
 #include <plat/pll.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 
 /* table of supported CPUs */
 
diff --git a/arch/arm/mach-s3c24xx/mach-amlm5900.c b/arch/arm/mach-s3c24xx/mach-amlm5900.c
index 432144c..d48c405 100644
--- a/arch/arm/mach-s3c24xx/mach-amlm5900.c
+++ b/arch/arm/mach-s3c24xx/mach-amlm5900.c
@@ -63,7 +63,7 @@
 #include <linux/mtd/map.h>
 #include <linux/mtd/physmap.h>
 
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-s3c24xx/mach-anubis.c b/arch/arm/mach-s3c24xx/mach-anubis.c
index 24f1a04..37d1c98 100644
--- a/arch/arm/mach-s3c24xx/mach-anubis.c
+++ b/arch/arm/mach-s3c24xx/mach-anubis.c
@@ -49,7 +49,7 @@
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <linux/platform_data/asoc-s3c24xx_simtec.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 
 #include "anubis.h"
 #include "common.h"
diff --git a/arch/arm/mach-s3c24xx/mach-at2440evb.c b/arch/arm/mach-s3c24xx/mach-at2440evb.c
index 2bf6c8c..0797671 100644
--- a/arch/arm/mach-s3c24xx/mach-at2440evb.c
+++ b/arch/arm/mach-s3c24xx/mach-at2440evb.c
@@ -48,7 +48,7 @@
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <linux/platform_data/mmc-s3cmci.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-s3c24xx/mach-bast.c b/arch/arm/mach-s3c24xx/mach-bast.c
index eabe2db..15d0ec1 100644
--- a/arch/arm/mach-s3c24xx/mach-bast.c
+++ b/arch/arm/mach-s3c24xx/mach-bast.c
@@ -55,7 +55,7 @@
 #include <plat/devs.h>
 #include <plat/gpio-cfg.h>
 #include <plat/regs-serial.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 
 #include "bast.h"
 #include "common.h"
diff --git a/arch/arm/mach-s3c24xx/mach-gta02.c b/arch/arm/mach-s3c24xx/mach-gta02.c
index 84a750d..a2959e4 100644
--- a/arch/arm/mach-s3c24xx/mach-gta02.c
+++ b/arch/arm/mach-s3c24xx/mach-gta02.c
@@ -81,7 +81,7 @@
 #include <plat/gpio-cfg.h>
 #include <plat/pm.h>
 #include <plat/regs-serial.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 
 #include "common.h"
 #include "gta02.h"
diff --git a/arch/arm/mach-s3c24xx/mach-h1940.c b/arch/arm/mach-s3c24xx/mach-h1940.c
index 8dd6601..5c56efd 100644
--- a/arch/arm/mach-s3c24xx/mach-h1940.c
+++ b/arch/arm/mach-s3c24xx/mach-h1940.c
@@ -62,7 +62,7 @@
 #include <plat/pll.h>
 #include <plat/pm.h>
 #include <plat/regs-serial.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 
 #include "common.h"
 #include "h1940.h"
diff --git a/arch/arm/mach-s3c24xx/mach-jive.c b/arch/arm/mach-s3c24xx/mach-jive.c
index 4096496..dddb320 100644
--- a/arch/arm/mach-s3c24xx/mach-jive.c
+++ b/arch/arm/mach-s3c24xx/mach-jive.c
@@ -53,7 +53,7 @@
 #include <plat/cpu.h>
 #include <plat/pm.h>
 #include <linux/platform_data/usb-s3c2410_udc.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 
 #include "s3c2412-power.h"
 
diff --git a/arch/arm/mach-s3c24xx/mach-mini2440.c b/arch/arm/mach-s3c24xx/mach-mini2440.c
index 29f106c..7b6add6 100644
--- a/arch/arm/mach-s3c24xx/mach-mini2440.c
+++ b/arch/arm/mach-s3c24xx/mach-mini2440.c
@@ -56,7 +56,7 @@
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 
 #include <sound/s3c24xx_uda134x.h>
 
diff --git a/arch/arm/mach-s3c24xx/mach-n30.c b/arch/arm/mach-s3c24xx/mach-n30.c
index 628b1e3..4f4baf0 100644
--- a/arch/arm/mach-s3c24xx/mach-n30.c
+++ b/arch/arm/mach-s3c24xx/mach-n30.c
@@ -50,7 +50,7 @@
 #include <linux/platform_data/mmc-s3cmci.h>
 #include <plat/s3c2410.h>
 #include <linux/platform_data/usb-s3c2410_udc.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-s3c24xx/mach-nexcoder.c b/arch/arm/mach-s3c24xx/mach-nexcoder.c
index f64a146..0b490ab 100644
--- a/arch/arm/mach-s3c24xx/mach-nexcoder.c
+++ b/arch/arm/mach-s3c24xx/mach-nexcoder.c
@@ -46,7 +46,7 @@
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-s3c24xx/mach-osiris.c b/arch/arm/mach-s3c24xx/mach-osiris.c
index ef3a7b0..1236ad7 100644
--- a/arch/arm/mach-s3c24xx/mach-osiris.c
+++ b/arch/arm/mach-s3c24xx/mach-osiris.c
@@ -44,7 +44,7 @@
 #include <plat/devs.h>
 #include <plat/gpio-cfg.h>
 #include <plat/regs-serial.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 
 #include <mach/hardware.h>
 #include <mach/regs-gpio.h>
diff --git a/arch/arm/mach-s3c24xx/mach-otom.c b/arch/arm/mach-s3c24xx/mach-otom.c
index 718cde8..da1b02a 100644
--- a/arch/arm/mach-s3c24xx/mach-otom.c
+++ b/arch/arm/mach-s3c24xx/mach-otom.c
@@ -34,7 +34,7 @@
 #include <plat/devs.h>
 #include <plat/regs-serial.h>
 #include <plat/s3c2410.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 
 #include "common.h"
 #include "otom.h"
diff --git a/arch/arm/mach-s3c24xx/mach-qt2410.c b/arch/arm/mach-s3c24xx/mach-qt2410.c
index c4ac6ea..31a76d4 100644
--- a/arch/arm/mach-s3c24xx/mach-qt2410.c
+++ b/arch/arm/mach-s3c24xx/mach-qt2410.c
@@ -60,7 +60,7 @@
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <plat/pm.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-s3c24xx/mach-rx1950.c b/arch/arm/mach-s3c24xx/mach-rx1950.c
index 799af43..23d9a6f 100644
--- a/arch/arm/mach-s3c24xx/mach-rx1950.c
+++ b/arch/arm/mach-s3c24xx/mach-rx1950.c
@@ -58,7 +58,7 @@
 #include <plat/pm.h>
 #include <plat/regs-iic.h>
 #include <plat/regs-serial.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 
 #include "common.h"
 #include "h1940.h"
diff --git a/arch/arm/mach-s3c24xx/mach-rx3715.c b/arch/arm/mach-s3c24xx/mach-rx3715.c
index 0a3c964..5843424 100644
--- a/arch/arm/mach-s3c24xx/mach-rx3715.c
+++ b/arch/arm/mach-s3c24xx/mach-rx3715.c
@@ -49,7 +49,7 @@
 #include <plat/devs.h>
 #include <plat/pm.h>
 #include <plat/regs-serial.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 
 #include "common.h"
 #include "h1940.h"
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2410.c b/arch/arm/mach-s3c24xx/mach-smdk2410.c
index dfd051f..183a9c8 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2410.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2410.c
@@ -53,7 +53,7 @@
 #include <plat/cpu.h>
 
 #include <plat/common-smdk.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2413.c b/arch/arm/mach-s3c24xx/mach-smdk2413.c
index 960f6d2b..04884cb 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2413.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2413.c
@@ -46,7 +46,7 @@
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 
 #include <plat/common-smdk.h>
 
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2416.c b/arch/arm/mach-s3c24xx/mach-smdk2416.c
index eef720d..08dde09 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2416.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2416.c
@@ -51,7 +51,7 @@
 #include <plat/sdhci.h>
 #include <linux/platform_data/usb-s3c2410_udc.h>
 #include <linux/platform_data/s3c-hsudc.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 
 #include <plat/fb.h>
 
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2440.c b/arch/arm/mach-s3c24xx/mach-smdk2440.c
index 05bf045..e3d3fbb 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2440.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2440.c
@@ -43,7 +43,7 @@
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 
 #include <plat/common-smdk.h>
 
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2443.c b/arch/arm/mach-s3c24xx/mach-smdk2443.c
index d9991fb..84ac047 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2443.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2443.c
@@ -43,7 +43,7 @@
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 
 #include <plat/common-smdk.h>
 
diff --git a/arch/arm/mach-s3c24xx/mach-tct_hammer.c b/arch/arm/mach-s3c24xx/mach-tct_hammer.c
index 31dfe58..5d88794 100644
--- a/arch/arm/mach-s3c24xx/mach-tct_hammer.c
+++ b/arch/arm/mach-s3c24xx/mach-tct_hammer.c
@@ -53,7 +53,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/map.h>
 #include <linux/mtd/physmap.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-s3c24xx/mach-vr1000.c b/arch/arm/mach-s3c24xx/mach-vr1000.c
index deeb8a0..b10f20c 100644
--- a/arch/arm/mach-s3c24xx/mach-vr1000.c
+++ b/arch/arm/mach-s3c24xx/mach-vr1000.c
@@ -45,7 +45,7 @@
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/regs-serial.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 
 #include "bast.h"
 #include "common.h"
diff --git a/arch/arm/mach-s3c24xx/mach-vstms.c b/arch/arm/mach-s3c24xx/mach-vstms.c
index dcc0f40..9d31250 100644
--- a/arch/arm/mach-s3c24xx/mach-vstms.c
+++ b/arch/arm/mach-s3c24xx/mach-vstms.c
@@ -46,7 +46,7 @@
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 
 static struct map_desc vstms_iodesc[] __initdata = {
 };
diff --git a/arch/arm/mach-s3c64xx/common.c b/arch/arm/mach-s3c64xx/common.c
index 5e5fbe5..89129e9 100644
--- a/arch/arm/mach-s3c64xx/common.c
+++ b/arch/arm/mach-s3c64xx/common.c
@@ -44,7 +44,7 @@
 #include <plat/irq-vic-timer.h>
 #include <plat/regs-irqtype.h>
 #include <plat/regs-serial.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 #include <plat/watchdog-reset.h>
 
 #include "common.h"
diff --git a/arch/arm/mach-s3c64xx/mach-anw6410.c b/arch/arm/mach-s3c64xx/mach-anw6410.c
index e62a523..83296ac 100644
--- a/arch/arm/mach-s3c64xx/mach-anw6410.c
+++ b/arch/arm/mach-s3c64xx/mach-anw6410.c
@@ -50,7 +50,7 @@
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <mach/regs-gpio.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 
 #include "common.h"
 #include "regs-modem.h"
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index e24ba45..3a642d9 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -65,7 +65,7 @@
 #include <plat/adc.h>
 #include <linux/platform_data/i2c-s3c2410.h>
 #include <plat/pm.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 
 #include "common.h"
 #include "crag6410.h"
diff --git a/arch/arm/mach-s3c64xx/mach-hmt.c b/arch/arm/mach-s3c64xx/mach-hmt.c
index 721f26d..88809e1 100644
--- a/arch/arm/mach-s3c64xx/mach-hmt.c
+++ b/arch/arm/mach-s3c64xx/mach-hmt.c
@@ -42,7 +42,7 @@
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-s3c64xx/mach-mini6410.c
index b2faf05..0ad716f 100644
--- a/arch/arm/mach-s3c64xx/mach-mini6410.c
+++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
@@ -42,7 +42,7 @@
 
 #include <video/platform_lcd.h>
 #include <video/samsung_fimd.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 
 #include "common.h"
 #include "regs-modem.h"
diff --git a/arch/arm/mach-s3c64xx/mach-ncp.c b/arch/arm/mach-s3c64xx/mach-ncp.c
index 91063d8..b3d1798 100644
--- a/arch/arm/mach-s3c64xx/mach-ncp.c
+++ b/arch/arm/mach-s3c64xx/mach-ncp.c
@@ -44,7 +44,7 @@
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-s3c64xx/mach-real6410.c
index 2db2316..e10c672 100644
--- a/arch/arm/mach-s3c64xx/mach-real6410.c
+++ b/arch/arm/mach-s3c64xx/mach-real6410.c
@@ -43,7 +43,7 @@
 
 #include <video/platform_lcd.h>
 #include <video/samsung_fimd.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 
 #include "common.h"
 #include "regs-modem.h"
diff --git a/arch/arm/mach-s3c64xx/mach-smartq.c b/arch/arm/mach-s3c64xx/mach-smartq.c
index 58ac990..4bed40a 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq.c
@@ -38,7 +38,7 @@
 #include <linux/platform_data/touchscreen-s3c2410.h>
 
 #include <video/platform_lcd.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 
 #include "common.h"
 #include "regs-modem.h"
diff --git a/arch/arm/mach-s3c64xx/mach-smartq5.c b/arch/arm/mach-s3c64xx/mach-smartq5.c
index 02717c2..37f1c19 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq5.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq5.c
@@ -29,7 +29,7 @@
 #include <plat/devs.h>
 #include <plat/fb.h>
 #include <plat/gpio-cfg.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 
 #include "common.h"
 #include "mach-smartq.h"
diff --git a/arch/arm/mach-s3c64xx/mach-smartq7.c b/arch/arm/mach-s3c64xx/mach-smartq7.c
index 70d975e..bd7131a 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq7.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq7.c
@@ -29,7 +29,7 @@
 #include <plat/devs.h>
 #include <plat/fb.h>
 #include <plat/gpio-cfg.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 
 #include "common.h"
 #include "mach-smartq.h"
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6400.c b/arch/arm/mach-s3c64xx/mach-smdk6400.c
index c91f8c9..6a588e5 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6400.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6400.c
@@ -36,7 +36,7 @@
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <linux/platform_data/i2c-s3c2410.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index 5202df9..3657e54 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -70,7 +70,7 @@
 #include <linux/platform_data/touchscreen-s3c2410.h>
 #include <plat/keypad.h>
 #include <plat/backlight.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 
 #include "common.h"
 #include "regs-modem.h"
diff --git a/arch/arm/mach-s5p64x0/common.c b/arch/arm/mach-s5p64x0/common.c
index dd93674..a959d98 100644
--- a/arch/arm/mach-s5p64x0/common.c
+++ b/arch/arm/mach-s5p64x0/common.c
@@ -48,7 +48,7 @@
 #include <plat/gpio-cfg.h>
 #include <plat/regs-irqtype.h>
 #include <plat/regs-serial.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 #include <plat/watchdog-reset.h>
 
 #include "common.h"
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6440.c b/arch/arm/mach-s5p64x0/mach-smdk6440.c
index 6cc5453..9b42fd6 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6440.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6440.c
@@ -49,7 +49,7 @@
 #include <plat/pll.h>
 #include <plat/adc.h>
 #include <linux/platform_data/touchscreen-s3c2410.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 #include <plat/backlight.h>
 #include <plat/fb.h>
 #include <plat/sdhci.h>
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6450.c b/arch/arm/mach-s5p64x0/mach-smdk6450.c
index 89299f2..544fe11 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6450.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6450.c
@@ -49,7 +49,7 @@
 #include <plat/pll.h>
 #include <plat/adc.h>
 #include <linux/platform_data/touchscreen-s3c2410.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 #include <plat/backlight.h>
 #include <plat/fb.h>
 #include <plat/sdhci.h>
diff --git a/arch/arm/mach-s5pc100/common.c b/arch/arm/mach-s5pc100/common.c
index f3f3a75..e63ff33 100644
--- a/arch/arm/mach-s5pc100/common.c
+++ b/arch/arm/mach-s5pc100/common.c
@@ -47,7 +47,7 @@
 #include <plat/onenand-core.h>
 #include <plat/spi-core.h>
 #include <plat/regs-serial.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 #include <plat/watchdog-reset.h>
 
 #include "common.h"
diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-s5pc100/mach-smdkc100.c
index 1508f80..bffb83f 100644
--- a/arch/arm/mach-s5pc100/mach-smdkc100.c
+++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
@@ -52,7 +52,7 @@
 #include <linux/platform_data/touchscreen-s3c2410.h>
 #include <linux/platform_data/asoc-s3c.h>
 #include <plat/backlight.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-s5pv210/common.c b/arch/arm/mach-s5pv210/common.c
index 45acaf3..2ab06ce 100644
--- a/arch/arm/mach-s5pv210/common.c
+++ b/arch/arm/mach-s5pv210/common.c
@@ -42,7 +42,7 @@
 #include <plat/fimc-core.h>
 #include <plat/iic-core.h>
 #include <plat/keypad-core.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 #include <plat/tv-core.h>
 #include <plat/spi-core.h>
 #include <plat/regs-serial.h>
diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-aquila.c
index 7307d18..ec2d1bb 100644
--- a/arch/arm/mach-s5pv210/mach-aquila.c
+++ b/arch/arm/mach-s5pv210/mach-aquila.c
@@ -39,7 +39,7 @@
 #include <plat/fb.h>
 #include <plat/fimc-core.h>
 #include <plat/sdhci.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index eb6f4fd..b9821a7 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -48,7 +48,7 @@
 #include <plat/keypad.h>
 #include <plat/sdhci.h>
 #include <plat/clock.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 #include <plat/mfc.h>
 #include <plat/camport.h>
 
diff --git a/arch/arm/mach-s5pv210/mach-smdkc110.c b/arch/arm/mach-s5pv210/mach-smdkc110.c
index 67d33ae..94f4a78 100644
--- a/arch/arm/mach-s5pv210/mach-smdkc110.c
+++ b/arch/arm/mach-s5pv210/mach-smdkc110.c
@@ -30,7 +30,7 @@
 #include <linux/platform_data/ata-samsung_cf.h>
 #include <linux/platform_data/i2c-s3c2410.h>
 #include <plat/pm.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 #include <plat/mfc.h>
 
 #include "common.h"
diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
index 5c8bde1..b427583 100644
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
@@ -45,7 +45,7 @@
 #include <plat/keypad.h>
 #include <plat/pm.h>
 #include <plat/fb.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 #include <plat/backlight.h>
 #include <plat/mfc.h>
 #include <plat/clock.h>
diff --git a/arch/arm/mach-s5pv210/mach-torbreck.c b/arch/arm/mach-s5pv210/mach-torbreck.c
index 34dd611..84e80f9 100644
--- a/arch/arm/mach-s5pv210/mach-torbreck.c
+++ b/arch/arm/mach-s5pv210/mach-torbreck.c
@@ -27,7 +27,7 @@
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <linux/platform_data/i2c-s3c2410.h>
-#include <plat/samsung-time.h>
+#include <linux/samsung-time.h>
 
 #include "common.h"
 
diff --git a/arch/arm/plat-samsung/include/plat/samsung-time.h b/arch/arm/plat-samsung/include/plat/samsung-time.h
deleted file mode 100644
index 68432af..0000000
--- a/arch/arm/plat-samsung/include/plat/samsung-time.h
+++ /dev/null
@@ -1,41 +0,0 @@
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
-struct samsung_timer_variant {
-	int bits;
-	u16 prescale;
-	u16 divisor;
-};
-
-extern void __init samsung_set_timer_source(enum samsung_timer_mode event,
-					enum samsung_timer_mode source);
-extern void __init samsung_timer_set_variant(
-				const struct samsung_timer_variant *variant);
-extern	void samsung_timer_init(void);
-#endif /* __ASM_PLAT_SAMSUNG_TIME_H */
diff --git a/drivers/clocksource/samsung-time.c b/drivers/clocksource/samsung-time.c
index a6af801..9c0626f 100644
--- a/drivers/clocksource/samsung-time.c
+++ b/drivers/clocksource/samsung-time.c
@@ -15,6 +15,7 @@
 #include <linux/clk.h>
 #include <linux/clockchips.h>
 #include <linux/platform_device.h>
+#include <linux/samsung-time.h>
 
 #include <asm/smp_twd.h>
 #include <asm/mach/time.h>
@@ -25,7 +26,6 @@
 #include <mach/map.h>
 #include <plat/devs.h>
 #include <plat/regs-timer.h>
-#include <plat/samsung-time.h>
 
 static struct clk *tin_event;
 static struct clk *tin_source;
diff --git a/include/linux/samsung-time.h b/include/linux/samsung-time.h
new file mode 100644
index 0000000..68432af
--- /dev/null
+++ b/include/linux/samsung-time.h
@@ -0,0 +1,41 @@
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
+struct samsung_timer_variant {
+	int bits;
+	u16 prescale;
+	u16 divisor;
+};
+
+extern void __init samsung_set_timer_source(enum samsung_timer_mode event,
+					enum samsung_timer_mode source);
+extern void __init samsung_timer_set_variant(
+				const struct samsung_timer_variant *variant);
+extern	void samsung_timer_init(void);
+#endif /* __ASM_PLAT_SAMSUNG_TIME_H */
-- 
1.8.1.2

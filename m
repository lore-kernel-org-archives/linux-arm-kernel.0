From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Thu, 7 Feb 2013 22:49:57 +0100
Subject: [PATCH 1/2] ARM: S3C24XX: move plat-samsung/s3c24XX headers to local
 common.h
In-Reply-To: <201302072249.04263.heiko@sntech.de>
References: <201302072249.04263.heiko@sntech.de>
Message-ID: <201302072249.58240.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The different soc functions are now only used in the mach-s3c24xx
directory, so it's not necessary anymore to keep the globally
visible.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/clock-s3c2410.c        |    1 -
 arch/arm/mach-s3c24xx/clock-s3c2412.c        |    1 -
 arch/arm/mach-s3c24xx/clock-s3c2416.c        |    1 -
 arch/arm/mach-s3c24xx/clock-s3c2443.c        |    1 -
 arch/arm/mach-s3c24xx/common.c               |    7 +-
 arch/arm/mach-s3c24xx/common.h               |  123 ++++++++++++++++++++++++++
 arch/arm/mach-s3c24xx/mach-jive.c            |    2 +-
 arch/arm/mach-s3c24xx/mach-n30.c             |    1 -
 arch/arm/mach-s3c24xx/mach-nexcoder.c        |    2 -
 arch/arm/mach-s3c24xx/mach-otom.c            |    1 -
 arch/arm/mach-s3c24xx/mach-smdk2413.c        |    4 +-
 arch/arm/mach-s3c24xx/mach-smdk2416.c        |    3 +-
 arch/arm/mach-s3c24xx/mach-smdk2440.c        |    2 -
 arch/arm/mach-s3c24xx/mach-smdk2443.c        |    4 +-
 arch/arm/mach-s3c24xx/mach-vstms.c           |    4 +-
 arch/arm/mach-s3c24xx/pm-s3c2412.c           |    1 -
 arch/arm/mach-s3c24xx/s3c2410.c              |    1 -
 arch/arm/mach-s3c24xx/s3c2412.c              |    1 -
 arch/arm/mach-s3c24xx/s3c2416.c              |    1 -
 arch/arm/mach-s3c24xx/s3c2440.c              |    1 -
 arch/arm/mach-s3c24xx/s3c2442.c              |    1 -
 arch/arm/mach-s3c24xx/s3c2443.c              |    1 -
 arch/arm/mach-s3c24xx/s3c244x.c              |    2 -
 arch/arm/plat-samsung/include/plat/s3c2410.h |   31 -------
 arch/arm/plat-samsung/include/plat/s3c2412.h |   32 -------
 arch/arm/plat-samsung/include/plat/s3c2416.h |   37 --------
 arch/arm/plat-samsung/include/plat/s3c2443.h |   36 --------
 arch/arm/plat-samsung/include/plat/s3c244x.h |   42 ---------
 28 files changed, 134 insertions(+), 210 deletions(-)
 delete mode 100644 arch/arm/plat-samsung/include/plat/s3c2410.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/s3c2412.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/s3c2416.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/s3c2443.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/s3c244x.h

diff --git a/arch/arm/mach-s3c24xx/clock-s3c2410.c b/arch/arm/mach-s3c24xx/clock-s3c2410.c
index 641266f3..34fffdf 100644
--- a/arch/arm/mach-s3c24xx/clock-s3c2410.c
+++ b/arch/arm/mach-s3c24xx/clock-s3c2410.c
@@ -40,7 +40,6 @@
 #include <mach/regs-clock.h>
 #include <mach/regs-gpio.h>
 
-#include <plat/s3c2410.h>
 #include <plat/clock.h>
 #include <plat/cpu.h>
 
diff --git a/arch/arm/mach-s3c24xx/clock-s3c2412.c b/arch/arm/mach-s3c24xx/clock-s3c2412.c
index d10b695..2cc017d 100644
--- a/arch/arm/mach-s3c24xx/clock-s3c2412.c
+++ b/arch/arm/mach-s3c24xx/clock-s3c2412.c
@@ -41,7 +41,6 @@
 #include <mach/regs-clock.h>
 #include <mach/regs-gpio.h>
 
-#include <plat/s3c2412.h>
 #include <plat/clock.h>
 #include <plat/cpu.h>
 
diff --git a/arch/arm/mach-s3c24xx/clock-s3c2416.c b/arch/arm/mach-s3c24xx/clock-s3c2416.c
index 14a81c2..036056ce 100644
--- a/arch/arm/mach-s3c24xx/clock-s3c2416.c
+++ b/arch/arm/mach-s3c24xx/clock-s3c2416.c
@@ -14,7 +14,6 @@
 #include <linux/init.h>
 #include <linux/clk.h>
 
-#include <plat/s3c2416.h>
 #include <plat/clock.h>
 #include <plat/clock-clksrc.h>
 #include <plat/cpu.h>
diff --git a/arch/arm/mach-s3c24xx/clock-s3c2443.c b/arch/arm/mach-s3c24xx/clock-s3c2443.c
index bdaba59..0a53051 100644
--- a/arch/arm/mach-s3c24xx/clock-s3c2443.c
+++ b/arch/arm/mach-s3c24xx/clock-s3c2443.c
@@ -41,7 +41,6 @@
 
 #include <plat/cpu-freq.h>
 
-#include <plat/s3c2443.h>
 #include <plat/clock.h>
 #include <plat/clock-clksrc.h>
 #include <plat/cpu.h>
diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
index 6bcf87f..d97533d 100644
--- a/arch/arm/mach-s3c24xx/common.c
+++ b/arch/arm/mach-s3c24xx/common.c
@@ -47,14 +47,11 @@
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/clock.h>
-#include <plat/s3c2410.h>
-#include <plat/s3c2412.h>
-#include <plat/s3c2416.h>
-#include <plat/s3c244x.h>
-#include <plat/s3c2443.h>
 #include <plat/cpu-freq.h>
 #include <plat/pll.h>
 
+#include "common.h"
+
 /* table of supported CPUs */
 
 static const char name_s3c2410[]  = "S3C2410";
diff --git a/arch/arm/mach-s3c24xx/common.h b/arch/arm/mach-s3c24xx/common.h
index ed6276f..4db3dd8 100644
--- a/arch/arm/mach-s3c24xx/common.h
+++ b/arch/arm/mach-s3c24xx/common.h
@@ -12,6 +12,129 @@
 #ifndef __ARCH_ARM_MACH_S3C24XX_COMMON_H
 #define __ARCH_ARM_MACH_S3C24XX_COMMON_H __FILE__
 
+#ifdef CONFIG_CPU_S3C2410
+
+extern  int s3c2410_init(void);
+extern  int s3c2410a_init(void);
+
+extern void s3c2410_map_io(void);
+
+extern void s3c2410_init_uarts(struct s3c2410_uartcfg *cfg, int no);
+
+extern void s3c2410_init_clocks(int xtal);
+
+#else
+#define s3c2410_init_clocks NULL
+#define s3c2410_init_uarts NULL
+#define s3c2410_map_io NULL
+#define s3c2410_init NULL
+#define s3c2410a_init NULL
+#endif
+
+#ifdef CONFIG_CPU_S3C2412
+
+extern  int s3c2412_init(void);
+
+extern void s3c2412_map_io(void);
+
+extern void s3c2412_init_uarts(struct s3c2410_uartcfg *cfg, int no);
+
+extern void s3c2412_init_clocks(int xtal);
+
+extern  int s3c2412_baseclk_add(void);
+
+extern void s3c2412_restart(char mode, const char *cmd);
+#else
+#define s3c2412_init_clocks NULL
+#define s3c2412_init_uarts NULL
+#define s3c2412_map_io NULL
+#define s3c2412_init NULL
+#define s3c2412_restart NULL
+#endif
+
+#ifdef CONFIG_CPU_S3C2416
+
+struct s3c2410_uartcfg;
+
+extern  int s3c2416_init(void);
+
+extern void s3c2416_map_io(void);
+
+extern void s3c2416_init_uarts(struct s3c2410_uartcfg *cfg, int no);
+
+extern void s3c2416_init_clocks(int xtal);
+
+extern  int s3c2416_baseclk_add(void);
+
+extern void s3c2416_restart(char mode, const char *cmd);
+
+extern void s3c2416_init_irq(void);
+extern struct syscore_ops s3c2416_irq_syscore_ops;
+
+#else
+#define s3c2416_init_clocks NULL
+#define s3c2416_init_uarts NULL
+#define s3c2416_map_io NULL
+#define s3c2416_init NULL
+#define s3c2416_restart NULL
+#endif
+
+#if defined(CONFIG_CPU_S3C2440) || defined(CONFIG_CPU_S3C2442)
+
+extern void s3c244x_map_io(void);
+
+extern void s3c244x_init_uarts(struct s3c2410_uartcfg *cfg, int no);
+
+extern void s3c244x_init_clocks(int xtal);
+
+#else
+#define s3c244x_init_clocks NULL
+#define s3c244x_init_uarts NULL
+#endif
+
+#ifdef CONFIG_CPU_S3C2440
+extern  int s3c2440_init(void);
+
+extern void s3c2440_map_io(void);
+#else
+#define s3c2440_init NULL
+#define s3c2440_map_io NULL
+#endif
+
+#ifdef CONFIG_CPU_S3C2442
+extern  int s3c2442_init(void);
+
+extern void s3c2442_map_io(void);
+#else
+#define s3c2442_init NULL
+#define s3c2442_map_io NULL
+#endif
+
+#ifdef CONFIG_CPU_S3C2443
+
+struct s3c2410_uartcfg;
+
+extern  int s3c2443_init(void);
+
+extern void s3c2443_map_io(void);
+
+extern void s3c2443_init_uarts(struct s3c2410_uartcfg *cfg, int no);
+
+extern void s3c2443_init_clocks(int xtal);
+
+extern  int s3c2443_baseclk_add(void);
+
+extern void s3c2443_restart(char mode, const char *cmd);
+
+extern void s3c2443_init_irq(void);
+#else
+#define s3c2443_init_clocks NULL
+#define s3c2443_init_uarts NULL
+#define s3c2443_map_io NULL
+#define s3c2443_init NULL
+#define s3c2443_restart NULL
+#endif
+
 void s3c2410_restart(char mode, const char *cmd);
 void s3c244x_restart(char mode, const char *cmd);
 
diff --git a/arch/arm/mach-s3c24xx/mach-jive.c b/arch/arm/mach-s3c24xx/mach-jive.c
index 4096496..0c8c733 100644
--- a/arch/arm/mach-s3c24xx/mach-jive.c
+++ b/arch/arm/mach-s3c24xx/mach-jive.c
@@ -46,7 +46,6 @@
 #include <linux/mtd/nand_ecc.h>
 #include <linux/mtd/partitions.h>
 
-#include <plat/s3c2412.h>
 #include <plat/gpio-cfg.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
@@ -56,6 +55,7 @@
 #include <plat/samsung-time.h>
 
 #include "s3c2412-power.h"
+#include "common.h"
 
 static struct map_desc jive_iodesc[] __initdata = {
 };
diff --git a/arch/arm/mach-s3c24xx/mach-n30.c b/arch/arm/mach-s3c24xx/mach-n30.c
index 628b1e3..73a690f 100644
--- a/arch/arm/mach-s3c24xx/mach-n30.c
+++ b/arch/arm/mach-s3c24xx/mach-n30.c
@@ -48,7 +48,6 @@
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <linux/platform_data/mmc-s3cmci.h>
-#include <plat/s3c2410.h>
 #include <linux/platform_data/usb-s3c2410_udc.h>
 #include <plat/samsung-time.h>
 
diff --git a/arch/arm/mach-s3c24xx/mach-nexcoder.c b/arch/arm/mach-s3c24xx/mach-nexcoder.c
index f64a146..5c826d1 100644
--- a/arch/arm/mach-s3c24xx/mach-nexcoder.c
+++ b/arch/arm/mach-s3c24xx/mach-nexcoder.c
@@ -41,8 +41,6 @@
 #include <linux/platform_data/i2c-s3c2410.h>
 
 #include <plat/gpio-cfg.h>
-#include <plat/s3c2410.h>
-#include <plat/s3c244x.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
diff --git a/arch/arm/mach-s3c24xx/mach-otom.c b/arch/arm/mach-s3c24xx/mach-otom.c
index 718cde8..7b86707 100644
--- a/arch/arm/mach-s3c24xx/mach-otom.c
+++ b/arch/arm/mach-s3c24xx/mach-otom.c
@@ -33,7 +33,6 @@
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/regs-serial.h>
-#include <plat/s3c2410.h>
 #include <plat/samsung-time.h>
 
 #include "common.h"
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2413.c b/arch/arm/mach-s3c24xx/mach-smdk2413.c
index 960f6d2..d5ef86d 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2413.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2413.c
@@ -41,8 +41,6 @@
 #include <linux/platform_data/i2c-s3c2410.h>
 #include <mach/fb.h>
 
-#include <plat/s3c2410.h>
-#include <plat/s3c2412.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
@@ -50,6 +48,8 @@
 
 #include <plat/common-smdk.h>
 
+#include "common.h"
+
 static struct map_desc smdk2413_iodesc[] __initdata = {
 };
 
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2416.c b/arch/arm/mach-s3c24xx/mach-smdk2416.c
index eef720d..5385f26 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2416.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2416.c
@@ -42,7 +42,6 @@
 #include <linux/platform_data/leds-s3c24xx.h>
 #include <linux/platform_data/i2c-s3c2410.h>
 
-#include <plat/s3c2416.h>
 #include <plat/gpio-cfg.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
@@ -57,6 +56,8 @@
 
 #include <plat/common-smdk.h>
 
+#include "common.h"
+
 static struct map_desc smdk2416_iodesc[] __initdata = {
 	/* ISA IO Space map (memory space selected by A24) */
 
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2440.c b/arch/arm/mach-s3c24xx/mach-smdk2440.c
index 05bf045..3f13e85 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2440.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2440.c
@@ -38,8 +38,6 @@
 #include <mach/fb.h>
 #include <linux/platform_data/i2c-s3c2410.h>
 
-#include <plat/s3c2410.h>
-#include <plat/s3c244x.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2443.c b/arch/arm/mach-s3c24xx/mach-smdk2443.c
index d9991fb..f60d485 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2443.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2443.c
@@ -38,8 +38,6 @@
 #include <mach/fb.h>
 #include <linux/platform_data/i2c-s3c2410.h>
 
-#include <plat/s3c2410.h>
-#include <plat/s3c2443.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
@@ -47,6 +45,8 @@
 
 #include <plat/common-smdk.h>
 
+#include "common.h"
+
 static struct map_desc smdk2443_iodesc[] __initdata = {
 	/* ISA IO Space map (memory space selected by A24) */
 
diff --git a/arch/arm/mach-s3c24xx/mach-vstms.c b/arch/arm/mach-s3c24xx/mach-vstms.c
index dcc0f40..622a1ed 100644
--- a/arch/arm/mach-s3c24xx/mach-vstms.c
+++ b/arch/arm/mach-s3c24xx/mach-vstms.c
@@ -41,13 +41,13 @@
 #include <linux/platform_data/i2c-s3c2410.h>
 #include <linux/platform_data/mtd-nand-s3c2410.h>
 
-#include <plat/s3c2410.h>
-#include <plat/s3c2412.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <plat/samsung-time.h>
 
+#include "common.h"
+
 static struct map_desc vstms_iodesc[] __initdata = {
 };
 
diff --git a/arch/arm/mach-s3c24xx/pm-s3c2412.c b/arch/arm/mach-s3c24xx/pm-s3c2412.c
index 668a78a..4c4bc1c 100644
--- a/arch/arm/mach-s3c24xx/pm-s3c2412.c
+++ b/arch/arm/mach-s3c24xx/pm-s3c2412.c
@@ -29,7 +29,6 @@
 
 #include <plat/cpu.h>
 #include <plat/pm.h>
-#include <plat/s3c2412.h>
 
 #include "regs-dsc.h"
 #include "s3c2412-power.h"
diff --git a/arch/arm/mach-s3c24xx/s3c2410.c b/arch/arm/mach-s3c24xx/s3c2410.c
index 9ebef95..d850ea5 100644
--- a/arch/arm/mach-s3c24xx/s3c2410.c
+++ b/arch/arm/mach-s3c24xx/s3c2410.c
@@ -37,7 +37,6 @@
 #include <mach/regs-clock.h>
 #include <plat/regs-serial.h>
 
-#include <plat/s3c2410.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/clock.h>
diff --git a/arch/arm/mach-s3c24xx/s3c2412.c b/arch/arm/mach-s3c24xx/s3c2412.c
index 0d59215..0f864d4 100644
--- a/arch/arm/mach-s3c24xx/s3c2412.c
+++ b/arch/arm/mach-s3c24xx/s3c2412.c
@@ -44,7 +44,6 @@
 #include <plat/pm.h>
 #include <plat/regs-serial.h>
 #include <plat/regs-spi.h>
-#include <plat/s3c2412.h>
 
 #include "common.h"
 #include "regs-dsc.h"
diff --git a/arch/arm/mach-s3c24xx/s3c2416.c b/arch/arm/mach-s3c24xx/s3c2416.c
index e30476d..b9c5d38 100644
--- a/arch/arm/mach-s3c24xx/s3c2416.c
+++ b/arch/arm/mach-s3c24xx/s3c2416.c
@@ -50,7 +50,6 @@
 #include <plat/gpio-core.h>
 #include <plat/gpio-cfg.h>
 #include <plat/gpio-cfg-helpers.h>
-#include <plat/s3c2416.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <plat/sdhci.h>
diff --git a/arch/arm/mach-s3c24xx/s3c2440.c b/arch/arm/mach-s3c24xx/s3c2440.c
index 559e394..5f9d656 100644
--- a/arch/arm/mach-s3c24xx/s3c2440.c
+++ b/arch/arm/mach-s3c24xx/s3c2440.c
@@ -33,7 +33,6 @@
 
 #include <plat/devs.h>
 #include <plat/cpu.h>
-#include <plat/s3c244x.h>
 #include <plat/pm.h>
 
 #include <plat/gpio-core.h>
diff --git a/arch/arm/mach-s3c24xx/s3c2442.c b/arch/arm/mach-s3c24xx/s3c2442.c
index f732826..6819961 100644
--- a/arch/arm/mach-s3c24xx/s3c2442.c
+++ b/arch/arm/mach-s3c24xx/s3c2442.c
@@ -44,7 +44,6 @@
 
 #include <plat/clock.h>
 #include <plat/cpu.h>
-#include <plat/s3c244x.h>
 #include <plat/pm.h>
 
 #include <plat/gpio-core.h>
diff --git a/arch/arm/mach-s3c24xx/s3c2443.c b/arch/arm/mach-s3c24xx/s3c2443.c
index 165b6a6..8328cd6 100644
--- a/arch/arm/mach-s3c24xx/s3c2443.c
+++ b/arch/arm/mach-s3c24xx/s3c2443.c
@@ -36,7 +36,6 @@
 #include <plat/gpio-core.h>
 #include <plat/gpio-cfg.h>
 #include <plat/gpio-cfg-helpers.h>
-#include <plat/s3c2443.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <plat/fb-core.h>
diff --git a/arch/arm/mach-s3c24xx/s3c244x.c b/arch/arm/mach-s3c24xx/s3c244x.c
index ad2671b..2a35edb 100644
--- a/arch/arm/mach-s3c24xx/s3c244x.c
+++ b/arch/arm/mach-s3c24xx/s3c244x.c
@@ -37,8 +37,6 @@
 #include <plat/regs-serial.h>
 #include <mach/regs-gpio.h>
 
-#include <plat/s3c2410.h>
-#include <plat/s3c244x.h>
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
diff --git a/arch/arm/plat-samsung/include/plat/s3c2410.h b/arch/arm/plat-samsung/include/plat/s3c2410.h
deleted file mode 100644
index 55b0e5f..0000000
--- a/arch/arm/plat-samsung/include/plat/s3c2410.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/* linux/arch/arm/plat-samsung/include/plat/s3c2410.h
- *
- * Copyright (c) 2004 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * Header file for s3c2410 machine directory
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
-*/
-
-#ifdef CONFIG_CPU_S3C2410
-
-extern  int s3c2410_init(void);
-extern  int s3c2410a_init(void);
-
-extern void s3c2410_map_io(void);
-
-extern void s3c2410_init_uarts(struct s3c2410_uartcfg *cfg, int no);
-
-extern void s3c2410_init_clocks(int xtal);
-
-#else
-#define s3c2410_init_clocks NULL
-#define s3c2410_init_uarts NULL
-#define s3c2410_map_io NULL
-#define s3c2410_init NULL
-#define s3c2410a_init NULL
-#endif
diff --git a/arch/arm/plat-samsung/include/plat/s3c2412.h b/arch/arm/plat-samsung/include/plat/s3c2412.h
deleted file mode 100644
index cbae50d..0000000
--- a/arch/arm/plat-samsung/include/plat/s3c2412.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/* linux/arch/arm/plat-samsung/include/plat/s3c2412.h
- *
- * Copyright (c) 2006 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * Header file for s3c2412 cpu support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifdef CONFIG_CPU_S3C2412
-
-extern  int s3c2412_init(void);
-
-extern void s3c2412_map_io(void);
-
-extern void s3c2412_init_uarts(struct s3c2410_uartcfg *cfg, int no);
-
-extern void s3c2412_init_clocks(int xtal);
-
-extern  int s3c2412_baseclk_add(void);
-
-extern void s3c2412_restart(char mode, const char *cmd);
-#else
-#define s3c2412_init_clocks NULL
-#define s3c2412_init_uarts NULL
-#define s3c2412_map_io NULL
-#define s3c2412_init NULL
-#define s3c2412_restart NULL
-#endif
diff --git a/arch/arm/plat-samsung/include/plat/s3c2416.h b/arch/arm/plat-samsung/include/plat/s3c2416.h
deleted file mode 100644
index f27399a..0000000
--- a/arch/arm/plat-samsung/include/plat/s3c2416.h
+++ /dev/null
@@ -1,37 +0,0 @@
-/* linux/arch/arm/plat-samsung/include/plat/s3c2416.h
- *
- * Copyright (c) 2009 Yauhen Kharuzhy <jekhor@gmail.com>
- *
- * Header file for s3c2416 cpu support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifdef CONFIG_CPU_S3C2416
-
-struct s3c2410_uartcfg;
-
-extern  int s3c2416_init(void);
-
-extern void s3c2416_map_io(void);
-
-extern void s3c2416_init_uarts(struct s3c2410_uartcfg *cfg, int no);
-
-extern void s3c2416_init_clocks(int xtal);
-
-extern  int s3c2416_baseclk_add(void);
-
-extern void s3c2416_restart(char mode, const char *cmd);
-
-extern void s3c2416_init_irq(void);
-extern struct syscore_ops s3c2416_irq_syscore_ops;
-
-#else
-#define s3c2416_init_clocks NULL
-#define s3c2416_init_uarts NULL
-#define s3c2416_map_io NULL
-#define s3c2416_init NULL
-#define s3c2416_restart NULL
-#endif
diff --git a/arch/arm/plat-samsung/include/plat/s3c2443.h b/arch/arm/plat-samsung/include/plat/s3c2443.h
deleted file mode 100644
index 71b88ec..0000000
--- a/arch/arm/plat-samsung/include/plat/s3c2443.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/* linux/arch/arm/plat-samsung/include/plat/s3c2443.h
- *
- * Copyright (c) 2004-2005 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * Header file for s3c2443 cpu support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifdef CONFIG_CPU_S3C2443
-
-struct s3c2410_uartcfg;
-
-extern  int s3c2443_init(void);
-
-extern void s3c2443_map_io(void);
-
-extern void s3c2443_init_uarts(struct s3c2410_uartcfg *cfg, int no);
-
-extern void s3c2443_init_clocks(int xtal);
-
-extern  int s3c2443_baseclk_add(void);
-
-extern void s3c2443_restart(char mode, const char *cmd);
-
-extern void s3c2443_init_irq(void);
-#else
-#define s3c2443_init_clocks NULL
-#define s3c2443_init_uarts NULL
-#define s3c2443_map_io NULL
-#define s3c2443_init NULL
-#define s3c2443_restart NULL
-#endif
diff --git a/arch/arm/plat-samsung/include/plat/s3c244x.h b/arch/arm/plat-samsung/include/plat/s3c244x.h
deleted file mode 100644
index ea0c961..0000000
--- a/arch/arm/plat-samsung/include/plat/s3c244x.h
+++ /dev/null
@@ -1,42 +0,0 @@
-/* linux/arch/arm/plat-samsung/include/plat/s3c244x.h
- *
- * Copyright (c) 2004-2005 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * Header file for S3C2440 and S3C2442 cpu support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#if defined(CONFIG_CPU_S3C2440) || defined(CONFIG_CPU_S3C2442)
-
-extern void s3c244x_map_io(void);
-
-extern void s3c244x_init_uarts(struct s3c2410_uartcfg *cfg, int no);
-
-extern void s3c244x_init_clocks(int xtal);
-
-#else
-#define s3c244x_init_clocks NULL
-#define s3c244x_init_uarts NULL
-#endif
-
-#ifdef CONFIG_CPU_S3C2440
-extern  int s3c2440_init(void);
-
-extern void s3c2440_map_io(void);
-#else
-#define s3c2440_init NULL
-#define s3c2440_map_io NULL
-#endif
-
-#ifdef CONFIG_CPU_S3C2442
-extern  int s3c2442_init(void);
-
-extern void s3c2442_map_io(void);
-#else
-#define s3c2442_init NULL
-#define s3c2442_map_io NULL
-#endif
-- 
1.7.2.3

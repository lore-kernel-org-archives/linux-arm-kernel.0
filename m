From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Jan 2014 14:53:38 +0100
Subject: [PATCH] ARM: S3C[24|64]xx: move includes back under <mach/> scope
Message-ID: <1389707618-17011-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When refactoring and breaking out the includes for the
machine-specific GPIO configuration, two files were created
in <linux/platform_data/gpio-samsung-s3c[24|64]xx.h>, but as
that namespace shall be used for defining data exchanged
between machines and drivers, using it for these broad macros
and config settings is wrong.

Move the headers back into the machine-local
<mach/gpio-samsung.h> file and think about the next step.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-samsung-soc at vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Maintainers (Kukjin especially) - it'd be nice with a speedy
ACK if this looks OK. I will put it into linux-next immediately
so things are in order and smoketested for the merge window.
---
 arch/arm/mach-s3c24xx/common-smdk.c                |   2 +-
 arch/arm/mach-s3c24xx/h1940-bluetooth.c            |   2 +-
 arch/arm/mach-s3c24xx/include/mach/gpio-samsung.h  | 106 +++++++++++++++++++++
 arch/arm/mach-s3c24xx/mach-amlm5900.c              |   2 +-
 arch/arm/mach-s3c24xx/mach-anubis.c                |   2 +-
 arch/arm/mach-s3c24xx/mach-at2440evb.c             |   2 +-
 arch/arm/mach-s3c24xx/mach-bast.c                  |   2 +-
 arch/arm/mach-s3c24xx/mach-gta02.c                 |   2 +-
 arch/arm/mach-s3c24xx/mach-h1940.c                 |   2 +-
 arch/arm/mach-s3c24xx/mach-jive.c                  |   2 +-
 arch/arm/mach-s3c24xx/mach-mini2440.c              |   2 +-
 arch/arm/mach-s3c24xx/mach-n30.c                   |   2 +-
 arch/arm/mach-s3c24xx/mach-nexcoder.c              |   2 +-
 arch/arm/mach-s3c24xx/mach-osiris-dvs.c            |   2 +-
 arch/arm/mach-s3c24xx/mach-osiris.c                |   2 +-
 arch/arm/mach-s3c24xx/mach-qt2410.c                |   2 +-
 arch/arm/mach-s3c24xx/mach-rx1950.c                |   2 +-
 arch/arm/mach-s3c24xx/mach-rx3715.c                |   2 +-
 arch/arm/mach-s3c24xx/mach-smdk2413.c              |   2 +-
 arch/arm/mach-s3c24xx/mach-smdk2416.c              |   2 +-
 arch/arm/mach-s3c24xx/mach-vr1000.c                |   2 +-
 arch/arm/mach-s3c24xx/pm-s3c2410.c                 |   2 +-
 arch/arm/mach-s3c24xx/pm.c                         |   2 +-
 arch/arm/mach-s3c24xx/s3c2410.c                    |   2 +-
 arch/arm/mach-s3c24xx/s3c2416.c                    |   2 +-
 arch/arm/mach-s3c24xx/s3c2440.c                    |   2 +-
 arch/arm/mach-s3c24xx/s3c2442.c                    |   2 +-
 arch/arm/mach-s3c24xx/s3c2443.c                    |   2 +-
 arch/arm/mach-s3c24xx/setup-i2c.c                  |   2 +-
 arch/arm/mach-s3c24xx/setup-sdhci-gpio.c           |   2 +-
 arch/arm/mach-s3c24xx/setup-ts.c                   |   2 +-
 arch/arm/mach-s3c24xx/simtec-usb.c                 |   2 +-
 arch/arm/mach-s3c64xx/common.c                     |   2 +-
 arch/arm/mach-s3c64xx/crag6410.h                   |   2 +-
 arch/arm/mach-s3c64xx/dev-audio.c                  |   2 +-
 arch/arm/mach-s3c64xx/include/mach/gpio-samsung.h  |  94 ++++++++++++++++++
 arch/arm/mach-s3c64xx/mach-anw6410.c               |   2 +-
 arch/arm/mach-s3c64xx/mach-crag6410.c              |   3 +-
 arch/arm/mach-s3c64xx/mach-hmt.c                   |   2 +-
 arch/arm/mach-s3c64xx/mach-mini6410.c              |   2 +-
 arch/arm/mach-s3c64xx/mach-real6410.c              |   2 +-
 arch/arm/mach-s3c64xx/mach-smartq.c                |   2 +-
 arch/arm/mach-s3c64xx/mach-smartq5.c               |   2 +-
 arch/arm/mach-s3c64xx/mach-smartq7.c               |   2 +-
 arch/arm/mach-s3c64xx/mach-smdk6400.c              |   2 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c              |   2 +-
 arch/arm/mach-s3c64xx/pm.c                         |   2 +-
 arch/arm/mach-s3c64xx/setup-fb-24bpp.c             |   2 +-
 arch/arm/mach-s3c64xx/setup-i2c0.c                 |   2 +-
 arch/arm/mach-s3c64xx/setup-i2c1.c                 |   2 +-
 arch/arm/mach-s3c64xx/setup-ide.c                  |   2 +-
 arch/arm/mach-s3c64xx/setup-keypad.c               |   2 +-
 arch/arm/mach-s3c64xx/setup-sdhci-gpio.c           |   2 +-
 arch/arm/mach-s3c64xx/setup-spi.c                  |   2 +-
 arch/arm/plat-samsung/pm-gpio.c                    |   7 +-
 arch/arm/plat-samsung/setup-camif.c                |   2 +-
 drivers/gpio/gpio-samsung.c                        |   7 +-
 drivers/mmc/host/s3cmci.c                          |   2 +-
 include/linux/platform_data/gpio-samsung-s3c24xx.h | 106 ---------------------
 include/linux/platform_data/gpio-samsung-s3c64xx.h |  94 ------------------
 60 files changed, 256 insertions(+), 267 deletions(-)
 create mode 100644 arch/arm/mach-s3c24xx/include/mach/gpio-samsung.h
 create mode 100644 arch/arm/mach-s3c64xx/include/mach/gpio-samsung.h
 delete mode 100644 include/linux/platform_data/gpio-samsung-s3c24xx.h
 delete mode 100644 include/linux/platform_data/gpio-samsung-s3c64xx.h

diff --git a/arch/arm/mach-s3c24xx/common-smdk.c b/arch/arm/mach-s3c24xx/common-smdk.c
index 0a84a9c9f429..e9fbcc91c5c0 100644
--- a/arch/arm/mach-s3c24xx/common-smdk.c
+++ b/arch/arm/mach-s3c24xx/common-smdk.c
@@ -37,8 +37,8 @@
 #include <asm/irq.h>
 
 #include <mach/regs-gpio.h>
+#include <mach/gpio-samsung.h>
 #include <linux/platform_data/leds-s3c24xx.h>
-#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 #include <linux/platform_data/mtd-nand-s3c2410.h>
 
 #include <plat/gpio-cfg.h>
diff --git a/arch/arm/mach-s3c24xx/h1940-bluetooth.c b/arch/arm/mach-s3c24xx/h1940-bluetooth.c
index f2b859f4c894..ff3afc163178 100644
--- a/arch/arm/mach-s3c24xx/h1940-bluetooth.c
+++ b/arch/arm/mach-s3c24xx/h1940-bluetooth.c
@@ -18,10 +18,10 @@
 #include <linux/leds.h>
 #include <linux/gpio.h>
 #include <linux/rfkill.h>
-#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <mach/hardware.h>
 #include <mach/regs-gpio.h>
+#include <mach/gpio-samsung.h>
 
 #include "h1940.h"
 
diff --git a/arch/arm/mach-s3c24xx/include/mach/gpio-samsung.h b/arch/arm/mach-s3c24xx/include/mach/gpio-samsung.h
new file mode 100644
index 000000000000..79b3a0e44955
--- /dev/null
+++ b/arch/arm/mach-s3c24xx/include/mach/gpio-samsung.h
@@ -0,0 +1,106 @@
+/*
+ * Copyright (c) 2008 Simtec Electronics
+ *	http://armlinux.simtec.co.uk/
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * S3C2410 - GPIO lib support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/* some boards require extra gpio capacity to support external
+ * devices that need GPIO.
+ */
+
+#ifndef GPIO_SAMSUNG_S3C24XX_H
+#define GPIO_SAMSUNG_S3C24XX_H
+
+/*
+ * GPIO sizes for various SoCs:
+ *
+ *   2410 2412 2440 2443 2416
+ *             2442
+ *   ---- ---- ---- ---- ----
+ * A  23   22   25   16   27
+ * B  11   11   11   11   11
+ * C  16   16   16   16   16
+ * D  16   16   16   16   16
+ * E  16   16   16   16   16
+ * F  8    8    8    8    8
+ * G  16   16   16   16   8
+ * H  11   11   11   15   15
+ * J  --   --   13   16   --
+ * K  --   --   --   --   16
+ * L  --   --   --   15   14
+ * M  --   --   --   2    2
+ */
+
+/* GPIO bank sizes */
+
+#define S3C2410_GPIO_A_NR	(32)
+#define S3C2410_GPIO_B_NR	(32)
+#define S3C2410_GPIO_C_NR	(32)
+#define S3C2410_GPIO_D_NR	(32)
+#define S3C2410_GPIO_E_NR	(32)
+#define S3C2410_GPIO_F_NR	(32)
+#define S3C2410_GPIO_G_NR	(32)
+#define S3C2410_GPIO_H_NR	(32)
+#define S3C2410_GPIO_J_NR	(32)	/* technically 16. */
+#define S3C2410_GPIO_K_NR	(32)	/* technically 16. */
+#define S3C2410_GPIO_L_NR	(32)	/* technically 15. */
+#define S3C2410_GPIO_M_NR	(32)	/* technically 2. */
+
+#if CONFIG_S3C_GPIO_SPACE != 0
+#error CONFIG_S3C_GPIO_SPACE cannot be nonzero at the moment
+#endif
+
+#define S3C2410_GPIO_NEXT(__gpio) \
+	((__gpio##_START) + (__gpio##_NR) + CONFIG_S3C_GPIO_SPACE + 0)
+
+#ifndef __ASSEMBLY__
+
+enum s3c_gpio_number {
+	S3C2410_GPIO_A_START = 0,
+	S3C2410_GPIO_B_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_A),
+	S3C2410_GPIO_C_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_B),
+	S3C2410_GPIO_D_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_C),
+	S3C2410_GPIO_E_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_D),
+	S3C2410_GPIO_F_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_E),
+	S3C2410_GPIO_G_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_F),
+	S3C2410_GPIO_H_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_G),
+	S3C2410_GPIO_J_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_H),
+	S3C2410_GPIO_K_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_J),
+	S3C2410_GPIO_L_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_K),
+	S3C2410_GPIO_M_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_L),
+};
+
+#endif /* __ASSEMBLY__ */
+
+/* S3C2410 GPIO number definitions. */
+
+#define S3C2410_GPA(_nr)	(S3C2410_GPIO_A_START + (_nr))
+#define S3C2410_GPB(_nr)	(S3C2410_GPIO_B_START + (_nr))
+#define S3C2410_GPC(_nr)	(S3C2410_GPIO_C_START + (_nr))
+#define S3C2410_GPD(_nr)	(S3C2410_GPIO_D_START + (_nr))
+#define S3C2410_GPE(_nr)	(S3C2410_GPIO_E_START + (_nr))
+#define S3C2410_GPF(_nr)	(S3C2410_GPIO_F_START + (_nr))
+#define S3C2410_GPG(_nr)	(S3C2410_GPIO_G_START + (_nr))
+#define S3C2410_GPH(_nr)	(S3C2410_GPIO_H_START + (_nr))
+#define S3C2410_GPJ(_nr)	(S3C2410_GPIO_J_START + (_nr))
+#define S3C2410_GPK(_nr)	(S3C2410_GPIO_K_START + (_nr))
+#define S3C2410_GPL(_nr)	(S3C2410_GPIO_L_START + (_nr))
+#define S3C2410_GPM(_nr)	(S3C2410_GPIO_M_START + (_nr))
+
+#include <plat/gpio-cfg.h>
+
+#ifdef CONFIG_CPU_S3C244X
+#define S3C_GPIO_END	(S3C2410_GPJ(0) + 32)
+#elif defined(CONFIG_CPU_S3C2443) || defined(CONFIG_CPU_S3C2416)
+#define S3C_GPIO_END	(S3C2410_GPM(0) + 32)
+#else
+#define S3C_GPIO_END	(S3C2410_GPH(0) + 32)
+#endif
+
+#endif /* GPIO_SAMSUNG_S3C24XX_H */
diff --git a/arch/arm/mach-s3c24xx/mach-amlm5900.c b/arch/arm/mach-s3c24xx/mach-amlm5900.c
index 530e9a624466..284ea1f44205 100644
--- a/arch/arm/mach-s3c24xx/mach-amlm5900.c
+++ b/arch/arm/mach-s3c24xx/mach-amlm5900.c
@@ -52,9 +52,9 @@
 #include <plat/regs-serial.h>
 #include <mach/regs-lcd.h>
 #include <mach/regs-gpio.h>
+#include <mach/gpio-samsung.h>
 
 #include <linux/platform_data/i2c-s3c2410.h>
-#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <plat/gpio-cfg.h>
diff --git a/arch/arm/mach-s3c24xx/mach-anubis.c b/arch/arm/mach-s3c24xx/mach-anubis.c
index b60a248c033a..2a16f8fb3584 100644
--- a/arch/arm/mach-s3c24xx/mach-anubis.c
+++ b/arch/arm/mach-s3c24xx/mach-anubis.c
@@ -35,9 +35,9 @@
 #include <plat/regs-serial.h>
 #include <mach/regs-gpio.h>
 #include <mach/regs-lcd.h>
+#include <mach/gpio-samsung.h>
 #include <linux/platform_data/mtd-nand-s3c2410.h>
 #include <linux/platform_data/i2c-s3c2410.h>
-#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
diff --git a/arch/arm/mach-s3c24xx/mach-at2440evb.c b/arch/arm/mach-s3c24xx/mach-at2440evb.c
index 74401196b429..6beab674c147 100644
--- a/arch/arm/mach-s3c24xx/mach-at2440evb.c
+++ b/arch/arm/mach-s3c24xx/mach-at2440evb.c
@@ -36,9 +36,9 @@
 #include <plat/regs-serial.h>
 #include <mach/regs-gpio.h>
 #include <mach/regs-lcd.h>
+#include <mach/gpio-samsung.h>
 #include <linux/platform_data/mtd-nand-s3c2410.h>
 #include <linux/platform_data/i2c-s3c2410.h>
-#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
diff --git a/arch/arm/mach-s3c24xx/mach-bast.c b/arch/arm/mach-s3c24xx/mach-bast.c
index 47fe7af87129..981ba1eb9fdc 100644
--- a/arch/arm/mach-s3c24xx/mach-bast.c
+++ b/arch/arm/mach-s3c24xx/mach-bast.c
@@ -35,7 +35,6 @@
 #include <linux/platform_data/hwmon-s3c.h>
 #include <linux/platform_data/i2c-s3c2410.h>
 #include <linux/platform_data/mtd-nand-s3c2410.h>
-#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <net/ax88796.h>
 
@@ -49,6 +48,7 @@
 #include <mach/hardware.h>
 #include <mach/regs-gpio.h>
 #include <mach/regs-lcd.h>
+#include <mach/gpio-samsung.h>
 
 #include <plat/clock.h>
 #include <plat/cpu.h>
diff --git a/arch/arm/mach-s3c24xx/mach-gta02.c b/arch/arm/mach-s3c24xx/mach-gta02.c
index c2c2ac78cea8..d9170e9f8ccd 100644
--- a/arch/arm/mach-s3c24xx/mach-gta02.c
+++ b/arch/arm/mach-s3c24xx/mach-gta02.c
@@ -70,12 +70,12 @@
 #include <linux/platform_data/touchscreen-s3c2410.h>
 #include <linux/platform_data/usb-ohci-s3c2410.h>
 #include <linux/platform_data/usb-s3c2410_udc.h>
-#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <mach/fb.h>
 #include <mach/hardware.h>
 #include <mach/regs-gpio.h>
 #include <mach/regs-irq.h>
+#include <mach/gpio-samsung.h>
 
 #include <plat/cpu.h>
 #include <plat/devs.h>
diff --git a/arch/arm/mach-s3c24xx/mach-h1940.c b/arch/arm/mach-s3c24xx/mach-h1940.c
index d25d8b18512c..de0832181d8c 100644
--- a/arch/arm/mach-s3c24xx/mach-h1940.c
+++ b/arch/arm/mach-s3c24xx/mach-h1940.c
@@ -46,7 +46,6 @@
 #include <linux/platform_data/mmc-s3cmci.h>
 #include <linux/platform_data/touchscreen-s3c2410.h>
 #include <linux/platform_data/usb-s3c2410_udc.h>
-#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <sound/uda1380.h>
 
@@ -55,6 +54,7 @@
 #include <mach/regs-clock.h>
 #include <mach/regs-gpio.h>
 #include <mach/regs-lcd.h>
+#include <mach/gpio-samsung.h>
 
 #include <plat/clock.h>
 #include <plat/cpu.h>
diff --git a/arch/arm/mach-s3c24xx/mach-jive.c b/arch/arm/mach-s3c24xx/mach-jive.c
index 434dbf231773..67cb8e948b7e 100644
--- a/arch/arm/mach-s3c24xx/mach-jive.c
+++ b/arch/arm/mach-s3c24xx/mach-jive.c
@@ -34,11 +34,11 @@
 #include <plat/regs-serial.h>
 #include <linux/platform_data/mtd-nand-s3c2410.h>
 #include <linux/platform_data/i2c-s3c2410.h>
-#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <mach/regs-gpio.h>
 #include <mach/regs-lcd.h>
 #include <mach/fb.h>
+#include <mach/gpio-samsung.h>
 
 #include <asm/mach-types.h>
 
diff --git a/arch/arm/mach-s3c24xx/mach-mini2440.c b/arch/arm/mach-s3c24xx/mach-mini2440.c
index 48af11fc15fd..1f1559713d8b 100644
--- a/arch/arm/mach-s3c24xx/mach-mini2440.c
+++ b/arch/arm/mach-s3c24xx/mach-mini2440.c
@@ -42,11 +42,11 @@
 #include <linux/platform_data/leds-s3c24xx.h>
 #include <mach/regs-lcd.h>
 #include <mach/irqs.h>
+#include <mach/gpio-samsung.h>
 #include <linux/platform_data/mtd-nand-s3c2410.h>
 #include <linux/platform_data/i2c-s3c2410.h>
 #include <linux/platform_data/mmc-s3cmci.h>
 #include <linux/platform_data/usb-s3c2410_udc.h>
-#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
diff --git a/arch/arm/mach-s3c24xx/mach-n30.c b/arch/arm/mach-s3c24xx/mach-n30.c
index 7fcb887f5289..997684f17930 100644
--- a/arch/arm/mach-s3c24xx/mach-n30.c
+++ b/arch/arm/mach-s3c24xx/mach-n30.c
@@ -36,13 +36,13 @@
 #include <linux/platform_data/leds-s3c24xx.h>
 #include <mach/regs-gpio.h>
 #include <mach/regs-lcd.h>
+#include <mach/gpio-samsung.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/map.h>
 
 #include <linux/platform_data/i2c-s3c2410.h>
-#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 #include <plat/regs-serial.h>
 
 #include <plat/clock.h>
diff --git a/arch/arm/mach-s3c24xx/mach-nexcoder.c b/arch/arm/mach-s3c24xx/mach-nexcoder.c
index 0f27ac44db09..575d28c9e6c6 100644
--- a/arch/arm/mach-s3c24xx/mach-nexcoder.c
+++ b/arch/arm/mach-s3c24xx/mach-nexcoder.c
@@ -37,9 +37,9 @@
 
 //#include <asm/debug-ll.h>
 #include <mach/regs-gpio.h>
+#include <mach/gpio-samsung.h>
 #include <plat/regs-serial.h>
 #include <linux/platform_data/i2c-s3c2410.h>
-#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <plat/gpio-cfg.h>
 #include <plat/clock.h>
diff --git a/arch/arm/mach-s3c24xx/mach-osiris-dvs.c b/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
index 5b8af46c0d6b..33afb9190091 100644
--- a/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
+++ b/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
@@ -16,11 +16,11 @@
 #include <linux/platform_device.h>
 #include <linux/cpufreq.h>
 #include <linux/gpio.h>
-#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <linux/i2c/tps65010.h>
 
 #include <plat/cpu-freq.h>
+#include <mach/gpio-samsung.h>
 
 #define OSIRIS_GPIO_DVS	S3C2410_GPB(5)
 
diff --git a/arch/arm/mach-s3c24xx/mach-osiris.c b/arch/arm/mach-s3c24xx/mach-osiris.c
index 040b16aff93d..f84f2a4c0c6d 100644
--- a/arch/arm/mach-s3c24xx/mach-osiris.c
+++ b/arch/arm/mach-s3c24xx/mach-osiris.c
@@ -33,7 +33,6 @@
 
 #include <linux/platform_data/mtd-nand-s3c2410.h>
 #include <linux/platform_data/i2c-s3c2410.h>
-#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
@@ -51,6 +50,7 @@
 #include <mach/hardware.h>
 #include <mach/regs-gpio.h>
 #include <mach/regs-lcd.h>
+#include <mach/gpio-samsung.h>
 
 #include "common.h"
 #include "osiris.h"
diff --git a/arch/arm/mach-s3c24xx/mach-qt2410.c b/arch/arm/mach-s3c24xx/mach-qt2410.c
index 96c3bc858710..b534b76812e3 100644
--- a/arch/arm/mach-s3c24xx/mach-qt2410.c
+++ b/arch/arm/mach-s3c24xx/mach-qt2410.c
@@ -54,7 +54,7 @@
 #include <linux/platform_data/mtd-nand-s3c2410.h>
 #include <linux/platform_data/usb-s3c2410_udc.h>
 #include <linux/platform_data/i2c-s3c2410.h>
-#include <linux/platform_data/gpio-samsung-s3c24xx.h>
+#include <mach/gpio-samsung.h>
 
 #include <plat/gpio-cfg.h>
 #include <plat/devs.h>
diff --git a/arch/arm/mach-s3c24xx/mach-rx1950.c b/arch/arm/mach-s3c24xx/mach-rx1950.c
index d492fb938bbb..345d01aa3524 100644
--- a/arch/arm/mach-s3c24xx/mach-rx1950.c
+++ b/arch/arm/mach-s3c24xx/mach-rx1950.c
@@ -45,13 +45,13 @@
 #include <linux/platform_data/mtd-nand-s3c2410.h>
 #include <linux/platform_data/touchscreen-s3c2410.h>
 #include <linux/platform_data/usb-s3c2410_udc.h>
-#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <sound/uda1380.h>
 
 #include <mach/fb.h>
 #include <mach/regs-gpio.h>
 #include <mach/regs-lcd.h>
+#include <mach/gpio-samsung.h>
 
 #include <plat/clock.h>
 #include <plat/cpu.h>
diff --git a/arch/arm/mach-s3c24xx/mach-rx3715.c b/arch/arm/mach-s3c24xx/mach-rx3715.c
index 319ed8033475..b36edce8b2b8 100644
--- a/arch/arm/mach-s3c24xx/mach-rx3715.c
+++ b/arch/arm/mach-s3c24xx/mach-rx3715.c
@@ -35,7 +35,6 @@
 #include <asm/mach/map.h>
 
 #include <linux/platform_data/mtd-nand-s3c2410.h>
-#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <asm/irq.h>
 #include <asm/mach-types.h>
@@ -44,6 +43,7 @@
 #include <mach/hardware.h>
 #include <mach/regs-gpio.h>
 #include <mach/regs-lcd.h>
+#include <mach/gpio-samsung.h>
 
 #include <plat/clock.h>
 #include <plat/cpu.h>
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2413.c b/arch/arm/mach-s3c24xx/mach-smdk2413.c
index 86e25012b0c1..f5bc721217e3 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2413.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2413.c
@@ -39,7 +39,7 @@
 
 #include <linux/platform_data/usb-s3c2410_udc.h>
 #include <linux/platform_data/i2c-s3c2410.h>
-#include <linux/platform_data/gpio-samsung-s3c24xx.h>
+#include <mach/gpio-samsung.h>
 #include <mach/fb.h>
 
 #include <plat/clock.h>
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2416.c b/arch/arm/mach-s3c24xx/mach-smdk2416.c
index 0cc691d01d60..12023cae4378 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2416.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2416.c
@@ -38,10 +38,10 @@
 #include <mach/regs-gpio.h>
 #include <mach/regs-lcd.h>
 #include <mach/regs-s3c2443-clock.h>
+#include <mach/gpio-samsung.h>
 
 #include <linux/platform_data/leds-s3c24xx.h>
 #include <linux/platform_data/i2c-s3c2410.h>
-#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <plat/gpio-cfg.h>
 #include <plat/clock.h>
diff --git a/arch/arm/mach-s3c24xx/mach-vr1000.c b/arch/arm/mach-s3c24xx/mach-vr1000.c
index 86e7ffdca33f..755df489a45f 100644
--- a/arch/arm/mach-s3c24xx/mach-vr1000.c
+++ b/arch/arm/mach-s3c24xx/mach-vr1000.c
@@ -37,10 +37,10 @@
 #include <linux/platform_data/leds-s3c24xx.h>
 #include <linux/platform_data/i2c-s3c2410.h>
 #include <linux/platform_data/asoc-s3c24xx_simtec.h>
-#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <mach/hardware.h>
 #include <mach/regs-gpio.h>
+#include <mach/gpio-samsung.h>
 
 #include <plat/clock.h>
 #include <plat/cpu.h>
diff --git a/arch/arm/mach-s3c24xx/pm-s3c2410.c b/arch/arm/mach-s3c24xx/pm-s3c2410.c
index e4cd56e8b90b..509b20b4ab3b 100644
--- a/arch/arm/mach-s3c24xx/pm-s3c2410.c
+++ b/arch/arm/mach-s3c24xx/pm-s3c2410.c
@@ -28,12 +28,12 @@
 #include <linux/syscore_ops.h>
 #include <linux/gpio.h>
 #include <linux/io.h>
-#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <asm/mach-types.h>
 
 #include <mach/hardware.h>
 #include <mach/regs-gpio.h>
+#include <mach/gpio-samsung.h>
 
 #include <plat/cpu.h>
 #include <plat/pm.h>
diff --git a/arch/arm/mach-s3c24xx/pm.c b/arch/arm/mach-s3c24xx/pm.c
index 2baa887b28d2..052ca23393a7 100644
--- a/arch/arm/mach-s3c24xx/pm.c
+++ b/arch/arm/mach-s3c24xx/pm.c
@@ -34,12 +34,12 @@
 #include <linux/interrupt.h>
 #include <linux/serial_core.h>
 #include <linux/io.h>
-#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <plat/regs-serial.h>
 #include <mach/regs-clock.h>
 #include <mach/regs-gpio.h>
 #include <mach/regs-irq.h>
+#include <mach/gpio-samsung.h>
 
 #include <asm/mach/time.h>
 
diff --git a/arch/arm/mach-s3c24xx/s3c2410.c b/arch/arm/mach-s3c24xx/s3c2410.c
index db22f748ce8d..ffb92cbca08c 100644
--- a/arch/arm/mach-s3c24xx/s3c2410.c
+++ b/arch/arm/mach-s3c24xx/s3c2410.c
@@ -24,13 +24,13 @@
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
 #include <linux/io.h>
-#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
+#include <mach/gpio-samsung.h>
 #include <asm/irq.h>
 #include <asm/system_misc.h>
 
diff --git a/arch/arm/mach-s3c24xx/s3c2416.c b/arch/arm/mach-s3c24xx/s3c2416.c
index cb77880029f7..8e01b4f2df35 100644
--- a/arch/arm/mach-s3c24xx/s3c2416.c
+++ b/arch/arm/mach-s3c24xx/s3c2416.c
@@ -36,13 +36,13 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/reboot.h>
-#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
+#include <mach/gpio-samsung.h>
 #include <asm/proc-fns.h>
 #include <asm/irq.h>
 #include <asm/system_misc.h>
diff --git a/arch/arm/mach-s3c24xx/s3c2440.c b/arch/arm/mach-s3c24xx/s3c2440.c
index 22e5dbdcbe8d..03d379f1fc52 100644
--- a/arch/arm/mach-s3c24xx/s3c2440.c
+++ b/arch/arm/mach-s3c24xx/s3c2440.c
@@ -23,13 +23,13 @@
 #include <linux/gpio.h>
 #include <linux/clk.h>
 #include <linux/io.h>
-#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
+#include <mach/gpio-samsung.h>
 #include <asm/irq.h>
 
 #include <plat/devs.h>
diff --git a/arch/arm/mach-s3c24xx/s3c2442.c b/arch/arm/mach-s3c24xx/s3c2442.c
index 4ba093b4e495..2c8adc028538 100644
--- a/arch/arm/mach-s3c24xx/s3c2442.c
+++ b/arch/arm/mach-s3c24xx/s3c2442.c
@@ -35,9 +35,9 @@
 #include <linux/gpio.h>
 #include <linux/clk.h>
 #include <linux/io.h>
-#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <mach/hardware.h>
+#include <mach/gpio-samsung.h>
 #include <linux/atomic.h>
 #include <asm/irq.h>
 
diff --git a/arch/arm/mach-s3c24xx/s3c2443.c b/arch/arm/mach-s3c24xx/s3c2443.c
index faa1086924c4..886c2147062b 100644
--- a/arch/arm/mach-s3c24xx/s3c2443.c
+++ b/arch/arm/mach-s3c24xx/s3c2443.c
@@ -23,13 +23,13 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/reboot.h>
-#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
+#include <mach/gpio-samsung.h>
 #include <asm/irq.h>
 #include <asm/system_misc.h>
 
diff --git a/arch/arm/mach-s3c24xx/setup-i2c.c b/arch/arm/mach-s3c24xx/setup-i2c.c
index 3d1fd5ce24e5..1852696ca16e 100644
--- a/arch/arm/mach-s3c24xx/setup-i2c.c
+++ b/arch/arm/mach-s3c24xx/setup-i2c.c
@@ -17,9 +17,9 @@ struct platform_device;
 
 #include <plat/gpio-cfg.h>
 #include <linux/platform_data/i2c-s3c2410.h>
-#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 #include <mach/hardware.h>
 #include <mach/regs-gpio.h>
+#include <mach/gpio-samsung.h>
 
 void s3c_i2c0_cfg_gpio(struct platform_device *dev)
 {
diff --git a/arch/arm/mach-s3c24xx/setup-sdhci-gpio.c b/arch/arm/mach-s3c24xx/setup-sdhci-gpio.c
index 2835241f732a..c99b0f664db7 100644
--- a/arch/arm/mach-s3c24xx/setup-sdhci-gpio.c
+++ b/arch/arm/mach-s3c24xx/setup-sdhci-gpio.c
@@ -18,9 +18,9 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
-#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include <mach/regs-gpio.h>
+#include <mach/gpio-samsung.h>
 #include <plat/gpio-cfg.h>
 
 void s3c2416_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
diff --git a/arch/arm/mach-s3c24xx/setup-ts.c b/arch/arm/mach-s3c24xx/setup-ts.c
index 1ea4056f6fdc..f61f02bdc52f 100644
--- a/arch/arm/mach-s3c24xx/setup-ts.c
+++ b/arch/arm/mach-s3c24xx/setup-ts.c
@@ -12,11 +12,11 @@
 
 #include <linux/kernel.h>
 #include <linux/gpio.h>
-#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 struct platform_device; /* don't need the contents */
 
 #include <mach/hardware.h>
+#include <mach/gpio-samsung.h>
 
 /**
  * s3c24xx_ts_cfg_gpio - configure gpio for s3c2410 systems
diff --git a/arch/arm/mach-s3c24xx/simtec-usb.c b/arch/arm/mach-s3c24xx/simtec-usb.c
index a007e5f16583..8dea917e954b 100644
--- a/arch/arm/mach-s3c24xx/simtec-usb.c
+++ b/arch/arm/mach-s3c24xx/simtec-usb.c
@@ -29,10 +29,10 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
+#include <mach/gpio-samsung.h>
 #include <asm/irq.h>
 
 #include <linux/platform_data/usb-ohci-s3c2410.h>
-#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 #include <plat/devs.h>
 
 #include "bast.h"
diff --git a/arch/arm/mach-s3c64xx/common.c b/arch/arm/mach-s3c64xx/common.c
index 64edda37bde3..76ab595d849b 100644
--- a/arch/arm/mach-s3c64xx/common.c
+++ b/arch/arm/mach-s3c64xx/common.c
@@ -32,7 +32,6 @@
 #include <linux/irq.h>
 #include <linux/gpio.h>
 #include <linux/irqchip/arm-vic.h>
-#include <linux/platform_data/gpio-samsung-s3c64xx.h>
 #include <clocksource/samsung_pwm.h>
 
 #include <asm/mach/arch.h>
@@ -42,6 +41,7 @@
 #include <mach/map.h>
 #include <mach/hardware.h>
 #include <mach/regs-gpio.h>
+#include <mach/gpio-samsung.h>
 
 #include <plat/cpu.h>
 #include <plat/devs.h>
diff --git a/arch/arm/mach-s3c64xx/crag6410.h b/arch/arm/mach-s3c64xx/crag6410.h
index 9ef20b8fd36f..7bc66682687e 100644
--- a/arch/arm/mach-s3c64xx/crag6410.h
+++ b/arch/arm/mach-s3c64xx/crag6410.h
@@ -11,7 +11,7 @@
 #ifndef MACH_CRAG6410_H
 #define MACH_CRAG6410_H
 
-#include <linux/platform_data/gpio-samsung-s3c64xx.h>
+#include <mach/gpio-samsung.h>
 
 #define GLENFARCLAS_PMIC_IRQ_BASE	IRQ_BOARD_START
 
diff --git a/arch/arm/mach-s3c64xx/dev-audio.c b/arch/arm/mach-s3c64xx/dev-audio.c
index 6f58c80235dc..ff780a8d8366 100644
--- a/arch/arm/mach-s3c64xx/dev-audio.c
+++ b/arch/arm/mach-s3c64xx/dev-audio.c
@@ -21,8 +21,8 @@
 
 #include <plat/devs.h>
 #include <linux/platform_data/asoc-s3c.h>
-#include <linux/platform_data/gpio-samsung-s3c64xx.h>
 #include <plat/gpio-cfg.h>
+#include <mach/gpio-samsung.h>
 
 static int s3c64xx_i2s_cfg_gpio(struct platform_device *pdev)
 {
diff --git a/arch/arm/mach-s3c64xx/include/mach/gpio-samsung.h b/arch/arm/mach-s3c64xx/include/mach/gpio-samsung.h
new file mode 100644
index 000000000000..9c81fac3b2d5
--- /dev/null
+++ b/arch/arm/mach-s3c64xx/include/mach/gpio-samsung.h
@@ -0,0 +1,94 @@
+/*
+ * Copyright 2008 Openmoko, Inc.
+ * Copyright 2008 Simtec Electronics
+ *	http://armlinux.simtec.co.uk/
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * S3C6400 - GPIO lib support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef GPIO_SAMSUNG_S3C64XX_H
+#define GPIO_SAMSUNG_S3C64XX_H
+
+/* GPIO bank sizes */
+#define S3C64XX_GPIO_A_NR	(8)
+#define S3C64XX_GPIO_B_NR	(7)
+#define S3C64XX_GPIO_C_NR	(8)
+#define S3C64XX_GPIO_D_NR	(5)
+#define S3C64XX_GPIO_E_NR	(5)
+#define S3C64XX_GPIO_F_NR	(16)
+#define S3C64XX_GPIO_G_NR	(7)
+#define S3C64XX_GPIO_H_NR	(10)
+#define S3C64XX_GPIO_I_NR	(16)
+#define S3C64XX_GPIO_J_NR	(12)
+#define S3C64XX_GPIO_K_NR	(16)
+#define S3C64XX_GPIO_L_NR	(15)
+#define S3C64XX_GPIO_M_NR	(6)
+#define S3C64XX_GPIO_N_NR	(16)
+#define S3C64XX_GPIO_O_NR	(16)
+#define S3C64XX_GPIO_P_NR	(15)
+#define S3C64XX_GPIO_Q_NR	(9)
+
+/* GPIO bank numbes */
+
+/* CONFIG_S3C_GPIO_SPACE allows the user to select extra
+ * space for debugging purposes so that any accidental
+ * change from one gpio bank to another can be caught.
+*/
+
+#define S3C64XX_GPIO_NEXT(__gpio) \
+	((__gpio##_START) + (__gpio##_NR) + CONFIG_S3C_GPIO_SPACE + 1)
+
+enum s3c_gpio_number {
+	S3C64XX_GPIO_A_START = 0,
+	S3C64XX_GPIO_B_START = S3C64XX_GPIO_NEXT(S3C64XX_GPIO_A),
+	S3C64XX_GPIO_C_START = S3C64XX_GPIO_NEXT(S3C64XX_GPIO_B),
+	S3C64XX_GPIO_D_START = S3C64XX_GPIO_NEXT(S3C64XX_GPIO_C),
+	S3C64XX_GPIO_E_START = S3C64XX_GPIO_NEXT(S3C64XX_GPIO_D),
+	S3C64XX_GPIO_F_START = S3C64XX_GPIO_NEXT(S3C64XX_GPIO_E),
+	S3C64XX_GPIO_G_START = S3C64XX_GPIO_NEXT(S3C64XX_GPIO_F),
+	S3C64XX_GPIO_H_START = S3C64XX_GPIO_NEXT(S3C64XX_GPIO_G),
+	S3C64XX_GPIO_I_START = S3C64XX_GPIO_NEXT(S3C64XX_GPIO_H),
+	S3C64XX_GPIO_J_START = S3C64XX_GPIO_NEXT(S3C64XX_GPIO_I),
+	S3C64XX_GPIO_K_START = S3C64XX_GPIO_NEXT(S3C64XX_GPIO_J),
+	S3C64XX_GPIO_L_START = S3C64XX_GPIO_NEXT(S3C64XX_GPIO_K),
+	S3C64XX_GPIO_M_START = S3C64XX_GPIO_NEXT(S3C64XX_GPIO_L),
+	S3C64XX_GPIO_N_START = S3C64XX_GPIO_NEXT(S3C64XX_GPIO_M),
+	S3C64XX_GPIO_O_START = S3C64XX_GPIO_NEXT(S3C64XX_GPIO_N),
+	S3C64XX_GPIO_P_START = S3C64XX_GPIO_NEXT(S3C64XX_GPIO_O),
+	S3C64XX_GPIO_Q_START = S3C64XX_GPIO_NEXT(S3C64XX_GPIO_P),
+};
+
+/* S3C64XX GPIO number definitions. */
+
+#define S3C64XX_GPA(_nr)	(S3C64XX_GPIO_A_START + (_nr))
+#define S3C64XX_GPB(_nr)	(S3C64XX_GPIO_B_START + (_nr))
+#define S3C64XX_GPC(_nr)	(S3C64XX_GPIO_C_START + (_nr))
+#define S3C64XX_GPD(_nr)	(S3C64XX_GPIO_D_START + (_nr))
+#define S3C64XX_GPE(_nr)	(S3C64XX_GPIO_E_START + (_nr))
+#define S3C64XX_GPF(_nr)	(S3C64XX_GPIO_F_START + (_nr))
+#define S3C64XX_GPG(_nr)	(S3C64XX_GPIO_G_START + (_nr))
+#define S3C64XX_GPH(_nr)	(S3C64XX_GPIO_H_START + (_nr))
+#define S3C64XX_GPI(_nr)	(S3C64XX_GPIO_I_START + (_nr))
+#define S3C64XX_GPJ(_nr)	(S3C64XX_GPIO_J_START + (_nr))
+#define S3C64XX_GPK(_nr)	(S3C64XX_GPIO_K_START + (_nr))
+#define S3C64XX_GPL(_nr)	(S3C64XX_GPIO_L_START + (_nr))
+#define S3C64XX_GPM(_nr)	(S3C64XX_GPIO_M_START + (_nr))
+#define S3C64XX_GPN(_nr)	(S3C64XX_GPIO_N_START + (_nr))
+#define S3C64XX_GPO(_nr)	(S3C64XX_GPIO_O_START + (_nr))
+#define S3C64XX_GPP(_nr)	(S3C64XX_GPIO_P_START + (_nr))
+#define S3C64XX_GPQ(_nr)	(S3C64XX_GPIO_Q_START + (_nr))
+
+/* the end of the S3C64XX specific gpios */
+#define S3C64XX_GPIO_END	(S3C64XX_GPQ(S3C64XX_GPIO_Q_NR) + 1)
+#define S3C_GPIO_END		S3C64XX_GPIO_END
+
+/* define the number of gpios we need to the one after the GPQ() range */
+#define GPIO_BOARD_START (S3C64XX_GPQ(S3C64XX_GPIO_Q_NR) + 1)
+
+#endif /* GPIO_SAMSUNG_S3C64XX_H */
+
diff --git a/arch/arm/mach-s3c64xx/mach-anw6410.c b/arch/arm/mach-s3c64xx/mach-anw6410.c
index 546f45b59ea1..ddeb0e51a962 100644
--- a/arch/arm/mach-s3c64xx/mach-anw6410.c
+++ b/arch/arm/mach-s3c64xx/mach-anw6410.c
@@ -43,13 +43,13 @@
 
 #include <plat/regs-serial.h>
 #include <linux/platform_data/i2c-s3c2410.h>
-#include <linux/platform_data/gpio-samsung-s3c64xx.h>
 #include <plat/fb.h>
 
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <mach/regs-gpio.h>
+#include <mach/gpio-samsung.h>
 #include <plat/samsung-time.h>
 
 #include "common.h"
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index 7b913595e4ee..3df3c372ee1f 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -32,7 +32,6 @@
 
 #include <linux/platform_data/pca953x.h>
 #include <linux/platform_data/s3c-hsotg.h>
-#include <linux/platform_data/gpio-samsung-s3c64xx.h>
 
 #include <video/platform_lcd.h>
 
@@ -49,8 +48,8 @@
 #include <video/samsung_fimd.h>
 #include <mach/hardware.h>
 #include <mach/map.h>
-
 #include <mach/regs-gpio.h>
+#include <mach/gpio-samsung.h>
 
 #include <plat/regs-serial.h>
 #include <plat/fb.h>
diff --git a/arch/arm/mach-s3c64xx/mach-hmt.c b/arch/arm/mach-s3c64xx/mach-hmt.c
index 009b19525cbf..0431016925b9 100644
--- a/arch/arm/mach-s3c64xx/mach-hmt.c
+++ b/arch/arm/mach-s3c64xx/mach-hmt.c
@@ -35,7 +35,7 @@
 
 #include <plat/regs-serial.h>
 #include <linux/platform_data/i2c-s3c2410.h>
-#include <linux/platform_data/gpio-samsung-s3c64xx.h>
+#include <mach/gpio-samsung.h>
 #include <plat/fb.h>
 #include <linux/platform_data/mtd-nand-s3c2410.h>
 
diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-s3c64xx/mach-mini6410.c
index 14c96ee5a3fe..8c84d3448dac 100644
--- a/arch/arm/mach-s3c64xx/mach-mini6410.c
+++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
@@ -30,6 +30,7 @@
 
 #include <mach/map.h>
 #include <mach/regs-gpio.h>
+#include <mach/gpio-samsung.h>
 
 #include <plat/adc.h>
 #include <plat/cpu.h>
@@ -38,7 +39,6 @@
 #include <linux/platform_data/mtd-nand-s3c2410.h>
 #include <plat/regs-serial.h>
 #include <linux/platform_data/touchscreen-s3c2410.h>
-#include <linux/platform_data/gpio-samsung-s3c64xx.h>
 
 #include <video/platform_lcd.h>
 #include <video/samsung_fimd.h>
diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-s3c64xx/mach-real6410.c
index af45149a96b3..5152026f0e19 100644
--- a/arch/arm/mach-s3c64xx/mach-real6410.c
+++ b/arch/arm/mach-s3c64xx/mach-real6410.c
@@ -31,6 +31,7 @@
 
 #include <mach/map.h>
 #include <mach/regs-gpio.h>
+#include <mach/gpio-samsung.h>
 
 #include <plat/adc.h>
 #include <plat/cpu.h>
@@ -39,7 +40,6 @@
 #include <linux/platform_data/mtd-nand-s3c2410.h>
 #include <plat/regs-serial.h>
 #include <linux/platform_data/touchscreen-s3c2410.h>
-#include <linux/platform_data/gpio-samsung-s3c64xx.h>
 
 #include <video/platform_lcd.h>
 #include <video/samsung_fimd.h>
diff --git a/arch/arm/mach-s3c64xx/mach-smartq.c b/arch/arm/mach-s3c64xx/mach-smartq.c
index 0271b3a191e5..5629df905fcd 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq.c
@@ -25,6 +25,7 @@
 
 #include <mach/map.h>
 #include <mach/regs-gpio.h>
+#include <mach/gpio-samsung.h>
 
 #include <plat/clock.h>
 #include <plat/cpu.h>
@@ -36,7 +37,6 @@
 #include <linux/platform_data/usb-ohci-s3c2410.h>
 #include <plat/sdhci.h>
 #include <linux/platform_data/touchscreen-s3c2410.h>
-#include <linux/platform_data/gpio-samsung-s3c64xx.h>
 
 #include <video/platform_lcd.h>
 #include <plat/samsung-time.h>
diff --git a/arch/arm/mach-s3c64xx/mach-smartq5.c b/arch/arm/mach-s3c64xx/mach-smartq5.c
index 15b6c2f98086..dec4c08e834f 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq5.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq5.c
@@ -16,7 +16,6 @@
 #include <linux/input.h>
 #include <linux/leds.h>
 #include <linux/platform_device.h>
-#include <linux/platform_data/gpio-samsung-s3c64xx.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -24,6 +23,7 @@
 #include <video/samsung_fimd.h>
 #include <mach/map.h>
 #include <mach/regs-gpio.h>
+#include <mach/gpio-samsung.h>
 
 #include <plat/cpu.h>
 #include <plat/devs.h>
diff --git a/arch/arm/mach-s3c64xx/mach-smartq7.c b/arch/arm/mach-s3c64xx/mach-smartq7.c
index e3b58942ee68..27b322069c7d 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq7.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq7.c
@@ -16,7 +16,6 @@
 #include <linux/input.h>
 #include <linux/leds.h>
 #include <linux/platform_device.h>
-#include <linux/platform_data/gpio-samsung-s3c64xx.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -24,6 +23,7 @@
 #include <video/samsung_fimd.h>
 #include <mach/map.h>
 #include <mach/regs-gpio.h>
+#include <mach/gpio-samsung.h>
 
 #include <plat/cpu.h>
 #include <plat/devs.h>
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6400.c b/arch/arm/mach-s3c64xx/mach-smdk6400.c
index bdbbddb803d5..150f55fb9e33 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6400.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6400.c
@@ -35,7 +35,7 @@
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <linux/platform_data/i2c-s3c2410.h>
-#include <linux/platform_data/gpio-samsung-s3c64xx.h>
+#include <mach/gpio-samsung.h>
 #include <plat/samsung-time.h>
 
 #include "common.h"
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index a8977da87eb1..43261d24a0a5 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -31,7 +31,6 @@
 #include <linux/regulator/machine.h>
 #include <linux/pwm_backlight.h>
 #include <linux/platform_data/s3c-hsotg.h>
-#include <linux/platform_data/gpio-samsung-s3c64xx.h>
 
 #ifdef CONFIG_SMDK6410_WM1190_EV1
 #include <linux/mfd/wm8350/core.h>
@@ -58,6 +57,7 @@
 
 #include <plat/regs-serial.h>
 #include <mach/regs-gpio.h>
+#include <mach/gpio-samsung.h>
 #include <linux/platform_data/ata-samsung_cf.h>
 #include <linux/platform_data/i2c-s3c2410.h>
 #include <plat/fb.h>
diff --git a/arch/arm/mach-s3c64xx/pm.c b/arch/arm/mach-s3c64xx/pm.c
index 99c778eecab6..b5a66986a529 100644
--- a/arch/arm/mach-s3c64xx/pm.c
+++ b/arch/arm/mach-s3c64xx/pm.c
@@ -18,7 +18,6 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 #include <linux/pm_domain.h>
-#include <linux/platform_data/gpio-samsung-s3c64xx.h>
 
 #include <mach/map.h>
 #include <mach/irqs.h>
@@ -29,6 +28,7 @@
 
 #include <mach/regs-gpio.h>
 #include <mach/regs-clock.h>
+#include <mach/gpio-samsung.h>
 
 #include "regs-gpio-memport.h"
 #include "regs-modem.h"
diff --git a/arch/arm/mach-s3c64xx/setup-fb-24bpp.c b/arch/arm/mach-s3c64xx/setup-fb-24bpp.c
index 222792691b41..9d17bff12d4d 100644
--- a/arch/arm/mach-s3c64xx/setup-fb-24bpp.c
+++ b/arch/arm/mach-s3c64xx/setup-fb-24bpp.c
@@ -16,10 +16,10 @@
 #include <linux/types.h>
 #include <linux/fb.h>
 #include <linux/gpio.h>
-#include <linux/platform_data/gpio-samsung-s3c64xx.h>
 
 #include <plat/fb.h>
 #include <plat/gpio-cfg.h>
+#include <mach/gpio-samsung.h>
 
 void s3c64xx_fb_gpio_setup_24bpp(void)
 {
diff --git a/arch/arm/mach-s3c64xx/setup-i2c0.c b/arch/arm/mach-s3c64xx/setup-i2c0.c
index f269dabc9593..4b8c1cfdd1fc 100644
--- a/arch/arm/mach-s3c64xx/setup-i2c0.c
+++ b/arch/arm/mach-s3c64xx/setup-i2c0.c
@@ -19,8 +19,8 @@
 struct platform_device; /* don't need the contents */
 
 #include <linux/platform_data/i2c-s3c2410.h>
-#include <linux/platform_data/gpio-samsung-s3c64xx.h>
 #include <plat/gpio-cfg.h>
+#include <mach/gpio-samsung.h>
 
 void s3c_i2c0_cfg_gpio(struct platform_device *dev)
 {
diff --git a/arch/arm/mach-s3c64xx/setup-i2c1.c b/arch/arm/mach-s3c64xx/setup-i2c1.c
index aa2bfcd5e818..cd1df71ee13b 100644
--- a/arch/arm/mach-s3c64xx/setup-i2c1.c
+++ b/arch/arm/mach-s3c64xx/setup-i2c1.c
@@ -19,8 +19,8 @@
 struct platform_device; /* don't need the contents */
 
 #include <linux/platform_data/i2c-s3c2410.h>
-#include <linux/platform_data/gpio-samsung-s3c64xx.h>
 #include <plat/gpio-cfg.h>
+#include <mach/gpio-samsung.h>
 
 void s3c_i2c1_cfg_gpio(struct platform_device *dev)
 {
diff --git a/arch/arm/mach-s3c64xx/setup-ide.c b/arch/arm/mach-s3c64xx/setup-ide.c
index 81dcebeaeb53..689fb72e715c 100644
--- a/arch/arm/mach-s3c64xx/setup-ide.c
+++ b/arch/arm/mach-s3c64xx/setup-ide.c
@@ -17,8 +17,8 @@
 #include <mach/map.h>
 #include <mach/regs-clock.h>
 #include <plat/gpio-cfg.h>
+#include <mach/gpio-samsung.h>
 #include <linux/platform_data/ata-samsung_cf.h>
-#include <linux/platform_data/gpio-samsung-s3c64xx.h>
 
 void s3c64xx_ide_setup_gpio(void)
 {
diff --git a/arch/arm/mach-s3c64xx/setup-keypad.c b/arch/arm/mach-s3c64xx/setup-keypad.c
index e236f40c9053..6ad9a89dfddf 100644
--- a/arch/arm/mach-s3c64xx/setup-keypad.c
+++ b/arch/arm/mach-s3c64xx/setup-keypad.c
@@ -11,9 +11,9 @@
 */
 
 #include <linux/gpio.h>
-#include <linux/platform_data/gpio-samsung-s3c64xx.h>
 #include <plat/gpio-cfg.h>
 #include <plat/keypad.h>
+#include <mach/gpio-samsung.h>
 
 void samsung_keypad_cfg_gpio(unsigned int rows, unsigned int cols)
 {
diff --git a/arch/arm/mach-s3c64xx/setup-sdhci-gpio.c b/arch/arm/mach-s3c64xx/setup-sdhci-gpio.c
index 79192b7217df..f426b7a16c16 100644
--- a/arch/arm/mach-s3c64xx/setup-sdhci-gpio.c
+++ b/arch/arm/mach-s3c64xx/setup-sdhci-gpio.c
@@ -17,10 +17,10 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
-#include <linux/platform_data/gpio-samsung-s3c64xx.h>
 
 #include <plat/gpio-cfg.h>
 #include <plat/sdhci.h>
+#include <mach/gpio-samsung.h>
 
 void s3c64xx_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
 {
diff --git a/arch/arm/mach-s3c64xx/setup-spi.c b/arch/arm/mach-s3c64xx/setup-spi.c
index dad4728ccb52..5fd1a315c901 100644
--- a/arch/arm/mach-s3c64xx/setup-spi.c
+++ b/arch/arm/mach-s3c64xx/setup-spi.c
@@ -9,8 +9,8 @@
  */
 
 #include <linux/gpio.h>
-#include <linux/platform_data/gpio-samsung-s3c64xx.h>
 #include <plat/gpio-cfg.h>
+#include <mach/gpio-samsung.h>
 
 #ifdef CONFIG_S3C64XX_DEV_SPI0
 int s3c64xx_spi0_cfg_gpio(void)
diff --git a/arch/arm/plat-samsung/pm-gpio.c b/arch/arm/plat-samsung/pm-gpio.c
index c4efa1c2a5d1..a9f7a37c4173 100644
--- a/arch/arm/plat-samsung/pm-gpio.c
+++ b/arch/arm/plat-samsung/pm-gpio.c
@@ -19,12 +19,7 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 
-#ifdef CONFIG_ARCH_S3C24XX
-#include <linux/platform_data/gpio-samsung-s3c24xx.h>
-#endif
-#ifdef CONFIG_ARCH_S3C64XX
-#include <linux/platform_data/gpio-samsung-s3c64xx.h>
-#endif
+#include <mach/gpio-samsung.h>
 #include <plat/gpio-core.h>
 #include <plat/pm.h>
 
diff --git a/arch/arm/plat-samsung/setup-camif.c b/arch/arm/plat-samsung/setup-camif.c
index 70cf503c9a6b..72d8edb8927a 100644
--- a/arch/arm/plat-samsung/setup-camif.c
+++ b/arch/arm/plat-samsung/setup-camif.c
@@ -9,8 +9,8 @@
  */
 
 #include <linux/gpio.h>
-#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 #include <plat/gpio-cfg.h>
+#include <mach/gpio-samsung.h>
 
 /* Number of camera port pins, without FIELD */
 #define S3C_CAMIF_NUM_GPIOS	13
diff --git a/drivers/gpio/gpio-samsung.c b/drivers/gpio/gpio-samsung.c
index 990754b97f2e..9741cce11df5 100644
--- a/drivers/gpio/gpio-samsung.c
+++ b/drivers/gpio/gpio-samsung.c
@@ -27,17 +27,12 @@
 #include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/of_address.h>
-#ifdef CONFIG_ARCH_S3C24XX
-#include <linux/platform_data/gpio-samsung-s3c24xx.h>
-#endif
-#ifdef CONFIG_ARCH_S3C64XX
-#include <linux/platform_data/gpio-samsung-s3c64xx.h>
-#endif
 
 #include <asm/irq.h>
 
 #include <mach/map.h>
 #include <mach/regs-gpio.h>
+#include <mach/gpio-samsung.h>
 
 #include <plat/cpu.h>
 #include <plat/gpio-core.h>
diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 11ba3cbb0951..e34d499cb316 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -24,9 +24,9 @@
 #include <linux/io.h>
 
 #include <mach/dma.h>
+#include <mach/gpio-samsung.h>
 
 #include <linux/platform_data/mmc-s3cmci.h>
-#include <linux/platform_data/gpio-samsung-s3c24xx.h>
 
 #include "s3cmci.h"
 
diff --git a/include/linux/platform_data/gpio-samsung-s3c24xx.h b/include/linux/platform_data/gpio-samsung-s3c24xx.h
deleted file mode 100644
index 79b3a0e44955..000000000000
--- a/include/linux/platform_data/gpio-samsung-s3c24xx.h
+++ /dev/null
@@ -1,106 +0,0 @@
-/*
- * Copyright (c) 2008 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S3C2410 - GPIO lib support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-/* some boards require extra gpio capacity to support external
- * devices that need GPIO.
- */
-
-#ifndef GPIO_SAMSUNG_S3C24XX_H
-#define GPIO_SAMSUNG_S3C24XX_H
-
-/*
- * GPIO sizes for various SoCs:
- *
- *   2410 2412 2440 2443 2416
- *             2442
- *   ---- ---- ---- ---- ----
- * A  23   22   25   16   27
- * B  11   11   11   11   11
- * C  16   16   16   16   16
- * D  16   16   16   16   16
- * E  16   16   16   16   16
- * F  8    8    8    8    8
- * G  16   16   16   16   8
- * H  11   11   11   15   15
- * J  --   --   13   16   --
- * K  --   --   --   --   16
- * L  --   --   --   15   14
- * M  --   --   --   2    2
- */
-
-/* GPIO bank sizes */
-
-#define S3C2410_GPIO_A_NR	(32)
-#define S3C2410_GPIO_B_NR	(32)
-#define S3C2410_GPIO_C_NR	(32)
-#define S3C2410_GPIO_D_NR	(32)
-#define S3C2410_GPIO_E_NR	(32)
-#define S3C2410_GPIO_F_NR	(32)
-#define S3C2410_GPIO_G_NR	(32)
-#define S3C2410_GPIO_H_NR	(32)
-#define S3C2410_GPIO_J_NR	(32)	/* technically 16. */
-#define S3C2410_GPIO_K_NR	(32)	/* technically 16. */
-#define S3C2410_GPIO_L_NR	(32)	/* technically 15. */
-#define S3C2410_GPIO_M_NR	(32)	/* technically 2. */
-
-#if CONFIG_S3C_GPIO_SPACE != 0
-#error CONFIG_S3C_GPIO_SPACE cannot be nonzero at the moment
-#endif
-
-#define S3C2410_GPIO_NEXT(__gpio) \
-	((__gpio##_START) + (__gpio##_NR) + CONFIG_S3C_GPIO_SPACE + 0)
-
-#ifndef __ASSEMBLY__
-
-enum s3c_gpio_number {
-	S3C2410_GPIO_A_START = 0,
-	S3C2410_GPIO_B_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_A),
-	S3C2410_GPIO_C_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_B),
-	S3C2410_GPIO_D_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_C),
-	S3C2410_GPIO_E_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_D),
-	S3C2410_GPIO_F_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_E),
-	S3C2410_GPIO_G_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_F),
-	S3C2410_GPIO_H_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_G),
-	S3C2410_GPIO_J_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_H),
-	S3C2410_GPIO_K_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_J),
-	S3C2410_GPIO_L_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_K),
-	S3C2410_GPIO_M_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_L),
-};
-
-#endif /* __ASSEMBLY__ */
-
-/* S3C2410 GPIO number definitions. */
-
-#define S3C2410_GPA(_nr)	(S3C2410_GPIO_A_START + (_nr))
-#define S3C2410_GPB(_nr)	(S3C2410_GPIO_B_START + (_nr))
-#define S3C2410_GPC(_nr)	(S3C2410_GPIO_C_START + (_nr))
-#define S3C2410_GPD(_nr)	(S3C2410_GPIO_D_START + (_nr))
-#define S3C2410_GPE(_nr)	(S3C2410_GPIO_E_START + (_nr))
-#define S3C2410_GPF(_nr)	(S3C2410_GPIO_F_START + (_nr))
-#define S3C2410_GPG(_nr)	(S3C2410_GPIO_G_START + (_nr))
-#define S3C2410_GPH(_nr)	(S3C2410_GPIO_H_START + (_nr))
-#define S3C2410_GPJ(_nr)	(S3C2410_GPIO_J_START + (_nr))
-#define S3C2410_GPK(_nr)	(S3C2410_GPIO_K_START + (_nr))
-#define S3C2410_GPL(_nr)	(S3C2410_GPIO_L_START + (_nr))
-#define S3C2410_GPM(_nr)	(S3C2410_GPIO_M_START + (_nr))
-
-#include <plat/gpio-cfg.h>
-
-#ifdef CONFIG_CPU_S3C244X
-#define S3C_GPIO_END	(S3C2410_GPJ(0) + 32)
-#elif defined(CONFIG_CPU_S3C2443) || defined(CONFIG_CPU_S3C2416)
-#define S3C_GPIO_END	(S3C2410_GPM(0) + 32)
-#else
-#define S3C_GPIO_END	(S3C2410_GPH(0) + 32)
-#endif
-
-#endif /* GPIO_SAMSUNG_S3C24XX_H */
diff --git a/include/linux/platform_data/gpio-samsung-s3c64xx.h b/include/linux/platform_data/gpio-samsung-s3c64xx.h
deleted file mode 100644
index 9c81fac3b2d5..000000000000
--- a/include/linux/platform_data/gpio-samsung-s3c64xx.h
+++ /dev/null
@@ -1,94 +0,0 @@
-/*
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S3C6400 - GPIO lib support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef GPIO_SAMSUNG_S3C64XX_H
-#define GPIO_SAMSUNG_S3C64XX_H
-
-/* GPIO bank sizes */
-#define S3C64XX_GPIO_A_NR	(8)
-#define S3C64XX_GPIO_B_NR	(7)
-#define S3C64XX_GPIO_C_NR	(8)
-#define S3C64XX_GPIO_D_NR	(5)
-#define S3C64XX_GPIO_E_NR	(5)
-#define S3C64XX_GPIO_F_NR	(16)
-#define S3C64XX_GPIO_G_NR	(7)
-#define S3C64XX_GPIO_H_NR	(10)
-#define S3C64XX_GPIO_I_NR	(16)
-#define S3C64XX_GPIO_J_NR	(12)
-#define S3C64XX_GPIO_K_NR	(16)
-#define S3C64XX_GPIO_L_NR	(15)
-#define S3C64XX_GPIO_M_NR	(6)
-#define S3C64XX_GPIO_N_NR	(16)
-#define S3C64XX_GPIO_O_NR	(16)
-#define S3C64XX_GPIO_P_NR	(15)
-#define S3C64XX_GPIO_Q_NR	(9)
-
-/* GPIO bank numbes */
-
-/* CONFIG_S3C_GPIO_SPACE allows the user to select extra
- * space for debugging purposes so that any accidental
- * change from one gpio bank to another can be caught.
-*/
-
-#define S3C64XX_GPIO_NEXT(__gpio) \
-	((__gpio##_START) + (__gpio##_NR) + CONFIG_S3C_GPIO_SPACE + 1)
-
-enum s3c_gpio_number {
-	S3C64XX_GPIO_A_START = 0,
-	S3C64XX_GPIO_B_START = S3C64XX_GPIO_NEXT(S3C64XX_GPIO_A),
-	S3C64XX_GPIO_C_START = S3C64XX_GPIO_NEXT(S3C64XX_GPIO_B),
-	S3C64XX_GPIO_D_START = S3C64XX_GPIO_NEXT(S3C64XX_GPIO_C),
-	S3C64XX_GPIO_E_START = S3C64XX_GPIO_NEXT(S3C64XX_GPIO_D),
-	S3C64XX_GPIO_F_START = S3C64XX_GPIO_NEXT(S3C64XX_GPIO_E),
-	S3C64XX_GPIO_G_START = S3C64XX_GPIO_NEXT(S3C64XX_GPIO_F),
-	S3C64XX_GPIO_H_START = S3C64XX_GPIO_NEXT(S3C64XX_GPIO_G),
-	S3C64XX_GPIO_I_START = S3C64XX_GPIO_NEXT(S3C64XX_GPIO_H),
-	S3C64XX_GPIO_J_START = S3C64XX_GPIO_NEXT(S3C64XX_GPIO_I),
-	S3C64XX_GPIO_K_START = S3C64XX_GPIO_NEXT(S3C64XX_GPIO_J),
-	S3C64XX_GPIO_L_START = S3C64XX_GPIO_NEXT(S3C64XX_GPIO_K),
-	S3C64XX_GPIO_M_START = S3C64XX_GPIO_NEXT(S3C64XX_GPIO_L),
-	S3C64XX_GPIO_N_START = S3C64XX_GPIO_NEXT(S3C64XX_GPIO_M),
-	S3C64XX_GPIO_O_START = S3C64XX_GPIO_NEXT(S3C64XX_GPIO_N),
-	S3C64XX_GPIO_P_START = S3C64XX_GPIO_NEXT(S3C64XX_GPIO_O),
-	S3C64XX_GPIO_Q_START = S3C64XX_GPIO_NEXT(S3C64XX_GPIO_P),
-};
-
-/* S3C64XX GPIO number definitions. */
-
-#define S3C64XX_GPA(_nr)	(S3C64XX_GPIO_A_START + (_nr))
-#define S3C64XX_GPB(_nr)	(S3C64XX_GPIO_B_START + (_nr))
-#define S3C64XX_GPC(_nr)	(S3C64XX_GPIO_C_START + (_nr))
-#define S3C64XX_GPD(_nr)	(S3C64XX_GPIO_D_START + (_nr))
-#define S3C64XX_GPE(_nr)	(S3C64XX_GPIO_E_START + (_nr))
-#define S3C64XX_GPF(_nr)	(S3C64XX_GPIO_F_START + (_nr))
-#define S3C64XX_GPG(_nr)	(S3C64XX_GPIO_G_START + (_nr))
-#define S3C64XX_GPH(_nr)	(S3C64XX_GPIO_H_START + (_nr))
-#define S3C64XX_GPI(_nr)	(S3C64XX_GPIO_I_START + (_nr))
-#define S3C64XX_GPJ(_nr)	(S3C64XX_GPIO_J_START + (_nr))
-#define S3C64XX_GPK(_nr)	(S3C64XX_GPIO_K_START + (_nr))
-#define S3C64XX_GPL(_nr)	(S3C64XX_GPIO_L_START + (_nr))
-#define S3C64XX_GPM(_nr)	(S3C64XX_GPIO_M_START + (_nr))
-#define S3C64XX_GPN(_nr)	(S3C64XX_GPIO_N_START + (_nr))
-#define S3C64XX_GPO(_nr)	(S3C64XX_GPIO_O_START + (_nr))
-#define S3C64XX_GPP(_nr)	(S3C64XX_GPIO_P_START + (_nr))
-#define S3C64XX_GPQ(_nr)	(S3C64XX_GPIO_Q_START + (_nr))
-
-/* the end of the S3C64XX specific gpios */
-#define S3C64XX_GPIO_END	(S3C64XX_GPQ(S3C64XX_GPIO_Q_NR) + 1)
-#define S3C_GPIO_END		S3C64XX_GPIO_END
-
-/* define the number of gpios we need to the one after the GPQ() range */
-#define GPIO_BOARD_START (S3C64XX_GPQ(S3C64XX_GPIO_Q_NR) + 1)
-
-#endif /* GPIO_SAMSUNG_S3C64XX_H */
-
-- 
1.8.4.2

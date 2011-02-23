From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed, 23 Feb 2011 12:38:16 +0100
Subject: [PATCH 2/6] ARM: pxa2xx: reorganize I2C files
In-Reply-To: <1298461100-14869-1-git-send-email-bigeasy@linutronix.de>
References: <1298461100-14869-1-git-send-email-bigeasy@linutronix.de>
Message-ID: <1298461100-14869-3-git-send-email-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves the platform data definition from
arch/arm/plat-pxa/include/plat/i2c.h to include/linux/i2c/pxa-i2c.h so
it can be accessed from x86 the same way as on ARM.

This change should make no functional change to the PXA code. The move
is verified by building the following defconfigs:
  cm_x2xx_defconfig corgi_defconfig em_x270_defconfig ezx_defconfig
  imote2_defconfig pxa3xx_defconfig spitz_defconfig zeus_defconfig
  raumfeld_defconfig magician_defconfig mmp2_defconfig pxa168_defconfig
  pxa910_defconfig

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
---
 arch/arm/mach-mmp/include/mach/mmp2.h              |    2 +-
 arch/arm/mach-mmp/include/mach/pxa168.h            |    2 +-
 arch/arm/mach-mmp/include/mach/pxa910.h            |    2 +-
 arch/arm/mach-pxa/balloon3.c                       |    3 +--
 arch/arm/mach-pxa/cm-x300.c                        |    2 +-
 arch/arm/mach-pxa/colibri-evalboard.c              |    3 +--
 arch/arm/mach-pxa/colibri-pxa270-income.c          |    3 +--
 arch/arm/mach-pxa/corgi.c                          |    2 +-
 arch/arm/mach-pxa/csb726.c                         |    2 +-
 arch/arm/mach-pxa/devices.c                        |    2 +-
 arch/arm/mach-pxa/em-x270.c                        |    2 +-
 arch/arm/mach-pxa/ezx.c                            |    2 +-
 arch/arm/mach-pxa/hx4700.c                         |    2 +-
 arch/arm/mach-pxa/littleton.c                      |    2 +-
 arch/arm/mach-pxa/magician.c                       |    2 +-
 arch/arm/mach-pxa/mainstone.c                      |    2 +-
 arch/arm/mach-pxa/mioa701.c                        |    2 +-
 arch/arm/mach-pxa/mxm8x10.c                        |    2 +-
 arch/arm/mach-pxa/palm27x.c                        |    3 +--
 arch/arm/mach-pxa/pcm990-baseboard.c               |    2 +-
 arch/arm/mach-pxa/poodle.c                         |    2 +-
 arch/arm/mach-pxa/pxa27x.c                         |    3 +--
 arch/arm/mach-pxa/pxa3xx.c                         |    2 +-
 arch/arm/mach-pxa/pxa95x.c                         |    2 +-
 arch/arm/mach-pxa/raumfeld.c                       |    2 +-
 arch/arm/mach-pxa/saar.c                           |    2 +-
 arch/arm/mach-pxa/saarb.c                          |    3 +--
 arch/arm/mach-pxa/spitz.c                          |    3 +--
 arch/arm/mach-pxa/stargate2.c                      |    2 +-
 arch/arm/mach-pxa/tavorevb3.c                      |    3 +--
 arch/arm/mach-pxa/tosa.c                           |    2 +-
 arch/arm/mach-pxa/trizeps4.c                       |    2 +-
 arch/arm/mach-pxa/viper.c                          |    2 +-
 arch/arm/mach-pxa/vpac270.c                        |    3 +--
 arch/arm/mach-pxa/xcep.c                           |    3 +--
 arch/arm/mach-pxa/z2.c                             |    3 +--
 arch/arm/mach-pxa/zeus.c                           |    3 +--
 arch/arm/mach-pxa/zylonite_pxa300.c                |    2 +-
 drivers/i2c/busses/i2c-pxa.c                       |    2 +-
 .../plat/i2c.h => include/linux/i2c/pxa-i2c.h      |    0
 40 files changed, 39 insertions(+), 51 deletions(-)
 rename arch/arm/plat-pxa/include/plat/i2c.h => include/linux/i2c/pxa-i2c.h (100%)

diff --git a/arch/arm/mach-mmp/include/mach/mmp2.h b/arch/arm/mach-mmp/include/mach/mmp2.h
index 4aec493..2cbf6df 100644
--- a/arch/arm/mach-mmp/include/mach/mmp2.h
+++ b/arch/arm/mach-mmp/include/mach/mmp2.h
@@ -11,8 +11,8 @@ extern void __init mmp2_init_irq(void);
 extern void mmp2_clear_pmic_int(void);
 
 #include <linux/i2c.h>
+#include <linux/i2c/pxa-i2c.h>
 #include <mach/devices.h>
-#include <plat/i2c.h>
 
 extern struct pxa_device_desc mmp2_device_uart1;
 extern struct pxa_device_desc mmp2_device_uart2;
diff --git a/arch/arm/mach-mmp/include/mach/pxa168.h b/arch/arm/mach-mmp/include/mach/pxa168.h
index 1801e42..a52b3d2 100644
--- a/arch/arm/mach-mmp/include/mach/pxa168.h
+++ b/arch/arm/mach-mmp/include/mach/pxa168.h
@@ -8,8 +8,8 @@ extern void __init pxa168_init_irq(void);
 extern void pxa168_clear_keypad_wakeup(void);
 
 #include <linux/i2c.h>
+#include <linux/i2c/pxa-i2c.h>
 #include <mach/devices.h>
-#include <plat/i2c.h>
 #include <plat/pxa3xx_nand.h>
 #include <video/pxa168fb.h>
 #include <plat/pxa27x_keypad.h>
diff --git a/arch/arm/mach-mmp/include/mach/pxa910.h b/arch/arm/mach-mmp/include/mach/pxa910.h
index f13c49d..91be755 100644
--- a/arch/arm/mach-mmp/include/mach/pxa910.h
+++ b/arch/arm/mach-mmp/include/mach/pxa910.h
@@ -7,8 +7,8 @@ extern struct sys_timer pxa910_timer;
 extern void __init pxa910_init_irq(void);
 
 #include <linux/i2c.h>
+#include <linux/i2c/pxa-i2c.h>
 #include <mach/devices.h>
-#include <plat/i2c.h>
 #include <plat/pxa3xx_nand.h>
 
 extern struct pxa_device_desc pxa910_device_uart1;
diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index a134a14..f1d4824 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -27,6 +27,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/types.h>
 #include <linux/i2c/pcf857x.h>
+#include <linux/i2c/pxa-i2c.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/physmap.h>
 #include <linux/regulator/max1586.h>
@@ -51,8 +52,6 @@
 #include <mach/irda.h>
 #include <mach/ohci.h>
 
-#include <plat/i2c.h>
-
 #include "generic.h"
 #include "devices.h"
 
diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index 7984268..bfca7ed 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -29,6 +29,7 @@
 
 #include <linux/i2c.h>
 #include <linux/i2c/pca953x.h>
+#include <linux/i2c/pxa-i2c.h>
 
 #include <linux/mfd/da903x.h>
 #include <linux/regulator/machine.h>
@@ -48,7 +49,6 @@
 #include <mach/pxafb.h>
 #include <mach/mmc.h>
 #include <mach/ohci.h>
-#include <plat/i2c.h>
 #include <plat/pxa3xx_nand.h>
 #include <mach/audio.h>
 #include <mach/pxa3xx-u2d.h>
diff --git a/arch/arm/mach-pxa/colibri-evalboard.c b/arch/arm/mach-pxa/colibri-evalboard.c
index 6b2c800..2adabbf 100644
--- a/arch/arm/mach-pxa/colibri-evalboard.c
+++ b/arch/arm/mach-pxa/colibri-evalboard.c
@@ -20,6 +20,7 @@
 #include <mach/hardware.h>
 #include <asm/mach/arch.h>
 #include <linux/i2c.h>
+#include <linux/i2c/pxa-i2c.h>
 
 #include <mach/pxa27x.h>
 #include <mach/colibri.h>
@@ -27,8 +28,6 @@
 #include <mach/ohci.h>
 #include <mach/pxa27x-udc.h>
 
-#include <plat/i2c.h>
-
 #include "generic.h"
 #include "devices.h"
 
diff --git a/arch/arm/mach-pxa/colibri-pxa270-income.c b/arch/arm/mach-pxa/colibri-pxa270-income.c
index 07b62a0..ee79739 100644
--- a/arch/arm/mach-pxa/colibri-pxa270-income.c
+++ b/arch/arm/mach-pxa/colibri-pxa270-income.c
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/pwm_backlight.h>
+#include <linux/i2c/pxa-i2c.h>
 #include <linux/sysdev.h>
 
 #include <asm/irq.h>
@@ -33,8 +34,6 @@
 #include <mach/pxa27x-udc.h>
 #include <mach/pxafb.h>
 
-#include <plat/i2c.h>
-
 #include "devices.h"
 #include "generic.h"
 
diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
index a5452a3..d4e705c 100644
--- a/arch/arm/mach-pxa/corgi.c
+++ b/arch/arm/mach-pxa/corgi.c
@@ -24,6 +24,7 @@
 #include <linux/gpio.h>
 #include <linux/backlight.h>
 #include <linux/i2c.h>
+#include <linux/i2c/pxa-i2c.h>
 #include <linux/io.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
@@ -45,7 +46,6 @@
 #include <asm/mach/irq.h>
 
 #include <mach/pxa25x.h>
-#include <plat/i2c.h>
 #include <mach/irda.h>
 #include <mach/mmc.h>
 #include <mach/udc.h>
diff --git a/arch/arm/mach-pxa/csb726.c b/arch/arm/mach-pxa/csb726.c
index a305424..0481c29 100644
--- a/arch/arm/mach-pxa/csb726.c
+++ b/arch/arm/mach-pxa/csb726.c
@@ -17,12 +17,12 @@
 #include <linux/mtd/partitions.h>
 #include <linux/sm501.h>
 #include <linux/smsc911x.h>
+#include <linux/i2c/pxa-i2c.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/csb726.h>
 #include <mach/mfp-pxa27x.h>
-#include <plat/i2c.h>
 #include <mach/mmc.h>
 #include <mach/ohci.h>
 #include <mach/pxa2xx-regs.h>
diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index 4c766e3..c4bf08b 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -4,6 +4,7 @@
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/spi/pxa2xx_spi.h>
+#include <linux/i2c/pxa-i2c.h>
 
 #include <asm/pmu.h>
 #include <mach/udc.h>
@@ -16,7 +17,6 @@
 #include <mach/camera.h>
 #include <mach/audio.h>
 #include <mach/hardware.h>
-#include <plat/i2c.h>
 #include <plat/pxa3xx_nand.h>
 
 #include "devices.h"
diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
index a78bb30..b411d7c 100644
--- a/arch/arm/mach-pxa/em-x270.c
+++ b/arch/arm/mach-pxa/em-x270.c
@@ -31,6 +31,7 @@
 #include <linux/apm-emulation.h>
 #include <linux/i2c.h>
 #include <linux/i2c/pca953x.h>
+#include <linux/i2c/pxa-i2c.h>
 #include <linux/regulator/userspace-consumer.h>
 
 #include <media/soc_camera.h>
@@ -45,7 +46,6 @@
 #include <mach/ohci.h>
 #include <mach/mmc.h>
 #include <plat/pxa27x_keypad.h>
-#include <plat/i2c.h>
 #include <mach/camera.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-pxa/ezx.c b/arch/arm/mach-pxa/ezx.c
index 87cec0a..93f05e0 100644
--- a/arch/arm/mach-pxa/ezx.c
+++ b/arch/arm/mach-pxa/ezx.c
@@ -20,6 +20,7 @@
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
 #include <linux/leds-lp3944.h>
+#include <linux/i2c/pxa-i2c.h>
 
 #include <media/soc_camera.h>
 
@@ -30,7 +31,6 @@
 #include <mach/pxa27x.h>
 #include <mach/pxafb.h>
 #include <mach/ohci.h>
-#include <plat/i2c.h>
 #include <mach/hardware.h>
 #include <plat/pxa27x_keypad.h>
 #include <mach/camera.h>
diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index a908e0a..6de0ad0 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -35,6 +35,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/pxa2xx_spi.h>
 #include <linux/usb/gpio_vbus.h>
+#include <linux/i2c/pxa-i2c.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -42,7 +43,6 @@
 
 #include <mach/pxa27x.h>
 #include <mach/hx4700.h>
-#include <plat/i2c.h>
 #include <mach/irda.h>
 
 #include <video/platform_lcd.h>
diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
index ccb7bfa..87c1ed9 100644
--- a/arch/arm/mach-pxa/littleton.c
+++ b/arch/arm/mach-pxa/littleton.c
@@ -28,6 +28,7 @@
 #include <linux/leds.h>
 #include <linux/mfd/da903x.h>
 #include <linux/i2c/max732x.h>
+#include <linux/i2c/pxa-i2c.h>
 
 #include <asm/types.h>
 #include <asm/setup.h>
@@ -45,7 +46,6 @@
 #include <mach/mmc.h>
 #include <plat/pxa27x_keypad.h>
 #include <mach/littleton.h>
-#include <plat/i2c.h>
 #include <plat/pxa3xx_nand.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 41198f0..5535991 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -28,6 +28,7 @@
 #include <linux/regulator/bq24022.h>
 #include <linux/regulator/machine.h>
 #include <linux/usb/gpio_vbus.h>
+#include <linux/i2c/pxa-i2c.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -36,7 +37,6 @@
 #include <mach/pxa27x.h>
 #include <mach/magician.h>
 #include <mach/pxafb.h>
-#include <plat/i2c.h>
 #include <mach/mmc.h>
 #include <mach/irda.h>
 #include <mach/ohci.h>
diff --git a/arch/arm/mach-pxa/mainstone.c b/arch/arm/mach-pxa/mainstone.c
index d4b6f23..f954222 100644
--- a/arch/arm/mach-pxa/mainstone.c
+++ b/arch/arm/mach-pxa/mainstone.c
@@ -27,6 +27,7 @@
 #include <linux/gpio_keys.h>
 #include <linux/pwm_backlight.h>
 #include <linux/smc91x.h>
+#include <linux/i2c/pxa-i2c.h>
 
 #include <asm/types.h>
 #include <asm/setup.h>
@@ -46,7 +47,6 @@
 #include <mach/mainstone.h>
 #include <mach/audio.h>
 #include <mach/pxafb.h>
-#include <plat/i2c.h>
 #include <mach/mmc.h>
 #include <mach/irda.h>
 #include <mach/ohci.h>
diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index faafea3..78d98a8 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -39,6 +39,7 @@
 #include <linux/usb/gpio_vbus.h>
 #include <linux/regulator/max1586.h>
 #include <linux/slab.h>
+#include <linux/i2c/pxa-i2c.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -50,7 +51,6 @@
 #include <mach/mmc.h>
 #include <mach/udc.h>
 #include <mach/pxa27x-udc.h>
-#include <plat/i2c.h>
 #include <mach/camera.h>
 #include <mach/audio.h>
 #include <media/soc_camera.h>
diff --git a/arch/arm/mach-pxa/mxm8x10.c b/arch/arm/mach-pxa/mxm8x10.c
index cdf7f41..b5a8fd3 100644
--- a/arch/arm/mach-pxa/mxm8x10.c
+++ b/arch/arm/mach-pxa/mxm8x10.c
@@ -22,8 +22,8 @@
 #include <linux/serial_8250.h>
 #include <linux/dm9000.h>
 #include <linux/gpio.h>
+#include <linux/i2c/pxa-i2c.h>
 
-#include <plat/i2c.h>
 #include <plat/pxa3xx_nand.h>
 
 #include <mach/pxafb.h>
diff --git a/arch/arm/mach-pxa/palm27x.c b/arch/arm/mach-pxa/palm27x.c
index 405b92a..ad077e8 100644
--- a/arch/arm/mach-pxa/palm27x.c
+++ b/arch/arm/mach-pxa/palm27x.c
@@ -22,6 +22,7 @@
 #include <linux/power_supply.h>
 #include <linux/usb/gpio_vbus.h>
 #include <linux/regulator/max1586.h>
+#include <linux/i2c/pxa-i2c.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -36,8 +37,6 @@
 #include <mach/palmasoc.h>
 #include <mach/palm27x.h>
 
-#include <plat/i2c.h>
-
 #include "generic.h"
 #include "devices.h"
 
diff --git a/arch/arm/mach-pxa/pcm990-baseboard.c b/arch/arm/mach-pxa/pcm990-baseboard.c
index 90820fa..9dbf3cc 100644
--- a/arch/arm/mach-pxa/pcm990-baseboard.c
+++ b/arch/arm/mach-pxa/pcm990-baseboard.c
@@ -23,12 +23,12 @@
 #include <linux/irq.h>
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
+#include <linux/i2c/pxa-i2c.h>
 #include <linux/pwm_backlight.h>
 
 #include <media/soc_camera.h>
 
 #include <asm/gpio.h>
-#include <plat/i2c.h>
 #include <mach/camera.h>
 #include <asm/mach/map.h>
 #include <mach/pxa27x.h>
diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
index 4f0ff1a..35353af 100644
--- a/arch/arm/mach-pxa/poodle.c
+++ b/arch/arm/mach-pxa/poodle.c
@@ -23,6 +23,7 @@
 #include <linux/mtd/physmap.h>
 #include <linux/gpio.h>
 #include <linux/i2c.h>
+#include <linux/i2c/pxa-i2c.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
 #include <linux/spi/pxa2xx_spi.h>
@@ -44,7 +45,6 @@
 #include <mach/irda.h>
 #include <mach/poodle.h>
 #include <mach/pxafb.h>
-#include <plat/i2c.h>
 
 #include <asm/hardware/scoop.h>
 #include <asm/hardware/locomo.h>
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 987301f..9845bd9 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -19,6 +19,7 @@
 #include <linux/sysdev.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/i2c/pxa-i2c.h>
 
 #include <asm/mach/map.h>
 #include <mach/hardware.h>
@@ -32,8 +33,6 @@
 #include <mach/dma.h>
 #include <mach/smemc.h>
 
-#include <plat/i2c.h>
-
 #include "generic.h"
 #include "devices.h"
 #include "clock.h"
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index a7a19e1..e748d9c 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -21,6 +21,7 @@
 #include <linux/irq.h>
 #include <linux/io.h>
 #include <linux/sysdev.h>
+#include <linux/i2c/pxa-i2c.h>
 
 #include <asm/mach/map.h>
 #include <mach/hardware.h>
@@ -32,7 +33,6 @@
 #include <mach/dma.h>
 #include <mach/regs-intc.h>
 #include <mach/smemc.h>
-#include <plat/i2c.h>
 
 #include "generic.h"
 #include "devices.h"
diff --git a/arch/arm/mach-pxa/pxa95x.c b/arch/arm/mach-pxa/pxa95x.c
index 437980f..23b229b 100644
--- a/arch/arm/mach-pxa/pxa95x.c
+++ b/arch/arm/mach-pxa/pxa95x.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/pm.h>
 #include <linux/platform_device.h>
+#include <linux/i2c/pxa-i2c.h>
 #include <linux/irq.h>
 #include <linux/io.h>
 #include <linux/sysdev.h>
@@ -27,7 +28,6 @@
 #include <mach/pm.h>
 #include <mach/dma.h>
 #include <mach/regs-intc.h>
-#include <plat/i2c.h>
 
 #include "generic.h"
 #include "devices.h"
diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index 8361151..4709418 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -32,6 +32,7 @@
 #include <linux/sched.h>
 #include <linux/pwm_backlight.h>
 #include <linux/i2c.h>
+#include <linux/i2c/pxa-i2c.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_gpio.h>
 #include <linux/lis3lv02d.h>
@@ -53,7 +54,6 @@
 #include <mach/ohci.h>
 #include <mach/pxafb.h>
 #include <mach/mmc.h>
-#include <plat/i2c.h>
 #include <plat/pxa3xx_nand.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-pxa/saar.c b/arch/arm/mach-pxa/saar.c
index c1ca8cb..eb83c89 100644
--- a/arch/arm/mach-pxa/saar.c
+++ b/arch/arm/mach-pxa/saar.c
@@ -20,6 +20,7 @@
 #include <linux/delay.h>
 #include <linux/fb.h>
 #include <linux/i2c.h>
+#include <linux/i2c/pxa-i2c.h>
 #include <linux/smc91x.h>
 #include <linux/mfd/da903x.h>
 #include <linux/mtd/mtd.h>
@@ -31,7 +32,6 @@
 #include <asm/mach/flash.h>
 
 #include <mach/pxa930.h>
-#include <plat/i2c.h>
 #include <mach/pxafb.h>
 
 #include "devices.h"
diff --git a/arch/arm/mach-pxa/saarb.c b/arch/arm/mach-pxa/saarb.c
index e497922..9322fe5 100644
--- a/arch/arm/mach-pxa/saarb.c
+++ b/arch/arm/mach-pxa/saarb.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/i2c.h>
+#include <linux/i2c/pxa-i2c.h>
 #include <linux/mfd/88pm860x.h>
 
 #include <asm/mach-types.h>
@@ -24,8 +25,6 @@
 #include <mach/mfp-pxa930.h>
 #include <mach/gpio.h>
 
-#include <plat/i2c.h>
-
 #include "generic.h"
 
 #define SAARB_NR_IRQS	(IRQ_BOARD_START + 40)
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index b49a2c2..38e2c09 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -19,6 +19,7 @@
 #include <linux/gpio.h>
 #include <linux/leds.h>
 #include <linux/i2c.h>
+#include <linux/i2c/pxa-i2c.h>
 #include <linux/i2c/pca953x.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
@@ -47,8 +48,6 @@
 #include <mach/sharpsl_pm.h>
 #include <mach/smemc.h>
 
-#include <plat/i2c.h>
-
 #include "generic.h"
 #include "devices.h"
 
diff --git a/arch/arm/mach-pxa/stargate2.c b/arch/arm/mach-pxa/stargate2.c
index 9a14fdb..cb5611d 100644
--- a/arch/arm/mach-pxa/stargate2.c
+++ b/arch/arm/mach-pxa/stargate2.c
@@ -25,6 +25,7 @@
 #include <linux/mtd/plat-ram.h>
 #include <linux/mtd/partitions.h>
 
+#include <linux/i2c/pxa-i2c.h>
 #include <linux/i2c/pcf857x.h>
 #include <linux/i2c/at24.h>
 #include <linux/smc91x.h>
@@ -43,7 +44,6 @@
 #include <asm/mach/flash.h>
 
 #include <mach/pxa27x.h>
-#include <plat/i2c.h>
 #include <mach/mmc.h>
 #include <mach/udc.h>
 #include <mach/pxa27x-udc.h>
diff --git a/arch/arm/mach-pxa/tavorevb3.c b/arch/arm/mach-pxa/tavorevb3.c
index 70191a9..79f4422 100644
--- a/arch/arm/mach-pxa/tavorevb3.c
+++ b/arch/arm/mach-pxa/tavorevb3.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
+#include <linux/i2c/pxa-i2c.h>
 #include <linux/gpio.h>
 #include <linux/mfd/88pm860x.h>
 
@@ -23,8 +24,6 @@
 
 #include <mach/pxa930.h>
 
-#include <plat/i2c.h>
-
 #include "devices.h"
 #include "generic.h"
 
diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
index af152e7..2de1492 100644
--- a/arch/arm/mach-pxa/tosa.c
+++ b/arch/arm/mach-pxa/tosa.c
@@ -34,6 +34,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/pxa2xx_spi.h>
 #include <linux/input/matrix_keypad.h>
+#include <linux/i2c/pxa-i2c.h>
 
 #include <asm/setup.h>
 #include <asm/mach-types.h>
@@ -41,7 +42,6 @@
 #include <mach/pxa25x.h>
 #include <mach/reset.h>
 #include <mach/irda.h>
-#include <plat/i2c.h>
 #include <mach/mmc.h>
 #include <mach/udc.h>
 #include <mach/tosa_bt.h>
diff --git a/arch/arm/mach-pxa/trizeps4.c b/arch/arm/mach-pxa/trizeps4.c
index 423261d..857bb2e 100644
--- a/arch/arm/mach-pxa/trizeps4.c
+++ b/arch/arm/mach-pxa/trizeps4.c
@@ -26,6 +26,7 @@
 #include <linux/dm9000.h>
 #include <linux/mtd/physmap.h>
 #include <linux/mtd/partitions.h>
+#include <linux/i2c/pxa-i2c.h>
 
 #include <asm/types.h>
 #include <asm/setup.h>
@@ -47,7 +48,6 @@
 #include <mach/irda.h>
 #include <mach/ohci.h>
 #include <mach/smemc.h>
-#include <plat/i2c.h>
 
 #include "generic.h"
 #include "devices.h"
diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
index 49eeeab..1227921 100644
--- a/arch/arm/mach-pxa/viper.c
+++ b/arch/arm/mach-pxa/viper.c
@@ -36,6 +36,7 @@
 #include <linux/gpio.h>
 #include <linux/jiffies.h>
 #include <linux/i2c-gpio.h>
+#include <linux/i2c/pxa-i2c.h>
 #include <linux/serial_8250.h>
 #include <linux/smc91x.h>
 #include <linux/pwm_backlight.h>
@@ -47,7 +48,6 @@
 #include <mach/pxa25x.h>
 #include <mach/audio.h>
 #include <mach/pxafb.h>
-#include <plat/i2c.h>
 #include <mach/regs-uart.h>
 #include <mach/arcom-pcmcia.h>
 #include <mach/viper.h>
diff --git a/arch/arm/mach-pxa/vpac270.c b/arch/arm/mach-pxa/vpac270.c
index b9b5797..e709fd4 100644
--- a/arch/arm/mach-pxa/vpac270.c
+++ b/arch/arm/mach-pxa/vpac270.c
@@ -26,6 +26,7 @@
 #include <linux/ucb1400.h>
 #include <linux/ata_platform.h>
 #include <linux/regulator/max1586.h>
+#include <linux/i2c/pxa-i2c.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -40,8 +41,6 @@
 #include <mach/udc.h>
 #include <mach/pata_pxa.h>
 
-#include <plat/i2c.h>
-
 #include "generic.h"
 #include "devices.h"
 
diff --git a/arch/arm/mach-pxa/xcep.c b/arch/arm/mach-pxa/xcep.c
index 51c0281..f55f8f2 100644
--- a/arch/arm/mach-pxa/xcep.c
+++ b/arch/arm/mach-pxa/xcep.c
@@ -16,6 +16,7 @@
 
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
+#include <linux/i2c/pxa-i2c.h>
 #include <linux/smc91x.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
@@ -26,8 +27,6 @@
 #include <asm/mach/irq.h>
 #include <asm/mach/map.h>
 
-#include <plat/i2c.h>
-
 #include <mach/hardware.h>
 #include <mach/pxa2xx-regs.h>
 #include <mach/mfp-pxa25x.h>
diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index a323e07..aaf8837 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -29,6 +29,7 @@
 #include <linux/gpio_keys.h>
 #include <linux/delay.h>
 #include <linux/regulator/machine.h>
+#include <linux/i2c/pxa-i2c.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -40,8 +41,6 @@
 #include <mach/mmc.h>
 #include <plat/pxa27x_keypad.h>
 
-#include <plat/i2c.h>
-
 #include "generic.h"
 #include "devices.h"
 
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index f4b053b..0bc99ac 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -25,6 +25,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
 #include <linux/i2c.h>
+#include <linux/i2c/pxa-i2c.h>
 #include <linux/i2c/pca953x.h>
 #include <linux/apm-emulation.h>
 #include <linux/can/platform/mcp251x.h>
@@ -33,8 +34,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <plat/i2c.h>
-
 #include <mach/pxa2xx-regs.h>
 #include <mach/regs-uart.h>
 #include <mach/ohci.h>
diff --git a/arch/arm/mach-pxa/zylonite_pxa300.c b/arch/arm/mach-pxa/zylonite_pxa300.c
index 3aa73b3..93c64d8 100644
--- a/arch/arm/mach-pxa/zylonite_pxa300.c
+++ b/arch/arm/mach-pxa/zylonite_pxa300.c
@@ -17,11 +17,11 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
+#include <linux/i2c/pxa-i2c.h>
 #include <linux/i2c/pca953x.h>
 #include <linux/gpio.h>
 
 #include <mach/pxa300.h>
-#include <plat/i2c.h>
 #include <mach/zylonite.h>
 
 #include "generic.h"
diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index a011455..fc2a90e 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -34,9 +34,9 @@
 #include <linux/clk.h>
 #include <linux/slab.h>
 #include <linux/io.h>
+#include <linux/i2c/pxa-i2c.h>
 
 #include <asm/irq.h>
-#include <plat/i2c.h>
 
 struct pxa_reg_layout {
 	u32 ibmr;
diff --git a/arch/arm/plat-pxa/include/plat/i2c.h b/include/linux/i2c/pxa-i2c.h
similarity index 100%
rename from arch/arm/plat-pxa/include/plat/i2c.h
rename to include/linux/i2c/pxa-i2c.h
-- 
1.7.4

From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 14 Aug 2017 18:43:01 +0200
Subject: [PATCH] i2c: pxa: move header file out of deprecated i2c folder
Message-ID: <20170814164303.2383-1-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

include/linux/i2c is deprecated because too many platform_data of i2c
clients incorrectly ended up there. The few still relevant include files
for I2C bus masters with their platform_data have been moved to the
platform_data directory. This final one, PXA, is not entirely
platform_data, so it is simply moved one layer up. After that, the i2c
subfolder can finally go soon.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---

If you think this should rather go to "include/linux/platform_data" instead of
"include/linux", I am open for that. I like the latter a tad better, but not
super much.

No runtime testing because of no HW, but buildbot is happy with this series at
least and I did build testing, too.


 arch/arm/mach-mmp/mmp2.h                  | 2 +-
 arch/arm/mach-mmp/pxa168.h                | 2 +-
 arch/arm/mach-mmp/pxa910.h                | 2 +-
 arch/arm/mach-pxa/balloon3.c              | 2 +-
 arch/arm/mach-pxa/cm-x300.c               | 2 +-
 arch/arm/mach-pxa/colibri-evalboard.c     | 2 +-
 arch/arm/mach-pxa/colibri-pxa270-income.c | 2 +-
 arch/arm/mach-pxa/corgi.c                 | 2 +-
 arch/arm/mach-pxa/csb726.c                | 2 +-
 arch/arm/mach-pxa/devices.c               | 2 +-
 arch/arm/mach-pxa/em-x270.c               | 2 +-
 arch/arm/mach-pxa/ezx.c                   | 2 +-
 arch/arm/mach-pxa/hx4700.c                | 2 +-
 arch/arm/mach-pxa/littleton.c             | 2 +-
 arch/arm/mach-pxa/magician.c              | 2 +-
 arch/arm/mach-pxa/mainstone.c             | 2 +-
 arch/arm/mach-pxa/mioa701.c               | 2 +-
 arch/arm/mach-pxa/mxm8x10.c               | 2 +-
 arch/arm/mach-pxa/palm27x.c               | 2 +-
 arch/arm/mach-pxa/pcm990-baseboard.c      | 2 +-
 arch/arm/mach-pxa/poodle.c                | 2 +-
 arch/arm/mach-pxa/pxa27x.c                | 2 +-
 arch/arm/mach-pxa/pxa3xx.c                | 2 +-
 arch/arm/mach-pxa/raumfeld.c              | 2 +-
 arch/arm/mach-pxa/saar.c                  | 2 +-
 arch/arm/mach-pxa/spitz.c                 | 2 +-
 arch/arm/mach-pxa/stargate2.c             | 2 +-
 arch/arm/mach-pxa/tosa.c                  | 2 +-
 arch/arm/mach-pxa/trizeps4.c              | 2 +-
 arch/arm/mach-pxa/viper.c                 | 2 +-
 arch/arm/mach-pxa/vpac270.c               | 2 +-
 arch/arm/mach-pxa/xcep.c                  | 2 +-
 arch/arm/mach-pxa/z2.c                    | 2 +-
 arch/arm/mach-pxa/zeus.c                  | 2 +-
 arch/arm/mach-pxa/zylonite_pxa300.c       | 2 +-
 drivers/i2c/busses/i2c-pxa-pci.c          | 2 +-
 drivers/i2c/busses/i2c-pxa.c              | 2 +-
 include/linux/{i2c => }/pxa-i2c.h         | 0
 38 files changed, 37 insertions(+), 37 deletions(-)
 rename include/linux/{i2c => }/pxa-i2c.h (100%)

diff --git a/arch/arm/mach-mmp/mmp2.h b/arch/arm/mach-mmp/mmp2.h
index 9b5e75ee9e4dab..c3aace206e6368 100644
--- a/arch/arm/mach-mmp/mmp2.h
+++ b/arch/arm/mach-mmp/mmp2.h
@@ -9,7 +9,7 @@ extern void __init mmp2_init_irq(void);
 extern void mmp2_clear_pmic_int(void);
 
 #include <linux/i2c.h>
-#include <linux/i2c/pxa-i2c.h>
+#include <linux/pxa-i2c.h>
 #include <linux/platform_data/dma-mmp_tdma.h>
 
 #include "devices.h"
diff --git a/arch/arm/mach-mmp/pxa168.h b/arch/arm/mach-mmp/pxa168.h
index 75841e9ccd7396..7bd503ef9a1573 100644
--- a/arch/arm/mach-mmp/pxa168.h
+++ b/arch/arm/mach-mmp/pxa168.h
@@ -10,7 +10,7 @@ extern void pxa168_restart(enum reboot_mode, const char *);
 extern void pxa168_clear_keypad_wakeup(void);
 
 #include <linux/i2c.h>
-#include <linux/i2c/pxa-i2c.h>
+#include <linux/pxa-i2c.h>
 #include <linux/platform_data/mtd-nand-pxa3xx.h>
 #include <video/pxa168fb.h>
 #include <linux/platform_data/keypad-pxa27x.h>
diff --git a/arch/arm/mach-mmp/pxa910.h b/arch/arm/mach-mmp/pxa910.h
index a211e81e5a0824..957e3b2492966f 100644
--- a/arch/arm/mach-mmp/pxa910.h
+++ b/arch/arm/mach-mmp/pxa910.h
@@ -6,7 +6,7 @@ extern void __init icu_init_irq(void);
 extern void __init pxa910_init_irq(void);
 
 #include <linux/i2c.h>
-#include <linux/i2c/pxa-i2c.h>
+#include <linux/pxa-i2c.h>
 #include <linux/platform_data/mtd-nand-pxa3xx.h>
 #include <video/mmp_disp.h>
 
diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index 1467c1d1e54194..95ab831b1cc902 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -28,7 +28,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/types.h>
 #include <linux/platform_data/pcf857x.h>
-#include <linux/i2c/pxa-i2c.h>
+#include <linux/pxa-i2c.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/physmap.h>
 #include <linux/regulator/max1586.h>
diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index 868448d2cd8251..9667c19a885c22 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -31,7 +31,7 @@
 
 #include <linux/i2c.h>
 #include <linux/platform_data/pca953x.h>
-#include <linux/i2c/pxa-i2c.h>
+#include <linux/pxa-i2c.h>
 
 #include <linux/mfd/da903x.h>
 #include <linux/regulator/machine.h>
diff --git a/arch/arm/mach-pxa/colibri-evalboard.c b/arch/arm/mach-pxa/colibri-evalboard.c
index dc44fbbe507317..ee6120a3ce098e 100644
--- a/arch/arm/mach-pxa/colibri-evalboard.c
+++ b/arch/arm/mach-pxa/colibri-evalboard.c
@@ -19,7 +19,7 @@
 #include <mach/hardware.h>
 #include <asm/mach/arch.h>
 #include <linux/i2c.h>
-#include <linux/i2c/pxa-i2c.h>
+#include <linux/pxa-i2c.h>
 #include <asm/io.h>
 
 #include "pxa27x.h"
diff --git a/arch/arm/mach-pxa/colibri-pxa270-income.c b/arch/arm/mach-pxa/colibri-pxa270-income.c
index d7cf47d0361882..38acc6180cc2c5 100644
--- a/arch/arm/mach-pxa/colibri-pxa270-income.c
+++ b/arch/arm/mach-pxa/colibri-pxa270-income.c
@@ -23,7 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 #include <linux/pwm_backlight.h>
-#include <linux/i2c/pxa-i2c.h>
+#include <linux/pxa-i2c.h>
 
 #include <asm/irq.h>
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
index 7270f0db343216..986e76cfddb319 100644
--- a/arch/arm/mach-pxa/corgi.c
+++ b/arch/arm/mach-pxa/corgi.c
@@ -26,7 +26,7 @@
 #include <linux/gpio.h>
 #include <linux/backlight.h>
 #include <linux/i2c.h>
-#include <linux/i2c/pxa-i2c.h>
+#include <linux/pxa-i2c.h>
 #include <linux/io.h>
 #include <linux/regulator/machine.h>
 #include <linux/spi/spi.h>
diff --git a/arch/arm/mach-pxa/csb726.c b/arch/arm/mach-pxa/csb726.c
index bf19b8426d2c43..796e37112c81ca 100644
--- a/arch/arm/mach-pxa/csb726.c
+++ b/arch/arm/mach-pxa/csb726.c
@@ -17,7 +17,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/sm501.h>
 #include <linux/smsc911x.h>
-#include <linux/i2c/pxa-i2c.h>
+#include <linux/pxa-i2c.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index fffb697bbf0e3a..7fa68a3dde31fe 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -4,7 +4,7 @@
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/spi/pxa2xx_spi.h>
-#include <linux/i2c/pxa-i2c.h>
+#include <linux/pxa-i2c.h>
 
 #include "udc.h"
 #include <linux/platform_data/usb-pxa3xx-ulpi.h>
diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
index 811a7317f3eaa4..73f062aa50a936 100644
--- a/arch/arm/mach-pxa/em-x270.c
+++ b/arch/arm/mach-pxa/em-x270.c
@@ -32,7 +32,7 @@
 #include <linux/apm-emulation.h>
 #include <linux/i2c.h>
 #include <linux/platform_data/pca953x.h>
-#include <linux/i2c/pxa-i2c.h>
+#include <linux/pxa-i2c.h>
 #include <linux/regulator/userspace-consumer.h>
 
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-pxa/ezx.c b/arch/arm/mach-pxa/ezx.c
index a057cf9c0e7b32..5e116752b66d00 100644
--- a/arch/arm/mach-pxa/ezx.c
+++ b/arch/arm/mach-pxa/ezx.c
@@ -23,7 +23,7 @@
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
 #include <linux/leds-lp3944.h>
-#include <linux/i2c/pxa-i2c.h>
+#include <linux/pxa-i2c.h>
 
 #include <asm/setup.h>
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index 66184f5cbe402c..85a98d2f6c1ea6 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -38,7 +38,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/pxa2xx_spi.h>
 #include <linux/usb/gpio_vbus.h>
-#include <linux/i2c/pxa-i2c.h>
+#include <linux/pxa-i2c.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
index fae38fdc8d8e56..693fcfccd5deeb 100644
--- a/arch/arm/mach-pxa/littleton.c
+++ b/arch/arm/mach-pxa/littleton.c
@@ -28,7 +28,7 @@
 #include <linux/leds.h>
 #include <linux/mfd/da903x.h>
 #include <linux/platform_data/max732x.h>
-#include <linux/i2c/pxa-i2c.h>
+#include <linux/pxa-i2c.h>
 
 #include <asm/types.h>
 #include <asm/setup.h>
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 7f3566c9373346..9a56f0eb325292 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -31,7 +31,7 @@
 #include <linux/regulator/gpio-regulator.h>
 #include <linux/regulator/machine.h>
 #include <linux/usb/gpio_vbus.h>
-#include <linux/i2c/pxa-i2c.h>
+#include <linux/pxa-i2c.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-pxa/mainstone.c b/arch/arm/mach-pxa/mainstone.c
index a2d851a3a546c5..423476db0099c3 100644
--- a/arch/arm/mach-pxa/mainstone.c
+++ b/arch/arm/mach-pxa/mainstone.c
@@ -29,7 +29,7 @@
 #include <linux/pwm.h>
 #include <linux/pwm_backlight.h>
 #include <linux/smc91x.h>
-#include <linux/i2c/pxa-i2c.h>
+#include <linux/pxa-i2c.h>
 #include <linux/slab.h>
 #include <linux/leds.h>
 
diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index 8a5d0491e73c37..259cccdaff7224 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -42,7 +42,7 @@
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/max1586.h>
 #include <linux/slab.h>
-#include <linux/i2c/pxa-i2c.h>
+#include <linux/pxa-i2c.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-pxa/mxm8x10.c b/arch/arm/mach-pxa/mxm8x10.c
index 9a22ae0ad8c9e0..454c03f2ff3965 100644
--- a/arch/arm/mach-pxa/mxm8x10.c
+++ b/arch/arm/mach-pxa/mxm8x10.c
@@ -22,7 +22,7 @@
 #include <linux/serial_8250.h>
 #include <linux/dm9000.h>
 #include <linux/gpio.h>
-#include <linux/i2c/pxa-i2c.h>
+#include <linux/pxa-i2c.h>
 
 #include <linux/platform_data/mtd-nand-pxa3xx.h>
 
diff --git a/arch/arm/mach-pxa/palm27x.c b/arch/arm/mach-pxa/palm27x.c
index e5ae99db1de4c0..639441aac900fb 100644
--- a/arch/arm/mach-pxa/palm27x.c
+++ b/arch/arm/mach-pxa/palm27x.c
@@ -22,7 +22,7 @@
 #include <linux/power_supply.h>
 #include <linux/usb/gpio_vbus.h>
 #include <linux/regulator/max1586.h>
-#include <linux/i2c/pxa-i2c.h>
+#include <linux/pxa-i2c.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-pxa/pcm990-baseboard.c b/arch/arm/mach-pxa/pcm990-baseboard.c
index 0bd5959ef7d55b..a06b7271615664 100644
--- a/arch/arm/mach-pxa/pcm990-baseboard.c
+++ b/arch/arm/mach-pxa/pcm990-baseboard.c
@@ -23,7 +23,7 @@
 #include <linux/irq.h>
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
-#include <linux/i2c/pxa-i2c.h>
+#include <linux/pxa-i2c.h>
 #include <linux/pwm.h>
 #include <linux/pwm_backlight.h>
 
diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
index 62a119137be7d3..4d0ab9dfaf3236 100644
--- a/arch/arm/mach-pxa/poodle.c
+++ b/arch/arm/mach-pxa/poodle.c
@@ -24,7 +24,7 @@
 #include <linux/mtd/physmap.h>
 #include <linux/gpio.h>
 #include <linux/i2c.h>
-#include <linux/i2c/pxa-i2c.h>
+#include <linux/pxa-i2c.h>
 #include <linux/regulator/machine.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 9b69be4e9fe331..54de53bda23249 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -22,7 +22,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/io.h>
 #include <linux/irq.h>
-#include <linux/i2c/pxa-i2c.h>
+#include <linux/pxa-i2c.h>
 
 #include <asm/mach/map.h>
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 0cc9f124c9ac37..3d87b8f00e500c 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -23,7 +23,7 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/syscore_ops.h>
-#include <linux/i2c/pxa-i2c.h>
+#include <linux/pxa-i2c.h>
 
 #include <asm/mach/map.h>
 #include <asm/suspend.h>
diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index e2c97728b3c6b2..2f440da3d368c0 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -32,7 +32,7 @@
 #include <linux/pwm.h>
 #include <linux/pwm_backlight.h>
 #include <linux/i2c.h>
-#include <linux/i2c/pxa-i2c.h>
+#include <linux/pxa-i2c.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_gpio.h>
 #include <linux/lis3lv02d.h>
diff --git a/arch/arm/mach-pxa/saar.c b/arch/arm/mach-pxa/saar.c
index 1414b5f291149c..c66c4c632a4ecd 100644
--- a/arch/arm/mach-pxa/saar.c
+++ b/arch/arm/mach-pxa/saar.c
@@ -20,7 +20,7 @@
 #include <linux/delay.h>
 #include <linux/fb.h>
 #include <linux/i2c.h>
-#include <linux/i2c/pxa-i2c.h>
+#include <linux/pxa-i2c.h>
 #include <linux/smc91x.h>
 #include <linux/mfd/da903x.h>
 #include <linux/mtd/mtd.h>
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 67d66c70257452..1fafd9f450f578 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -20,7 +20,7 @@
 #include <linux/gpio.h>
 #include <linux/leds.h>
 #include <linux/i2c.h>
-#include <linux/i2c/pxa-i2c.h>
+#include <linux/pxa-i2c.h>
 #include <linux/platform_data/pca953x.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
diff --git a/arch/arm/mach-pxa/stargate2.c b/arch/arm/mach-pxa/stargate2.c
index 2d45d18b1a5e0a..e22bd4bb33ba3c 100644
--- a/arch/arm/mach-pxa/stargate2.c
+++ b/arch/arm/mach-pxa/stargate2.c
@@ -25,7 +25,7 @@
 #include <linux/mtd/plat-ram.h>
 #include <linux/mtd/partitions.h>
 
-#include <linux/i2c/pxa-i2c.h>
+#include <linux/pxa-i2c.h>
 #include <linux/platform_data/pcf857x.h>
 #include <linux/platform_data/at24.h>
 #include <linux/smc91x.h>
diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
index 13de6602966fea..db228e3a1db41b 100644
--- a/arch/arm/mach-pxa/tosa.c
+++ b/arch/arm/mach-pxa/tosa.c
@@ -35,7 +35,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/pxa2xx_spi.h>
 #include <linux/input/matrix_keypad.h>
-#include <linux/i2c/pxa-i2c.h>
+#include <linux/pxa-i2c.h>
 #include <linux/usb/gpio_vbus.h>
 #include <linux/reboot.h>
 #include <linux/memblock.h>
diff --git a/arch/arm/mach-pxa/trizeps4.c b/arch/arm/mach-pxa/trizeps4.c
index 3dd13b44c31153..bab4cb76c6d114 100644
--- a/arch/arm/mach-pxa/trizeps4.c
+++ b/arch/arm/mach-pxa/trizeps4.c
@@ -28,7 +28,7 @@
 #include <linux/mtd/physmap.h>
 #include <linux/mtd/partitions.h>
 #include <linux/regulator/machine.h>
-#include <linux/i2c/pxa-i2c.h>
+#include <linux/pxa-i2c.h>
 
 #include <asm/types.h>
 #include <asm/setup.h>
diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
index 8e89d91b206b6d..0a4c149d7a26f9 100644
--- a/arch/arm/mach-pxa/viper.c
+++ b/arch/arm/mach-pxa/viper.c
@@ -36,7 +36,7 @@
 #include <linux/gpio.h>
 #include <linux/jiffies.h>
 #include <linux/i2c-gpio.h>
-#include <linux/i2c/pxa-i2c.h>
+#include <linux/pxa-i2c.h>
 #include <linux/serial_8250.h>
 #include <linux/smc91x.h>
 #include <linux/pwm.h>
diff --git a/arch/arm/mach-pxa/vpac270.c b/arch/arm/mach-pxa/vpac270.c
index 70ab3ad2823790..3b56648dde1779 100644
--- a/arch/arm/mach-pxa/vpac270.c
+++ b/arch/arm/mach-pxa/vpac270.c
@@ -27,7 +27,7 @@
 #include <linux/ata_platform.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/max1586.h>
-#include <linux/i2c/pxa-i2c.h>
+#include <linux/pxa-i2c.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-pxa/xcep.c b/arch/arm/mach-pxa/xcep.c
index 056369ef250e8a..948210a675418c 100644
--- a/arch/arm/mach-pxa/xcep.c
+++ b/arch/arm/mach-pxa/xcep.c
@@ -16,7 +16,7 @@
 
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
-#include <linux/i2c/pxa-i2c.h>
+#include <linux/pxa-i2c.h>
 #include <linux/smc91x.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index 510e533871f3ca..e07dccbda12f9e 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -30,7 +30,7 @@
 #include <linux/gpio_keys.h>
 #include <linux/delay.h>
 #include <linux/regulator/machine.h>
-#include <linux/i2c/pxa-i2c.h>
+#include <linux/pxa-i2c.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index ecbcaee5a2d5f8..7ee48162a39db2 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -26,7 +26,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
 #include <linux/i2c.h>
-#include <linux/i2c/pxa-i2c.h>
+#include <linux/pxa-i2c.h>
 #include <linux/platform_data/pca953x.h>
 #include <linux/apm-emulation.h>
 #include <linux/can/platform/mcp251x.h>
diff --git a/arch/arm/mach-pxa/zylonite_pxa300.c b/arch/arm/mach-pxa/zylonite_pxa300.c
index e247acf1400a90..bf75d461384d7f 100644
--- a/arch/arm/mach-pxa/zylonite_pxa300.c
+++ b/arch/arm/mach-pxa/zylonite_pxa300.c
@@ -17,7 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
-#include <linux/i2c/pxa-i2c.h>
+#include <linux/pxa-i2c.h>
 #include <linux/platform_data/pca953x.h>
 #include <linux/gpio.h>
 
diff --git a/drivers/i2c/busses/i2c-pxa-pci.c b/drivers/i2c/busses/i2c-pxa-pci.c
index 004deb96afe35e..5c6ef1107a7a13 100644
--- a/drivers/i2c/busses/i2c-pxa-pci.c
+++ b/drivers/i2c/busses/i2c-pxa-pci.c
@@ -10,7 +10,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
-#include <linux/i2c/pxa-i2c.h>
+#include <linux/pxa-i2c.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_address.h>
diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 6cf333ecc8b83f..394b2bdb506eb0 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -36,7 +36,7 @@
 #include <linux/clk.h>
 #include <linux/slab.h>
 #include <linux/io.h>
-#include <linux/i2c/pxa-i2c.h>
+#include <linux/pxa-i2c.h>
 
 #include <asm/irq.h>
 
diff --git a/include/linux/i2c/pxa-i2c.h b/include/linux/pxa-i2c.h
similarity index 100%
rename from include/linux/i2c/pxa-i2c.h
rename to include/linux/pxa-i2c.h
-- 
2.11.0

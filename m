From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 28 May 2013 10:21:46 +0800
Subject: [PATCH v2 4/5] ARM: mmp: move irqs head file
In-Reply-To: <1369707707-30295-1-git-send-email-haojian.zhuang@gmail.com>
References: <1369707707-30295-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1369707707-30295-5-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since irq-mmp driver includes <mach/irqs.h>, it blocks the multiple
platform build. So move the head file into include/linux/irqchip/
directory.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 arch/arm/mach-mmp/aspenite.c                                         | 2 +-
 arch/arm/mach-mmp/avengers_lite.c                                    | 2 +-
 arch/arm/mach-mmp/brownstone.c                                       | 2 +-
 arch/arm/mach-mmp/devices.c                                          | 2 +-
 arch/arm/mach-mmp/flint.c                                            | 2 +-
 arch/arm/mach-mmp/gplugd.c                                           | 2 +-
 arch/arm/mach-mmp/jasper.c                                           | 2 +-
 arch/arm/mach-mmp/mmp2.c                                             | 2 +-
 arch/arm/mach-mmp/pm-mmp2.c                                          | 2 +-
 arch/arm/mach-mmp/pm-pxa910.c                                        | 2 +-
 arch/arm/mach-mmp/pxa168.c                                           | 2 +-
 arch/arm/mach-mmp/pxa910.c                                           | 2 +-
 arch/arm/mach-mmp/tavorevb.c                                         | 2 +-
 arch/arm/mach-mmp/teton_bga.c                                        | 2 +-
 arch/arm/mach-mmp/time.c                                             | 2 +-
 arch/arm/mach-mmp/ttc_dkb.c                                          | 2 +-
 drivers/gpio/gpio-pxa.c                                              | 3 +--
 drivers/irqchip/irq-mmp.c                                            | 3 +--
 arch/arm/mach-mmp/include/mach/irqs.h => include/linux/irqchip/mmp.h | 0
 19 files changed, 18 insertions(+), 20 deletions(-)
 rename arch/arm/mach-mmp/include/mach/irqs.h => include/linux/irqchip/mmp.h (100%)

diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index 5b660ec..e850fc0 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -11,6 +11,7 @@
 #include <linux/gpio.h>
 #include <linux/gpio-pxa.h>
 #include <linux/init.h>
+#include <linux/irqchip/mmp.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/smc91x.h>
@@ -25,7 +26,6 @@
 #include <mach/addr-map.h>
 #include <mach/mfp-pxa168.h>
 #include <mach/pxa168.h>
-#include <mach/irqs.h>
 #include <video/pxa168fb.h>
 #include <linux/input.h>
 #include <linux/platform_data/keypad-pxa27x.h>
diff --git a/arch/arm/mach-mmp/avengers_lite.c b/arch/arm/mach-mmp/avengers_lite.c
index a451a0f..c2c5b09 100644
--- a/arch/arm/mach-mmp/avengers_lite.c
+++ b/arch/arm/mach-mmp/avengers_lite.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/irqchip/mmp.h>
 #include <linux/kernel.h>
 #include <linux/gpio-pxa.h>
 #include <linux/platform_device.h>
@@ -20,7 +21,6 @@
 #include <mach/addr-map.h>
 #include <mach/mfp-pxa168.h>
 #include <mach/pxa168.h>
-#include <mach/irqs.h>
 
 
 #include "common.h"
diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.c
index ac25544..41941b6 100644
--- a/arch/arm/mach-mmp/brownstone.c
+++ b/arch/arm/mach-mmp/brownstone.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/irqchip/mmp.h>
 #include <linux/gpio-pxa.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/max8649.h>
@@ -25,7 +26,6 @@
 #include <mach/addr-map.h>
 #include <mach/mfp-mmp2.h>
 #include <mach/mmp2.h>
-#include <mach/irqs.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-mmp/devices.c b/arch/arm/mach-mmp/devices.c
index dd2d8b1..bbb0aa0 100644
--- a/arch/arm/mach-mmp/devices.c
+++ b/arch/arm/mach-mmp/devices.c
@@ -7,12 +7,12 @@
  */
 
 #include <linux/init.h>
+#include <linux/irqchip/mmp.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/delay.h>
 
 #include <asm/irq.h>
-#include <mach/irqs.h>
 #include <mach/devices.h>
 #include <mach/cputype.h>
 #include <mach/regs-usb.h>
diff --git a/arch/arm/mach-mmp/flint.c b/arch/arm/mach-mmp/flint.c
index 6291c33..0c733f5 100644
--- a/arch/arm/mach-mmp/flint.c
+++ b/arch/arm/mach-mmp/flint.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/smc91x.h>
 #include <linux/io.h>
+#include <linux/irqchip/mmp.h>
 #include <linux/gpio.h>
 #include <linux/gpio-pxa.h>
 #include <linux/interrupt.h>
@@ -24,7 +25,6 @@
 #include <mach/addr-map.h>
 #include <mach/mfp-mmp2.h>
 #include <mach/mmp2.h>
-#include <mach/irqs.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-mmp/gplugd.c b/arch/arm/mach-mmp/gplugd.c
index d81b247..87b884f 100644
--- a/arch/arm/mach-mmp/gplugd.c
+++ b/arch/arm/mach-mmp/gplugd.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/irqchip/mmp.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 #include <linux/gpio-pxa.h>
@@ -16,7 +17,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 
-#include <mach/irqs.h>
 #include <mach/pxa168.h>
 #include <mach/mfp-pxa168.h>
 
diff --git a/arch/arm/mach-mmp/jasper.c b/arch/arm/mach-mmp/jasper.c
index 0e9e5c0..68dc03b 100644
--- a/arch/arm/mach-mmp/jasper.c
+++ b/arch/arm/mach-mmp/jasper.c
@@ -15,12 +15,12 @@
 #include <linux/gpio-pxa.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/irqchip/mmp.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/max8649.h>
 #include <linux/mfd/max8925.h>
 #include <linux/interrupt.h>
 
-#include <mach/irqs.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/addr-map.h>
diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index c7592f1..08245c7 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/irqchip/mmp.h>
 #include <linux/platform_device.h>
 
 #include <asm/hardware/cache-tauros2.h>
@@ -21,7 +22,6 @@
 #include <mach/addr-map.h>
 #include <mach/regs-apbc.h>
 #include <mach/cputype.h>
-#include <mach/irqs.h>
 #include <mach/dma.h>
 #include <mach/mfp.h>
 #include <mach/devices.h>
diff --git a/arch/arm/mach-mmp/pm-mmp2.c b/arch/arm/mach-mmp/pm-mmp2.c
index 461a191..7646829 100644
--- a/arch/arm/mach-mmp/pm-mmp2.c
+++ b/arch/arm/mach-mmp/pm-mmp2.c
@@ -15,6 +15,7 @@
 #include <linux/delay.h>
 #include <linux/suspend.h>
 #include <linux/irq.h>
+#include <linux/irqchip/mmp.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <asm/mach-types.h>
@@ -23,7 +24,6 @@
 #include <mach/addr-map.h>
 #include <mach/pm-mmp2.h>
 #include <mach/regs-icu.h>
-#include <mach/irqs.h>
 
 int mmp2_set_wake(struct irq_data *d, unsigned int on)
 {
diff --git a/arch/arm/mach-mmp/pm-pxa910.c b/arch/arm/mach-mmp/pm-pxa910.c
index 48981ca..e919539 100644
--- a/arch/arm/mach-mmp/pm-pxa910.c
+++ b/arch/arm/mach-mmp/pm-pxa910.c
@@ -17,13 +17,13 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/irqchip/mmp.h>
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
 #include <mach/cputype.h>
 #include <mach/addr-map.h>
 #include <mach/pm-pxa910.h>
 #include <mach/regs-icu.h>
-#include <mach/irqs.h>
 
 int pxa910_set_wake(struct irq_data *data, unsigned int on)
 {
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index a30dcf3..8da96de 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/irqchip/mmp.h>
 #include <linux/list.h>
 #include <linux/io.h>
 #include <linux/clk.h>
@@ -22,7 +23,6 @@
 #include <mach/addr-map.h>
 #include <mach/regs-apbc.h>
 #include <mach/regs-apmu.h>
-#include <mach/irqs.h>
 #include <mach/dma.h>
 #include <mach/devices.h>
 #include <mach/mfp.h>
diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
index a586742..4ce3e16 100644
--- a/arch/arm/mach-mmp/pxa910.c
+++ b/arch/arm/mach-mmp/pxa910.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/io.h>
+#include <linux/irqchip/mmp.h>
 #include <linux/platform_device.h>
 
 #include <asm/hardware/cache-tauros2.h>
@@ -19,7 +20,6 @@
 #include <mach/addr-map.h>
 #include <mach/regs-apbc.h>
 #include <mach/cputype.h>
-#include <mach/irqs.h>
 #include <mach/dma.h>
 #include <mach/mfp.h>
 #include <mach/devices.h>
diff --git a/arch/arm/mach-mmp/tavorevb.c b/arch/arm/mach-mmp/tavorevb.c
index cdfc9bf..d3bb3a7 100644
--- a/arch/arm/mach-mmp/tavorevb.c
+++ b/arch/arm/mach-mmp/tavorevb.c
@@ -10,6 +10,7 @@
 #include <linux/gpio.h>
 #include <linux/gpio-pxa.h>
 #include <linux/init.h>
+#include <linux/irqchip/mmp.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/smc91x.h>
@@ -19,7 +20,6 @@
 #include <mach/addr-map.h>
 #include <mach/mfp-pxa910.h>
 #include <mach/pxa910.h>
-#include <mach/irqs.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-mmp/teton_bga.c b/arch/arm/mach-mmp/teton_bga.c
index e4d95b4..a88a2ff 100644
--- a/arch/arm/mach-mmp/teton_bga.c
+++ b/arch/arm/mach-mmp/teton_bga.c
@@ -18,6 +18,7 @@
 #include <linux/gpio.h>
 #include <linux/gpio-pxa.h>
 #include <linux/input.h>
+#include <linux/irqchip/mmp.h>
 #include <linux/platform_data/keypad-pxa27x.h>
 #include <linux/i2c.h>
 
@@ -27,7 +28,6 @@
 #include <mach/mfp-pxa168.h>
 #include <mach/pxa168.h>
 #include <mach/teton_bga.h>
-#include <mach/irqs.h>
 
 #include "common.h"
 
diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
index 86a18b3..891b9da 100644
--- a/arch/arm/mach-mmp/time.c
+++ b/arch/arm/mach-mmp/time.c
@@ -25,6 +25,7 @@
 
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/irqchip/mmp.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
@@ -33,7 +34,6 @@
 #include <mach/addr-map.h>
 #include <mach/regs-timers.h>
 #include <mach/regs-apbc.h>
-#include <mach/irqs.h>
 #include <mach/cputype.h>
 #include <asm/mach/time.h>
 
diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index 8483906..39db088 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -15,6 +15,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/onenand.h>
 #include <linux/interrupt.h>
+#include <linux/irqchip/mmp.h>
 #include <linux/i2c/pca953x.h>
 #include <linux/gpio.h>
 #include <linux/gpio-pxa.h>
@@ -29,7 +30,6 @@
 #include <mach/addr-map.h>
 #include <mach/mfp-pxa910.h>
 #include <mach/pxa910.h>
-#include <mach/irqs.h>
 #include <mach/regs-usb.h>
 
 #include "common.h"
diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index df2199d..cb8f31f 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -20,6 +20,7 @@
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/irqchip/chained_irq.h>
+#include <linux/irqchip/mmp.h>
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -27,8 +28,6 @@
 #include <linux/syscore_ops.h>
 #include <linux/slab.h>
 
-#include <mach/irqs.h>
-
 /*
  * We handle the GPIOs by banks, each bank covers up to 32 GPIOs with
  * one set of registers. The register offsets are organized below:
diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
index f54ebca..90fe265 100644
--- a/drivers/irqchip/irq-mmp.c
+++ b/drivers/irqchip/irq-mmp.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/irq.h>
+#include <linux/irqchip/mmp.h>
 #include <linux/irqdomain.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
@@ -24,8 +25,6 @@
 #include <asm/exception.h>
 #include <asm/mach/irq.h>
 
-#include <mach/irqs.h>
-
 #ifdef CONFIG_CPU_MMP2
 #include <mach/pm-mmp2.h>
 #endif
diff --git a/arch/arm/mach-mmp/include/mach/irqs.h b/include/linux/irqchip/mmp.h
similarity index 100%
rename from arch/arm/mach-mmp/include/mach/irqs.h
rename to include/linux/irqchip/mmp.h
-- 
1.8.1.2

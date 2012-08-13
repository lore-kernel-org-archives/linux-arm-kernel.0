From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 13 Aug 2012 13:57:53 +0200
Subject: [PATCH 3/7] pinctrl/coh901: move header to platform data dir
Message-ID: <1344859073-29370-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Move the platform-specific COH901 pin control header out of the
ARM tree and down into the proper platform data include
directory.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-u300/core.c                    |  2 +-
 arch/arm/mach-u300/include/mach/gpio-u300.h  | 26 --------------------------
 drivers/pinctrl/pinctrl-coh901.c             |  2 +-
 include/linux/platform_data/pinctrl-coh901.h | 26 ++++++++++++++++++++++++++
 4 files changed, 28 insertions(+), 28 deletions(-)
 delete mode 100644 arch/arm/mach-u300/include/mach/gpio-u300.h
 create mode 100644 include/linux/platform_data/pinctrl-coh901.h

diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index 883d5c2..0158189 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -31,6 +31,7 @@
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_data/clk-u300.h>
+#include <linux/platform_data/pinctrl-coh901.h>
 
 #include <asm/types.h>
 #include <asm/setup.h>
@@ -43,7 +44,6 @@
 #include <mach/hardware.h>
 #include <mach/syscon.h>
 #include <mach/dma_channels.h>
-#include <mach/gpio-u300.h>
 
 #include "spi.h"
 #include "i2c.h"
diff --git a/arch/arm/mach-u300/include/mach/gpio-u300.h b/arch/arm/mach-u300/include/mach/gpio-u300.h
deleted file mode 100644
index 30dea25..0000000
--- a/arch/arm/mach-u300/include/mach/gpio-u300.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * Copyright (C) 2007-2012 ST-Ericsson AB
- * License terms: GNU General Public License (GPL) version 2
- * GPIO block resgister definitions and inline macros for
- * U300 GPIO COH 901 335 or COH 901 571/3
- * Author: Linus Walleij <linus.walleij@stericsson.com>
- */
-
-#ifndef __MACH_U300_GPIO_U300_H
-#define __MACH_U300_GPIO_U300_H
-
-/**
- * struct u300_gpio_platform - U300 GPIO platform data
- * @ports: number of GPIO block ports
- * @gpio_base: first GPIO number for this block (use a free range)
- * @gpio_irq_base: first GPIO IRQ number for this block (use a free range)
- * @pinctrl_device: pin control device to spawn as child
- */
-struct u300_gpio_platform {
-	u8 ports;
-	int gpio_base;
-	int gpio_irq_base;
-	struct platform_device *pinctrl_device;
-};
-
-#endif /* __MACH_U300_GPIO_U300_H */
diff --git a/drivers/pinctrl/pinctrl-coh901.c b/drivers/pinctrl/pinctrl-coh901.c
index 91a5dc7..b446c96 100644
--- a/drivers/pinctrl/pinctrl-coh901.c
+++ b/drivers/pinctrl/pinctrl-coh901.c
@@ -21,7 +21,7 @@
 #include <linux/slab.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pinctrl/pinconf-generic.h>
-#include <mach/gpio-u300.h>
+#include <linux/platform_data/pinctrl-coh901.h>
 #include "pinctrl-coh901.h"
 
 #define U300_GPIO_PORT_STRIDE				(0x30)
diff --git a/include/linux/platform_data/pinctrl-coh901.h b/include/linux/platform_data/pinctrl-coh901.h
new file mode 100644
index 0000000..30dea25
--- /dev/null
+++ b/include/linux/platform_data/pinctrl-coh901.h
@@ -0,0 +1,26 @@
+/*
+ * Copyright (C) 2007-2012 ST-Ericsson AB
+ * License terms: GNU General Public License (GPL) version 2
+ * GPIO block resgister definitions and inline macros for
+ * U300 GPIO COH 901 335 or COH 901 571/3
+ * Author: Linus Walleij <linus.walleij@stericsson.com>
+ */
+
+#ifndef __MACH_U300_GPIO_U300_H
+#define __MACH_U300_GPIO_U300_H
+
+/**
+ * struct u300_gpio_platform - U300 GPIO platform data
+ * @ports: number of GPIO block ports
+ * @gpio_base: first GPIO number for this block (use a free range)
+ * @gpio_irq_base: first GPIO IRQ number for this block (use a free range)
+ * @pinctrl_device: pin control device to spawn as child
+ */
+struct u300_gpio_platform {
+	u8 ports;
+	int gpio_base;
+	int gpio_irq_base;
+	struct platform_device *pinctrl_device;
+};
+
+#endif /* __MACH_U300_GPIO_U300_H */
-- 
1.7.11.3

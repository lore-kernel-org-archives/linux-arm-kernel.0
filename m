From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  1 Oct 2013 10:32:30 +0200
Subject: [PATCH] ARM: w90x900: delete <mach/gpio.h>
Message-ID: <1380616350-16924-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The local <mach/gpio.h> file on the w90x900 is completely unused
and the platform does not define NEED_MACH_GPIO_H.

Cc: Wan ZongShun <mcuos.com@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
This patch will be applied to the GPIO tree unless there are
protests against this.
---
 arch/arm/mach-w90x900/include/mach/gpio.h | 30 ------------------------------
 1 file changed, 30 deletions(-)
 delete mode 100644 arch/arm/mach-w90x900/include/mach/gpio.h

diff --git a/arch/arm/mach-w90x900/include/mach/gpio.h b/arch/arm/mach-w90x900/include/mach/gpio.h
deleted file mode 100644
index 5385a42..0000000
--- a/arch/arm/mach-w90x900/include/mach/gpio.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- * linux/arch/arm/mach-w90p910/include/mach/gpio.h
- *
- * Generic w90p910 GPIO handling
- *
- *  Wan ZongShun <mcuos.com@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ASM_ARCH_W90P910_GPIO_H
-#define __ASM_ARCH_W90P910_GPIO_H
-
-#include <mach/hardware.h>
-#include <asm/irq.h>
-
-static inline int gpio_to_irq(unsigned gpio)
-{
-	return gpio;
-}
-#define gpio_to_irq gpio_to_irq
-
-static inline int irq_to_gpio(unsigned irq)
-{
-	return irq;
-}
-
-#endif
-- 
1.8.3.1

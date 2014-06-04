From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  4 Jun 2014 15:33:58 +0200
Subject: [PATCH 4/4] ARM: delete old reference to ARM_GPIOLIB_COMPLEX
In-Reply-To: <1401888838-3126-1-git-send-email-linus.walleij@linaro.org>
References: <1401888838-3126-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1401888838-3126-5-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This inclusion guard became pointless after commit
40ca061b1bb8827609d39679ddde6705551cb031
"ARM: 7841/1: sa1100: remove complex GPIO interface"
which removed the last complex gpiolib interface.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/include/asm/gpio.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/include/asm/gpio.h b/arch/arm/include/asm/gpio.h
index 5e1742ea36b7..504dcddebfcc 100644
--- a/arch/arm/include/asm/gpio.h
+++ b/arch/arm/include/asm/gpio.h
@@ -5,7 +5,6 @@
 #define ARCH_NR_GPIOS CONFIG_ARCH_NR_GPIO
 #endif
 
-#ifndef __ARM_GPIOLIB_COMPLEX
 /* Note: this may rely upon the value of ARCH_NR_GPIOS set in mach/gpio.h */
 #include <asm-generic/gpio.h>
 
@@ -13,7 +12,6 @@
 #define gpio_get_value  __gpio_get_value
 #define gpio_set_value  __gpio_set_value
 #define gpio_cansleep   __gpio_cansleep
-#endif
 
 /*
  * Provide a default gpio_to_irq() which should satisfy every case.
-- 
1.9.3

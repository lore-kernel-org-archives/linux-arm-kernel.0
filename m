From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 10 Aug 2011 14:16:41 +0200
Subject: [PATCH 03/19] mach-u300: delete irq_to_gpio() function
Message-ID: <1312978601-18169-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This function is not used in the U300 build, and on the whole the
call is hard to consolidate so get rid of it from this machine.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-u300/include/mach/gpio.h |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-u300/include/mach/gpio.h b/arch/arm/mach-u300/include/mach/gpio.h
index 6a3f24d..430a054 100644
--- a/arch/arm/mach-u300/include/mach/gpio.h
+++ b/arch/arm/mach-u300/include/mach/gpio.h
@@ -44,13 +44,4 @@ static inline unsigned gpio_to_irq(unsigned gpio)
 }
 #define gpio_to_irq gpio_to_irq
 
-static inline unsigned irq_to_gpio(unsigned irq)
-{
-	/*
-	 * FIXME: This is no 1-1 mapping at all, it points to the
-	 * whole block of 8 pins.
-	 */
-	return (irq - IRQ_U300_GPIO_PORT0) << 3;
-}
-
 #endif /* __MACH_U300_GPIO_H */
-- 
1.7.3.2

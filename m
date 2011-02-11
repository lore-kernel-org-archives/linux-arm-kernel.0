From: ryan@bluewatersys.com (Ryan Mallon)
Date: Fri, 11 Feb 2011 16:44:03 +1300
Subject: [PATCH 1/2] AT91: Use macros for gpio_to_irq/irq_to_gpio
Message-ID: <1297395844-21162-1-git-send-email-ryan@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the static inline functions for gpio_to_irq/irq_to_gpio so that they
can be used in static initialisers.

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---
 arch/arm/mach-at91/include/mach/gpio.h |   11 ++---------
 1 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/gpio.h b/arch/arm/mach-at91/include/mach/gpio.h
index bfdd8ab..ddeb645 100644
--- a/arch/arm/mach-at91/include/mach/gpio.h
+++ b/arch/arm/mach-at91/include/mach/gpio.h
@@ -220,15 +220,8 @@ extern void at91_gpio_resume(void);
 #define gpio_set_value	__gpio_set_value
 #define gpio_cansleep	__gpio_cansleep
 
-static inline int gpio_to_irq(unsigned gpio)
-{
-	return gpio;
-}
-
-static inline int irq_to_gpio(unsigned irq)
-{
-	return irq;
-}
+#define gpio_to_irq(gpio) (gpio)
+#define irq_to_gpio(irq)  (irq)
 
 #endif	/* __ASSEMBLY__ */
 
-- 
1.7.0.4

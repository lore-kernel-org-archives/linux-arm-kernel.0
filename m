From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 10 Aug 2011 14:18:48 +0200
Subject: [PATCH 19/19] mach-sa1100: delete irq_to_gpio() function
Message-ID: <1312978728-18704-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This function is not used in the assabet build, and on the whole the
call is hard to consolidate so get rid of it from this machine.

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-sa1100/include/mach/gpio.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-sa1100/include/mach/gpio.h b/arch/arm/mach-sa1100/include/mach/gpio.h
index ab45b43..7036318 100644
--- a/arch/arm/mach-sa1100/include/mach/gpio.h
+++ b/arch/arm/mach-sa1100/include/mach/gpio.h
@@ -53,7 +53,5 @@ static inline void gpio_set_value(unsigned gpio, int value)
 
 #define gpio_to_irq(gpio)	((gpio < 11) ? (IRQ_GPIO0 + gpio) : \
 					(IRQ_GPIO11 - 11 + gpio))
-#define irq_to_gpio(irq)	((irq < IRQ_GPIO11_27) ? (irq - IRQ_GPIO0) : \
-					(irq - IRQ_GPIO11 + 11))
 
 #endif
-- 
1.7.3.2

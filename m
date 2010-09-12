From: linus.walleij@stericsson.com (Linus Walleij)
Date: Sun, 12 Sep 2010 22:11:54 +0200
Subject: [PATCH] ARM: supply _cansleep gpio function to U300
Message-ID: <1284322314-25218-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have to use _cansleep gpio accessors in the MMCI driver so as
to avoid slowpath warnings, now U300 has MMCI but doesn't have
these functions in place to siply wrap the existing non-sleeping
functions into sleepable variants.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-u300/include/mach/gpio.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-u300/include/mach/gpio.h b/arch/arm/mach-u300/include/mach/gpio.h
index 7b1fc98..d5a71ab 100644
--- a/arch/arm/mach-u300/include/mach/gpio.h
+++ b/arch/arm/mach-u300/include/mach/gpio.h
@@ -273,6 +273,9 @@ extern void gpio_pullup(unsigned gpio, int value);
 extern int gpio_get_value(unsigned gpio);
 extern void gpio_set_value(unsigned gpio, int value);
 
+#define gpio_get_value_cansleep gpio_get_value
+#define gpio_set_value_cansleep gpio_set_value
+
 /* wrappers to sleep-enable the previous two functions */
 static inline unsigned gpio_to_irq(unsigned gpio)
 {
-- 
1.6.3.3

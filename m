From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 8 Feb 2011 10:20:54 +0100
Subject: [PATCH 9/9] plat-nomadik: change sleep/wakeup setting in GPIO SLPM
	register
In-Reply-To: <1297156854-32295-1-git-send-email-linus.walleij@stericsson.com>
References: <1297156854-32295-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1297156854-32295-10-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rikard Olsson <rikard.p.olsson@stericsson.com>

This patch fixes a bug when setting SLPM register for DB8500.
When calling__nmk_gpio_set_slpm(...) offset to GPIO is now used
instead of the GPIO number itself.

Signed-off-by: Rikard Olsson <rikard.p.olsson@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/plat-nomadik/gpio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
index 9f1b720..acc9de2 100644
--- a/arch/arm/plat-nomadik/gpio.c
+++ b/arch/arm/plat-nomadik/gpio.c
@@ -602,7 +602,7 @@ static int nmk_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
 
 #ifdef CONFIG_ARCH_U8500
 	if (cpu_is_u8500v2()) {
-		__nmk_gpio_set_slpm(nmk_chip, gpio,
+		__nmk_gpio_set_slpm(nmk_chip, gpio - nmk_chip->chip.base,
 				    on ? NMK_GPIO_SLPM_WAKEUP_ENABLE
 				       : NMK_GPIO_SLPM_WAKEUP_DISABLE);
 	}
-- 
1.7.3.2

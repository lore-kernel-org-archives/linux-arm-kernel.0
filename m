From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 23 Oct 2012 11:46:59 +0200
Subject: [PATCH] pinctrl/nomadik: pass DT node to the irqdomain
Message-ID: <1350985619-17408-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

When creating the simple irqdomain, pass the DT node pointer along,
as is apropriate.

Cc: Lee Jones <lee.jones@linaro.org>
Reported-by: Gabriel Fernandez <gabriel.fernandez@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinctrl-nomadik.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-nomadik.c b/drivers/pinctrl/pinctrl-nomadik.c
index 8bfbad6..cf82d9c 100644
--- a/drivers/pinctrl/pinctrl-nomadik.c
+++ b/drivers/pinctrl/pinctrl-nomadik.c
@@ -1387,7 +1387,7 @@ static int __devinit nmk_gpio_probe(struct platform_device *dev)
 
 	if (!np)
 		irq_start = NOMADIK_GPIO_TO_IRQ(pdata->first_gpio);
-	nmk_chip->domain = irq_domain_add_simple(NULL,
+	nmk_chip->domain = irq_domain_add_simple(np,
 				NMK_GPIO_PER_CHIP, irq_start,
 				&nmk_gpio_irq_simple_ops, nmk_chip);
 	if (!nmk_chip->domain) {
-- 
1.7.11.3

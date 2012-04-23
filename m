From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 23 Apr 2012 11:14:42 +0200
Subject: [PATCH 5/9] gpio/nomadik: use typesafe __io_address()
Message-ID: <1335172482-27648-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

We were using a custom io_p2v() (physical-to-virtual) translation
macro, but with the advent of the cross-platform __io_address()
let us try to get rid of this. Inspired by a similar patch by
Jonas Aberg.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-nomadik.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
index 7b45d88..edf9a95 100644
--- a/drivers/gpio/gpio-nomadik.c
+++ b/drivers/gpio/gpio-nomadik.c
@@ -1186,7 +1186,7 @@ static int __devinit nmk_gpio_probe(struct platform_device *dev)
 	 */
 	nmk_chip->bank = dev->id;
 	nmk_chip->clk = clk;
-	nmk_chip->addr = io_p2v(res->start);
+	nmk_chip->addr = __io_address(res->start);
 	nmk_chip->chip = nmk_gpio_template;
 	nmk_chip->parent_irq = irq;
 	nmk_chip->secondary_parent_irq = secondary_irq;
-- 
1.7.9.2

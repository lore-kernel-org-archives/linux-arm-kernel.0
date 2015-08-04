From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue,  4 Aug 2015 15:55:18 +0200
Subject: [PATCH v2 5/6] pinctrl: sh-pfc: Remove empty gpio_function_free()
In-Reply-To: <1438696519-13727-1-git-send-email-geert+renesas@glider.be>
References: <1438696519-13727-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1438696519-13727-6-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpio_chip.free() is optional, and can just be left unimplemented.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
Untested due to lack of hardware (used on sh only).

v2:
  - Add Acked-by.
---
 drivers/pinctrl/sh-pfc/gpio.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/gpio.c b/drivers/pinctrl/sh-pfc/gpio.c
index b380e3f17b121bbb..e46439030914ad13 100644
--- a/drivers/pinctrl/sh-pfc/gpio.c
+++ b/drivers/pinctrl/sh-pfc/gpio.c
@@ -286,17 +286,12 @@ static int gpio_function_request(struct gpio_chip *gc, unsigned offset)
 	return ret;
 }
 
-static void gpio_function_free(struct gpio_chip *gc, unsigned offset)
-{
-}
-
 static int gpio_function_setup(struct sh_pfc_chip *chip)
 {
 	struct sh_pfc *pfc = chip->pfc;
 	struct gpio_chip *gc = &chip->gpio_chip;
 
 	gc->request = gpio_function_request;
-	gc->free = gpio_function_free;
 
 	gc->label = pfc->info->name;
 	gc->owner = THIS_MODULE;
-- 
1.9.1

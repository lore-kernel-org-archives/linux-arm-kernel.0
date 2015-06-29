From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Mon, 29 Jun 2015 16:56:46 +0200
Subject: [PATCH] gpiolib: Fix docs for gpiochip_add_pingroup_range
Message-ID: <1435589806-31079-1-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpiochip_add_pingroup_range() has a pctldev argument, not pinctrl.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/gpio/gpiolib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index bf4bd1d..b1b08b3 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -671,7 +671,7 @@ static void gpiochip_irqchip_remove(struct gpio_chip *gpiochip) {}
 /**
  * gpiochip_add_pingroup_range() - add a range for GPIO <-> pin mapping
  * @chip: the gpiochip to add the range for
- * @pinctrl: the dev_name() of the pin controller to map to
+ * @pctldev: the pin controller to map to
  * @gpio_offset: the start offset in the current gpio_chip number space
  * @pin_group: name of the pin group inside the pin controller
  */
-- 
2.4.1

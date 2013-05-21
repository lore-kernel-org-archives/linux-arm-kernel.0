From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Tue, 21 May 2013 13:40:05 +0200
Subject: [RFC/PATCH v2 1/2] gpio-rcar: Make the platform data gpio_base field
 signed
In-Reply-To: <1369136406-23800-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1369136406-23800-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1369136406-23800-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gpio_base field is used to specify the desired GPIO base for the
GPIO controller. The GPIO core can automatically allocate a GPIO number
range when the base is set to -1. To make this possible, make the field
signed.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 include/linux/platform_data/gpio-rcar.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/platform_data/gpio-rcar.h b/include/linux/platform_data/gpio-rcar.h
index cc472f6..fb2c718 100644
--- a/include/linux/platform_data/gpio-rcar.h
+++ b/include/linux/platform_data/gpio-rcar.h
@@ -17,7 +17,7 @@
 #define __GPIO_RCAR_H__
 
 struct gpio_rcar_config {
-	unsigned int gpio_base;
+	int gpio_base;
 	unsigned int irq_base;
 	unsigned int number_of_pins;
 	const char *pctl_name;
-- 
1.8.1.5

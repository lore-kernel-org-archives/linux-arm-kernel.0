From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:24:53 +0900
Subject: [PATCH 002/130] gpio-rcar: Make the platform data gpio_base field
 signed
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

The gpio_base field is used to specify the desired GPIO base for the
GPIO controller. The GPIO core can automatically allocate a GPIO number
range when the base is set to -1. To make this possible, make the field
signed.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 include/linux/platform_data/gpio-rcar.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/platform_data/gpio-rcar.h b/include/linux/platform_data/gpio-rcar.h
index b253f77..aba7079 100644
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
1.8.2.1

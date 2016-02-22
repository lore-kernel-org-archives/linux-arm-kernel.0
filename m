From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:38:07 +0530
Subject: [PATCH 18/61] gpio: ep93xx: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-19-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/gpio/gpio-ep93xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-ep93xx.c b/drivers/gpio/gpio-ep93xx.c
index ad27907..d054219 100644
--- a/drivers/gpio/gpio-ep93xx.c
+++ b/drivers/gpio/gpio-ep93xx.c
@@ -339,7 +339,7 @@ static int ep93xx_gpio_add_bank(struct gpio_chip *gc, struct device *dev,
 		gc->to_irq = ep93xx_gpio_to_irq;
 	}
 
-	return gpiochip_add_data(gc, NULL);
+	return devm_gpiochip_add_data(dev, gc, NULL);
 }
 
 static int ep93xx_gpio_probe(struct platform_device *pdev)
-- 
2.1.4

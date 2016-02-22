From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:38:43 +0530
Subject: [PATCH 54/61] gpio: ucb1400: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-55-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/gpio/gpio-ucb1400.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-ucb1400.c b/drivers/gpio/gpio-ucb1400.c
index 2c5cd46..5dbe31b 100644
--- a/drivers/gpio/gpio-ucb1400.c
+++ b/drivers/gpio/gpio-ucb1400.c
@@ -67,7 +67,7 @@ static int ucb1400_gpio_probe(struct platform_device *dev)
 	ucb->gc.set = ucb1400_gpio_set;
 	ucb->gc.can_sleep = true;
 
-	err = gpiochip_add_data(&ucb->gc, ucb);
+	err = devm_gpiochip_add_data(&dev->dev, &ucb->gc, ucb);
 	if (err)
 		goto err;
 
@@ -90,7 +90,6 @@ static int ucb1400_gpio_remove(struct platform_device *dev)
 			return err;
 	}
 
-	gpiochip_remove(&ucb->gc);
 	return err;
 }
 
-- 
2.1.4

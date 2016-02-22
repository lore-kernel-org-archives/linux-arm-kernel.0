From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:38:36 +0530
Subject: [PATCH 47/61] gpio: timberdale Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-48-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/gpio/gpio-timberdale.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-timberdale.c b/drivers/gpio/gpio-timberdale.c
index a6de10c..f0164ec 100644
--- a/drivers/gpio/gpio-timberdale.c
+++ b/drivers/gpio/gpio-timberdale.c
@@ -279,7 +279,7 @@ static int timbgpio_probe(struct platform_device *pdev)
 	gc->ngpio = pdata->nr_pins;
 	gc->can_sleep = false;
 
-	err = gpiochip_add_data(gc, tgpio);
+	err = devm_gpiochip_add_data(&pdev->dev, gc, tgpio);
 	if (err)
 		return err;
 
@@ -320,8 +320,6 @@ static int timbgpio_remove(struct platform_device *pdev)
 		irq_set_handler_data(irq, NULL);
 	}
 
-	gpiochip_remove(&tgpio->gpio);
-
 	return 0;
 }
 
-- 
2.1.4

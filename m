From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:38:18 +0530
Subject: [PATCH 29/61] gpio: moxart: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-30-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/gpio/gpio-moxart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-moxart.c b/drivers/gpio/gpio-moxart.c
index ca60453..869002b 100644
--- a/drivers/gpio/gpio-moxart.c
+++ b/drivers/gpio/gpio-moxart.c
@@ -63,7 +63,7 @@ static int moxart_gpio_probe(struct platform_device *pdev)
 	gc->parent = dev;
 	gc->owner = THIS_MODULE;
 
-	ret = gpiochip_add_data(gc, NULL);
+	ret = devm_gpiochip_add_data(dev, gc, NULL);
 	if (ret) {
 		dev_err(dev, "%s: gpiochip_add failed\n",
 			dev->of_node->full_name);
-- 
2.1.4

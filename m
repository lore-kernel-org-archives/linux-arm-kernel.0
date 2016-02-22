From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:38:09 +0530
Subject: [PATCH 20/61] gpio: ge: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-21-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/gpio/gpio-ge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-ge.c b/drivers/gpio/gpio-ge.c
index cbbec83..8650b29 100644
--- a/drivers/gpio/gpio-ge.c
+++ b/drivers/gpio/gpio-ge.c
@@ -89,7 +89,7 @@ static int __init gef_gpio_probe(struct platform_device *pdev)
 	gc->of_node = pdev->dev.of_node;
 
 	/* This function adds a memory mapped GPIO chip */
-	ret = gpiochip_add_data(gc, NULL);
+	ret = devm_gpiochip_add_data(&pdev->dev, gc, NULL);
 	if (ret)
 		goto err0;
 
-- 
2.1.4

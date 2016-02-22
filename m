From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:38:49 +0530
Subject: [PATCH 60/61] gpio: xgene-sb: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-61-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/gpio/gpio-xgene-sb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-xgene-sb.c b/drivers/gpio/gpio-xgene-sb.c
index 282004d..e665770 100644
--- a/drivers/gpio/gpio-xgene-sb.c
+++ b/drivers/gpio/gpio-xgene-sb.c
@@ -116,7 +116,7 @@ static int xgene_gpio_sb_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
-	ret = gpiochip_add_data(&priv->gc, priv);
+	ret = devm_gpiochip_add_data(&pdev->dev, &priv->gc, priv);
 	if (ret)
 		dev_err(&pdev->dev, "failed to register X-Gene GPIO Standby driver\n");
 	else
@@ -138,7 +138,6 @@ static int xgene_gpio_sb_remove(struct platform_device *pdev)
 		acpi_gpiochip_free_interrupts(&priv->gc);
 	}
 
-	gpiochip_remove(&priv->gc);
 	return 0;
 }
 
-- 
2.1.4

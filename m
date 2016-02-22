From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:38:22 +0530
Subject: [PATCH 33/61] gpio: pca953x: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-34-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/gpio/gpio-pca953x.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 23196c5..b7fe5d5 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -754,7 +754,7 @@ static int pca953x_probe(struct i2c_client *client,
 	if (ret)
 		return ret;
 
-	ret = gpiochip_add_data(&chip->gpio_chip, chip);
+	ret = devm_gpiochip_add_data(&client->dev, &chip->gpio_chip, chip);
 	if (ret)
 		return ret;
 
@@ -789,8 +789,6 @@ static int pca953x_remove(struct i2c_client *client)
 		}
 	}
 
-	gpiochip_remove(&chip->gpio_chip);
-
 	return 0;
 }
 
-- 
2.1.4

From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:38:29 +0530
Subject: [PATCH 40/61] gpio: sta2x11: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-41-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/gpio/gpio-sta2x11.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-sta2x11.c b/drivers/gpio/gpio-sta2x11.c
index 83af1cb..0d5b8c5 100644
--- a/drivers/gpio/gpio-sta2x11.c
+++ b/drivers/gpio/gpio-sta2x11.c
@@ -409,7 +409,7 @@ static int gsta_probe(struct platform_device *dev)
 		goto err_free_descs;
 	}
 
-	err = gpiochip_add_data(&chip->gpio, chip);
+	err = devm_gpiochip_add_data(&dev->dev, &chip->gpio, chip);
 	if (err < 0) {
 		dev_err(&dev->dev, "sta2x11 gpio: Can't register (%i)\n",
 			-err);
-- 
2.1.4

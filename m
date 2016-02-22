From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:38:30 +0530
Subject: [PATCH 41/61] gpio: stp-xway: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-42-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/gpio/gpio-stp-xway.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-stp-xway.c b/drivers/gpio/gpio-stp-xway.c
index d11dd48..19e654f 100644
--- a/drivers/gpio/gpio-stp-xway.c
+++ b/drivers/gpio/gpio-stp-xway.c
@@ -258,7 +258,7 @@ static int xway_stp_probe(struct platform_device *pdev)
 
 	ret = xway_stp_hw_init(chip);
 	if (!ret)
-		ret = gpiochip_add_data(&chip->gc, chip);
+		ret = devm_gpiochip_add_data(&pdev->dev, &chip->gc, chip);
 
 	if (!ret)
 		dev_info(&pdev->dev, "Init done\n");
-- 
2.1.4

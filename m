From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:38:28 +0530
Subject: [PATCH 39/61] gpio: spear-spics: Use devm_gpiochip_add_data() for
 gpio registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-40-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/gpio/gpio-spear-spics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-spear-spics.c b/drivers/gpio/gpio-spear-spics.c
index 50fb090..7ffd164 100644
--- a/drivers/gpio/gpio-spear-spics.c
+++ b/drivers/gpio/gpio-spear-spics.c
@@ -165,7 +165,7 @@ static int spics_gpio_probe(struct platform_device *pdev)
 	spics->chip.owner = THIS_MODULE;
 	spics->last_off = -1;
 
-	ret = gpiochip_add_data(&spics->chip, spics);
+	ret = devm_gpiochip_add_data(&pdev->dev, &spics->chip, spics);
 	if (ret) {
 		dev_err(&pdev->dev, "unable to add gpio chip\n");
 		return ret;
-- 
2.1.4

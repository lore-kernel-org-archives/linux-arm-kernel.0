From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:38:35 +0530
Subject: [PATCH 46/61] gpio: tegra: Use devm_gpiochip_add_data() for gpio
 registration
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456150130-2668-47-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_gpiochip_add_data() for GPIO registration.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/gpio/gpio-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 9a1a7e2..790bb11 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -545,7 +545,7 @@ static int tegra_gpio_probe(struct platform_device *pdev)
 
 	tegra_gpio_chip.of_node = pdev->dev.of_node;
 
-	ret = gpiochip_add_data(&tegra_gpio_chip, NULL);
+	ret = devm_gpiochip_add_data(&pdev->dev, &tegra_gpio_chip, NULL);
 	if (ret < 0) {
 		irq_domain_remove(irq_domain);
 		return ret;
-- 
2.1.4

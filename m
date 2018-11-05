From: Claudiu.Beznea@microchip.com (Claudiu.Beznea at microchip.com)
Date: Mon, 5 Nov 2018 11:14:31 +0000
Subject: [PATCH 4/4] power: reset: at91-poweroff: remove at91_ramc_of_match
In-Reply-To: <1541416443-4321-1-git-send-email-claudiu.beznea@microchip.com>
References: <1541416443-4321-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <1541416443-4321-5-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove at91_ramc_of_match[] since it is not used anywhere in this code.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-poweroff.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at91-poweroff.c
index e75d8f0f0526..43b4cccb7d0c 100644
--- a/drivers/power/reset/at91-poweroff.c
+++ b/drivers/power/reset/at91-poweroff.c
@@ -232,11 +232,6 @@ static int __exit at91_poweroff_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id at91_ramc_of_match[] = {
-	{ .compatible = "atmel,sama5d3-ddramc", },
-	{ /* sentinel */ }
-};
-
 static const struct of_device_id at91_poweroff_of_match[] = {
 	{ .compatible = "atmel,at91sam9260-shdwc", },
 	{ .compatible = "atmel,at91sam9rl-shdwc", },
-- 
2.7.4

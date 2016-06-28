From: j-keerthy@ti.com (Keerthy)
Date: Tue, 28 Jun 2016 11:36:16 +0530
Subject: [PATCH v3 06/10] gpio: tps65218: Remove the compatible
In-Reply-To: <1467093980-11458-1-git-send-email-j-keerthy@ti.com>
References: <1467093980-11458-1-git-send-email-j-keerthy@ti.com>
Message-ID: <1467093980-11458-7-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the individual compatible for the gpio module.
Introduce id_table and update the driver accordingly
to parse device tree nodes by just using the mfd compatible.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/gpio/gpio-tps65218.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-tps65218.c b/drivers/gpio/gpio-tps65218.c
index 0f9d9bd..06fd61f 100644
--- a/drivers/gpio/gpio-tps65218.c
+++ b/drivers/gpio/gpio-tps65218.c
@@ -225,19 +225,19 @@ static int tps65218_gpio_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id tps65218_dt_match[] = {
-	{ .compatible = "ti,tps65218-gpio" },
-	{  }
+static const struct platform_device_id tps65218_gpio_id_table[] = {
+	{ "tps65218-gpio", },
+	{ /* sentinel */ }
 };
-MODULE_DEVICE_TABLE(of, tps65218_dt_match);
+MODULE_DEVICE_TABLE(platform, tps65218_gpio_id_table);
 
 static struct platform_driver tps65218_gpio_driver = {
 	.driver = {
 		.name = "tps65218-gpio",
-		.of_match_table = of_match_ptr(tps65218_dt_match)
 	},
 	.probe = tps65218_gpio_probe,
 	.remove = tps65218_gpio_remove,
+	.id_table = tps65218_gpio_id_table,
 };
 
 module_platform_driver(tps65218_gpio_driver);
-- 
1.9.1

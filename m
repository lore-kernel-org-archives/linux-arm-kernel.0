From: j-keerthy@ti.com (Keerthy)
Date: Tue, 28 Jun 2016 14:52:07 +0530
Subject: [PATCH v4 4/6] gpio: tps65218-gpio: Add platform_device_id table
In-Reply-To: <1467105729-28249-1-git-send-email-j-keerthy@ti.com>
References: <1467105729-28249-1-git-send-email-j-keerthy@ti.com>
Message-ID: <1467105729-28249-5-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_device_id table is needed for adding the tps65218-gpio
module to the mfd_cell array.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Changes in v4:

  * Retained the compatible strings in order to interrogate the DT in the
    normal way.

 drivers/gpio/gpio-tps65218.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpio/gpio-tps65218.c b/drivers/gpio/gpio-tps65218.c
index 0f9d9bd..0961f3a 100644
--- a/drivers/gpio/gpio-tps65218.c
+++ b/drivers/gpio/gpio-tps65218.c
@@ -231,6 +231,12 @@ static const struct of_device_id tps65218_dt_match[] = {
 };
 MODULE_DEVICE_TABLE(of, tps65218_dt_match);
 
+static const struct platform_device_id tps65218_gpio_id_table[] = {
+	{ "tps65218-gpio", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, tps65218_gpio_id_table);
+
 static struct platform_driver tps65218_gpio_driver = {
 	.driver = {
 		.name = "tps65218-gpio",
@@ -238,6 +244,7 @@ static struct platform_driver tps65218_gpio_driver = {
 	},
 	.probe = tps65218_gpio_probe,
 	.remove = tps65218_gpio_remove,
+	.id_table = tps65218_gpio_id_table,
 };
 
 module_platform_driver(tps65218_gpio_driver);
-- 
1.9.1

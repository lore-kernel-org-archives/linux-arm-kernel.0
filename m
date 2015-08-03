From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Mon, 3 Aug 2015 14:59:58 +0800
Subject: [PATCH 2/2] drivers: PL061: add ACPI probing for PL061
In-Reply-To: <1438585198-8764-1-git-send-email-zhaoshenglong@huawei.com>
References: <1438585198-8764-1-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <1438585198-8764-3-git-send-email-zhaoshenglong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

Add the necessary driver boilerplate to let the driver be used when
the respective ACPI table is discovered by the ACPI subsystem.

Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>
Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 drivers/gpio/gpio-pl061.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
index 64c10eb..41fcf7b 100644
--- a/drivers/gpio/gpio-pl061.c
+++ b/drivers/gpio/gpio-pl061.c
@@ -25,6 +25,7 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/pm.h>
 #include <linux/platform_device.h>
+#include <linux/acpi.h>
 
 #define GPIODIR 0x400
 #define GPIOIS  0x404
@@ -471,10 +472,17 @@ static const struct of_device_id pl061_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, pl061_of_match);
 
+static const struct acpi_device_id pl061_acpi_match[] = {
+	{ "ARMH0061",},
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, pl061_acpi_match);
+
 static struct platform_driver pl061_gpio_platform_driver = {
 	.driver = {
 		.name	= "pl061_gpio",
 		.of_match_table	= pl061_of_match,
+		.acpi_match_table = ACPI_PTR(pl061_acpi_match),
 #ifdef CONFIG_PM
 		.pm	= &pl061_dev_pm_ops,
 #endif
-- 
2.0.4

From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 20 Nov 2014 12:57:28 +0000
Subject: [PATCH] mfd: axp20x: Constify axp20x_acpi_match and rid unused warning
Message-ID: <1416488248-24246-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

axp20x.c:239:30:
  warning: ?axp20x_acpi_match? defined but not used [-Wunused-variable]

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/axp20x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 971b0eb..c522ee2 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -236,7 +236,7 @@ static const struct i2c_device_id axp20x_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, axp20x_i2c_id);
 
-static struct acpi_device_id axp20x_acpi_match[] = {
+static const struct acpi_device_id axp20x_acpi_match[] = {
 	{
 		.id = "INT33F4",
 		.driver_data = AXP288_ID,
-- 
1.9.1

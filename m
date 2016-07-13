From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 13 Jul 2016 12:26:50 +0100
Subject: [PATCH 2/3] mfd: ab8500: Example using new OF_MFD_CELL MACRO
In-Reply-To: <20160713112651.14539-1-lee.jones@linaro.org>
References: <20160713112651.14539-1-lee.jones@linaro.org>
Message-ID: <20160713112651.14539-3-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

... with and without platform ID.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/ab8500-core.c | 138 ++++++++++++++--------------------------------
 1 file changed, 42 insertions(+), 96 deletions(-)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index f3d6891..ed92e5a 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -606,107 +606,53 @@ int ab8500_suspend(struct ab8500 *ab8500)
 }
 
 static const struct mfd_cell ab8500_bm_devs[] = {
-	{
-		.name = "ab8500-charger",
-		.of_compatible = "stericsson,ab8500-charger",
-		.platform_data = &ab8500_bm_data,
-		.pdata_size = sizeof(ab8500_bm_data),
-	},
-	{
-		.name = "ab8500-btemp",
-		.of_compatible = "stericsson,ab8500-btemp",
-		.platform_data = &ab8500_bm_data,
-		.pdata_size = sizeof(ab8500_bm_data),
-	},
-	{
-		.name = "ab8500-fg",
-		.of_compatible = "stericsson,ab8500-fg",
-		.platform_data = &ab8500_bm_data,
-		.pdata_size = sizeof(ab8500_bm_data),
-	},
-	{
-		.name = "ab8500-chargalg",
-		.of_compatible = "stericsson,ab8500-chargalg",
-		.platform_data = &ab8500_bm_data,
-		.pdata_size = sizeof(ab8500_bm_data),
-	},
+	OF_MFD_CELL("ab8500-charger", NULL, &ab8500_bm_data,
+		    sizeof(ab8500_bm_data), 0, "stericsson,ab8500-charger"),
+	OF_MFD_CELL("ab8500-btemp", NULL, &ab8500_bm_data,
+		    sizeof(ab8500_bm_data), 0, "stericsson,ab8500-btemp"),
+	OF_MFD_CELL("ab8500-fg", NULL, &ab8500_bm_data,
+		    sizeof(ab8500_bm_data), 0, "stericsson,ab8500-fg"),
+	OF_MFD_CELL("ab8500-chargalg", NULL, &ab8500_bm_data,
+		    sizeof(ab8500_bm_data), 0, "stericsson,ab8500-chargalg"),
 };
 
 static const struct mfd_cell ab8500_devs[] = {
 #ifdef CONFIG_DEBUG_FS
-	{
-		.name = "ab8500-debug",
-		.of_compatible = "stericsson,ab8500-debug",
-	},
+	OF_MFD_CELL("ab8500-debug",
+		    NULL, NULL, 0, 0, "stericsson,ab8500-debug"),
 #endif
-	{
-		.name = "ab8500-sysctrl",
-		.of_compatible = "stericsson,ab8500-sysctrl",
-	},
-	{
-		.name = "ab8500-ext-regulator",
-		.of_compatible = "stericsson,ab8500-ext-regulator",
-	},
-	{
-		.name = "ab8500-regulator",
-		.of_compatible = "stericsson,ab8500-regulator",
-	},
-	{
-		.name = "abx500-clk",
-		.of_compatible = "stericsson,abx500-clk",
-	},
-	{
-		.name = "ab8500-gpadc",
-		.of_compatible = "stericsson,ab8500-gpadc",
-	},
-	{
-		.name = "ab8500-rtc",
-		.of_compatible = "stericsson,ab8500-rtc",
-	},
-	{
-		.name = "ab8500-acc-det",
-		.of_compatible = "stericsson,ab8500-acc-det",
-	},
-	{
-
-		.name = "ab8500-poweron-key",
-		.of_compatible = "stericsson,ab8500-poweron-key",
-	},
-	{
-		.name = "ab8500-pwm",
-		.of_compatible = "stericsson,ab8500-pwm",
-		.id = 1,
-	},
-	{
-		.name = "ab8500-pwm",
-		.of_compatible = "stericsson,ab8500-pwm",
-		.id = 2,
-	},
-	{
-		.name = "ab8500-pwm",
-		.of_compatible = "stericsson,ab8500-pwm",
-		.id = 3,
-	},
-	{
-		.name = "ab8500-denc",
-		.of_compatible = "stericsson,ab8500-denc",
-	},
-	{
-		.name = "pinctrl-ab8500",
-		.of_compatible = "stericsson,ab8500-gpio",
-	},
-	{
-		.name = "abx500-temp",
-		.of_compatible = "stericsson,abx500-temp",
-	},
-	{
-		.name = "ab8500-usb",
-		.of_compatible = "stericsson,ab8500-usb",
-	},
-	{
-		.name = "ab8500-codec",
-		.of_compatible = "stericsson,ab8500-codec",
-	},
+	OF_MFD_CELL("ab8500-sysctrl",
+		    NULL, NULL, 0, 0, "stericsson,ab8500-sysctrl"),
+	OF_MFD_CELL("ab8500-ext-regulator",
+		    NULL, NULL, 0, 0, "stericsson,ab8500-ext-regulator"),
+	OF_MFD_CELL("ab8500-regulator",
+		    NULL, NULL, 0, 0, "stericsson,ab8500-regulator"),
+	OF_MFD_CELL("abx500-clk",
+		    NULL, NULL, 0, 0, "stericsson,abx500-clk"),
+	OF_MFD_CELL("ab8500-gpadc",
+		    NULL, NULL, 0, 0, "stericsson,ab8500-gpadc"),
+	OF_MFD_CELL("ab8500-rtc",
+		    NULL, NULL, 0, 0, "stericsson,ab8500-rtc"),
+	OF_MFD_CELL("ab8500-acc-det",
+		    NULL, NULL, 0, 0, "stericsson,ab8500-acc-det"),
+	OF_MFD_CELL("ab8500-poweron-key",
+		    NULL, NULL, 0, 0, "stericsson,ab8500-poweron-key"),
+	OF_MFD_CELL("ab8500-pwm",
+		    NULL, NULL, 0, 1, "stericsson,ab8500-pwm"),
+	OF_MFD_CELL("ab8500-pwm",
+		    NULL, NULL, 0, 2, "stericsson,ab8500-pwm"),
+	OF_MFD_CELL("ab8500-pwm",
+		    NULL, NULL, 0, 3, "stericsson,ab8500-pwm"),
+	OF_MFD_CELL("ab8500-denc",
+		    NULL, NULL, 0, 0, "stericsson,ab8500-denc"),
+	OF_MFD_CELL("pinctrl-ab8500",
+		    NULL, NULL, 0, 0, "stericsson,ab8500-gpio"),
+	OF_MFD_CELL("abx500-temp",
+		    NULL, NULL, 0, 0, "stericsson,abx500-temp"),
+	OF_MFD_CELL("ab8500-usb",
+		    NULL, NULL, 0, 0, "stericsson,ab8500-usb"),
+	OF_MFD_CELL("ab8500-codec",
+		    NULL, NULL, 0, 0, "stericsson,ab8500-codec"),
 };
 
 static const struct mfd_cell ab9540_devs[] = {
-- 
2.9.0

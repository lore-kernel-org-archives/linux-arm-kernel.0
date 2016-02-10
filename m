From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 10 Feb 2016 15:39:38 +0000
Subject: [PATCH v2] mfd: ab8500: Provide a small example using new MFD cell
 MACROs
In-Reply-To: <1455028027-1527-1-git-send-email-lee.jones@linaro.org>
References: <1455028027-1527-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20160210153938.GC26950@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mfd: ab8500: Provide a small example using new MFD cell MACROs
    
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/ab8500-core.c | 106 +++++++++++++++-------------------------------
 1 file changed, 34 insertions(+), 72 deletions(-)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index f3d6891..c03a86e 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -634,79 +634,41 @@ static const struct mfd_cell ab8500_bm_devs[] = {
 
 static const struct mfd_cell ab8500_devs[] = {
 #ifdef CONFIG_DEBUG_FS
-	{
-		.name = "ab8500-debug",
-		.of_compatible = "stericsson,ab8500-debug",
-	},
+	OF_MFD_CELL("ab8500-debug",
+		    NULL, NULL, 0, "stericsson,ab8500-debug"),
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
+		    NULL, NULL, 0, "stericsson,ab8500-sysctrl"),
+	OF_MFD_CELL("ab8500-ext-regulator",
+		    NULL, NULL, 0, "stericsson,ab8500-ext-regulator"),
+	OF_MFD_CELL("ab8500-regulator",
+		    NULL, NULL, 0, "stericsson,ab8500-regulator"),
+	OF_MFD_CELL("abx500-clk",
+		    NULL, NULL, 0, "stericsson,abx500-clk"),
+	OF_MFD_CELL("ab8500-gpadc",
+		    NULL, NULL, 0, "stericsson,ab8500-gpadc"),
+	OF_MFD_CELL("ab8500-rtc",
+		    NULL, NULL, 0, "stericsson,ab8500-rtc"),
+	OF_MFD_CELL("ab8500-acc-det",
+		    NULL, NULL, 0, "stericsson,ab8500-acc-det"),
+	OF_MFD_CELL("ab8500-poweron-key",
+		    NULL, NULL, 0, "stericsson,ab8500-poweron-key"),
+	OF_MFD_CELL("ab8500-pwm",
+		    NULL, NULL, 1, "stericsson,ab8500-pwm"),
+	OF_MFD_CELL("ab8500-pwm",
+		    NULL, NULL, 2, "stericsson,ab8500-pwm"),
+	OF_MFD_CELL("ab8500-pwm",
+		    NULL, NULL, 3, "stericsson,ab8500-pwm"),
+	OF_MFD_CELL("ab8500-denc",
+		    NULL, NULL, 0, "stericsson,ab8500-denc"),
+	OF_MFD_CELL("pinctrl-ab8500",
+		    NULL, NULL, 0, "stericsson,ab8500-gpio"),
+	OF_MFD_CELL("abx500-temp",
+		    NULL, NULL, 0, "stericsson,abx500-temp"),
+	OF_MFD_CELL("ab8500-usb",
+		    NULL, NULL, 0, "stericsson,ab8500-usb"),
+	OF_MFD_CELL("ab8500-codec",
+		    NULL, NULL, 0, "stericsson,ab8500-codec"),
 };
 
 static const struct mfd_cell ab9540_devs[] = {

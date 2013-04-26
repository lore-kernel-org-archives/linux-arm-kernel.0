From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Fri, 26 Apr 2013 14:17:16 +0200
Subject: [PATCH 3/5] mfd: ab8500: drop references to ab8500-leds
In-Reply-To: <1366978638-967-1-git-send-email-fabio.baltieri@linaro.org>
References: <1366978638-967-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <1366978638-967-4-git-send-email-fabio.baltieri@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ab8500-leds driver has never been upstreamed and was replaced by a
PWM framework based driver, so these references are not needed anymore.

Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
---
 drivers/mfd/ab8500-core.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index 8e8a016..dd41ae2 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -1089,10 +1089,6 @@ static struct mfd_cell ab8500_devs[] = {
 		.id = 3,
 	},
 	{
-		.name = "ab8500-leds",
-		.of_compatible = "stericsson,ab8500-leds",
-	},
-	{
 		.name = "ab8500-denc",
 		.of_compatible = "stericsson,ab8500-denc",
 	},
@@ -1161,9 +1157,6 @@ static struct mfd_cell ab9540_devs[] = {
 		.id = 1,
 	},
 	{
-		.name = "ab8500-leds",
-	},
-	{
 		.name = "abx500-temp",
 		.num_resources = ARRAY_SIZE(ab8500_temp_resources),
 		.resources = ab8500_temp_resources,
@@ -1231,9 +1224,6 @@ static struct mfd_cell ab8505_devs[] = {
 		.id = 1,
 	},
 	{
-		.name = "ab8500-leds",
-	},
-	{
 		.name = "ab8500-gpio",
 	},
 	{
@@ -1294,9 +1284,6 @@ static struct mfd_cell ab8540_devs[] = {
 		.id = 1,
 	},
 	{
-		.name = "ab8500-leds",
-	},
-	{
 		.name = "abx500-temp",
 		.num_resources = ARRAY_SIZE(ab8500_temp_resources),
 		.resources = ab8500_temp_resources,
-- 
1.8.1.3

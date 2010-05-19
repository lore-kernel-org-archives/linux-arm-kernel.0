From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed, 19 May 2010 13:06:59 +0800
Subject: [PATCH] mfd: fix led resource in 88pm860x
Message-ID: <mailman.461.1274252333.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix typo error in LED resource of 88pm860x.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/mfd/88pm860x-core.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index 2c65a2c..1580f1f 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -74,12 +74,12 @@ static struct mfd_cell backlight_devs[] = {
 }

 static struct resource led_resources[] = {
-	PM8606_LED_RESOURCE(PM8606_LED1_RED, RGB2B),
-	PM8606_LED_RESOURCE(PM8606_LED1_GREEN, RGB2C),
-	PM8606_LED_RESOURCE(PM8606_LED1_BLUE, RGB2D),
-	PM8606_LED_RESOURCE(PM8606_LED2_RED, RGB1B),
-	PM8606_LED_RESOURCE(PM8606_LED2_GREEN, RGB1C),
-	PM8606_LED_RESOURCE(PM8606_LED2_BLUE, RGB1D),
+	PM8606_LED_RESOURCE(PM8606_LED1_RED, RGB1B),
+	PM8606_LED_RESOURCE(PM8606_LED1_GREEN, RGB1C),
+	PM8606_LED_RESOURCE(PM8606_LED1_BLUE, RGB1D),
+	PM8606_LED_RESOURCE(PM8606_LED2_RED, RGB2B),
+	PM8606_LED_RESOURCE(PM8606_LED2_GREEN, RGB2C),
+	PM8606_LED_RESOURCE(PM8606_LED2_BLUE, RGB2D),
 };

 #define PM8606_LED_DEVS(_i)				\
-- 
1.5.6.5

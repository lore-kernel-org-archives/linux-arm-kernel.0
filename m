From: thommycheck@gmx.de (Thomas Kunze)
Date: Mon,  5 Oct 2009 23:35:28 +0200
Subject: [PATCH 4/9] collie: locomo-led change default trigger
In-Reply-To: <1254778533-3529-4-git-send-email-thommycheck@gmx.de>
References: <1254778533-3529-1-git-send-email-thommycheck@gmx.de>
	<1254778533-3529-2-git-send-email-thommycheck@gmx.de>
	<1254778533-3529-3-git-send-email-thommycheck@gmx.de>
	<1254778533-3529-4-git-send-email-thommycheck@gmx.de>
Message-ID: <1254778533-3529-5-git-send-email-thommycheck@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Collie uses now the powersupply framework. Change the
default led-trigger of locomo-led to reflect that.

Signed-off-by: Thomas Kunze <thommycheck@gmx.de>
---
 drivers/leds/leds-locomo.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/leds/leds-locomo.c b/drivers/leds/leds-locomo.c
index 5d91362..1f7c10f 100644
--- a/drivers/leds/leds-locomo.c
+++ b/drivers/leds/leds-locomo.c
@@ -44,7 +44,7 @@ static void locomoled_brightness_set1(struct led_classdev *led_cdev,
 
 static struct led_classdev locomo_led0 = {
 	.name			= "locomo:amber:charge",
-	.default_trigger	= "sharpsl-charge",
+	.default_trigger	= "main-battery-charging",
 	.brightness_set		= locomoled_brightness_set0,
 };
 
-- 
1.6.0.4

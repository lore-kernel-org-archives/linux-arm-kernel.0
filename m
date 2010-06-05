From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat,  5 Jun 2010 11:50:41 +0200
Subject: [PATCH 2/2] backlight: Fix blanking for L4F00242T03 LCD
In-Reply-To: <1275731441-7612-1-git-send-email-marek.vasut@gmail.com>
References: <1275731441-7612-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1275731441-7612-2-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LCD was turned on if the variable power was > 0, but that was incorrect. The
LCD has to be turned on in NORMAL and UNBLANK case.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 drivers/video/backlight/l4f00242t03.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/backlight/l4f00242t03.c b/drivers/video/backlight/l4f00242t03.c
index 9093ef0..c67801e 100644
--- a/drivers/video/backlight/l4f00242t03.c
+++ b/drivers/video/backlight/l4f00242t03.c
@@ -78,7 +78,7 @@ static int l4f00242t03_lcd_power_set(struct lcd_device *ld, int power)
 	const u16 slpin = 0x10;
 	const u16 disoff = 0x28;
 
-	if (power) {
+	if (power <= FB_BLANK_NORMAL) {
 		if (priv->lcd_on)
 			return 0;
 
-- 
1.7.1

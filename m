From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat,  2 Apr 2011 03:43:16 +0200
Subject: [PATCH 2/3] Use gpio_set_value_cansleep() in corgi_lcd.c
In-Reply-To: <1301708597-7413-1-git-send-email-marek.vasut@gmail.com>
References: <1301708597-7413-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1301708597-7413-2-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 drivers/video/backlight/corgi_lcd.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/corgi_lcd.c b/drivers/video/backlight/corgi_lcd.c
index 1e71c35..8c80cb7 100644
--- a/drivers/video/backlight/corgi_lcd.c
+++ b/drivers/video/backlight/corgi_lcd.c
@@ -409,10 +409,10 @@ static int corgi_bl_set_intensity(struct corgi_lcd *lcd, int intensity)
 	cont = !!(intensity & 0x20) ^ lcd->gpio_backlight_cont_inverted;
 
 	if (gpio_is_valid(lcd->gpio_backlight_cont))
-		gpio_set_value(lcd->gpio_backlight_cont, cont);
+		gpio_set_value_cansleep(lcd->gpio_backlight_cont, cont);
 
 	if (gpio_is_valid(lcd->gpio_backlight_on))
-		gpio_set_value(lcd->gpio_backlight_on, intensity);
+		gpio_set_value_cansleep(lcd->gpio_backlight_on, intensity);
 
 	if (lcd->kick_battery)
 		lcd->kick_battery();
-- 
1.7.4.1

From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Fri, 16 Mar 2012 14:40:13 +0100
Subject: [PATCH] pxa/hx4700: fix the LCD initialization
Message-ID: <1331905213.29979.1.camel@flow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Common sense and the SDG bootldr code reference dictate that
N2.7V/7.3V be disabled here, and not LVDD, which already was
disabled 10 ms earlier.
This should only have an effect if the LCD was enabled in the
bootloader.

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Paul Parsons <lost.distance@yahoo.com>
---
 arch/arm/mach-pxa/hx4700.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index 61bb967..31c6dd1 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -399,7 +399,7 @@ static void sony_lcd_init(void)
 	gpio_set_value(GPIO62_HX4700_LCD_nRESET, 0);
 	mdelay(10);
 	gpio_set_value(GPIO59_HX4700_LCD_PC1, 0);
-	gpio_set_value(GPIO110_HX4700_LCD_LVDD_3V3_ON, 0);
+	gpio_set_value(GPIO112_HX4700_LCD_N2V7_7V3_ON, 0);
 	mdelay(20);
 
 	gpio_set_value(GPIO110_HX4700_LCD_LVDD_3V3_ON, 1);
-- 
1.7.9.1

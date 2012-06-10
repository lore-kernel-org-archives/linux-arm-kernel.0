From: todorcolov@gmail.com (Todor Colov)
Date: Sun, 10 Jun 2012 15:44:08 +0300 (EEST)
Subject: [PATCH] arm: ep93xx: Enable i2c support for ep9302
Message-ID: <alpine.LFD.2.00.1206101542100.21012@FC9.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Enable i2c support for ep9302. i2c support is needed when external RTC is 
used. 

Signed-off-by: Todor Colov <todorcolov@gmail.com>
---
--- linux-3.4/arch/arm/mach-ep93xx/edb93xx.c	2012-05-21 01:29:13.000000000 +0300
+++ linux-3.4/arch/arm/mach-ep93xx/edb93xx-i2c-ep9302-enabled.c	2012-06-10 14:18:06.977893546 +0300
@@ -91,8 +91,8 @@
 		ep93xx_register_i2c(&edb93xx_i2c_gpio_data,
 				    edb93xxa_i2c_board_info,
 				    ARRAY_SIZE(edb93xxa_i2c_board_info));
-	} else if (machine_is_edb9307() || machine_is_edb9312() ||
-		   machine_is_edb9315()) {
+	} else if (machine_is_edb9302() || machine_is_edb9307()
+		|| machine_is_edb9312() || machine_is_edb9315()) {
 		ep93xx_register_i2c(&edb93xx_i2c_gpio_data,
 				    edb93xx_i2c_board_info,
 				    ARRAY_SIZE(edb93xx_i2c_board_info));

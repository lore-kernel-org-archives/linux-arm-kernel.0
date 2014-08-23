From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 23 Aug 2014 19:31:55 +0200
Subject: [PATCH] ARM: nomadik: set proper compatible for accelerometer
Message-ID: <1408815115-5861-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adjust device tree entry to the proper registered compatible
string for LIS3LV02DL.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
index dbcf521b017f..258876b67050 100644
--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -744,8 +744,9 @@
 			   reg = <0x1a>;
 		};
 		lis3lv02dl at 1d {
-			   compatible = "st,lis3lv02dl";
-			   reg = <0x1d>;
+			/* Accelerometer */
+			compatible = "st,lis3lv02dl-accel";
+			reg = <0x1d>;
 		};
 	};
 
-- 
1.9.3

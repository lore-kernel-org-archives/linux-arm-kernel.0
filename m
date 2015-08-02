From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun,  2 Aug 2015 23:56:46 +0200
Subject: [PATCH 4/4] ARM: nomadik: push accelerometer down to boards
Message-ID: <1438552606-4625-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The two Nomadik variants have the accelerometer mounted on
different I2C lines. Push the definition down to the top-level
board DTS files to get things right.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-nomadik-nhk15.dts    | 5 +++++
 arch/arm/boot/dts/ste-nomadik-s8815.dts    | 8 ++++++++
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi | 5 -----
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/ste-nomadik-nhk15.dts b/arch/arm/boot/dts/ste-nomadik-nhk15.dts
index 9d888b0e75af..4a21c6492dbb 100644
--- a/arch/arm/boot/dts/ste-nomadik-nhk15.dts
+++ b/arch/arm/boot/dts/ste-nomadik-nhk15.dts
@@ -83,6 +83,11 @@
 	};
 
 	i2c0 {
+		lis3lv02dl at 1d {
+			/* Accelerometer */
+			compatible = "st,lis3lv02dl-accel";
+			reg = <0x1d>;
+		};
 		stmpe0: stmpe2401 at 43 {
 			compatible = "st,stmpe2401";
 			reg = <0x43>;
diff --git a/arch/arm/boot/dts/ste-nomadik-s8815.dts b/arch/arm/boot/dts/ste-nomadik-s8815.dts
index 11b5e34150b8..35282c0105c6 100644
--- a/arch/arm/boot/dts/ste-nomadik-s8815.dts
+++ b/arch/arm/boot/dts/ste-nomadik-s8815.dts
@@ -105,6 +105,14 @@
 		};
 	};
 
+	i2c1 {
+		lis3lv02dl at 1d {
+			/* Accelerometer */
+			compatible = "st,lis3lv02dl-accel";
+			reg = <0x1d>;
+		};
+	};
+
 	/* GPIO I2C connected to the USB portions of the STw4811 only */
 	gpio-i2c {
 		compatible = "i2c-gpio";
diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
index defabe053114..314f59c12162 100644
--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -726,11 +726,6 @@
 			   compatible = "st,stw5095";
 			   reg = <0x1a>;
 		};
-		lis3lv02dl at 1d {
-			/* Accelerometer */
-			compatible = "st,lis3lv02dl-accel";
-			reg = <0x1d>;
-		};
 	};
 
 	amba {
-- 
2.4.3

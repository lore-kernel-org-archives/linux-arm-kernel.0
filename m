From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Sun,  7 Jul 2013 18:31:58 -0300
Subject: [PATCH 3/4] ARM: sun5i: dt: Enable I2C controllers on
 A10S-OLinuXino-Micro
In-Reply-To: <1373232719-13050-1-git-send-email-emilio@elopez.com.ar>
References: <1373232719-13050-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1373232719-13050-4-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This board from OLIMEX is using the three I2C controllers present on A10S:
  * I2C-0 connects to the AXP152 PMU
  * I2C-1 holds an AT24C16BN-SH EEPROM with the MAC address for ethernet
  * I2C-2 is used for UEXT modules.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
index 64dc0c4..2a69ddf 100644
--- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
@@ -60,6 +60,24 @@
 			pinctrl-0 = <&uart3_pins_a>;
 			status = "okay";
 		};
+
+		i2c0: i2c at 01c2ac00 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_pins_a>;
+			status = "okay";
+		};
+
+		i2c1: i2c at 01c2b000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c1_pins_a>;
+			status = "okay";
+		};
+
+		i2c2: i2c at 01c2b400 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c2_pins_a>;
+			status = "okay";
+		};
 	};
 
 	leds {
-- 
1.8.3.2

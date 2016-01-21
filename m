From: rogershimizu@gmail.com (Roger Shimizu)
Date: Thu, 21 Jan 2016 23:38:47 +0900
Subject: [PATCH v3 4/7] ARM: dts: kirkwood: gpio-leds fixes for linkstation
 ls-wvl/vl
In-Reply-To: <1453387130-6914-1-git-send-email-rogershimizu@gmail.com>
References: <1453387130-6914-1-git-send-email-rogershimizu@gmail.com>
Message-ID: <1453387130-6914-5-git-send-email-rogershimizu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPIOs controlling the LEDs, listed below, are active high, not low:
  - gpio-leds: "lswvl:red:alarm" pin
  - gpio-leds: "lswvl:red:func" pin
  - gpio-leds: "lswvl:amber:info" pin
  - gpio-leds: "lswvl:blue:func" pin
  - gpio-leds: "lswvl:red:hdderr{0,1}" pin

Fixes: c43379e150aa ("ARM: dts: add buffalo linkstation ls-wvl/vl")
Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-lswvl.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-lswvl.dts b/arch/arm/boot/dts/kirkwood-lswvl.dts
index 28fd9abd7a57..36eec7392ab4 100644
--- a/arch/arm/boot/dts/kirkwood-lswvl.dts
+++ b/arch/arm/boot/dts/kirkwood-lswvl.dts
@@ -186,22 +186,22 @@
 
 		led at 1 {
 			label = "lswvl:red:alarm";
-			gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
 		};
 
 		led at 2 {
 			label = "lswvl:red:func";
-			gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>;
 		};
 
 		led at 3 {
 			label = "lswvl:amber:info";
-			gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
 		};
 
 		led at 4 {
 			label = "lswvl:blue:func";
-			gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
 		};
 
 		led at 5 {
@@ -212,12 +212,12 @@
 
 		led at 6 {
 			label = "lswvl:red:hdderr0";
-			gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
 		};
 
 		led at 7 {
 			label = "lswvl:red:hdderr1";
-			gpios = <&gpio1 3 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio1 3 GPIO_ACTIVE_HIGH>;
 		};
 	};
 
-- 
2.1.4

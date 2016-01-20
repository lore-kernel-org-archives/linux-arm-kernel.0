From: rogershimizu@gmail.com (Roger Shimizu)
Date: Thu, 21 Jan 2016 00:33:55 +0900
Subject: [PATCH v2 4/7] ARM: dts: kirkwood: gpio-leds fixes for linkstation
 ls-wvl/vl
In-Reply-To: <1453304038-28345-1-git-send-email-rogershimizu@gmail.com>
References: <1453211342-25214-1-git-send-email-rogershimizu@gmail.com>
 <1453304038-28345-1-git-send-email-rogershimizu@gmail.com>
Message-ID: <1453304038-28345-5-git-send-email-rogershimizu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make all leds initially to "off" state except power indicator, so pins below
change from active_low to active_high:
  - gpio-leds: "lswvl:red:alarm" pin
  - gpio-leds: "lswvl:red:func" pin
  - gpio-leds: "lswvl:amber:info" pin
  - gpio-leds: "lswvl:blue:func" pin
  - gpio-leds: "lswvl:blue:power" pin
  - gpio-leds: "lswvl:red:hdderr{0,1}" pin

Fixes: c43379e150aa ("ARM: dts: add buffalo linkstation ls-wvl/vl")
Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>
---
 arch/arm/boot/dts/kirkwood-lswvl.dts | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-lswvl.dts b/arch/arm/boot/dts/kirkwood-lswvl.dts
index 28fd9abd7a57..20b6b0c8b3ec 100644
--- a/arch/arm/boot/dts/kirkwood-lswvl.dts
+++ b/arch/arm/boot/dts/kirkwood-lswvl.dts
@@ -186,38 +186,37 @@
 
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
 			label = "lswvl:blue:power";
-			gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
-			default-state = "keep";
+			gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
 		};
 
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

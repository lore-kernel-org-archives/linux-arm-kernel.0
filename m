From: rogershimizu@gmail.com (Roger Shimizu)
Date: Thu, 21 Jan 2016 23:38:46 +0900
Subject: [PATCH v3 3/7] ARM: dts: kirkwood: gpio-leds fixes for linkstation
 ls-wxl/wsxl
In-Reply-To: <1453387130-6914-1-git-send-email-rogershimizu@gmail.com>
References: <1453387130-6914-1-git-send-email-rogershimizu@gmail.com>
Message-ID: <1453387130-6914-4-git-send-email-rogershimizu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPIOs controlling the LEDs, listed below, are active high, not low:
  - gpio-leds: "lswxl:blue:power" pin
  - gpio-leds: "lswxl:red:func" pin
  - gpio-leds: "lswxl:red:hdderr{0,1}" pin

Fixes: e54e4b1b622e ("ARM: dts: add buffalo linkstation ls-wxl/wsxl")
Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-lswxl.dts | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-lswxl.dts b/arch/arm/boot/dts/kirkwood-lswxl.dts
index 0e93f6d19259..b13ec20a7088 100644
--- a/arch/arm/boot/dts/kirkwood-lswxl.dts
+++ b/arch/arm/boot/dts/kirkwood-lswxl.dts
@@ -201,23 +201,23 @@
 
 		led at 4 {
 			label = "lswxl:blue:power";
-			gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
+			default-state = "keep";
 		};
 
 		led at 5 {
 			label = "lswxl:red:func";
-			gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
-			default-state = "keep";
+			gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
 		};
 
 		led at 6 {
 			label = "lswxl:red:hdderr0";
-			gpios = <&gpio0 8 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio0 8 GPIO_ACTIVE_HIGH>;
 		};
 
 		led at 7 {
 			label = "lswxl:red:hdderr1";
-			gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>;
 		};
 	};
 
-- 
2.1.4

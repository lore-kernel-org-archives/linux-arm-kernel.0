From: andrew@lunn.ch (Andrew Lunn)
Date: Sun,  3 Apr 2016 04:03:44 +0200
Subject: [PATCH 2/8] ARM: kirkwood: DT: Remove node address from leds
In-Reply-To: <1459649030-21886-1-git-send-email-andrew@lunn.ch>
References: <1459649030-21886-1-git-send-email-andrew@lunn.ch>
Message-ID: <1459649030-21886-3-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

leds don't have a reg property, so remove the address from the unit name.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-lsxl.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-lsxl.dtsi b/arch/arm/boot/dts/kirkwood-lsxl.dtsi
index 2869c5dbc1ad..8b7c6ce79a41 100644
--- a/arch/arm/boot/dts/kirkwood-lsxl.dtsi
+++ b/arch/arm/boot/dts/kirkwood-lsxl.dtsi
@@ -133,28 +133,28 @@
 			     &pmx_led_function_blue>;
 		pinctrl-names = "default";
 
-		led at 1 {
+		func_blue {
 			label = "lsxl:blue:func";
 			gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
 		};
 
-		led at 2 {
+		alarm {
 			label = "lsxl:red:alarm";
 			gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
 		};
 
-		led at 3 {
+		info {
 			label = "lsxl:amber:info";
 			gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
 		};
 
-		led at 4 {
+		power {
 			label = "lsxl:blue:power";
 			gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
 			default-state = "keep";
 		};
 
-		led at 5 {
+		func_red {
 			label = "lsxl:red:func";
 			gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
 		};
-- 
2.7.0

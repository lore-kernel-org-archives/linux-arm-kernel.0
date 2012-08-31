From: anilkumar@ti.com (AnilKumar Ch)
Date: Fri, 31 Aug 2012 14:59:18 +0530
Subject: [PATCH v5 2/5] arm/dts: AM33XX: Configure pinmuxs for user leds
 control on Bone
In-Reply-To: <1346405361-29711-1-git-send-email-anilkumar@ti.com>
References: <1346405361-29711-1-git-send-email-anilkumar@ti.com>
Message-ID: <1346405361-29711-3-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds GPIO pinctrl nodes to am3358_pinmux master node to control
user leds (USR0, USR1, USR2 and USR3) present on BeagleBone.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am335x-bone.dts |   41 +++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index c634f87..ce486fc 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -18,11 +18,52 @@
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
 
+	am3358_pinmux: pinmux at 44e10800 {
+		userled_pins: pinmux_userled_pins {
+			pinctrl-single,pins = <
+				0x54 0x7	/* gpmc_a5.gpio1_21, OUTPUT | MODE7 */
+				0x58 0x17	/* gpmc_a6.gpio1_22, OUTPUT_PULLUP | MODE7 */
+				0x5c 0x7	/* gpmc_a7.gpio1_23, OUTPUT | MODE7 */
+				0x60 0x17	/* gpmc_a8.gpio1_24, OUTPUT_PULLUP | MODE7 */
+			>;
+		};
+	};
+
 	ocp {
 		uart1: serial at 44e09000 {
 			status = "okay";
 		};
 
+		gpio-leds {
+			compatible = "gpio-leds";
+			pinctrl-names = "default";
+			pinctrl-0 = <&userled_pins>;
+
+			led0 {
+				label = "status:green:user0";
+				gpios = <&gpio2 21 0>;
+				default-state = "off";
+			};
+
+			led1 {
+				label = "status:green:user1";
+				gpios = <&gpio2 22 0>;
+				default-state = "off";
+			};
+
+			led2 {
+				label = "status:green:user2";
+				gpios = <&gpio2 23 0>;
+				default-state = "off";
+			};
+
+			led3 {
+				label = "status:green:user3";
+				gpios = <&gpio2 24 0>;
+				default-state = "off";
+			};
+		};
+
 		i2c1: i2c at 44e0b000 {
 			status = "okay";
 			clock-frequency = <400000>;
-- 
1.7.9.5

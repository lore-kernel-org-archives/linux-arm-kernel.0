From: marex@denx.de (Marek Vasut)
Date: Sun, 20 Mar 2016 00:57:45 +0100
Subject: [PATCH 1/2] ARM: socfpga: Add support for HPS LEDs on SoCKit
Message-ID: <1458431866-9269-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the blue LEDs on the SoCFPGA SoCkit board.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts | 32 +++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
index b61f22f..1461690 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
@@ -39,6 +39,34 @@
 		ethernet0 = &gmac1;
 	};
 
+	leds {
+		compatible = "gpio-leds";
+
+		hps_led0 {
+			label = "hps:blue:led0";
+			gpios = <&portb 24 0>;	/* HPS_GPIO53 */
+			linux,default-trigger = "heartbeat";
+		};
+
+		hps_led1 {
+			label = "hps:blue:led1";
+			gpios = <&portb 25 0>;	/* HPS_GPIO54 */
+			linux,default-trigger = "heartbeat";
+		};
+
+		hps_led2 {
+			label = "hps:blue:led2";
+			gpios = <&portb 26 0>;	/* HPS_GPIO55 */
+			linux,default-trigger = "heartbeat";
+		};
+
+		hps_led3 {
+			label = "hps:blue:led3";
+			gpios = <&portb 27 0>;	/* HPS_GPIO56 */
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
 	regulator_3_3v: vcc3p3-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "VCC3P3";
@@ -61,6 +89,10 @@
 	rxc-skew-ps = <2000>;
 };
 
+&gpio1 {	/* GPIO 30..57 */
+	status = "okay";
+};
+
 &gpio2 {
 	status = "okay";
 };
-- 
2.7.0

From: codekipper@gmail.com (codekipper at gmail.com)
Date: Mon, 20 Feb 2017 17:20:52 +0100
Subject: [linux-sunxi][PATCH] ARM: dts: sun8i-h3: orange-pi-2: Enable audio
 codec
Message-ID: <20170220162052.21932-1-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

The Orange Pi 2 routes the LINEOUT pins through a SGM8900 PA which
needs to be enabled. The onboard microphone is routed to MIC1, with
MBIAS providing power.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
index 047e9e1c6093..b0d2b99990cc 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
@@ -105,6 +105,16 @@
 	};
 };
 
+&codec {
+	pinctrl-0 = <&codec_pa_pin>;
+	allwinner,pa-gpios = <&pio 0 16 GPIO_ACTIVE_HIGH>; /* PA16 */
+	allwinner,audio-routing =
+		"Speaker", "LINEOUT",
+		"MIC1", "Mic",
+		"Mic",  "MBIAS";
+	status = "okay";
+};
+
 &ehci1 {
 	status = "okay";
 };
@@ -144,6 +154,11 @@
 };
 
 &pio {
+	codec_pa_pin: codec_pa_pin at 0 {
+		pins = "PA16";
+		function = "gpio_out";
+	};
+
 	leds_opc: led_pins at 0 {
 		pins = "PA15";
 		function = "gpio_out";
-- 
2.11.1

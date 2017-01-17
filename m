From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue, 17 Jan 2017 02:17:53 +0100
Subject: [PATCH] ARM64: dts: meson-gxbb-vega-s95: Add LED
Message-ID: <20170117011753.29978-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is one blue LED on the front of the device. Keep it lit and
configure it as panic indicator.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
index ab497126c9a3..b3937b72d102 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
@@ -53,6 +53,17 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	leds {
+		compatible = "gpio-leds";
+
+		blue {
+			label = "vega-s95:blue:on";
+			gpios = <&gpio_ao GPIOAO_13 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+			panic-indicator;
+		};
+	};
+
 	usb_vbus: regulator-usb0-vbus {
 		compatible = "regulator-fixed";
 
-- 
2.10.2

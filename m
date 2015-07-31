From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 31 Jul 2015 22:40:58 +0800
Subject: [PATCH v2 1/2] ARM: dts: sun5i: hsg-h702: Enable side volume buttons
 with LRADC
In-Reply-To: <1438353659-3360-1-git-send-email-wens@csie.org>
References: <1438353659-3360-1-git-send-email-wens@csie.org>
Message-ID: <1438353659-3360-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The tablet has volume up/down buttons on the side, connected to the LRADC.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts b/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
index 990f9d61ae4d..4b8808ab9711 100644
--- a/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
+++ b/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
@@ -45,6 +45,7 @@
 #include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/sun4i-a10.h>
 
 / {
@@ -96,6 +97,25 @@
 	status = "okay";
 };
 
+&lradc {
+	vref-supply = <&reg_ldo2>;
+	status = "okay";
+
+	button at 200 {
+		label = "Volume Up";
+		linux,code = <KEY_VOLUMEUP>;
+		channel = <0>;
+		voltage = <200000>;
+	};
+
+	button at 400 {
+		label = "Volume Down";
+		linux,code = <KEY_VOLUMEDOWN>;
+		channel = <0>;
+		voltage = <400000>;
+	};
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_h702>;
-- 
2.5.0

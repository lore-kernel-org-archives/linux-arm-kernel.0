From: vishnupatekar0510@gmail.com (Vishnu Patekar)
Date: Thu, 17 Mar 2016 00:04:34 +0800
Subject: [PATCH v4 11/13] ARM: dts: sun8i: enable mmc for H8Homlet Board.
In-Reply-To: <1458144276-31108-1-git-send-email-vishnupatekar0510@gmail.com>
References: <1458144276-31108-1-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <1458144276-31108-12-git-send-email-vishnupatekar0510@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables mmc0.

Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
Tested-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts b/arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts
index 342e1d3..3269f39 100644
--- a/arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts
@@ -43,6 +43,7 @@
 
 /dts-v1/;
 #include "sun8i-a83t.dtsi"
+#include "sunxi-common-regulators.dtsi"
 
 / {
 	model = "Allwinner A83T H8Homlet Proto Dev Board v2.0";
@@ -57,6 +58,16 @@
 	};
 };
 
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
+	vmmc-supply = <&reg_vcc3v0>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
+	bus-width = <4>;
+	cd-inverted;
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_b>;
-- 
1.9.1

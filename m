From: carlo@caione.org (Carlo Caione)
Date: Sat, 15 Mar 2014 16:43:44 +0100
Subject: [PATCH v2 7/8] ARM: sun7i: dt: Add AXP209 support to various boards
In-Reply-To: <1394898225-28452-1-git-send-email-carlo@caione.org>
References: <1394898225-28452-1-git-send-email-carlo@caione.org>
Message-ID: <1394898225-28452-8-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Carlo Caione <carlo@caione.org>
---
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     | 12 ++++++++++++
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts      | 13 +++++++++++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 12 ++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
index 5c51cb8..9ad7da5 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
@@ -53,6 +53,18 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2c0_pins_a>;
 			status = "okay";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			axp: axp20x at 34 {
+				reg = <0x34>;
+				interrupt-parent = <&nmi_intc>;
+				interrupts = <0 8>;
+
+				axp,system-power-controller;
+
+				/include/ "x-powers-axp209.dtsi"
+			};
 		};
 
 		i2c1: i2c at 01c2b000 {
diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index f9dcb61..aab77f9 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -38,6 +38,19 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2c0_pins_a>;
 			status = "okay";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			axp: axp20x at 34 {
+				reg = <0x34>;
+				interrupt-parent = <&nmi_intc>;
+				interrupts = <0 8>;
+
+				axp,system-power-controller;
+
+				/include/ "x-powers-axp209.dtsi"
+			};
+
 		};
 
 		i2c1: i2c at 01c2b000 {
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index ead3013..a5fe5d0 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -65,6 +65,18 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2c0_pins_a>;
 			status = "okay";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			axp: axp20x at 34 {
+				reg = <0x34>;
+				interrupt-parent = <&nmi_intc>;
+				interrupts = <0 8>;
+
+				axp,system-power-controller;
+
+				/include/ "x-powers-axp209.dtsi"
+			};
 		};
 
 		i2c1: i2c at 01c2b000 {
-- 
1.8.3.2

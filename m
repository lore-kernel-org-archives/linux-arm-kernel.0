From: abailon@baylibre.com (Alexandre Bailon)
Date: Thu,  3 Nov 2016 16:59:12 +0100
Subject: [PATCH v4 4/4] ARM: dts: da850: Add the usb otg device node
In-Reply-To: <1478188752-22447-1-git-send-email-abailon@baylibre.com>
References: <1478188752-22447-1-git-send-email-abailon@baylibre.com>
Message-ID: <1478188752-22447-5-git-send-email-abailon@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the device tree node for the usb otg
controller present in the da850 family of SoC's.
This also enables the otg usb controller for the lcdk board.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 arch/arm/boot/dts/da850-lcdk.dts |  8 ++++++++
 arch/arm/boot/dts/da850.dtsi     | 15 +++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index 7b8ab21..9f5040c 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -158,6 +158,14 @@
 	rx-num-evt = <32>;
 };
 
+&usb_phy {
+	status = "okay";
+	};
+
+&usb0 {
+	status = "okay";
+};
+
 &aemif {
 	pinctrl-names = "default";
 	pinctrl-0 = <&nand_pins>;
diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index f79e1b9..322a31a 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -372,6 +372,21 @@
 					>;
 			status = "disabled";
 		};
+		usb_phy: usb-phy {
+			compatible = "ti,da830-usb-phy";
+			#phy-cells = <1>;
+			status = "disabled";
+		};
+		usb0: usb at 200000 {
+			compatible = "ti,da830-musb";
+			reg = <0x200000 0x10000>;
+			interrupts = <58>;
+			interrupt-names = "mc";
+			dr_mode = "otg";
+			phys = <&usb_phy 0>;
+			phy-names = "usb-phy";
+			status = "disabled";
+		};
 		gpio: gpio at 226000 {
 			compatible = "ti,dm6441-gpio";
 			gpio-controller;
-- 
2.7.3

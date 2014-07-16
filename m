From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Wed, 16 Jul 2014 10:26:03 +0200
Subject: [PATCH v3 09/12] ARM: dts: berlin: add BG2Q nodes for USB support
In-Reply-To: <1405499166-6726-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1405499166-6726-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1405499166-6726-10-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds nodes describing the Marvell Berlin BG2Q USB PHY and USB. The BG2Q
SoC has 3 USB host controller, compatible with ChipIdea.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 52 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index a6f7ec325200..a56ee2ca196e 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -111,6 +111,39 @@
 			#interrupt-cells = <3>;
 		};
 
+		usb_phy2: phy at a2f400 {
+			compatible = "marvell,berlin2-usb-phy";
+			reg = <0xa2f400 0x128>;
+			#phy-cells = <0>;
+			resets = <&chip 0x104 14>;
+			status = "disabled";
+		};
+
+		usb2: usb at a30000 {
+			compatible = "chipidea,usb2";
+			reg = <0xa30000 0x10000>;
+			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&chip CLKID_USB2>;
+			phys = <&usb_phy2>;
+			status = "disabled";
+		};
+
+		usb_phy0: phy at b74000 {
+			compatible = "marvell,berlin2-usb-phy";
+			reg = <0xb74000 0x128>;
+			#phy-cells = <0>;
+			resets = <&chip 0x104 12>;
+			status = "disabled";
+		};
+
+		usb_phy1: phy at b78000 {
+			compatible = "marvell,berlin2-usb-phy";
+			reg = <0xb78000 0x128>;
+			#phy-cells = <0>;
+			resets = <&chip 0x104 13>;
+			status = "disabled";
+		};
+
 		apb at e80000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
@@ -304,6 +337,24 @@
 			clock-names = "refclk";
 		};
 
+		usb0: usb at ed0000 {
+			compatible = "chipidea,usb2";
+			reg = <0xed0000 0x10000>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&chip CLKID_USB0>;
+			phys = <&usb_phy0>;
+			status = "disabled";
+		};
+
+		usb1: usb at ee0000 {
+			compatible = "chipidea,usb2";
+			reg = <0xee0000 0x10000>;
+			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&chip CLKID_USB1>;
+			phys = <&usb_phy1>;
+			status = "disabled";
+		};
+
 		apb at fc0000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
@@ -360,5 +411,6 @@
 				interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
+
 	};
 };
-- 
1.9.1

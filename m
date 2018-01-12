From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 12 Jan 2018 17:51:58 +1100
Subject: [PATCH] dts: ARM: Add Aspeed virtual hub to SoC templates
Message-ID: <1515739918.31850.102.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't yet enable it in any of the boards

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/arm/boot/dts/aspeed-g4.dtsi |  8 ++++++++
 arch/arm/boot/dts/aspeed-g5.dtsi | 13 +++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index e55f2ad5de59..743b79014d3d 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -120,6 +120,14 @@
 			status = "disabled";
 		};
 
+		vhub: usb-vhub at 1e6a0000 {
+			compatible = "aspeed,ast2400-usb-vhub";
+			reg = <0x1e6a0000 0x300>;
+			interrupts = <5>;
+			clocks = <&syscon ASPEED_CLK_GATE_USBPORT1CLK>;
+			status = "disabled";
+		};
+
 		apb {
 			compatible = "simple-bus";
 			#address-cells = <1>;
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 655258edee24..e50d7f3e18a0 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -163,6 +163,14 @@
 			status = "disabled";
 		};
 
+		vhub: usb-vhub at 1e6a0000 {
+			compatible = "aspeed,ast2500-usb-vhub";
+			reg = <0x1e6a0000 0x300>;
+			interrupts = <5>;
+			clocks = <&syscon ASPEED_CLK_GATE_USBPORT1CLK>;
+			status = "disabled";
+		};
+
 		apb {
 			compatible = "simple-bus";
 			#address-cells = <1>;
@@ -1388,6 +1396,11 @@
 		groups = "USB2AH";
 	};
 
+	pinctrl_usb2ad_default: usb2ad_default {
+		function = "USB2AD";
+		groups = "USB2AD";
+	};
+
 	pinctrl_usb11bhid_default: usb11bhid_default {
 		function = "USB11BHID";
 		groups = "USB11BHID";

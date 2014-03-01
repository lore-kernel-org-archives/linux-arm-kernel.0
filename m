From: hdegoede@redhat.com (Hans de Goede)
Date: Sat,  1 Mar 2014 20:26:23 +0100
Subject: [PATCH 04/19] ARM: sun4i: dt: Add USB host bindings
In-Reply-To: <1393701998-3553-1-git-send-email-hdegoede@redhat.com>
References: <1393701998-3553-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1393701998-3553-5-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roman Byshko <rbyshko@gmail.com>

Add nodes for the usb-phy and ehci- and ohci-usb-host controllers.

Signed-off-by: Roman Byshko <rbyshko@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 52 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index e073c41..b5e5bf2 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -377,6 +377,38 @@
 			#size-cells = <0>;
 		};
 
+		usbphy: phy at 01c13400 {
+			#phy-cells = <1>;
+			compatible = "allwinner,sun4i-a10-usb-phy";
+			reg = <0x01c13400 0x10 0x01c14800 0x4 0x01c1c800 0x4>;
+			reg-names = "phy_ctrl", "pmu1", "pmu2";
+			clocks = <&usb_clk 8>;
+			clock-names = "usb_phy";
+			resets = <&usb_clk 1>, <&usb_clk 2>;
+			reset-names = "usb1_reset", "usb2_reset";
+			status = "disabled";
+		};
+
+		ehci0: usb at 01c14000 {
+			compatible = "allwinner,sun4i-a10-ehci", "generic-ehci";
+			reg = <0x01c14000 0x100>;
+			interrupts = <39>;
+			clocks = <&ahb_gates 1>;
+			phys = <&usbphy 1>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		ohci0: usb at 01c14400 {
+			compatible = "allwinner,sun4i-a10-ohci", "generic-ohci";
+			reg = <0x01c14400 0x100>;
+			interrupts = <64>;
+			clocks = <&usb_clk 6>, <&ahb_gates 2>;
+			phys = <&usbphy 1>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
 		spi2: spi at 01c17000 {
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c17000 0x1000>;
@@ -396,6 +428,26 @@
 			status = "disabled";
 		};
 
+		ehci1: usb at 01c1c000 {
+			compatible = "allwinner,sun4i-a10-ehci", "generic-ehci";
+			reg = <0x01c1c000 0x100>;
+			interrupts = <40>;
+			clocks = <&ahb_gates 3>;
+			phys = <&usbphy 2>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		ohci1: usb at 01c1c400 {
+			compatible = "allwinner,sun4i-a10-ohci", "generic-ohci";
+			reg = <0x01c1c400 0x100>;
+			interrupts = <65>;
+			clocks = <&usb_clk 7>, <&ahb_gates 4>;
+			phys = <&usbphy 2>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
 		spi3: spi at 01c1f000 {
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c1f000 0x1000>;
-- 
1.9.0

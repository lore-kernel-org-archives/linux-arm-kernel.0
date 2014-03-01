From: hdegoede@redhat.com (Hans de Goede)
Date: Sat,  1 Mar 2014 20:26:24 +0100
Subject: [PATCH 05/19] ARM: sun5i: dt: Add USB host bindings
In-Reply-To: <1393701998-3553-1-git-send-email-hdegoede@redhat.com>
References: <1393701998-3553-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1393701998-3553-6-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roman Byshko <rbyshko@gmail.com>

Add nodes for the usb-phy and ehci- and ohci-usb-host controllers.

Signed-off-by: Roman Byshko <rbyshko@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i-a10s.dtsi | 32 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/sun5i-a13.dtsi  | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index a7198b6..9fc375a 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -338,6 +338,38 @@
 			#size-cells = <0>;
 		};
 
+		usbphy: phy at 01c13400 {
+			#phy-cells = <1>;
+			compatible = "allwinner,sun5i-a13-usb-phy";
+			reg = <0x01c13400 0x10 0x01c14800 0x4>;
+			reg-names = "phy_ctrl", "pmu1";
+			clocks = <&usb_clk 8>;
+			clock-names = "usb_phy";
+			resets = <&usb_clk 1>;
+			reset-names = "usb1_reset";
+			status = "disabled";
+		};
+
+		ehci0: usb at 01c14000 {
+			compatible = "allwinner,sun5i-a10s-ehci", "generic-ehci";
+			reg = <0x01c14000 0x100>;
+			interrupts = <39>;
+			clocks = <&ahb_gates 1>;
+			phys = <&usbphy 1>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		ohci0: usb at 01c14400 {
+			compatible = "allwinner,sun5i-a10s-ohci", "generic-ohci";
+			reg = <0x01c14400 0x100>;
+			interrupts = <40>;
+			clocks = <&usb_clk 6>, <&ahb_gates 2>;
+			phys = <&usbphy 1>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
 		spi2: spi at 01c17000 {
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c17000 0x1000>;
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index cda1d4b..8931c08 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -320,6 +320,38 @@
 			#size-cells = <0>;
 		};
 
+		usbphy: phy at 01c13400 {
+			#phy-cells = <1>;
+			compatible = "allwinner,sun5i-a13-usb-phy";
+			reg = <0x01c13400 0x10 0x01c14800 0x4>;
+			reg-names = "phy_ctrl", "pmu1";
+			clocks = <&usb_clk 8>;
+			clock-names = "usb_phy";
+			resets = <&usb_clk 1>;
+			reset-names = "usb1_reset";
+			status = "disabled";
+		};
+
+		ehci0: usb at 01c14000 {
+			compatible = "allwinner,sun5i-a13-ehci", "generic-ehci";
+			reg = <0x01c14000 0x100>;
+			interrupts = <39>;
+			clocks = <&ahb_gates 1>;
+			phys = <&usbphy 1>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		ohci0: usb at 01c14400 {
+			compatible = "allwinner,sun5i-a13-ohci", "generic-ohci";
+			reg = <0x01c14400 0x100>;
+			interrupts = <40>;
+			clocks = <&usb_clk 6>, <&ahb_gates 2>;
+			phys = <&usbphy 1>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
 		spi2: spi at 01c17000 {
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c17000 0x1000>;
-- 
1.9.0

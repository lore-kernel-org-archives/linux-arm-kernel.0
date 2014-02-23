From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 23 Feb 2014 13:09:11 +0100
Subject: [PATCH v3 3/4] ARM: sun5i: dt: Add USB host bindings
In-Reply-To: <1393157352-21104-1-git-send-email-hdegoede@redhat.com>
References: <1393157352-21104-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1393157352-21104-4-git-send-email-hdegoede@redhat.com>
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
index 0565040..a5431ed 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -341,6 +341,38 @@
 			status = "disabled";
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
 		intc: interrupt-controller at 01c20400 {
 			compatible = "allwinner,sun4i-ic";
 			reg = <0x01c20400 0x400>;
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 785dea5..7fe9cdc 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -312,6 +312,38 @@
 			status = "disabled";
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
 		intc: interrupt-controller at 01c20400 {
 			compatible = "allwinner,sun4i-ic";
 			reg = <0x01c20400 0x400>;
-- 
1.9.0

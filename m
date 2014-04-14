From: dinguyen@altera.com (dinguyen at altera.com)
Date: Mon, 14 Apr 2014 16:38:04 -0500
Subject: [PATCH] dts: socfpga: Add DTS entries for USB
Message-ID: <1397511484-23368-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Update all the SOCFPGA DTS files with USB entries.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
---
 arch/arm/boot/dts/socfpga.dtsi                |   30 +++++++++++++++++++++++++
 arch/arm/boot/dts/socfpga_arria5_socdk.dts    |    4 ++++
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts  |    4 ++++
 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts |    4 ++++
 4 files changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index df43702..445fe2f 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -681,6 +681,36 @@
 			reg = <0xffd05000 0x1000>;
 		};
 
+		usbphy0: usbphy at 0 {
+			#phy-cells = <0>;
+			compatible = "usb-nop-xceiv";
+			status = "okay";
+		};
+
+		usb0: usb at ffb00000 {
+			compatible = "snps,dwc2";
+			reg = <0xffb00000 0xffff>;
+			interrupts = <0 125 4>;
+			clocks = <&usb_mp_clk>;
+			clock-names = "otg";
+			phys = <&usbphy0>;
+			phy-names = "usb2-phy";
+			dma-desc-enable = <0>;
+			status = "disabled";
+		};
+
+		usb1: usb at ffb40000 {
+			compatible = "snps,dwc2";
+			reg = <0xffb40000 0xffff>;
+			interrupts = <0 128 4>;
+			clocks = <&usb_mp_clk>;
+			clock-names = "otg";
+			phys = <&usbphy0>;
+			phy-names = "usb2-phy";
+			dma-desc-enable = <0>;
+			status = "disabled";
+		};
+
 		sysmgr: sysmgr at ffd08000 {
 			compatible = "altr,sys-mgr", "syscon";
 			reg = <0xffd08000 0x4000>;
diff --git a/arch/arm/boot/dts/socfpga_arria5_socdk.dts b/arch/arm/boot/dts/socfpga_arria5_socdk.dts
index a04061f..d532d17 100644
--- a/arch/arm/boot/dts/socfpga_arria5_socdk.dts
+++ b/arch/arm/boot/dts/socfpga_arria5_socdk.dts
@@ -74,3 +74,7 @@
 		reg = <0x68>;
 	};
 };
+
+&usb1 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
index 55d54f7..45de151 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
@@ -67,3 +67,7 @@
 		reg = <0x68>;
 	};
 };
+
+&usb1 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
index d5ce22c..d26f155 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
@@ -52,3 +52,7 @@
 	rxdv-skew-ps = <0>;
 	rxc-skew-ps = <2000>;
 };
+
+&usb1 {
+	status = "okay";
+};
-- 
1.7.9.5

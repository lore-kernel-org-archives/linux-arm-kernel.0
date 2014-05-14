From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Wed, 14 May 2014 19:31:04 +0530
Subject: [PATCH v6 2/8] ARM: dts: exynos5420: Enable support for DWC3
 controller
In-Reply-To: <1400076070-12456-1-git-send-email-gautam.vivek@samsung.com>
References: <1400076070-12456-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <1400076070-12456-3-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree nodes for DWC3 controller present on
Exynos 5420 SoC, to enable support for USB 3.0.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 8eebf7f..128829a 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -805,6 +805,23 @@
 		samsung,pmureg-phandle = <&pmu_system_controller>;
 	};
 
+	usbdrd3_0: usb at 12000000 {
+		compatible = "samsung,exynos5250-dwusb3";
+		clocks = <&clock CLK_USBD300>;
+		clock-names = "usbdrd30";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		dwc3 {
+			compatible = "snps,dwc3";
+			reg = <0x12000000 0x10000>;
+			interrupts = <0 72 0>;
+			phys = <&usbdrd_phy0 0>, <&usbdrd_phy0 1>;
+			phy-names = "usb2-phy", "usb3-phy";
+		};
+	};
+
 	usbdrd_phy0: phy at 12100000 {
 		compatible = "samsung,exynos5420-usbdrd-phy";
 		reg = <0x12100000 0x100>;
@@ -814,6 +831,23 @@
 		#phy-cells = <1>;
 	};
 
+	usbdrd3_1: usb at 12400000 {
+		compatible = "samsung,exynos5250-dwusb3";
+		clocks = <&clock CLK_USBD301>;
+		clock-names = "usbdrd30";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		dwc3 {
+			compatible = "snps,dwc3";
+			reg = <0x12400000 0x10000>;
+			interrupts = <0 73 0>;
+			phys = <&usbdrd_phy1 0>, <&usbdrd_phy1 1>;
+			phy-names = "usb2-phy", "usb3-phy";
+		};
+	};
+
 	usbdrd_phy1: phy at 12500000 {
 		compatible = "samsung,exynos5420-usbdrd-phy";
 		reg = <0x12500000 0x100>;
-- 
1.7.10.4

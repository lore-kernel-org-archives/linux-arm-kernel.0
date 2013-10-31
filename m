From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Thu, 31 Oct 2013 13:15:42 +0530
Subject: [PATCH 2/4] dt: exynos5250: Enable support for generic USB 3.0 phy
In-Reply-To: <1383205544-32244-1-git-send-email-gautam.vivek@samsung.com>
References: <1383205544-32244-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <1383205544-32244-3-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update device tree bindings for DWC3 controller and
USB 3.0 phy present on Exynos 5250 SoC, to start using
the phy driver based on generic phy framework.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 arch/arm/boot/dts/exynos5250.dtsi |   17 ++++++-----------
 1 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index bbac42a..31a6595 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -472,22 +472,17 @@
 			compatible = "synopsys,dwc3";
 			reg = <0x12000000 0x10000>;
 			interrupts = <0 72 0>;
-			usb-phy = <&usb2_phy &usb3_phy>;
+			phys = <&usb3_phy>;
+			phy-names = "usb3-phy";
 		};
 	};
 
 	usb3_phy: usbphy at 12100000 {
 		compatible = "samsung,exynos5250-usb3phy";
-		reg = <0x12100000 0x100>;
-		clocks = <&clock 1>, <&clock 286>;
-		clock-names = "ext_xtal", "usbdrd30";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		usbphy-sys {
-			reg = <0x10040704 0x8>;
-		};
+		reg = <0x12100000 0x100 0x10040704 0x4>;
+		clocks = <&clock 286>, <&clock 1>;
+		clock-names = "phy", "usb3drd";
+		#phy-cells = <0>;
 	};
 
 	usb at 12110000 {
-- 
1.7.6.5

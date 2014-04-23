From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Wed, 23 Apr 2014 20:00:46 +0530
Subject: [PATCH v5 4/9] dts: exynos5250: Update DWC3 usb controller to use new
 phy driver
In-Reply-To: <1398263451-18023-1-git-send-email-gautam.vivek@samsung.com>
References: <1398263451-18023-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <1398263451-18023-5-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Removing the dt node for older usb3 phy driver from Exynos5250
device tree and updating the dt node for DWC3 controller to
use new phy driver based on generic phy framework.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/boot/dts/exynos5250.dtsi |   17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index d4254c0..d7c65e6 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -533,21 +533,8 @@
 			compatible = "synopsys,dwc3";
 			reg = <0x12000000 0x10000>;
 			interrupts = <0 72 0>;
-			usb-phy = <&usb2_phy &usb3_phy>;
-		};
-	};
-
-	usb3_phy: usbphy at 12100000 {
-		compatible = "samsung,exynos5250-usb3phy";
-		reg = <0x12100000 0x100>;
-		clocks = <&clock CLK_FIN_PLL>, <&clock CLK_USB3>;
-		clock-names = "ext_xtal", "usbdrd30";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		usbphy-sys {
-			reg = <0x10040704 0x8>;
+			phys = <&usbdrd_phy 0>, <&usbdrd_phy 1>;
+			phy-names = "usb2-phy", "usb3-phy";
 		};
 	};
 
-- 
1.7.10.4

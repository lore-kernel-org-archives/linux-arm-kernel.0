From: jg1.han@samsung.com (Jingoo Han)
Date: Wed, 29 May 2013 18:48:12 +0900
Subject: [PATCH 2/2] ARM: dts: Add USB PHY node to Exynos4210
Message-ID: <000201ce5c51$a261d530$e7257f90$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device node for USB 2.0 PHY controller to Exynos4210.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
Tested on Exynos4210.

 arch/arm/boot/dts/exynos4210.dtsi |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index 3c173c7..bec6637 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -135,6 +135,20 @@
 		clock-names = "usbhost";
 	};
 
+	usb2_phy: usbphy at 125b0000 {
+		compatible = "samsung,exynos4210-usb2phy";
+		reg = <0x125b0000 0x100>;
+		clocks = <&clock 2>, <&clock 305>;
+		clock-names = "xusbxti", "usb_device";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		usbphy-sys {
+			reg = <0x10020704 0x8>;
+		};
+	};
+
 	g2d at 12800000 {
 		compatible = "samsung,s5pv210-g2d";
 		reg = <0x12800000 0x1000>;
-- 
1.7.10.4

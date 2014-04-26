From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 26 Apr 2014 12:16:18 +0200
Subject: [PATCH v9 14/17] ARM: dts: sun7i: Add mmc controller nodes
In-Reply-To: <1398507381-5614-1-git-send-email-hdegoede@redhat.com>
References: <1398507381-5614-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1398507381-5614-15-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add nodes for the 4 mmc controllers found on A20 SoCs to
arch/arm/boot/dts/sun7i-a20.dtsi.

Signed-off-by: David Lanzend?rfer <david.lanzendoerfer@o2s.ch>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 32efc10..d7e4cac 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -447,6 +447,42 @@
 			#size-cells = <0>;
 		};
 
+		mmc0: mmc at 01c0f000 {
+			compatible = "allwinner,sun5i-a13-mmc";
+			reg = <0x01c0f000 0x1000>;
+			clocks = <&ahb_gates 8>, <&mmc0_clk>;
+			clock-names = "ahb", "mod";
+			interrupts = <0 32 4>;
+			status = "disabled";
+		};
+
+		mmc1: mmc at 01c10000 {
+			compatible = "allwinner,sun5i-a13-mmc";
+			reg = <0x01c10000 0x1000>;
+			clocks = <&ahb_gates 9>, <&mmc1_clk>;
+			clock-names = "ahb", "mod";
+			interrupts = <0 33 4>;
+			status = "disabled";
+		};
+
+		mmc2: mmc at 01c11000 {
+			compatible = "allwinner,sun5i-a13-mmc";
+			reg = <0x01c11000 0x1000>;
+			clocks = <&ahb_gates 10>, <&mmc2_clk>;
+			clock-names = "ahb", "mod";
+			interrupts = <0 34 4>;
+			status = "disabled";
+		};
+
+		mmc3: mmc at 01c12000 {
+			compatible = "allwinner,sun5i-a13-mmc";
+			reg = <0x01c12000 0x1000>;
+			clocks = <&ahb_gates 11>, <&mmc3_clk>;
+			clock-names = "ahb", "mod";
+			interrupts = <0 35 4>;
+			status = "disabled";
+		};
+
 		usbphy: phy at 01c13400 {
 			#phy-cells = <1>;
 			compatible = "allwinner,sun7i-a20-usb-phy";
-- 
1.9.0

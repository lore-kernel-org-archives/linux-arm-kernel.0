From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Jan 2015 03:54:08 +0800
Subject: [PATCH v3 03/10] ARM: dts: sun9i: Add usb clock nodes to a80 dtsi
In-Reply-To: <1422388455-25923-1-git-send-email-wens@csie.org>
References: <1422388455-25923-1-git-send-email-wens@csie.org>
Message-ID: <1422388455-25923-4-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The USB controller and phy clocks and resets have a separate address
block and driver. Add the nodes to represent them.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index 9e28ffc6dd90..679cf2878800 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -147,6 +147,28 @@
 			clock-output-names = "osc32k";
 		};
 
+		usb_mod_clk: clk at 00a08000 {
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			compatible = "allwinner,sun9i-a80-usb-mod-clk";
+			reg = <0x00a08000 0x4>;
+			clocks = <&ahb1_gates 1>;
+			clock-output-names = "usb0_ahb", "usb_ohci0",
+					     "usb1_ahb", "usb_ohci1",
+					     "usb2_ahb", "usb_ohci2";
+		};
+
+		usb_phy_clk: clk at 00a08004 {
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			compatible = "allwinner,sun9i-a80-usb-phy-clk";
+			reg = <0x00a08004 0x4>;
+			clocks = <&ahb1_gates 1>;
+			clock-output-names = "usb_phy0", "usb_hsic1_480M",
+					     "usb_phy1", "usb_hsic2_480M",
+					     "usb_phy2", "usb_hsic_12M";
+		};
+
 		pll4: clk at 0600000c {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun9i-a80-pll4-clk";
-- 
2.1.4

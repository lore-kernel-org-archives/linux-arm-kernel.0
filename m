From: ryder.lee@mediatek.com (Ryder Lee)
Date: Fri, 20 Oct 2017 17:46:46 +0800
Subject: [PATCH 2/3] arm: dts: mt7623: update usb related nodes
In-Reply-To: <4cabb9ad6f59b42cc10ba25a9eb0ce68f77d0a43.1508492662.git.ryder.lee@mediatek.com>
References: <4cabb9ad6f59b42cc10ba25a9eb0ce68f77d0a43.1508492662.git.ryder.lee@mediatek.com>
Message-ID: <66237617e8208edc30a0b6cf604eee175b62a9c9.1508492662.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current usb related nodes are out-of-date, so we make them be
consistent with the binding documents.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 arch/arm/boot/dts/mt7623.dtsi | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index 6c2c8c8..84a3f27 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -788,7 +788,7 @@
 		interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_LOW>;
 		clocks = <&hifsys CLK_HIFSYS_USB0PHY>,
 			 <&topckgen CLK_TOP_ETHIF_SEL>;
-		clock-names = "sys_ck", "free_ck";
+		clock-names = "sys_ck", "ref_ck";
 		power-domains = <&scpsys MT2701_POWER_DOMAIN_HIF>;
 		phys = <&u2port0 PHY_TYPE_USB2>, <&u3port0 PHY_TYPE_USB3>;
 		status = "disabled";
@@ -798,8 +798,6 @@
 		compatible = "mediatek,mt7623-u3phy",
 			     "mediatek,mt2701-u3phy";
 		reg = <0 0x1a1c4000 0 0x0700>;
-		clocks = <&clk26m>;
-		clock-names = "u3phya_ref";
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
@@ -807,12 +805,16 @@
 
 		u2port0: usb-phy at 1a1c4800 {
 			reg = <0 0x1a1c4800 0 0x0100>;
+			clocks = <&topckgen CLK_TOP_USB_PHY48M>;
+			clock-names = "ref";
 			#phy-cells = <1>;
 			status = "okay";
 		};
 
 		u3port0: usb-phy at 1a1c4900 {
 			reg = <0 0x1a1c4900 0 0x0700>;
+			clocks = <&clk26m>;
+			clock-names = "ref";
 			#phy-cells = <1>;
 			status = "okay";
 		};
@@ -827,7 +829,7 @@
 		interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_LOW>;
 		clocks = <&hifsys CLK_HIFSYS_USB1PHY>,
 			 <&topckgen CLK_TOP_ETHIF_SEL>;
-		clock-names = "sys_ck", "free_ck";
+		clock-names = "sys_ck", "ref_ck";
 		power-domains = <&scpsys MT2701_POWER_DOMAIN_HIF>;
 		phys = <&u2port1 PHY_TYPE_USB2>, <&u3port1 PHY_TYPE_USB3>;
 		status = "disabled";
@@ -837,8 +839,6 @@
 		compatible = "mediatek,mt7623-u3phy",
 			     "mediatek,mt2701-u3phy";
 		reg = <0 0x1a244000 0 0x0700>;
-		clocks = <&clk26m>;
-		clock-names = "u3phya_ref";
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
@@ -846,12 +846,16 @@
 
 		u2port1: usb-phy at 1a244800 {
 			reg = <0 0x1a244800 0 0x0100>;
+			clocks = <&topckgen CLK_TOP_USB_PHY48M>;
+			clock-names = "ref";
 			#phy-cells = <1>;
 			status = "okay";
 		};
 
 		u3port1: usb-phy at 1a244900 {
 			reg = <0 0x1a244900 0 0x0700>;
+			clocks = <&clk26m>;
+			clock-names = "ref";
 			#phy-cells = <1>;
 			status = "okay";
 		};
-- 
1.9.1

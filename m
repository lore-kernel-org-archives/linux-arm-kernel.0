From: ryder.lee@mediatek.com (Ryder Lee)
Date: Mon, 2 Oct 2017 09:54:55 +0800
Subject: [PATCH v3 05/10] arm: dts: mt7623: update pio, usb and crypto nodes
In-Reply-To: <cover.1506908511.git.ryder.lee@mediatek.com>
References: <cover.1506908511.git.ryder.lee@mediatek.com>
Message-ID: <08d722e47b83bd70ed4d3c9a4546a3f70df96de4.1506908511.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates pio, usb and crypto nodes to make them be consistent
with the binding documents.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 arch/arm/boot/dts/mt7623.dtsi | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index 381843e..0640fb7 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -227,8 +227,7 @@
 	};
 
 	pio: pinctrl at 10005000 {
-		compatible = "mediatek,mt7623-pinctrl",
-			     "mediatek,mt2701-pinctrl";
+		compatible = "mediatek,mt7623-pinctrl";
 		reg = <0 0x1000b000 0 0x1000>;
 		mediatek,pctl-regmap = <&syscfg_pctl_a>;
 		pins-are-numbered;
@@ -680,7 +679,7 @@
 		interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_LOW>;
 		clocks = <&hifsys CLK_HIFSYS_USB0PHY>,
 			 <&topckgen CLK_TOP_ETHIF_SEL>;
-		clock-names = "sys_ck", "free_ck";
+		clock-names = "sys_ck", "ref_ck";
 		power-domains = <&scpsys MT2701_POWER_DOMAIN_HIF>;
 		phys = <&u2port0 PHY_TYPE_USB2>, <&u3port0 PHY_TYPE_USB3>;
 		status = "disabled";
@@ -690,8 +689,6 @@
 		compatible = "mediatek,mt7623-u3phy",
 			     "mediatek,mt2701-u3phy";
 		reg = <0 0x1a1c4000 0 0x0700>;
-		clocks = <&clk26m>;
-		clock-names = "u3phya_ref";
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
@@ -699,12 +696,16 @@
 
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
@@ -719,7 +720,7 @@
 		interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_LOW>;
 		clocks = <&hifsys CLK_HIFSYS_USB1PHY>,
 			 <&topckgen CLK_TOP_ETHIF_SEL>;
-		clock-names = "sys_ck", "free_ck";
+		clock-names = "sys_ck", "ref_ck";
 		power-domains = <&scpsys MT2701_POWER_DOMAIN_HIF>;
 		phys = <&u2port1 PHY_TYPE_USB2>, <&u3port1 PHY_TYPE_USB3>;
 		status = "disabled";
@@ -729,8 +730,6 @@
 		compatible = "mediatek,mt7623-u3phy",
 			     "mediatek,mt2701-u3phy";
 		reg = <0 0x1a244000 0 0x0700>;
-		clocks = <&clk26m>;
-		clock-names = "u3phya_ref";
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
@@ -738,12 +737,16 @@
 
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
@@ -784,16 +787,15 @@
 	};
 
 	crypto: crypto at 1b240000 {
-		compatible = "mediatek,mt7623-crypto";
+		compatible = "mediatek,eip97-crypto";
 		reg = <0 0x1b240000 0 0x20000>;
 		interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_LOW>,
 			     <GIC_SPI 83 IRQ_TYPE_LEVEL_LOW>,
 			     <GIC_SPI 84 IRQ_TYPE_LEVEL_LOW>,
 			     <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>,
 			     <GIC_SPI 97 IRQ_TYPE_LEVEL_LOW>;
-		clocks = <&topckgen CLK_TOP_ETHIF_SEL>,
-			 <&ethsys CLK_ETHSYS_CRYPTO>;
-		clock-names = "ethif","cryp";
+		clocks = <&ethsys CLK_ETHSYS_CRYPTO>;
+		clock-names = "cryp";
 		power-domains = <&scpsys MT2701_POWER_DOMAIN_ETH>;
 		status = "disabled";
 	};
-- 
1.9.1

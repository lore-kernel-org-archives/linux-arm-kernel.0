From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Wed, 26 Apr 2017 17:25:57 +0800
Subject: [PATCH v2 13/30] arm: dts: mt7623: add usb nodes to the mt7623.dtsi
 file
In-Reply-To: <1493198774-4478-1-git-send-email-sean.wang@mediatek.com>
References: <1493198774-4478-1-git-send-email-sean.wang@mediatek.com>
Message-ID: <1493198774-4478-14-git-send-email-sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: John Crispin <john@phrozen.org>

Add USB nodes to the mt7623.dtsi file.

Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm/boot/dts/mt7623.dtsi | 77 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index 1ea9b18..56da5ba 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -377,12 +377,89 @@
 		status = "disabled";
 	};
 
+	usb1: usb at 1a1c0000 {
+		compatible = "mediatek,mt7623-xhci",
+			     "mediatek,mt8173-xhci";
+		reg = <0 0x1a1c0000 0 0x1000>,
+		      <0 0x1a1c4700 0 0x0100>;
+		reg-names = "mac", "ippc";
+		interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&hifsys CLK_HIFSYS_USB0PHY>,
+			 <&topckgen CLK_TOP_ETHIF_SEL>;
+		clock-names = "sys_ck", "free_ck";
+		power-domains = <&scpsys MT2701_POWER_DOMAIN_HIF>;
+		phys = <&u2port0 PHY_TYPE_USB2>, <&u3port0 PHY_TYPE_USB3>;
+		status = "disabled";
+	};
+
+	u3phy1: usb-phy at 1a1c4000 {
+		compatible = "mediatek,mt7623-u3phy", "mediatek,mt2701-u3phy";
+		reg = <0 0x1a1c4000 0 0x0700>;
+		clocks = <&clk26m>;
+		clock-names = "u3phya_ref";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		status = "disabled";
+
+		u2port0: usb-phy at 1a1c4800 {
+			reg = <0 0x1a1c4800 0 0x0100>;
+			#phy-cells = <1>;
+			status = "okay";
+		};
+
+		u3port0: usb-phy at 1a1c4900 {
+			reg = <0 0x1a1c4900 0 0x0700>;
+			#phy-cells = <1>;
+			status = "okay";
+		};
+	};
+
+	usb2: usb at 1a240000 {
+		compatible = "mediatek,mt7623-xhci",
+			     "mediatek,mt8173-xhci";
+		reg = <0 0x1a240000 0 0x1000>,
+		      <0 0x1a244700 0 0x0100>;
+		reg-names = "mac", "ippc";
+		interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&hifsys CLK_HIFSYS_USB1PHY>,
+			 <&topckgen CLK_TOP_ETHIF_SEL>;
+		clock-names = "sys_ck", "free_ck";
+		power-domains = <&scpsys MT2701_POWER_DOMAIN_HIF>;
+		phys = <&u2port1 PHY_TYPE_USB2>, <&u3port1 PHY_TYPE_USB3>;
+		status = "disabled";
+	};
+
+	u3phy2: usb-phy at 1a244000 {
+		compatible = "mediatek,mt7623-u3phy", "mediatek,mt2701-u3phy";
+		reg = <0 0x1a244000 0 0x0700>;
+		clocks = <&clk26m>;
+		clock-names = "u3phya_ref";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		status = "disabled";
+
+		u2port1: usb-phy at 1a244800 {
+			reg = <0 0x1a244800 0 0x0100>;
+			#phy-cells = <1>;
+			status = "okay";
+		};
+
+		u3port1: usb-phy at 1a244900 {
+			reg = <0 0x1a244900 0 0x0700>;
+			#phy-cells = <1>;
+			status = "okay";
+		};
+	};
+
 	hifsys: syscon at 1a000000 {
 		compatible = "mediatek,mt7623-hifsys",
 			     "mediatek,mt2701-hifsys",
 			     "syscon";
 		reg = <0 0x1a000000 0 0x1000>;
 		#clock-cells = <1>;
+		#reset-cells = <1>;
 	};
 
 	ethsys: syscon at 1b000000 {
-- 
1.9.1

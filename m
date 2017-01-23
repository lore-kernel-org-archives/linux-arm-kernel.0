From: john@phrozen.org (John Crispin)
Date: Mon, 23 Jan 2017 12:29:30 +0100
Subject: [PATCH 11/16] arm: dts: add usb nodes to the mt7623.dtsi file
In-Reply-To: <1485170975-51813-1-git-send-email-john@phrozen.org>
References: <1485170975-51813-1-git-send-email-john@phrozen.org>
Message-ID: <1485170975-51813-12-git-send-email-john@phrozen.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add USB nodes to the mt7623.dtsi file.

Signed-off-by: John Crispin <john@phrozen.org>
---
 arch/arm/boot/dts/mt7623.dtsi |   59 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index 791f3b1..540f70c 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -340,6 +340,65 @@
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
+		clock-names = "sys_ck", "ethif";
+		power-domains = <&scpsys MT2701_POWER_DOMAIN_HIF>;
+		phys = <&phy_port0 PHY_TYPE_USB3>;
+		status = "disabled";
+	};
+
+	u3phy1: usb-phy at 1a1c4000 {
+		compatible = "mediatek,mt7623-u3phy",
+			     "mediatek,mt8173-u3phy";
+		reg = <0 0x1a1c4000 0 0x0700>;
+		clocks = <&clk26m>;
+		clock-names = "u3phya_ref";
+		#phy-cells = <1>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		status = "disabled";
+
+		phy_port0: phy_port0: port at 1a1c4800 {
+			reg = <0 0x1a1c4800 0 0x800>;
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
+		interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&hifsys CLK_HIFSYS_USB1PHY>,
+			 <&topckgen CLK_TOP_ETHIF_SEL>;
+		clock-names = "sys_ck", "ethif";
+		power-domains = <&scpsys MT2701_POWER_DOMAIN_HIF>;
+		phys = <&u3phy2 0>;
+		status = "disabled";
+	};
+
+	u3phy2: usb-phy at 1a244000 {
+		compatible = "mediatek,mt7623-u3phy",
+			     "mediatek,mt8173-u3phy";
+		reg = <0 0x1a244000 0 0x0700>,
+		      <0 0x1a244800 0 0x0800>;
+		clocks = <&clk26m>;
+		clock-names = "u3phya_ref";
+		#phy-cells = <1>;
+		status = "disabled";
+	};
+
 	hifsys: syscon at 1a000000 {
 		compatible = "mediatek,mt7623-hifsys",
 			     "mediatek,mt2701-hifsys",
-- 
1.7.10.4

From: john@phrozen.org (John Crispin)
Date: Mon, 23 Jan 2017 12:29:28 +0100
Subject: [PATCH 09/16] arm: dts: add nand nodes to the mt7623.dtsi file
In-Reply-To: <1485170975-51813-1-git-send-email-john@phrozen.org>
References: <1485170975-51813-1-git-send-email-john@phrozen.org>
Message-ID: <1485170975-51813-10-git-send-email-john@phrozen.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add NAND/EEC nodes to the mt7623.dtsi file.

Signed-off-by: John Crispin <john@phrozen.org>
---
 arch/arm/boot/dts/mt7623.dtsi |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index c8f38e1..240f382 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -293,6 +293,31 @@
 		status = "disabled";
 	};
 
+	nandc: nfi at 1100d000 {
+		compatible = "mediatek,mt7623-nfc",
+			     "mediatek,mt2701-nfc";
+		reg = <0 0x1100d000 0 0x1000>;
+		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_LOW>;
+		power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
+		clocks = <&pericfg CLK_PERI_NFI>,
+			 <&pericfg CLK_PERI_NFI_PAD>;
+		clock-names = "nfi_clk", "pad_clk";
+		status = "disabled";
+		ecc-engine = <&bch>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	bch: ecc at 1100e000 {
+		compatible = "mediatek,mt7623-ecc",
+			     "mediatek,mt2701-ecc";
+		reg = <0 0x1100e000 0 0x1000>;
+		interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&pericfg CLK_PERI_NFI_ECC>;
+		clock-names = "nfiecc_clk";
+		status = "disabled";
+	};
+
 	hifsys: syscon at 1a000000 {
 		compatible = "mediatek,mt7623-hifsys",
 			     "mediatek,mt2701-hifsys",
-- 
1.7.10.4

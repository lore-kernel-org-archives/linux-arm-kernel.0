From: john@phrozen.org (John Crispin)
Date: Mon, 23 Jan 2017 12:29:29 +0100
Subject: [PATCH 10/16] arm: dts: add mmc nodes to the mt7623.dtsi file
In-Reply-To: <1485170975-51813-1-git-send-email-john@phrozen.org>
References: <1485170975-51813-1-git-send-email-john@phrozen.org>
Message-ID: <1485170975-51813-11-git-send-email-john@phrozen.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add e/MMC nodes to the mt7623.dtsi file.

Signed-off-by: John Crispin <john@phrozen.org>
---
 arch/arm/boot/dts/mt7623.dtsi |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index 240f382..791f3b1 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -318,6 +318,28 @@
 		status = "disabled";
 	};
 
+	mmc0: mmc at 11230000 {
+		compatible = "mediatek,mt7623-mmc",
+			     "mediatek,mt8135-mmc";
+		reg = <0 0x11230000 0 0x1000>;
+		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&pericfg CLK_PERI_MSDC30_0>,
+			 <&topckgen CLK_TOP_MSDC30_0_SEL>;
+		clock-names = "source", "hclk";
+		status = "disabled";
+	};
+
+	mmc1: mmc at 11240000 {
+		compatible = "mediatek,mt7623-mmc",
+			     "mediatek,mt8135-mmc";
+		reg = <0 0x11240000 0 0x1000>;
+		interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&pericfg CLK_PERI_MSDC30_1>,
+			 <&topckgen CLK_TOP_MSDC30_1_SEL>;
+		clock-names = "source", "hclk";
+		status = "disabled";
+	};
+
 	hifsys: syscon at 1a000000 {
 		compatible = "mediatek,mt7623-hifsys",
 			     "mediatek,mt2701-hifsys",
-- 
1.7.10.4

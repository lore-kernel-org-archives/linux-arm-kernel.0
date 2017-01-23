From: john@phrozen.org (John Crispin)
Date: Mon, 23 Jan 2017 12:29:26 +0100
Subject: [PATCH 07/16] arm: dts: add i2c nodes to the mt7623.dtsi file
In-Reply-To: <1485170975-51813-1-git-send-email-john@phrozen.org>
References: <1485170975-51813-1-git-send-email-john@phrozen.org>
Message-ID: <1485170975-51813-8-git-send-email-john@phrozen.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add I2C nodes to the mt7623.dtsi file.

Signed-off-by: John Crispin <john@phrozen.org>
---
 arch/arm/boot/dts/mt7623.dtsi |   45 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index 6099f05..8ac4569 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -236,6 +236,51 @@
 		status = "disabled";
 	};
 
+	i2c0: i2c at 11007000 {
+		compatible = "mediatek,mt7623-i2c",
+			     "mediatek,mt6577-i2c";
+		reg = <0 0x11007000 0 0x70>,
+		      <0 0x11000200 0 0x80>;
+		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_LOW>;
+		clock-div = <16>;
+		clocks = <&pericfg CLK_PERI_I2C0>,
+			 <&pericfg CLK_PERI_AP_DMA>;
+		clock-names = "main", "dma";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	i2c1: i2c at 11008000 {
+		compatible = "mediatek,mt7623-i2c",
+			     "mediatek,mt6577-i2c";
+		reg = <0 0x11008000 0 0x70>,
+		      <0 0x11000280 0 0x80>;
+		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_LOW>;
+		clock-div = <16>;
+		clocks = <&pericfg CLK_PERI_I2C1>,
+			 <&pericfg CLK_PERI_AP_DMA>;
+		clock-names = "main", "dma";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	i2c2: i2c at 11009000 {
+		compatible = "mediatek,mt7623-i2c",
+			     "mediatek,mt6577-i2c";
+		reg = <0 0x11009000 0 0x70>,
+		      <0 0x11000300 0 0x80>;
+		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_LOW>;
+		clock-div = <16>;
+		clocks = <&pericfg CLK_PERI_I2C2>,
+			 <&pericfg CLK_PERI_AP_DMA>;
+		clock-names = "main", "dma";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	hifsys: syscon at 1a000000 {
 		compatible = "mediatek,mt7623-hifsys",
 			     "mediatek,mt2701-hifsys",
-- 
1.7.10.4

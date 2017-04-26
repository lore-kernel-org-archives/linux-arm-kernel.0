From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Wed, 26 Apr 2017 17:25:53 +0800
Subject: [PATCH v2 09/30] arm: dts: mt7623: add i2c nodes to the mt7623.dtsi
 file
In-Reply-To: <1493198774-4478-1-git-send-email-sean.wang@mediatek.com>
References: <1493198774-4478-1-git-send-email-sean.wang@mediatek.com>
Message-ID: <1493198774-4478-10-git-send-email-sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: John Crispin <john@phrozen.org>

Add I2C nodes to the mt7623.dtsi file.

Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm/boot/dts/mt7623.dtsi | 45 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index 6adc21d..adb4793 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -243,6 +243,51 @@
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
1.9.1

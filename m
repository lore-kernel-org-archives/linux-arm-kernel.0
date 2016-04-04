From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Apr 2016 10:23:15 +0900
Subject: [PATCH 43/47] ARM: dts: r8a7794: Add IIC nodes
In-Reply-To: <cover.1459732726.git.horms+renesas@verge.net.au>
References: <cover.1459732726.git.horms+renesas@verge.net.au>
Message-ID: <9ad60d7fe899cdc7759dc8af97a6bb401872a125.1459732726.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add IIC nodes to r8a7794 device tree.

Based on similar work for the r8a7793 by Laurent Pinchart.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7794.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 78e0b8186e4a..93a6293fa982 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -26,6 +26,8 @@
 		i2c3 = &i2c3;
 		i2c4 = &i2c4;
 		i2c5 = &i2c5;
+		i2c6 = &i2c6;
+		i2c7 = &i2c7;
 		spi0 = &qspi;
 		vin0 = &vin0;
 		vin1 = &vin1;
@@ -647,6 +649,32 @@
 		status = "disabled";
 	};
 
+	i2c6: i2c at e6500000 {
+		compatible = "renesas,iic-r8a7794", "renesas,rmobile-iic";
+		reg = <0 0xe6500000 0 0x425>;
+		interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7794_CLK_IIC0>;
+		dmas = <&dmac0 0x61>, <&dmac0 0x62>;
+		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	i2c7: i2c at e6510000 {
+		compatible = "renesas,iic-r8a7794", "renesas,rmobile-iic";
+		reg = <0 0xe6510000 0 0x425>;
+		interrupts = <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7794_CLK_IIC1>;
+		dmas = <&dmac0 0x65>, <&dmac0 0x66>;
+		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	mmcif0: mmc at ee200000 {
 		compatible = "renesas,mmcif-r8a7794", "renesas,sh-mmcif";
 		reg = <0 0xee200000 0 0x80>;
-- 
2.1.4

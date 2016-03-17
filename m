From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Mar 2016 16:35:17 +0900
Subject: [PATCH 2/2] ARM: dts: r8a7794: Add IIC nodes
In-Reply-To: <1458199991-19391-1-git-send-email-horms+renesas@verge.net.au>
References: <1458199991-19391-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1458200117-19693-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add IIC nodes to r8a7794 device tree.

Based on similar work for the r8a7793 by Laurent Pinchart.

CC: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 755d85715c4a..3188d2671123 100644
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

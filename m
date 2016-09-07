From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Sep 2016 09:50:11 +0200
Subject: [PATCH 24/26] ARM: dts: r8a7792: add QSPI support
In-Reply-To: <cover.1473234371.git.horms+renesas@verge.net.au>
References: <cover.1473234371.git.horms+renesas@verge.net.au>
Message-ID: <c9acea6efdd7b08bf80a3721a44970252935621b.1473234372.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Define the generic R8A7792 part of the QSPI device node.

Based  on the original (and large) patch by Vladimir Barinov
<vladimir.barinov@cogentembedded.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7792.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7792.dtsi b/arch/arm/boot/dts/r8a7792.dtsi
index 6ff3e365d56a..713141d38b3e 100644
--- a/arch/arm/boot/dts/r8a7792.dtsi
+++ b/arch/arm/boot/dts/r8a7792.dtsi
@@ -25,6 +25,7 @@
 		i2c3 = &i2c3;
 		i2c4 = &i2c4;
 		i2c5 = &i2c5;
+		spi0 = &qspi;
 		vin0 = &vin0;
 		vin1 = &vin1;
 		vin2 = &vin2;
@@ -556,6 +557,21 @@
 			status = "disabled";
 		};
 
+		qspi: spi at e6b10000 {
+			compatible = "renesas,qspi-r8a7792", "renesas,qspi";
+			reg = <0 0xe6b10000 0 0x2c>;
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A7792_CLK_QSPI_MOD>;
+			dmas = <&dmac0 0x17>, <&dmac0 0x18>,
+			       <&dmac1 0x17>, <&dmac1 0x18>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			num-cs = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		du: display at feb00000 {
 			compatible = "renesas,du-r8a7792";
 			reg = <0 0xfeb00000 0 0x40000>;
-- 
2.7.0.rc3.207.g0ac5344

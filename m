From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 20 Aug 2014 09:24:01 +0900
Subject: [PATCH 10/12] ARM: shmobile: r8a7790 dtsi: Enable DMA for MSIOF
In-Reply-To: <cover.1408492753.git.horms+renesas@verge.net.au>
References: <cover.1408492753.git.horms+renesas@verge.net.au>
Message-ID: <fbff66886b9c5f657b6649a264551ac572fae0b7.1408492753.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add register sets used for access by the DMA engine, and DMA properties to
the MSIOF nodes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 6dc328d..60f8551 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -956,9 +956,11 @@
 
 	msiof0: spi at e6e20000 {
 		compatible = "renesas,msiof-r8a7790";
-		reg = <0 0xe6e20000 0 0x0064>;
+		reg = <0 0xe6e20000 0 0x0064>, <0 0xe7e20000 0 0x0064>;
 		interrupts = <0 156 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7790_CLK_MSIOF0>;
+		dmas = <&dmac0 0x51>, <&dmac0 0x52>;
+		dma-names = "tx", "rx";
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -966,9 +968,11 @@
 
 	msiof1: spi at e6e10000 {
 		compatible = "renesas,msiof-r8a7790";
-		reg = <0 0xe6e10000 0 0x0064>;
+		reg = <0 0xe6e10000 0 0x0064>, <0 0xe7e10000 0 0x0064>;
 		interrupts = <0 157 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_MSIOF1>;
+		dmas = <&dmac0 0x55>, <&dmac0 0x56>;
+		dma-names = "tx", "rx";
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -976,9 +980,11 @@
 
 	msiof2: spi at e6e00000 {
 		compatible = "renesas,msiof-r8a7790";
-		reg = <0 0xe6e00000 0 0x0064>;
+		reg = <0 0xe6e00000 0 0x0064>, <0 0xe7e00000 0 0x0064>;
 		interrupts = <0 158 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_MSIOF2>;
+		dmas = <&dmac0 0x41>, <&dmac0 0x42>;
+		dma-names = "tx", "rx";
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -986,9 +992,11 @@
 
 	msiof3: spi at e6c90000 {
 		compatible = "renesas,msiof-r8a7790";
-		reg = <0 0xe6c90000 0 0x0064>;
+		reg = <0 0xe6c90000 0 0x0064>, <0 0xe7c90000 0 0x0064>;
 		interrupts = <0 159 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_MSIOF3>;
+		dmas = <&dmac0 0x45>, <&dmac0 0x46>;
+		dma-names = "tx", "rx";
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
-- 
2.0.1

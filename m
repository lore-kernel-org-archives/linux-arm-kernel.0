From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 18 Oct 2013 11:05:34 +0200
Subject: [PATCH 5/5] ARM: ux500: register all SSP and SPI blocks
Message-ID: <1382087134-31740-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the SSP and SPI blocks to the device tree and makes
them active. Only this way can their clocks be properly gated
off at boot.

Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi | 75 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index b7d1738..9edc392 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -704,7 +704,80 @@
 			interrupts = <0 14 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			status = "disabled";
+			clocks = <&prcc_kclk 3 1>, <&prcc_pclk 3 1>;
+			clock-names = "ssp0clk", "apb_pclk";
+			dmas = <&dma 8 0 0x2>, /* Logical - DevToMem */
+			       <&dma 8 0 0x0>; /* Logical - MemToDev */
+			dma-names = "rx", "tx";
+		};
+
+		ssp at 80003000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0x80003000 0x1000>;
+			interrupts = <0 52 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&prcc_kclk 3 2>, <&prcc_pclk 3 2>;
+			clock-names = "ssp1clk", "apb_pclk";
+			dmas = <&dma 9 0 0x2>, /* Logical - DevToMem */
+			       <&dma 9 0 0x0>; /* Logical - MemToDev */
+			dma-names = "rx", "tx";
+		};
+
+		spi at 8011a000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0x8011a000 0x1000>;
+			interrupts = <0 8 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			/* Same clock wired to kernel and pclk */
+			clocks = <&prcc_pclk 2 8>, <&prcc_pclk 2 8>;
+			clock-names = "spi0clk", "apb_pclk";
+			dmas = <&dma 0 0 0x2>, /* Logical - DevToMem */
+			       <&dma 0 0 0x0>; /* Logical - MemToDev */
+			dma-names = "rx", "tx";
+		};
+
+		spi at 80112000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0x80112000 0x1000>;
+			interrupts = <0 96 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			/* Same clock wired to kernel and pclk */
+			clocks = <&prcc_pclk 2 2>, <&prcc_pclk 2 2>;
+			clock-names = "spi1clk", "apb_pclk";
+			dmas = <&dma 35 0 0x2>, /* Logical - DevToMem */
+			       <&dma 35 0 0x0>; /* Logical - MemToDev */
+			dma-names = "rx", "tx";
+		};
+
+		spi at 80111000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0x80111000 0x1000>;
+			interrupts = <0 6 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			/* Same clock wired to kernel and pclk */
+			clocks = <&prcc_pclk 2 1>, <&prcc_pclk 2 1>;
+			clock-names = "spi2clk", "apb_pclk";
+			dmas = <&dma 33 0 0x2>, /* Logical - DevToMem */
+			       <&dma 33 0 0x0>; /* Logical - MemToDev */
+			dma-names = "rx", "tx";
+		};
+
+		spi at 80129000 {
+			compatible = "arm,pl022", "arm,primecell";
+			reg = <0x80129000 0x1000>;
+			interrupts = <0 49 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			/* Same clock wired to kernel and pclk */
+			clocks = <&prcc_pclk 1 7>, <&prcc_pclk 1 7>;
+			clock-names = "spi3clk", "apb_pclk";
+			dmas = <&dma 40 0 0x2>, /* Logical - DevToMem */
+			       <&dma 40 0 0x0>; /* Logical - MemToDev */
+			dma-names = "rx", "tx";
 		};
 
 		uart at 80120000 {
-- 
1.8.3.1

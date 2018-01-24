From: codekipper@gmail.com (codekipper at gmail.com)
Date: Wed, 24 Jan 2018 11:39:43 +0100
Subject: [linux-sunxi][PATCH 5/5] arm64: allwinner: a64: Add DAI nodes
In-Reply-To: <20180124103943.2062-1-codekipper@gmail.com>
References: <20180124103943.2062-1-codekipper@gmail.com>
Message-ID: <20180124103943.2062-6-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Add the DAI blocks to the device tree. I2S0 and I2S1 are for
connecting to an external codec.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index f060a58f374c..f3354f8c2026 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -419,6 +419,32 @@
 			status = "disabled";
 		};
 
+		i2s0: i2s at 1c22000 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun8i-h3-i2s";
+			reg = <0x01c22000 0x400>;
+			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2S0>, <&ccu CLK_I2S0>;
+			clock-names = "apb", "mod";
+			resets = <&ccu RST_BUS_I2S0>;
+			dma-names = "rx", "tx";
+			dmas = <&dma 3>, <&dma 3>;
+			status = "disabled";
+		};
+
+		i2s1: i2s at 1c22400 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun8i-h3-i2s";
+			reg = <0x01c22400 0x400>;
+			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2S1>, <&ccu CLK_I2S1>;
+			clock-names = "apb", "mod";
+			resets = <&ccu RST_BUS_I2S1>;
+			dma-names = "rx", "tx";
+			dmas = <&dma 4>, <&dma 4>;
+			status = "disabled";
+		};
+
 		uart0: serial at 1c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
-- 
2.16.0

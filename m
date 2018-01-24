From: codekipper@gmail.com (codekipper at gmail.com)
Date: Wed, 24 Jan 2018 11:39:39 +0100
Subject: [linux-sunxi][PATCH 1/5] arm64: allwinner: a64: Add the SPDIF block
In-Reply-To: <20180124103943.2062-1-codekipper@gmail.com>
References: <20180124103943.2062-1-codekipper@gmail.com>
Message-ID: <20180124103943.2062-2-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Add the SPDIF transceiver controller block to the A64 dtsi.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index d783d164b9c3..c82979038b0b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -382,6 +382,19 @@
 			};
 		};
 
+		spdif: spdif at 1c21000 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun8i-h3-spdif";
+			reg = <0x01c21000 0x400>;
+			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_SPDIF>, <&ccu CLK_SPDIF>;
+			resets = <&ccu RST_BUS_SPDIF>;
+			clock-names = "apb", "spdif";
+			dmas = <&dma 2>;
+			dma-names = "tx";
+			status = "disabled";
+		};
+
 		uart0: serial at 1c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
-- 
2.16.0

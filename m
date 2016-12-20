From: codekipper@gmail.com (codekipper at gmail.com)
Date: Tue, 20 Dec 2016 11:40:37 +0100
Subject: [linux-sunxi][PATCH 2/3] ARM: dts: sun6i: Add the SPDIF block to the
 A31
In-Reply-To: <20161220104038.22532-1-codekipper@gmail.com>
References: <20161220104038.22532-1-codekipper@gmail.com>
Message-ID: <20161220104038.22532-3-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Add the SPDIF transceiver controller block to the A31 dtsi.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 7370ba6c9993..559c53efa7e6 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -613,6 +613,20 @@
 			reg = <0x01c20ca0 0x20>;
 		};
 
+		spdif: spdif at 01c21000 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun6i-a31-spdif";
+			reg = <0x01c21000 0x400>;
+			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_APB1_SPDIF>, <&ccu CLK_SPDIF>;
+			resets = <&ccu RST_APB1_SPDIF>;
+			clock-names = "apb", "spdif";
+			dmas = <&dma 2>, <&dma 2>;
+			dma-names = "rx", "tx";
+			spdif-out = "disabled";
+			status = "disabled";
+		};
+
 		lradc: lradc at 01c22800 {
 			compatible = "allwinner,sun4i-a10-lradc-keys";
 			reg = <0x01c22800 0x100>;
-- 
2.11.0

From: codekipper@gmail.com (codekipper at gmail.com)
Date: Mon, 21 Mar 2016 21:01:03 +0100
Subject: [linux-sunxi][PATCH v3 5/8] ARM: dts: sun4i: Add the SPDIF block to
 the A10
In-Reply-To: <1458590466-12572-1-git-send-email-codekipper@gmail.com>
References: <1458590466-12572-1-git-send-email-codekipper@gmail.com>
Message-ID: <1458590466-12572-6-git-send-email-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Add the SPDIF transceiver controller block to the A10 dtsi.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 5747522..7171a27 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -1052,6 +1052,19 @@
 			status = "disabled";
 		};
 
+		spdif: spdif at 01c21000 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun4i-a10-spdif";
+			reg = <0x01c21000 0x400>;
+			interrupts = <13>;
+			clocks = <&apb0_gates 1>, <&spdif_clk>;
+			clock-names = "apb", "spdif";
+			dmas = <&dma SUN4I_DMA_NORMAL 2>,
+			       <&dma SUN4I_DMA_NORMAL 2>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
 		ir0: ir at 01c21800 {
 			compatible = "allwinner,sun4i-a10-ir";
 			clocks = <&apb0_gates 6>, <&ir0_clk>;
-- 
2.7.4

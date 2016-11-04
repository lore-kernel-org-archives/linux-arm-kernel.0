From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  4 Nov 2016 10:44:07 +0100
Subject: [PATCH 12/12] arm64: renesas: r8a7796: add SYS-DMAC controller nodes
In-Reply-To: <cover.1478251192.git.horms+renesas@verge.net.au>
References: <cover.1478251192.git.horms+renesas@verge.net.au>
Message-ID: <935085209343a0c507e3d9a3e01883b25c8f743e.1478251192.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 99 ++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index 6ec988c78ff8..f9cb7796ad49 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -252,6 +252,105 @@
 			status = "disabled";
 		};
 
+		dmac0: dma-controller at e6700000 {
+			compatible = "renesas,dmac-r8a7796",
+				     "renesas,rcar-dmac";
+			reg = <0 0xe6700000 0 0x10000>;
+			interrupts = <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error",
+					"ch0", "ch1", "ch2", "ch3",
+					"ch4", "ch5", "ch6", "ch7",
+					"ch8", "ch9", "ch10", "ch11",
+					"ch12", "ch13", "ch14", "ch15";
+			clocks = <&cpg CPG_MOD 219>;
+			clock-names = "fck";
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			#dma-cells = <1>;
+			dma-channels = <16>;
+		};
+
+		dmac1: dma-controller at e7300000 {
+			compatible = "renesas,dmac-r8a7796",
+				     "renesas,rcar-dmac";
+			reg = <0 0xe7300000 0 0x10000>;
+			interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error",
+					"ch0", "ch1", "ch2", "ch3",
+					"ch4", "ch5", "ch6", "ch7",
+					"ch8", "ch9", "ch10", "ch11",
+					"ch12", "ch13", "ch14", "ch15";
+			clocks = <&cpg CPG_MOD 218>;
+			clock-names = "fck";
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			#dma-cells = <1>;
+			dma-channels = <16>;
+		};
+
+		dmac2: dma-controller at e7310000 {
+			compatible = "renesas,dmac-r8a7796",
+				     "renesas,rcar-dmac";
+			reg = <0 0xe7310000 0 0x10000>;
+			interrupts = <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 427 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 428 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 429 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 430 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 431 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error",
+					"ch0", "ch1", "ch2", "ch3",
+					"ch4", "ch5", "ch6", "ch7",
+					"ch8", "ch9", "ch10", "ch11",
+					"ch12", "ch13", "ch14", "ch15";
+			clocks = <&cpg CPG_MOD 217>;
+			clock-names = "fck";
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			#dma-cells = <1>;
+			dma-channels = <16>;
+		};
+
 		sdhi0: sd at ee100000 {
 			compatible = "renesas,sdhi-r8a7796";
 			reg = <0 0xee100000 0 0x2000>;
-- 
2.7.0.rc3.207.g0ac5344

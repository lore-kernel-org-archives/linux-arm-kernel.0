From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 2 Feb 2018 21:36:16 +0300
Subject: [PATCH 06/11] arm64: dts: renesas: r8a77980: add SYS-DMAC support
In-Reply-To: <46fca582-220d-e5a7-62cd-2fc77a29846b@cogentembedded.com>
References: <46fca582-220d-e5a7-62cd-2fc77a29846b@cogentembedded.com>
Message-ID: <70132f3d-0f37-ae7e-a44b-d65920620936@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe SYS-DMAC1/2 in the R8A77980 device tree.

Based on the original (and large) patch by Vladimir Barinov.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm64/boot/dts/renesas/r8a77980.dtsi |   68 ++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

Index: renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a77980.dtsi
+++ renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
@@ -85,6 +85,74 @@
 			#power-domain-cells = <1>;
 		};
 
+		dmac1: dma-controller at e7300000 {
+			compatible = "renesas,dmac-r8a77980",
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
+				      GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error",
+					  "ch0", "ch1", "ch2", "ch3",
+					  "ch4", "ch5", "ch6", "ch7",
+					  "ch8", "ch9", "ch10", "ch11",
+					  "ch12", "ch13", "ch14", "ch15";
+			clocks = <&cpg CPG_MOD 218>;
+			clock-names = "fck";
+			power-domains = <&sysc 32>;
+			resets = <&cpg 218>;
+			#dma-cells = <1>;
+			dma-channels = <16>;
+		};
+
+		dmac2: dma-controller at e7310000 {
+			compatible = "renesas,dmac-r8a77980",
+				     "renesas,rcar-dmac";
+			reg = <0 0xe7310000 0 0x10000>;
+			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 362 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 363 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 364 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 366 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 367 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 368 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error",
+					  "ch0", "ch1", "ch2", "ch3",
+					  "ch4", "ch5", "ch6", "ch7",
+					  "ch8", "ch9", "ch10", "ch11",
+					  "ch12", "ch13", "ch14", "ch15";
+			clocks = <&cpg CPG_MOD 217>;
+			clock-names = "fck";
+			power-domains = <&sysc 32>;
+			resets = <&cpg 217>;
+			#dma-cells = <1>;
+			dma-channels = <16>;
+		};
+
 		gic: interrupt-controller at f1010000 {
 			compatible = "arm,gic-400";
 			#interrupt-cells = <3>;

From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 12 May 2016 23:47:31 +0300
Subject: [PATCH v3 4/6] ARM: dts: r8a7794: add Audio-DMAC support
In-Reply-To: <2378837.cigT3tNQPe@wasted.cogentembedded.com>
References: <2378837.cigT3tNQPe@wasted.cogentembedded.com>
Message-ID: <25671875.9c5xSSzmjj@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe Audio-DMAC in the R8A7794 device tree.

This patch is loosely based on the commit 8994fff67761 ("ARM: shmobile:
r8a7791: Add Audio DMAC devices to DT").

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 3:
- refreshed the patch.

 arch/arm/boot/dts/r8a7794.dtsi |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7794.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7794.dtsi
+++ renesas/arch/arm/boot/dts/r8a7794.dtsi
@@ -295,6 +295,34 @@
 		dma-channels = <15>;
 	};
 
+	audma0: dma-controller at ec700000 {
+		compatible = "renesas,dmac-r8a7794", "renesas,rcar-dmac";
+		reg = <0 0xec700000 0 0x10000>;
+		interrupts =	<GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "error",
+				  "ch0", "ch1", "ch2", "ch3", "ch4", "ch5",
+				  "ch6", "ch7", "ch8", "ch9", "ch10", "ch11",
+				  "ch12";
+		clocks = <&mstp5_clks R8A7794_CLK_AUDIO_DMAC0>;
+		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
+		#dma-cells = <1>;
+		dma-channels = <13>;
+	};
+
 	scifa0: serial at e6c40000 {
 		compatible = "renesas,scifa-r8a7794",
 			     "renesas,rcar-gen2-scifa", "renesas,scifa";

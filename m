From: r.sricharan@ti.com (Sricharan R)
Date: Mon, 11 Nov 2013 21:36:16 +0530
Subject: [PATCH V2 2/2] ARM: dts: doc: Document missing binding for ti-sdma
 controller
In-Reply-To: <1384185976-17822-1-git-send-email-r.sricharan@ti.com>
References: <1384185976-17822-1-git-send-email-r.sricharan@ti.com>
Message-ID: <1384185976-17822-2-git-send-email-r.sricharan@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The binding and support for system DMA module present in OMAP2+ Socs
and DRA7 with dma-engine is already present. So adding the missing
documentation for the same.

Signed-off-by: Sricharan R <r.sricharan@ti.com>
---
[V2] Fixed comments from Rob Herring <robherring2@gmail.com>

 Documentation/devicetree/bindings/dma/ti-sdma.txt |   28 +++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/ti-sdma.txt

diff --git a/Documentation/devicetree/bindings/dma/ti-sdma.txt b/Documentation/devicetree/bindings/dma/ti-sdma.txt
new file mode 100644
index 0000000..2e0a6d8
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/ti-sdma.txt
@@ -0,0 +1,28 @@
+TI SDMA
+
+Required Properties:
+- compatible :	Should be "ti,omap2420-sdma", "ti,omap2430-sdma" for OMAP2
+		Should be "ti,omap3430-sdma", "ti,omap3630-sdma" for OMAP3
+		Should be "ti,omap4430-sdma" for OMAP4, OMAP5 and DRA7
+- reg: Memory map for accessing module
+- interrupts: Interrupt request number from the DMA controller to
+	      interrupt controller
+- #dma-cells: Should be set to <1>
+- #dma-channels: Total number of logical DMA channels supported by the
+		controller
+- #dma-requests: Total number of DMA request signals supported by the
+		controller
+
+Example:
+
+sdma: dma-controller at 48056000 {
+	compatible = "ti,omap4430-sdma";
+	reg = <0x48056000 0x1000>;
+	interrupts = <12>,
+		     <13>,
+		     <14>,
+		     <15>;
+	#dma-cells = <1>;
+	#dma-channels = <32>;
+	#dma-requests = <64>;
+};
-- 
1.7.9.5

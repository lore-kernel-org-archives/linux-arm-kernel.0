From: yao.yuan@freescale.com (Yuan Yao)
Date: Fri, 23 Oct 2015 09:59:12 +0800
Subject: [PATCH v2 2/3] dma: Binding for freescale qDMA engine driver support
In-Reply-To: <1445565553-1141-1-git-send-email-yao.yuan@freescale.com>
References: <1445565553-1141-1-git-send-email-yao.yuan@freescale.com>
Message-ID: <1445565553-1141-2-git-send-email-yao.yuan@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Binding document for Freescale Queue Direct Memory Access(qDMA)
controller.
This module can be found on LS-1 and LS-2 SoCs.

Signed-off-by: Yuan Yao <yao.yuan@freescale.com>
---
 Documentation/devicetree/bindings/dma/fsl-qdma.txt | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/fsl-qdma.txt

diff --git a/Documentation/devicetree/bindings/dma/fsl-qdma.txt b/Documentation/devicetree/bindings/dma/fsl-qdma.txt
new file mode 100644
index 0000000..cdae71c
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/fsl-qdma.txt
@@ -0,0 +1,43 @@
+* Freescale queue Direct Memory Access Controller(qDMA) Controller
+
+  The qDMA controller transfers blocks of data between one source and one or more
+destinations. The blocks of data transferred can be represented in memory as contiguous
+or non-contiguous using scatter/gather table(s). Channel virtualization is supported
+through enqueuing of DMA jobs to, or dequeuing DMA jobs from, different work
+queues.
+  Legacy mode is primarily included for software requiring the earlier
+QorIQ DMA programming model. This mode provides a simple programming
+model not utilizing the datapath architecture. In legacy mode, DMA
+operations are directly configured through a set of architectural
+registers per channel.
+
+* qDMA Controller
+Required properties:
+- compatible :
+	- "fsl,ls1021a-qdma" for qDMA used similar to that on LS SoC
+- reg : Specifies base physical address(s) and size of the qDMA registers.
+	The region is qDMA control register's address and size.
+- interrupts : A list of interrupt-specifiers, one for each entry in
+	interrupt-names.
+- interrupt-names : Should contain:
+	"qdma-tx" - the  interrupt
+	"qdma-err" - the error interrupt
+- channels : Number of channels supported by the controller
+
+Optional properties:
+- big-endian: If present registers and hardware scatter/gather descriptors
+	of the qDMA are implemented in big endian mode, otherwise in little
+	mode.
+
+
+Examples:
+
+	qdma: qdma at 8390000 {
+		compatible = "fsl,ls1021a-qdma";
+		reg = <0x0 0x8380000 0x0 0x20000>;
+		interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "qdma-tx", "qdma-err";
+		big-endian;
+		channels = <1>;
+	};
-- 
2.1.0.27.g96db324

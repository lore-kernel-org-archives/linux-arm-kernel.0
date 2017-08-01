From: jiaheng.fan@nxp.com (jiaheng.fan)
Date: Tue, 1 Aug 2017 09:47:19 +0800
Subject: [PATCH v1 1/6] dma: fsl-dma: add devicetree documentation for qdma
 driver.
Message-ID: <1501552044-6081-2-git-send-email-jiaheng.fan@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

signed-off-by: jiaheng.fan <jiaheng.fan@nxp.com>
---
 Documentation/devicetree/bindings/dma/fsl-qdma.txt | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/fsl-qdma.txt

diff --git a/Documentation/devicetree/bindings/dma/fsl-qdma.txt b/Documentation/devicetree/bindings/dma/fsl-qdma.txt
new file mode 100644
index 0000000..b076177
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/fsl-qdma.txt
@@ -0,0 +1,42 @@
+* Freescale queue Direct Memory Access Controller(qDMA) Controller
+
+  The qDMA controller transfers blocks of data between one source and one or more
+destinations. The blocks of data transferred can be represented in memory as contiguous
+or non-contiguous using scatter/gather table(s). Channel virtualization is supported
+through enqueuing of DMA jobs to, or dequeuing DMA jobs from, different work
+queues.
+
+* qDMA Controller
+Required properties:
+- compatible :
+	- "fsl,ls1021a-qdma",
+	Or "fsl,ls1043a-qdma" followed by "fsl,ls1021a-qdma",
+- reg : Specifies base physical address(s) and size of the qDMA registers.
+	The region is qDMA control register's address and size.
+- interrupts : A list of interrupt-specifiers, one for each entry in
+	interrupt-names.
+- interrupt-names : Should contain:
+	"qdma-error" - the error interrupt
+	"qdma-queue" - the queue interrupt
+- channels : Number of channels supported by the controller
+- queues : Number of queues supported by driver
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
+		reg = <0x0 0x8398000 0x0 0x2000 /* Controller registers */
+		       0x0 0x839a000 0x0 0x2000>; /* Block registers */
+		interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "qdma-error", "qdma-queue";
+		channels = <8>;
+		queues = <2>;
+		big-endian;
+	};
-- 
2.7.4

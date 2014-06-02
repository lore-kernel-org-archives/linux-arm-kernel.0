From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon,  2 Jun 2014 15:42:08 +0200
Subject: [PATCH v2 4/7] ARM: shmobile: r8a7791: Add SYS-DMAC channel
 definitions for bindings
In-Reply-To: <1401716531-29794-1-git-send-email-geert+renesas@glider.be>
References: <1401716531-29794-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1401716531-29794-5-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add channel resource identifiers for the SYS DMA controller.

Cfr. the r8a7790 version by Ben Dooks.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes

I don't like the CHCR_[RT]X_*BIT definitions

 include/dt-bindings/dma/r8a7791-dma.h | 111 ++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)
 create mode 100644 include/dt-bindings/dma/r8a7791-dma.h

diff --git a/include/dt-bindings/dma/r8a7791-dma.h b/include/dt-bindings/dma/r8a7791-dma.h
new file mode 100644
index 000000000000..6fec881d5d46
--- /dev/null
+++ b/include/dt-bindings/dma/r8a7791-dma.h
@@ -0,0 +1,111 @@
+/*
+ * R8A7791 System DMA channel resource identifiers
+ */
+
+#ifndef __DT_BINDINGS_DMA_R8A7791_DMA_H__
+#define __DT_BINDINGS_DMA_R8A7791_DMA_H__
+
+#include <dt-bindings/dma/shdma.h>
+
+/* System DMAC */
+
+#define R8A7791_DMA_SCIFA0_TX	(0x21)
+#define R8A7791_DMA_SCIFA0_RX	(0x22)
+#define R8A7791_DMA_SCIFA1_TX	(0x25)
+#define R8A7791_DMA_SCIFA1_RX	(0x26)
+#define R8A7791_DMA_SCIFA2_TX	(0x27)
+#define R8A7791_DMA_SCIFA2_RX	(0x28)
+#define R8A7791_DMA_SCIFA3_TX	(0x1B)
+#define R8A7791_DMA_SCIFA3_RX	(0x1C)
+#define R8A7791_DMA_SCIFA4_TX	(0x1F)
+#define R8A7791_DMA_SCIFA4_RX	(0x20)
+#define R8A7791_DMA_SCIFA5_TX	(0x23)
+#define R8A7791_DMA_SCIFA5_RX	(0x24)
+
+#define R8A7791_DMA_SCIFB0_TX	(0x3D)
+#define R8A7791_DMA_SCIFB0_RX	(0x3E)
+#define R8A7791_DMA_SCIFB1_TX	(0x19)
+#define R8A7791_DMA_SCIFB1_RX	(0x1A)
+#define R8A7791_DMA_SCIFB2_TX	(0x1D)
+#define R8A7791_DMA_SCIFB2_RX	(0x1E)
+
+#define R8A7791_DMA_HSCIF0_TX	(0x39)
+#define R8A7791_DMA_HSCIF0_RX	(0x3A)
+#define R8A7791_DMA_HSCIF1_TX	(0x4D)
+#define R8A7791_DMA_HSCIF1_RX	(0x4E)
+#define R8A7791_DMA_HSCIF2_TX	(0x3B)
+#define R8A7791_DMA_HSCIF2_RX	(0x3C)
+
+#define R8A7791_DMA_SCIF0_TX	(0x29)
+#define R8A7791_DMA_SCIF0_RX	(0x2A)
+#define R8A7791_DMA_SCIF1_TX	(0x2D)
+#define R8A7791_DMA_SCIF1_RX	(0x2E)
+#define R8A7791_DMA_SCIF2_TX	(0x2B)
+#define R8A7791_DMA_SCIF2_RX	(0x2C)
+#define R8A7791_DMA_SCIF3_TX	(0x2F)
+#define R8A7791_DMA_SCIF3_RX	(0x30)
+#define R8A7791_DMA_SCIF4_TX	(0xFB)
+#define R8A7791_DMA_SCIF4_RX	(0xFC)
+#define R8A7791_DMA_SCIF5_TX	(0xFD)
+#define R8A7791_DMA_SCIF5_RX	(0xFE)
+
+#define R8A7791_DMA_MSIOF0_TX	(0x51)
+#define R8A7791_DMA_MSIOF0_RX	(0x52)
+#define R8A7791_DMA_MSIOF1_TX	(0x55)
+#define R8A7791_DMA_MSIOF1_RX	(0x56)
+#define R8A7791_DMA_MSIOF2_TX	(0x41)
+#define R8A7791_DMA_MSIOF2_RX	(0x42)
+
+#define R8A7791_DMA_QSPI_TX	(0x17)
+#define R8A7791_DMA_QSPI_RX	(0x18)
+
+#define R8A7791_DMA_SIM_TX	(0xA1)
+#define R8A7791_DMA_SIM_RX	(0xA2)
+
+#define R8A7791_DMA_IIC0_TX	(0x61)
+#define R8A7791_DMA_IIC0_RX	(0x62)
+#define R8A7791_DMA_IIC1_TX	(0x65)
+#define R8A7791_DMA_IIC1_RX	(0x66)
+#define R8A7791_DMA_IICDVFS_TX	(0x77)
+#define R8A7791_DMA_IICDVFS_RX	(0x78)
+
+#define R8A7791_DMA_SDHI0_TX	(0xCD)
+#define R8A7791_DMA_SDHI0_RX	(0xCE)
+#define R8A7791_DMA_SDHI2_TX	(0xC1)
+#define R8A7791_DMA_SDHI2_RX	(0xC2)
+#define R8A7791_DMA_SDHI2C2_TX	(0xC5)
+#define R8A7791_DMA_SDHI2C2_RX	(0xC6)
+#define R8A7791_DMA_SDHI3_TX	(0xD3)
+#define R8A7791_DMA_SDHI3_RX	(0xD4)
+#define R8A7791_DMA_SDHI3C2_TX	(0xDF)
+#define R8A7791_DMA_SDHI3C2_RX	(0xDE)
+
+#define R8A7791_DMA_TPU0	(0xF1)
+#define R8A7791_DMA_TSIF0	(0xEA)
+#define R8A7791_DMA_TSIF1	(0xF0)
+
+#define R8A7791_DMA_AXISTATR	(0xA6)
+#define R8A7791_DMA_AXISTATS0	(0xAC)
+#define R8A7791_DMA_AXISTATS1	(0xAA)
+#define R8A7791_DMA_AXISTATS2	(0xA8)
+#define R8A7791_DMA_AXISTATS3C	(0xA4)
+
+#define R8A7791_DMA_MMCIF0_TX	(0xD1)
+#define R8A7791_DMA_MMCIF0_RX	(0xD2)
+
+#define R8A7791_DMA_AXSTM	(0xAE)
+
+
+/* Misc */
+
+// FIXME
+#define CHCR_RX_8BIT	SHDMA_ARM_CHCR_RX(SHDMA_ARM_SZ_8BIT)
+#define CHCR_TX_8BIT	SHDMA_ARM_CHCR_TX(SHDMA_ARM_SZ_8BIT)
+#define CHCR_RX_16BIT	SHDMA_ARM_CHCR_RX(SHDMA_ARM_SZ_16BIT)
+#define CHCR_TX_16BIT	SHDMA_ARM_CHCR_TX(SHDMA_ARM_SZ_16BIT)
+#define CHCR_RX_32BIT	SHDMA_ARM_CHCR_RX(SHDMA_ARM_SZ_32BIT)
+#define CHCR_TX_32BIT	SHDMA_ARM_CHCR_TX(SHDMA_ARM_SZ_32BIT)
+#define CHCR_RX_256BIT	SHDMA_ARM_CHCR_RX(SHDMA_ARM_SZ_256BIT)
+#define CHCR_TX_256BIT	SHDMA_ARM_CHCR_TX(SHDMA_ARM_SZ_256BIT)
+
+#endif /* __DT_BINDINGS_DMA_R8A7791_DMA_H__ */
-- 
1.9.1

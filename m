From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Fri, 10 Jun 2016 14:42:34 +0530
Subject: [PATCH 4/4] dmaengine: dma: Rename driver and config
In-Reply-To: <1465549954-30220-1-git-send-email-appanad@xilinx.com>
References: <1465549954-30220-1-git-send-email-appanad@xilinx.com>
Message-ID: <1465549954-30220-5-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the existing vdma driver support for
AXI DMA and CDMA got added so the driver is no
longer VDMA specific.

This patch renames the driver and DT binding doc to xilinx_dma
and updates the Kconfig description for all the DMAS.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
 .../dma/xilinx/{xilinx_vdma.txt => xilinx_dma.txt} |    0
 drivers/dma/Kconfig                                |   13 +++++++++----
 drivers/dma/xilinx/Makefile                        |    2 +-
 drivers/dma/xilinx/{xilinx_vdma.c => xilinx_dma.c} |    0
 4 files changed, 10 insertions(+), 5 deletions(-)
 rename Documentation/devicetree/bindings/dma/xilinx/{xilinx_vdma.txt => xilinx_dma.txt} (100%)
 rename drivers/dma/xilinx/{xilinx_vdma.c => xilinx_dma.c} (100%)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
similarity index 100%
rename from Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
rename to Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 01a53ed..d7c03b6 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -519,19 +519,24 @@ config XGENE_DMA
 	help
 	  Enable support for the APM X-Gene SoC DMA engine.
 
-config XILINX_VDMA
-	tristate "Xilinx AXI VDMA Engine"
+config XILINX_DMA
+	tristate "Xilinx AXI DMAS Engine"
 	depends on (ARCH_ZYNQ || MICROBLAZE || ARM64)
 	select DMA_ENGINE
 	help
-	  Enable support for Xilinx AXI VDMA Soft IP.
+	  Enable support for Xilinx AXI DMAS Soft IP.
 
-	  This engine provides high-bandwidth direct memory access
+	  AXI VDMA engine provides high-bandwidth direct memory access
 	  between memory and AXI4-Stream video type target
 	  peripherals including peripherals which support AXI4-
 	  Stream Video Protocol.  It has two stream interfaces/
 	  channels, Memory Mapped to Stream (MM2S) and Stream to
 	  Memory Mapped (S2MM) for the data transfers.
+	  AXI CDMA engine provides high-bandwidth direct memory access
+	  between a memory-mapped source address and a memory-mapped
+	  destination address.
+	  AXI DMA engine provides high-bandwidth one dimensional direct
+	  memory access between memory and AXI4-Stream target peripherals.
 
 config XILINX_ZYNQMP_DMA
 	tristate "Xilinx ZynqMP DMA Engine"
diff --git a/drivers/dma/xilinx/Makefile b/drivers/dma/xilinx/Makefile
index 95469dc..9e91f8f 100644
--- a/drivers/dma/xilinx/Makefile
+++ b/drivers/dma/xilinx/Makefile
@@ -1,2 +1,2 @@
-obj-$(CONFIG_XILINX_VDMA) += xilinx_vdma.o
+obj-$(CONFIG_XILINX_DMA) += xilinx_dma.o
 obj-$(CONFIG_XILINX_ZYNQMP_DMA) += zynqmp_dma.o
diff --git a/drivers/dma/xilinx/xilinx_vdma.c b/drivers/dma/xilinx/xilinx_dma.c
similarity index 100%
rename from drivers/dma/xilinx/xilinx_vdma.c
rename to drivers/dma/xilinx/xilinx_dma.c
-- 
1.7.1

From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Fri, 24 Jun 2016 10:51:25 +0530
Subject: [PATCH v2 4/5] dmaengine: dma: Rename driver and config
In-Reply-To: <1466745686-23898-1-git-send-email-appanad@xilinx.com>
References: <1466745686-23898-1-git-send-email-appanad@xilinx.com>
Message-ID: <1466745686-23898-5-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the existing vdma driver support for
AXI DMA and CDMA got added so the driver is no
longer VDMA specific.

This patch renames the driver and DT binding doc to xilinx_dma
and updates the Kconfig description for all the DMAS.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
Changes for v2:
---> None.

 .../dma/xilinx/{xilinx_vdma.txt => xilinx_dma.txt} |    0
 drivers/dma/Kconfig                                |   11 ++++++++---
 drivers/dma/xilinx/Makefile                        |    2 +-
 drivers/dma/xilinx/{xilinx_vdma.c => xilinx_dma.c} |    0
 4 files changed, 9 insertions(+), 4 deletions(-)
 rename Documentation/devicetree/bindings/dma/xilinx/{xilinx_vdma.txt => xilinx_dma.txt} (100%)
 rename drivers/dma/xilinx/{xilinx_vdma.c => xilinx_dma.c} (100%)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
similarity index 100%
rename from Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
rename to Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 8c98779..1f39f3e 100644
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
 	  Enable support for Xilinx AXI VDMA Soft IP.
 
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
 
 config ZX_DMA
 	tristate "ZTE ZX296702 DMA support"
diff --git a/drivers/dma/xilinx/Makefile b/drivers/dma/xilinx/Makefile
index 3c4e9f2..af9e69a 100644
--- a/drivers/dma/xilinx/Makefile
+++ b/drivers/dma/xilinx/Makefile
@@ -1 +1 @@
-obj-$(CONFIG_XILINX_VDMA) += xilinx_vdma.o
+obj-$(CONFIG_XILINX_DMA) += xilinx_dma.o
diff --git a/drivers/dma/xilinx/xilinx_vdma.c b/drivers/dma/xilinx/xilinx_dma.c
similarity index 100%
rename from drivers/dma/xilinx/xilinx_vdma.c
rename to drivers/dma/xilinx/xilinx_dma.c
-- 
1.7.1

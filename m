From: javier.martin@vista-silicon.com (Javier Martin)
Date: Fri,  9 Mar 2012 16:20:36 +0100
Subject: [PATCH v3 00/13] dmaengine: imx-dma: merge dma arch code into
 dmaengine.
Message-ID: <1331306449-28591-1-git-send-email-javier.martin@vista-silicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following series have to be applied on top of the following patches:
[PATCH v2 1/2] dmaengine: Add support for MEMCPY for imx-dma.
[PATCH v3 2/2] dmaengine: Add support for multiple descriptors for imx-dma.

As discussed with Vinod and Sascha, the file 'arch/arm/mach-imx/dma-v1.c'
is deprecated and no new patches are accepted for it.

This series merges this code into the imx-dma.c dmaengine driver.

Notes for v3:
 - I send the whole series again despite some patches being the same. I think
 this is more comfortable for Vinod than just sending those patches that have
 been modified.
 - I've generated my series with the following command this time:
 'git format-patch -s -13 -M -B --subject-prefix="PATCH v3"' as suggested by
 Sascha but still removing two files in 01/13 generates a lot of noisy diffs.
 Sorry about that.
 - I don't include Sascha's Tested-by since maybe he wants to test this last
 version.

Changes since v2:
 - Alloc all DMA channels (16) instead of 8.
 - Free IRQs properly for i.MX1


[PATCH v3 01/13] dmaengine: imx-dma: merge old dma-v1.c with imx-dma.c
[PATCH v3 02/13] dmaengine: imx-dma: remove data member from internal structure.
[PATCH v3 03/13] dmaengine: imx-dma: remove dma_mode member of internal structure.
[PATCH v3 04/13] dmaengine: imx-dma: remove 'imxdma_setup_mem2mem_hw' function.
[PATCH v3 05/13] dmaengine: imx-dma: remove 'imxdma_config_channel_hw' function.
[PATCH v3 06/13] dmaengine: imx-dma: remove 'imxdma_setup_sg_hw' function.
[PATCH v3 07/13] dmaengine: imx-dma: remove sg member from internal structure.
[PATCH v3 08/13] dmaengine: imx-dma: remove 'in_use' field of 'internal' structure.
[PATCH v3 09/13] dmaengine: imx-dma: remove 'resbytes' field of 'internal' structure.
[PATCH v3 10/13] dmaengine: imx-dma: remove internal structure.
[PATCH v3 11/13] dmaengine: imx-dma: remove unused arg of imxdma_sg_next.
[PATCH v3 12/13] dmaengine: imx-dma: remove 'imx_dmav1_baseaddr' and 'dma_clk'.
[PATCH v3 13/13] dmaengine: imx-dma: use 'dev_dbg' and 'dev_warn' for messages.

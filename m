From: radhey.shyam.pandey@xilinx.com (Radhey Shyam Pandey)
Date: Mon, 2 Apr 2018 16:09:00 +0530
Subject: [RFC 0/6] Xilinx DMA enhancements and optimization
Message-ID: <1522665546-10035-1-git-send-email-radheys@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some background about the patch series: Xilinx Axi Ethernet device driver
(xilinx_axienet_main.c) currently has axi-dma code inside it. The goal
is to refactor axiethernet driver and use existing AXI DMA driver using 
DMAEngine API.

This patchset does feature addition and optimization to support
integration with axiethernet network driver. Once this patchset
is reviewed I will send separate patchset for axiethernet driver.

Radhey Shyam Pandey (6):
  dt-bindings: dma: xilinx_dma: Add optional property
    has_axieth_connected
  dmaengine: xilinx_dma: Pass AXI4-Stream control words to netdev dma
    client
  dmaengine: xilinx_dma: Increase AXI DMA transaction segment count
  dmaengine: xilinx_dma: Freeup active list based on descriptor
    completion bit
  dmaengine: xilinx_dma: Program interrupt delay timeout
  dmaengine: xilinx_dma: Use tasklet_hi_schedule for timing critical
    usecase

 .../devicetree/bindings/dma/xilinx/xilinx_dma.txt  |    1 +
 drivers/dma/xilinx/xilinx_dma.c                    |   73 +++++++++++++++----
 2 files changed, 58 insertions(+), 16 deletions(-)

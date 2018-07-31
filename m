From: radhey.shyam.pandey@xilinx.com (Radhey Shyam Pandey)
Date: Tue, 31 Jul 2018 23:16:11 +0530
Subject: [RFC PATCH 0/2] dmaengine: xilinx_dma: Add Xilinx AXI MCDMA Engine
 driver support
Message-ID: <1533059173-21405-1-git-send-email-radhey.shyam.pandey@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds Xilinx AXI MCDMA IP support. The AXI MCDMA provides
high-bandwidth direct memory access between memory and AXI4-Stream target
peripherals. It supports up to 16 independent read/write channels.

MCDMA IP supports per channel interrupt output but driver support one
interrupt per channel for simplification. IP specification/programming
sequence and register description is mentioned in PG [1].


The driver is tested with xilinx internal dmatest client. In end usecase
MCDMA will be used by xilinx axiethernet driver using dma API's.

[1] https://www.xilinx.com/support/documentation/ip_documentation/axi_mcdma/v1_0/pg288-axi-mcdma.pdf

Radhey Shyam Pandey (2):
  dt-bindings: dmaengine: xilinx_dma: Add binding for Xilinx MCDMA IP
  dmaengine: xilinx_dma: Add Xilinx AXI MCDMA Engine driver support

 .../devicetree/bindings/dma/xilinx/xilinx_dma.txt  |  10 +-
 drivers/dma/xilinx/xilinx_dma.c                    | 449 ++++++++++++++++++++-
 2 files changed, 448 insertions(+), 11 deletions(-)

-- 
2.7.4

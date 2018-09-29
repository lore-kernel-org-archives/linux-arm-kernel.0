From: radhey.shyam.pandey@xilinx.com (Radhey Shyam Pandey)
Date: Sat, 29 Sep 2018 11:17:56 -0600
Subject: [PATCH v2 0/4] dmaengine: xilinx_dma: Minor fix and refactoring
Message-ID: <1538241480-13844-1-git-send-email-radhey.shyam.pandey@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset fixes 64-bit simple CDMA transfer.
It also does some trivial code refactoring.

Changes for v2:
- Introduce helper macro for creating dma_addr_t from hardware buffer
descriptor LSB and MSB fields. Use it to fix 64-bit simple CDMA transfer.
- Modified commit description in 2/4 patch.



Radhey Shyam Pandey (4):
  dmaengine: xilinx_dma: Refactor axidma channel allocation
  dmaengine: xilinx_dma: Refactor axidma channel validation
  dmaengine: xilinx_dma: Introduce helper macro for preparing dma
    address
  dmaengine: xilinx_dma: Fix 64-bit simple CDMA transfer

 drivers/dma/xilinx/xilinx_dma.c |   48 +++++++++++++++++++++-----------------
 1 files changed, 26 insertions(+), 22 deletions(-)

From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 13 Dec 2011 23:48:02 +0800
Subject: [PATCH 0/4] Fix the left DMA_NONE from dma_transfer_direction
 migration
Message-ID: <1323791286-29574-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have been working on -rc recently, and have not noticed the failure
until I ran next tree today.  The mxs-mmc driver is broken on next
tree because the DMA_NONE was left over from the dma_transfer_direction
migration for mxs-dma and its client drivers.

This seires is trying to fix it up.

Huang Shijie (1):
      mtd: fix compile error for gpmi-nand

Shawn Guo (3):
      dmaengine: add DMA_TRANS_NONE to dma_transfer_direction
      mmc: mxs-mmc: fix the dma_transfer_direction migration
      mtd: gpmi-nand: move to dma_transfer_direction

 drivers/dma/mxs-dma.c                 |    2 +-
 drivers/mmc/host/mxs-mmc.c            |    3 +
 drivers/mtd/nand/gpmi-nand/gpmi-lib.c |   22 ++++++-----
 include/linux/dmaengine.h             |    1 +
 include/linux/mtd/gpmi-nand.h         |   68 +++++++++++++++++++++++++++++++++
 5 files changed, 85 insertions(+), 11 deletions(-)

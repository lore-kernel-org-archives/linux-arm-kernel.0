From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Tue, 13 Dec 2016 14:40:42 +0100
Subject: [PATCH 0/9] dmaengine: stm32-dma: Bug fixes and improvements series
Message-ID: <1481636451-27863-1-git-send-email-cedric.madianga@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds bug fixes reported by devices using STM32 DMA and some
improvements mainly linked to dmaengine framework evolution.

M'boumba Cedric Madianga (9):
  dmaengine: stm32-dma: Set correct args number for DMA request from DT
  dmaengine: stm32-dma: Fix typo in Kconfig
  dt-bindings: stm32-dma: Fix typo regarding DMA client binding
  dmaengine: stm32-dma: Fix null pointer dereference in stm32_dma_tx_status
  dmaengine: stm32-dma: Rework starting transfer management
  dmaengine: stm32-dma: Fix residue computation issue in cyclic mode
  dmaengine: stm32-dma: Add error messages if xlate fails
  dmaengine: stm32-dma: Add synchronization support
  dmaengine: stm32-dma: Add max_burst support

 .../devicetree/bindings/dma/stm32-dma.txt          |   5 +-
 drivers/dma/Kconfig                                |   2 +-
 drivers/dma/stm32-dma.c                            | 103 +++++++++++++--------
 3 files changed, 66 insertions(+), 44 deletions(-)

-- 
1.9.1

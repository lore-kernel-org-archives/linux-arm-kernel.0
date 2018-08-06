From: sjhuang@iluvatar.ai (Huang Shijie)
Date: Mon,  6 Aug 2018 16:52:22 +0800
Subject: [PATCH v2 0/9] dmaengine: Use dmaenginem_async_device_register to
 simplify the code
Message-ID: <20180806085231.4597-1-sjhuang@iluvatar.ai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using the dmaenginem_async_device_register to simplify code for these DMA drivers:
    1.) dma_async_device_unregister is the last action of drv->remove().
    2.) the dma driver does not have the ->remove().

v1 --> v2:
   Drop the patched which call dma_async_device_unregister() are not
   the last action.

Huang Shijie (9):
  dmaengine: dw-axi-dmac: use dmaenginem_async_device_register to
    simplify the code
  dmaengine: stm32-mdma: use dmaenginem_async_device_register to
    simplify the code
  dmaengine: st_fdma: use dmaenginem_async_device_register to simplify
    the code
  dmaengine: mmp_tdma: use dmaenginem_async_device_register to simplify
    the code
  dmaengine: ste_dma40: use dmaenginem_async_device_register to simplify
    the code
  dmaengine: dma-jz4780: use dmaenginem_async_device_register to
    simplify the code
  dmaengine: pxa_dma: use dmaenginem_async_device_register to simplify
    the code
  dmaengine: mxs-dma: use dmaenginem_async_device_register to simplify
    the code
  dmaengine: add COMPILE_TEST for the drivers

 drivers/dma/Kconfig                            |  4 ++--
 drivers/dma/dma-jz4780.c                       |  8 ++------
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c |  4 +---
 drivers/dma/mmp_tdma.c                         |  7 ++-----
 drivers/dma/mxs-dma.c                          |  3 +--
 drivers/dma/pxa_dma.c                          |  3 +--
 drivers/dma/st_fdma.c                          |  4 +---
 drivers/dma/ste_dma40.c                        | 14 +++++---------
 drivers/dma/stm32-mdma.c                       |  4 +---
 9 files changed, 16 insertions(+), 35 deletions(-)

-- 
2.17.1

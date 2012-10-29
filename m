From: elen.song@atmel.com (Elen Song)
Date: Mon, 29 Oct 2012 17:09:14 +0800
Subject: [PATCH 0/6] Serial: AT91: Support rx and tx dma
Message-ID: <1351501754-25028-1-git-send-email-elen.song@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a patch series for support tx and rx dma for at91sam9 boards.
The patches contain the following support:
- add parameters for dma use
- request tx dma channel and enable tx
- request rx dma channel and enable rx

The rx dma part use dmaengine_tx_status to get remain bytes.
The api has been updated in the following patch:
[PATCH]DMA: AT91: Get residual bytes in dma buffer

Elen Song (6):
  DMA: AT91: Serial: Add parameter for serial dma use
  Serial: AT91: Distinguish PDC from DMA
  Serial: AT91: Request tx dma channel
  Serial: AT91: Enable tx dma
  Serial: AT91: Request rx dma channel
  Serial: AT91: Enable rx cyclic DMA transfer

 arch/arm/mach-at91/include/mach/board.h |    2 +
 drivers/tty/serial/atmel_serial.c       |  507 +++++++++++++++++++++++++++++--
 include/linux/platform_data/dma-atmel.h |   10 +
 3 files changed, 491 insertions(+), 28 deletions(-)

-- 
1.7.9.5

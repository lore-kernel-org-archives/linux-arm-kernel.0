From: eric@anholt.net (Eric Anholt)
Date: Wed, 16 Mar 2016 12:24:54 -0700
Subject: [PATCH 0/8 v4] bcm2835 DMA slave support
Message-ID: <1458156302-4359-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's the series for DMA slave and memcpy support for 2835, with the
DT changes to enable the remaining channels dropped out while that
goes through review.  I had to do some minor conflict resolution, but
it was pretty mechanical, and I tested again with dmatest on the last
patch.

Martin Sperl (8):
  dmaengine: bcm2835: set residue_granularity field
  dmaengine: bcm2835: remove unnecessary masking of dma channels
  dmaengine: bcm2835: add additional defines for DMA-registers
  dmaengine: bcm2835: move cyclic member from bcm2835_chan into
    bcm2835_desc
  dmaengine: bcm2835: move controlblock chain generation into separate
    method
  dmaengine: bcm2835: limit max length based on channel type
  dmaengine: bcm2835: add slave_sg support to bcm2835-dma
  dmaengine: bcm2835: add dma_memcopy support to bcm2835-dma

 drivers/dma/bcm2835-dma.c | 529 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 412 insertions(+), 117 deletions(-)

-- 
2.7.0

From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Thu, 13 Nov 2014 11:52:38 +0100
Subject: [PATCH 0/7] fixes and update for at_xdmac
Message-ID: <1415875965-6905-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This set of patches is mainly about fixes and an update to remove the chancnt
affection since xdmac was not in the tree when Maxime managed that.


Cyrille Pitchen (2):
  dmaengine: at_xdmac: fix software lockup at_xdmac_tx_status()
  dmaengine: at_xdmac: fix a bug in transfer residue computation

Ludovic Desroches (5):
  dmaengine: at_xdmac: prefer usage of readl/writel_relaxed
  dmaengine: at_xdmac: remove chancnt affectation
  dmaengine: at_xdmac: fix missing spin_unlock
  ARM: dts: at_xdmac: fix bad value of dma-cells in documentation
  dmaengine: at_xdmac: Add DMA_PRIVATE

 .../devicetree/bindings/dma/atmel-xdma.txt         |  2 +-
 drivers/dma/Kconfig                                |  2 +-
 drivers/dma/at_xdmac.c                             | 36 +++++++++++++++-------
 3 files changed, 27 insertions(+), 13 deletions(-)

-- 
2.0.3

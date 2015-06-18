From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Thu, 18 Jun 2015 13:25:40 +0200
Subject: [PATCH linux-next v2 0/1] dmaengine: at_hdmac: fix residue computation
Message-ID: <cover.1434626239.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ChangeLog

v2:
- rework the processing of the linked list of DMA descriptors to take a
  race condition risk into account. See patch comments for more details on
  why we have chosen this implementation.

v1:
This patch fixes a bug reported by Jiri Prchal for the USART behaviour on
some Atmel SoCs when DMA is used to receive data. More generally, it fixes
the DMA residue computation.

Cyrille Pitchen (1):
  dmaengine: at_hdmac: fix residue computation

 drivers/dma/at_hdmac.c      | 132 +++++++++++++++++++++++++++++---------------
 drivers/dma/at_hdmac_regs.h |   3 +-
 2 files changed, 88 insertions(+), 47 deletions(-)

-- 
1.8.2.2

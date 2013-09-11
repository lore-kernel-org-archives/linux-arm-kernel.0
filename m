From: padma.v@samsung.com (Padmavathi Venna)
Date: Wed, 11 Sep 2013 11:38:02 +0530
Subject: [PATCH 0/3] Add pl330 residue support
Message-ID: <1378879685-5352-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds support for finding the remaining number of bytes
in the current transfer and fills txstate.residue with the amount of
bytes remaining. Although Samsung specific dma operations will be
removed in future, the residue specific patches are required. So when
we add support for generic dma engine these patches have to be ported
accordingly.

Dylan Reid (3):
  dmaengine: pl330: Set residue in tx_status callback.
  ARM: SAMSUNG: Add residue DMA operation.
  ASoC: Update pointer to account for pending dma transfers.

 arch/arm/plat-samsung/dma-ops.c              |   14 +++++++
 arch/arm/plat-samsung/include/plat/dma-ops.h |    1 +
 drivers/dma/pl330.c                          |   55 +++++++++++++++++++++++++-
 sound/soc/samsung/dma.c                      |   27 +++++++++----
 4 files changed, 88 insertions(+), 9 deletions(-)

-- 
1.7.4.4

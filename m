From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 29 Jul 2013 17:42:12 +0200
Subject: [PATCHv2 0/2] dma: mv_xor: big endian support
Message-ID: <1375112534-748-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod, Dan,

This small set of patches adds support for big endian operation in the
DMA mv_xor driver. It has been tested in both little-endian and
big-endian modes on the Armada XP GP board.

If possible, I'd like those to be merged for 3.12.

Changes since v1:
 * Use readl_relaxed() and writel_relaxed() instead of readl/writel
   when converting from raw_readl/raw_writel, since they preserve the
   same barrier behavior. Suggested by Russell King.

Thanks!

Thomas

Thomas Petazzoni (2):
  mv_xor: use {readl,writel}_relaxed instead of __raw_{readl,writel}
  mv_xor: support big endian systems using descriptor swap feature

 drivers/dma/mv_xor.c | 47 +++++++++++++++++++++++++++--------------------
 drivers/dma/mv_xor.h | 28 +++++++++++++++++++++++++++-
 2 files changed, 54 insertions(+), 21 deletions(-)

-- 
1.8.1.2

From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 18 Jul 2018 18:10:49 +0200
Subject: [PATCH net-next v3 0/8] A fix and a few improvements on mvneta
Message-ID: <20180718161057.28704-1-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series brings some improvements for the mvneta driver and also
adds a fix.

Compared to the v2, the main change is another patch fixing a bug
in mtu_change.

Gregory

Changelog:
v1 -> v2

 - In patch 2, use EXPORT_SYMBOL_GPL for mvneta_bm_get and
   mvneta_bm_put to be used in module, reported by kbuild test robot.

 - In patch 4, add the counter to the driver's ethtool state,
   suggested by David Miller.

 - In patch 6, use a single if, suggested by Marcin Wojtas

v2 -> v3

 - Adding a patch fixing the mtu change issue

 - Removing the inline keyword for mvneta_rx_refill() and let the
   comiler decided, suggested by David Miller.

Andrew Lunn (1):
  net: ethernet: mvneta: Fix napi structure mixup on armada 3700

Gregory CLEMENT (3):
  net: mvneta: remove data pointer usage from device_node structure
  net: mvneta: discriminate error cause for missed packet
  net: mvneta: Allocate page for the descriptor

Yelena Krivosheev (4):
  net: mvneta: fix mtu change on port without link
  net: mvneta: increase number of buffers in RX and TX queue
  net: mvneta: Verify hardware checksum only when offload checksum
    feature is set
  net: mvneta: Improve the buffer allocation method for SWBM

 drivers/net/ethernet/marvell/mvneta.c    | 409 ++++++++++++++---------
 drivers/net/ethernet/marvell/mvneta_bm.c |  15 +
 drivers/net/ethernet/marvell/mvneta_bm.h |   8 +-
 3 files changed, 272 insertions(+), 160 deletions(-)

-- 
2.18.0

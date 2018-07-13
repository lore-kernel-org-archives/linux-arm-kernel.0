From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Fri, 13 Jul 2018 18:18:34 +0200
Subject: [PATCH net-next v2 0/7] A fix and a few improvements on mvneta
Message-ID: <20180713161841.11202-1-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series brings some improvements for the mvneta driver and also
adds a fix.

Compared to the v1, the main change is the a new patch fixing a bug
which is visible in net-next. Now the mvneta driver just crashes when
opening on Armada 37xx. As indicated in the patch, the bug was there
since many releases but the problem is only visible now.

The series had been tested on ARM32 (clearfog) and ARM64
(EspressoBin), with and without hardware buffer management.

Gregory

Chnagelog:
v1 -> v2

 - In patch 2, use EXPORT_SYMBOL_GPL for mvneta_bm_get and
   mvneta_bm_put to be used in module, reported by kbuild test robot.

 - In patch 4, add the counter to the driver's ethtool state,
   suggested by David Miller.

 - In patch 6, use a single if, suggested by Marcin Wojtas

Andrew Lunn (1):
  net: ethernet: mvneta: Fix napi structure mixup on armada 3700

Gregory CLEMENT (3):
  net: mvneta: remove data pointer usage from device_node structure
  net: mvneta: discriminate error cause for missed packet
  net: mvneta: Allocate page for the descriptor

Yelena Krivosheev (3):
  net: mvneta: increase number of buffers in RX and TX queue
  net: mvneta: Verify hardware checksum only when offload checksum
    feature is set
  net: mvneta: Improve the buffer allocation method for SWBM

 drivers/net/ethernet/marvell/mvneta.c    | 412 ++++++++++++++---------
 drivers/net/ethernet/marvell/mvneta_bm.c |  15 +
 drivers/net/ethernet/marvell/mvneta_bm.h |   8 +-
 3 files changed, 274 insertions(+), 161 deletions(-)

-- 
2.18.0

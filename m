From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Fri,  6 Jul 2018 15:19:43 +0200
Subject: [PATCH net-next 0/6] Few improvements on mvneta
Message-ID: <20180706131949.2684-1-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series brings some improvements for the mvneta driver.

The main one is the last patch which improves the driver for system
with low memory.

Patch 2 and 4 also contribute to improve the performance, whereas the
3 other ones are more about cleanup.

The series had been tested on ARM32 (clearfog) and ARM64
(EspressoBin), with and without hardware buffer management.

Gregory

Gregory CLEMENT (2):
  net: mvneta: remove data pointer usage from device_node structure
  net: mvneta: Allocate page for the descriptor

Yelena Krivosheev (4):
  net: mvneta: increase number of buffers in RX and TX queue
  net: mvneta: discriminate error cause for missed packet
  net: mvneta: Verify hardware checksum only when offload checksum
    feature is set
  net: mvneta: Improve the buffer allocation method for SWBM

 drivers/net/ethernet/marvell/mvneta.c    | 395 ++++++++++++++---------
 drivers/net/ethernet/marvell/mvneta_bm.c |  13 +
 drivers/net/ethernet/marvell/mvneta_bm.h |   8 +-
 3 files changed, 258 insertions(+), 158 deletions(-)

-- 
2.17.1

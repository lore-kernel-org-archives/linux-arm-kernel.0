From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 11 Nov 2018 14:45:23 +0100
Subject: [PATCH 0/7] mmc: Several fixes for bcm2835 driver
Message-ID: <1541943930-23873-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series fixes several issues which has been discovered after
submission.

Michal Suchanek (1):
  mmc: bcm2835: reset host on timeout

Phil Elwell (1):
  mmc: bcm2835: Recover from MMC_SEND_EXT_CSD

Stefan Wahren (5):
  mmc: bcm2835: Release DMA channel on driver unload
  mmc: bcm2835: Avoid possible races on data requests
  mmc: bcm2835: Terminate timeout work synchronously
  mmc: bcm2835: Refactor dma_map_sg handling
  mmc: bcm2835: Properly handle dmaengine_prep_slave_sg

 drivers/mmc/host/bcm2835.c | 58 ++++++++++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 20 deletions(-)

-- 
2.7.4

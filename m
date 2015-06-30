From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 30 Jun 2015 16:36:51 +0200
Subject: [PATCH v3 0/6] dmaengine: mv_xor fixes and improvements
Message-ID: <1435675017-875-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Here is a v3 of the series making some fixes and improvements to the
mv_xor driver.

Changes v2 -> v3:

 * Added Reviewed-by from Maxime Ripard on patches 1, 3, 4 and 5.

 * Added an additional patch improving the performance of the XOR
   engine by only using a subset of the available channels depending
   on the number of CPUs in the system.

Changes v1 -> v2:

 * Device Tree related changes omitted, since they have been applied
   by one of the ARM mach-mvebu maintainer.

 * Addition of one commit, "dmaengine: mv_xor: fix big endian
   operation in register mode", fixing a regression introduced by one
   the patches currently in the 'next' branch of Vinod's
   repository. It should be merged as part of 4.2.

 * Addition of two cleanup patches:

    dmaengine: mv_xor: remove mv_xor_chan->current_type field
    dmaengine: mv_xor: de-duplicate mv_chan_set_mode*()

   These patches, like the two other non-fixes, can either go in 4.2
   if it's not too late, or in 4.3.

Thanks,

Thomas

Thomas Petazzoni (6):
  dmaengine: mv_xor: fix big endian operation in register mode
  dmaengine: mv_xor: add suspend/resume support
  dmaengine: mv_xor: remove support for dmacap,* DT properties
  dmaengine: mv_xor: remove mv_xor_chan->current_type field
  dmaengine: mv_xor: de-duplicate mv_chan_set_mode*()
  dmaengine: mv_xor: optimize performance by using a subset of the XOR
    channels

 Documentation/devicetree/bindings/dma/mv-xor.txt |  10 +-
 drivers/dma/mv_xor.c                             | 121 ++++++++++++++---------
 drivers/dma/mv_xor.h                             |   2 +-
 3 files changed, 81 insertions(+), 52 deletions(-)

-- 
2.4.5

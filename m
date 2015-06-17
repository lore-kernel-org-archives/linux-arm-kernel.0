From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 17 Jun 2015 18:04:41 +0200
Subject: [PATCHv2 0/5] dmaengine: mv_xor fixes and improvements
Message-ID: <1434557086-9520-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Here is a v2 of the series making some fixes and improvements to the
mv_xor driver.

Here are the changes compared to v1:

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

Thomas Petazzoni (5):
  dmaengine: mv_xor: fix big endian operation in register mode
  dmaengine: mv_xor: add suspend/resume support
  dmaengine: mv_xor: remove support for dmacap,* DT properties
  dmaengine: mv_xor: remove mv_xor_chan->current_type field
  dmaengine: mv_xor: de-duplicate mv_chan_set_mode*()

 Documentation/devicetree/bindings/dma/mv-xor.txt | 10 +--
 drivers/dma/mv_xor.c                             | 97 +++++++++++++-----------
 drivers/dma/mv_xor.h                             |  2 +-
 3 files changed, 58 insertions(+), 51 deletions(-)

-- 
2.1.0

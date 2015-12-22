From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 22 Dec 2015 11:43:26 +0100
Subject: [PATCHv3 0/3] mv_xor improvements
Message-ID: <1450781009-30618-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Vinod,

Here is the third iteration of some mv_xor improvements patches. The
previous iteration was sent in July earlier this year. Compared to the
v2:

 - rebased on top of v4.4-rc1

 - dropped patches that were merged

 - as you suggested, add a comment in the code to explain that our
   suspend/resume implementation makes the assumption that there are
   no in-flight DMA transactions because mv_xor is only used for
   RAID5, and the block layer will have already suspended I/O
   activity, so not special care needs to be taken in the driver
   itself.

I have retested this with a RAID5 array on Armada 388 GP, while the
array is in reconstruction, and doing some suspend/resume cycles in
the middle.

Thanks!

Thomas

Thomas Petazzoni (3):
  dmaengine: mv_xor: remove mv_xor_chan->current_type field
  dmaengine: mv_xor: de-duplicate mv_chan_set_mode*()
  dmaengine: mv_xor: add suspend/resume support

 drivers/dma/mv_xor.c | 95 +++++++++++++++++++++++++++++++---------------------
 drivers/dma/mv_xor.h |  2 +-
 2 files changed, 57 insertions(+), 40 deletions(-)

-- 
2.6.4

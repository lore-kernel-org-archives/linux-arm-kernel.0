From: hias@horus.com (Matthias Reichl)
Date: Thu,  9 Jun 2016 13:41:42 +0200
Subject: [PATCH 0/2] dmaengine: bcm2835: Cyclic DMA fixes
Message-ID: <1465472504-10191-1-git-send-email-hias@horus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In downstream Raspberry Pi kernel we noticed that audio didn't work
as expected, we got stuttering and overruns/underruns. Here's the
link to the original discussion on GitHub:
https://github.com/raspberrypi/linux/issues/1517

This issue is caused by a small bug in the period-splitting-code
and fixed by the first patch.

The second patch, avoiding very small chunks, is mainly a precaution.
While small chunks are not known to have caused any problems so far
they have the potentical to cause very hard to track down issues.
So better avoid such situations in the first place.

Matthias Reichl (2):
  dmaengine: bcm2835: Fix cyclic DMA period splitting
  dmaengine: bcm2835: Avoid splitting periods into very small chunks

 drivers/dma/bcm2835-dma.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

-- 
2.1.4

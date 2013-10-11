From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 11 Oct 2013 14:12:14 +0200
Subject: [PATCH v4 0/5] dma: mxs-dma bugfixes and cleanup
Message-ID: <1381493539-31756-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

v4 adds another patch to increase sound stability. Patch 3 ("dma: mxs-dma: Fix
channel reset hardware bug") decreases the number of channel stalls, but after
hours of repeated playback the bug still appears. The new patch ("dma: mxs: Use
semaphores for cyclic DMA") replaces reset channel usage with hardware
semaphore counter mechanism.

Regards,

Markus Pargmann


Markus Pargmann (5):
      dma: mxs-dma: Cleanup interrupt handler
      dma: mxs-dma: Report correct residue for cyclic DMA
      dma: mxs-dma: Fix channel reset hardware bug
      dma: mxs-dma: Update state after channel reset
      dma: mxs: Use semaphores for cyclic DMA

 drivers/dma/mxs-dma.c | 176 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 137 insertions(+), 39 deletions(-)

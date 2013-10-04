From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri,  4 Oct 2013 12:44:05 +0200
Subject: [PATCH v3 0/4] dma: mxs-dma bugfixes and cleanup
Message-ID: <1380883449-8649-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

in v3 I dropped patch 2 from v2 (dma: mxs-dma: Pause channel while prep_dma_cyclic).
It seems to be fixed by one of the other patches.

On i.MX28 a channel reset can cause a channel failure until DMA engine reset.
I added a patch to observe the DMA state machine and wait for a suitable state.
The other patch fixes the dma channel software state when a interrupt occures on
a DMA channel that is not active after a reset.

Regards,

Markus


Markus Pargmann (4):
      dma: mxs-dma: Cleanup interrupt handler
      dma: mxs-dma: Report correct residue for cyclic DMA
      dma: mxs-dma: Fix channel reset hardware bug
      dma: mxs-dma: Update state after channel reset

 drivers/dma/mxs-dma.c | 145 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 106 insertions(+), 39 deletions(-)

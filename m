From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 30 Sep 2013 15:13:39 +0200
Subject: [PATCH v2 0/3] dma: mxs-dma bugfixes and cleanup
Message-ID: <1380546822-14034-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am using the mxs-dma driver with the generic soc pcm dmaengine and found some
sound issues. The patches are based on v3.12-rc2.

v2 contains a new patch which reports correct residues for cyclic dma.
I removed "dma: mxs-dma: Track number of irqs for callback" as it is not
necessary for pcm dmaengine.

Regards,

Markus Pargmann


Markus Pargmann (3):
      dma: mxs-dma: Cleanup interrupt handler
      dma: mxs-dma: Pause channel while prep_dma_cyclic
      dma: mxs-dma: Report correct residue for cyclic DMA

 drivers/dma/mxs-dma.c | 123 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 84 insertions(+), 39 deletions(-)

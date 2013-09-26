From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 26 Sep 2013 17:06:33 +0200
Subject: [PATCH 0/3] dma: mxs-dma bugfixes and cleanup
Message-ID: <1380207996-27257-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am using the mxs-dma driver with the generic soc pcm dmaengine and found some
sound issues. This patch series contains two bugfixes and a cleanup of the
interrupt handler. The patches are based on v3.12-rc2.

Regards,

Markus Pargmann


Markus Pargmann (3):
      dma: mxs-dma: Cleanup interrupt handler
      dma: mxs-dma: Track number of irqs for callback
      dma: mxs-dma: Pause channel while prep_dma_cyclic

 drivers/dma/mxs-dma.c | 130 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 91 insertions(+), 39 deletions(-)

From: joelf@ti.com (Joel Fernandes)
Date: Thu, 18 Jul 2013 11:46:38 -0500
Subject: [PATCH 0/3] Pending dmaengine patches
Message-ID: <1374166001-31340-1-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've reworked Matt's dmaegine sg_limits series addressing review comments at [1].

Currently MMC on AM33xx requires EDMA which was posted and accepted, following
it is a series that are fixes that have to go in for it to work correctly.
Without this series, DMA fails on MMC resulting in I/O errors.

A subsequent MMC DT patch for AM33xx is also on hold [2] for the same reason.

Tested on AM335x (Beaglebone Rev A5A).

[1] http://linux.davincidsp.com/pipermail/davinci-linux-open-source/2013-March/026658.html
[2] http://lkml.indiana.edu/hypermail/linux/kernel/1306.3/03766.html

Matt Porter (3):
  dmaengine: add dma_get_slave_sg_limits()
  mmc: omap_hsmmc: set max_segs based on dma engine limits
  dma: edma: add device_slave_sg_limits() support

 drivers/dma/edma.c            |   14 +++++++++++++
 drivers/mmc/host/omap_hsmmc.c |    9 +++++++++
 include/linux/dmaengine.h     |   45 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

-- 
1.7.9.5

From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 27 Sep 2014 10:54:36 +0200
Subject: [PATCH 0/9] dmaengine: Implement generic slave capabilities retrieval
Message-ID: <1411808085-27792-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

As we discussed a couple of weeks ago, this is a first attempt at
creating a generic behaviour for slave capabilities retrieval so that
generic layers using dmaengine can actually rely on that.

That has been done mostly through two steps: by moving out the
sub-commands of the device_control callback, so that the dmaengine
core can then infer from that wether a sub-command is implemented, and
then by moving the slave properties, such as the supported buswidth,
to the structure dma_device itself.

Comments are as usual appreciated!

Thanks,
Maxime

Maxime Ripard (9):
  dmaengine: Make the destination abbreviation coherent
  dmaengine: Make channel allocation callbacks optional
  dmaengine: Introduce a device_config callback
  dmaengine: split out pause/resume operations from device_control
  dmaengine: Add device_terminate_all callback
  dmaengine: Create a generic dma_slave_caps callback
  dmaengine: Move slave caps to dma_device
  dmaengine: Mark device_control as deprecated
  dmaengine: sun6i: Convert to generic slave_caps

 drivers/dma/bcm2835-dma.c |   2 +-
 drivers/dma/dmaengine.c   |   4 --
 drivers/dma/edma.c        |   2 +-
 drivers/dma/fsl-edma.c    |   2 +-
 drivers/dma/omap-dma.c    |   2 +-
 drivers/dma/pl330.c       |   2 +-
 drivers/dma/sirf-dma.c    |   2 +-
 drivers/dma/sun6i-dma.c   | 158 +++++++++++++++++++++++++---------------------
 include/linux/dmaengine.h |  81 +++++++++++++++++++-----
 9 files changed, 158 insertions(+), 97 deletions(-)

-- 
2.1.0

From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 17 Jun 2018 19:02:03 +0200
Subject: [PATCH v3 00/14] ARM: pxa: switch to DMA slave maps
Message-ID: <20180617170217.24177-1-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As I gathered almost all the required acks, this is an information only post
before queuing to the PXA tree.

The only missing part is for netdev, for which I'd like an ack from netdev
people for patches 0007 and 0008, but that won't prevent me from queuing all the
other patches (excepting the patch 0012 which can only be applied once 0007 and
0008 are queued).

Cheers.

--
Robert

Robert Jarzmik (14):
  dmaengine: pxa: use a dma slave map
  ARM: pxa: add dma slave map
  dmaengine: pxa: add a default requestor policy
  mmc: pxamci: remove the dmaengine compat need
  media: pxa_camera: remove the dmaengine compat need
  mtd: rawnand: marvell: remove the dmaengine compat need
  net: smc911x: remove the dmaengine compat need
  net: smc91x: remove the dmaengine compat need
  ASoC: pxa: remove the dmaengine compat need
  ata: pata_pxa: remove the dmaengine compat need
  dmaengine: pxa: document pxad_param
  dmaengine: pxa: make the filter function internal
  ARM: pxa: remove the DMA IO resources
  ARM: pxa: change SSP DMA channels allocation

 arch/arm/mach-pxa/devices.c           | 148 +---------------------------------
 arch/arm/mach-pxa/devices.h           |   6 +-
 arch/arm/mach-pxa/pxa25x.c            |  38 ++++++++-
 arch/arm/mach-pxa/pxa27x.c            |  39 ++++++++-
 arch/arm/mach-pxa/pxa3xx.c            |  41 +++++++++-
 arch/arm/plat-pxa/ssp.c               |  47 -----------
 drivers/ata/pata_pxa.c                |  10 +--
 drivers/dma/pxa_dma.c                 |  18 ++++-
 drivers/media/platform/pxa_camera.c   |  22 +----
 drivers/mmc/host/pxamci.c             |  29 +------
 drivers/mtd/nand/raw/marvell_nand.c   |  17 +---
 drivers/net/ethernet/smsc/smc911x.c   |  13 +--
 drivers/net/ethernet/smsc/smc91x.c    |   9 +--
 drivers/net/ethernet/smsc/smc91x.h    |   1 -
 include/linux/dma/pxa-dma.h           |  20 +++--
 include/linux/platform_data/mmp_dma.h |   4 +
 include/linux/pxa2xx_ssp.h            |   2 -
 sound/arm/pxa2xx-ac97.c               |  14 +---
 sound/arm/pxa2xx-pcm-lib.c            |   6 +-
 sound/soc/pxa/pxa-ssp.c               |   5 +-
 sound/soc/pxa/pxa2xx-ac97.c           |  32 ++------
 sound/soc/pxa/pxa2xx-i2s.c            |   6 +-
 22 files changed, 176 insertions(+), 351 deletions(-)

-- 
2.11.0

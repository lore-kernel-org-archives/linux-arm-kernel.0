From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 12 Jul 2018 22:21:35 +0200
Subject: [GIT PULL] pxa for v4.19
Message-ID: <87va9kb3xs.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof,

This is the pxa pull request for 4.19. This time it touches a lot of subsystems
because of the dma slave map conversion of the pxa architecture.

And there is one catch : the build of pxa defconfigs will probably fail in your
arm-soc tree, while it will succeed in -next tree. The reason of the failure is
that one patch, namely "dmaengine: pxa: make the filter function internal",
depends on one patch queued in Mark Brown's tree.
If that is a problem for you, I'll postpone this patch, and resend a new pull
request if you ask it.

Can you please consider pulling ?

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  https://github.com/rjarzmik/linux.git tags/pxa-for-4.19

for you to fetch changes up to 0d0b16b8e008825834684163799ab944920aabce:

  dmaengine: pxa: make the filter function internal (2018-06-29 22:30:14 +0200)

----------------------------------------------------------------
This is the pxa changes for 4.19 cycle :
 - the pxa architecture is ported to dma slavemap
 - some minor AC97 fixes
 - some minor board fixes

----------------------------------------------------------------
Robert Jarzmik (17):
      dmaengine: pxa: use a dma slave map
      ARM: pxa: add dma slave map
      dmaengine: pxa: add a default requestor policy
      mmc: pxamci: remove the dmaengine compat need
      media: pxa_camera: remove the dmaengine compat need
      mtd: rawnand: marvell: remove the dmaengine compat need
      ata: pata_pxa: remove the dmaengine compat need
      dmaengine: pxa: document pxad_param
      ARM: pxa: remove the DMA IO resources
      ARM: pxa: change SSP DMA channels allocation
      ARM: pxa: hx4700: fix the usb client
      ARM: pxa: mioa701 convert to the new AC97 bus
      ARM: pxa: add the missing AC97 clocks
      ARM: pxa: zylonite: use the new ac97 bus support
      net: smc911x: remove the dmaengine compat need
      net: smc91x: remove the dmaengine compat need
      dmaengine: pxa: make the filter function internal

 arch/arm/mach-pxa/devices.c           | 161 ++++------------------------------
 arch/arm/mach-pxa/devices.h           |   6 +-
 arch/arm/mach-pxa/hx4700.c            |   4 +
 arch/arm/mach-pxa/mioa701.c           |   2 -
 arch/arm/mach-pxa/pxa25x.c            |  38 +++++++-
 arch/arm/mach-pxa/pxa27x.c            |  39 +++++++-
 arch/arm/mach-pxa/pxa3xx.c            |  41 ++++++++-
 arch/arm/mach-pxa/zylonite.c          |  11 ---
 arch/arm/plat-pxa/ssp.c               |  47 ----------
 drivers/ata/pata_pxa.c                |  10 +--
 drivers/dma/pxa_dma.c                 |  18 +++-
 drivers/media/platform/pxa_camera.c   |  22 +----
 drivers/mmc/host/pxamci.c             |  29 +-----
 drivers/mtd/nand/raw/marvell_nand.c   |  17 +---
 drivers/net/ethernet/smsc/smc911x.c   |  13 +--
 drivers/net/ethernet/smsc/smc91x.c    |   9 +-
 drivers/net/ethernet/smsc/smc91x.h    |   1 -
 include/linux/dma/pxa-dma.h           |  20 ++---
 include/linux/platform_data/mmp_dma.h |   4 +
 include/linux/pxa2xx_ssp.h            |   2 -
 sound/soc/pxa/pxa-ssp.c               |   5 +-
 21 files changed, 181 insertions(+), 318 deletions(-)

-- 
Robert

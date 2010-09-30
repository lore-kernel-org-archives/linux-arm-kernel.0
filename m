From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 30 Sep 2010 15:56:31 +0200
Subject: dmaengine patches
Message-ID: <1285854995-6569-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The following patches are new versions of patches previously
posted with the latest comments from Dan integrated. New
in this series is a dma driver for the older i.MX SoCs. I decided
to implement the dmaengine driver for these SoCs as a user of
the old dma driver. This allows us keep both dma drivers in the
tree and to convert the users of the dma driver smoothly and one
by one to the new driver and remove the old driver afterwards.

Sascha

The following changes since commit 32163f4b2cef28a5aab8b226ffecfc6379a53786:

  alpha: fix usp value in multithreaded coredumps (2010-09-25 14:38:13 -0700)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6.git sdma-dmaengine

Sascha Hauer (4):
      dmaengine: add possibility for cyclic transfers
      dmaengine: add wrapper functions for device control functions
      dmaengine: Add Freescale i.MX SDMA support
      dmaengine: Add Freescale i.MX1/21/27 DMA driver

 arch/arm/mach-imx/include/mach/dma-v1.h |    8 +-
 arch/arm/plat-mxc/include/mach/dma.h    |   67 ++
 arch/arm/plat-mxc/include/mach/sdma.h   |   17 +
 drivers/dma/Kconfig                     |   16 +
 drivers/dma/Makefile                    |    2 +
 drivers/dma/dmaengine.c                 |    2 +
 drivers/dma/imx-dma.c                   |  426 ++++++++++
 drivers/dma/imx-sdma.c                  | 1392 +++++++++++++++++++++++++++++++
 include/linux/dmaengine.h               |   43 +-
 9 files changed, 1966 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/plat-mxc/include/mach/dma.h
 create mode 100644 arch/arm/plat-mxc/include/mach/sdma.h
 create mode 100644 drivers/dma/imx-dma.c
 create mode 100644 drivers/dma/imx-sdma.c

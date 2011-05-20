From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 20 May 2011 09:59:15 +0200
Subject: i.MX: switch to sparse irqs
Message-ID: <1305878365-827-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following series switches the i.MX architecture to sparse
irqs. It allows us to remove some ugly dependencies on irq
number defines in both the boards and the architecture.

Sascha Hauer (9):
      ARM i.MX tzic: do not depend on MXC_INTERNAL_IRQS
      ARM i.MX avic: do not depend on MXC_INTERNAL_IRQS
      ARM i.MX: get rid of wrong MXC_INTERNAL_IRQ usage
      mfd wm8350: allocate irq descs dynamically
      ARM i.MX mx31ads: allocate irqs for expio dynamically
      ARM i.MX 3ds debugboard: allocate irqs dynamically
      ARM i.MX: use sparse irqs
      dma IPU: rework irq handling
      ARM i.MX3: remove now useless ipu platform data from boards

 arch/arm/Kconfig                               |    1 +
 arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c |    6 +-
 arch/arm/mach-imx/mach-armadillo5x0.c          |    6 +-
 arch/arm/mach-imx/mach-mx27_3ds.c              |    2 +-
 arch/arm/mach-imx/mach-mx31_3ds.c              |    6 +-
 arch/arm/mach-imx/mach-mx31ads.c               |   45 ++--
 arch/arm/mach-imx/mach-mx31moboard.c           |    6 +-
 arch/arm/mach-imx/mach-mx35_3ds.c              |    2 +-
 arch/arm/mach-imx/mach-pcm037.c                |    6 +-
 arch/arm/mach-imx/mach-pcm043.c                |    6 +-
 arch/arm/mach-imx/mach-vpr200.c                |    6 +-
 arch/arm/mach-imx/mm-imx31.c                   |    2 +-
 arch/arm/mach-imx/mm-imx35.c                   |    1 +
 arch/arm/mach-imx/mx31lilly-db.c               |    6 +-
 arch/arm/mach-mx5/board-cpuimx51.c             |   12 +-
 arch/arm/mach-mx5/board-mx51_3ds.c             |    2 +-
 arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c   |    3 +-
 arch/arm/plat-mxc/3ds_debugboard.c             |   53 +++--
 arch/arm/plat-mxc/avic.c                       |   18 +-
 arch/arm/plat-mxc/gpio.c                       |    6 +-
 arch/arm/plat-mxc/include/mach/iomux-v1.h      |    3 -
 arch/arm/plat-mxc/include/mach/ipu.h           |    1 -
 arch/arm/plat-mxc/include/mach/irqs.h          |   53 +----
 arch/arm/plat-mxc/tzic.c                       |    4 +-
 drivers/dma/Kconfig                            |   10 -
 drivers/dma/ipu/ipu_idmac.c                    |   41 +---
 drivers/dma/ipu/ipu_intern.h                   |   14 +-
 drivers/dma/ipu/ipu_irq.c                      |  300 +++---------------------
 drivers/mfd/wm8350-irq.c                       |   16 +-
 29 files changed, 166 insertions(+), 471 deletions(-)

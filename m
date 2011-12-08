From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 8 Dec 2011 22:32:05 +0800
Subject: [GIT PULL] imx: gpio interrupt cleanup
Message-ID: <20111208143204.GA8139@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and  Olof,

Please consider to pull the series below.  I really should have
Thomas' ack on Jamie's patch 'irqdomain: export irq_domain_simple_ops
for !CONFIG_OF', and Grant's ack on patch 'gpio/mxc: adopt irq_domain
in gpio driver'.  So this pull request is also asking comments for the
path of these patches.

Thomas, Grant,

Please speak up if you do not want "your" patches to go through arm-soc
tree.  Thanks.

Shawn

The following changes since commit fec607aab5dca019cfc76768fa0b5908d47a55b1:

  Merge branch 'imx/fix-irqdomain' of git://git.linaro.org/people/shawnguo/linux-2.6 into fixes (2011-12-06 14:15:02 +0000)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git imx/clean-gpio-irq

Jamie Iles (1):
      irqdomain: export irq_domain_simple_ops for !CONFIG_OF

Shawn Guo (5):
      arm/imx: eliminate macro IMX_GPIO_TO_IRQ()
      arm/imx: eliminate macro IOMUX_TO_IRQ()
      arm/imx: eliminate macro IRQ_GPIOx()
      gpio/mxc: adopt irq_domain in gpio driver
      arm/imx: remove macro MXC_GPIO_IRQ_START

 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c |    3 +-
 arch/arm/mach-imx/mach-apf9328.c             |    6 ++-
 arch/arm/mach-imx/mach-armadillo5x0.c        |   12 ++++--
 arch/arm/mach-imx/mach-cpuimx27.c            |   12 ++++--
 arch/arm/mach-imx/mach-cpuimx35.c            |    3 +-
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c  |    8 ++--
 arch/arm/mach-imx/mach-imx6q.c               |   13 ------
 arch/arm/mach-imx/mach-kzm_arm11_01.c        |   20 +++++++--
 arch/arm/mach-imx/mach-mx21ads.c             |    5 +-
 arch/arm/mach-imx/mach-mx27_3ds.c            |    3 +-
 arch/arm/mach-imx/mach-mx27ads.c             |   12 +++---
 arch/arm/mach-imx/mach-mx31_3ds.c            |   13 +++---
 arch/arm/mach-imx/mach-mx31ads.c             |   14 ++++--
 arch/arm/mach-imx/mach-mx31lilly.c           |   10 +++-
 arch/arm/mach-imx/mach-mx31lite.c            |   10 +++-
 arch/arm/mach-imx/mach-mx31moboard.c         |    4 +-
 arch/arm/mach-imx/mach-mxt_td60.c            |    6 +-
 arch/arm/mach-imx/mach-pca100.c              |    4 +-
 arch/arm/mach-imx/mach-pcm037.c              |   18 +++++---
 arch/arm/mach-imx/mach-pcm038.c              |    4 +-
 arch/arm/mach-imx/mach-qong.c                |    9 ++--
 arch/arm/mach-imx/mach-scb9328.c             |    6 ++-
 arch/arm/mach-imx/mach-vpr200.c              |    3 +-
 arch/arm/mach-imx/mx31lilly-db.c             |    5 +-
 arch/arm/mach-imx/mx31lite-db.c              |    5 +-
 arch/arm/mach-imx/pcm970-baseboard.c         |   13 +++---
 arch/arm/mach-mx5/board-cpuimx51.c           |   12 ++++--
 arch/arm/mach-mx5/board-cpuimx51sd.c         |    6 ++-
 arch/arm/mach-mx5/board-mx53_ard.c           |    5 +-
 arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c |    3 +-
 arch/arm/mach-mx5/imx51-dt.c                 |   12 -----
 arch/arm/mach-mx5/imx53-dt.c                 |   12 -----
 arch/arm/mach-mx5/mx51_efika.c               |    3 +-
 arch/arm/plat-mxc/include/mach/hardware.h    |    2 -
 arch/arm/plat-mxc/include/mach/iomux-mx3.h   |    3 -
 arch/arm/plat-mxc/include/mach/iomux-v1.h    |   12 +++---
 arch/arm/plat-mxc/include/mach/irqs.h        |    2 -
 drivers/gpio/Kconfig                         |    1 +
 drivers/gpio/gpio-mxc.c                      |   57 ++++++++++++++------------
 include/linux/irqdomain.h                    |    3 +-
 kernel/irq/irqdomain.c                       |   12 +++--
 41 files changed, 195 insertions(+), 171 deletions(-)

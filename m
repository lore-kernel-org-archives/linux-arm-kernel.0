From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Sep 2012 23:36:05 +0200
Subject: [PATCH 00/12] New warnings and build errors in linux-next
Message-ID: <1348868177-21205-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

I've run my own build tests on the arm-soc tree, and now on linux-next
in order to find regressions on build warnings. These are a bunch of
patches that I came up with to address problems that were newly
introduced since 3.6 and that are not in the domain of the
arm-soc tree.

I'd hope to find someone for each patch to apply or rewrite it
in a better way. Sorry for any duplicates. I've made the patches
last week but had not gotten around to get them ready for submission,
it it may be possible that they are already fixed in one tree or
another.

	Arnd

Arnd Bergmann (12):
  mtd: atmel nand: build regression
  ata: mark probe function as __devinit rather than __init
  mmc: dw_mmc: fix building exynos driver as a module
  video: exynos: warnings in exynos_dp_core.c
  ARM: ixp4xx: use __iomem for MMIO
  sched: warnings in kernel/sched/fair.c
  staging/iio/lis3l02dq: fix building without irq_to_gpio
  dtc: be more quiet with "make -s"
  tty/console: fix warnings in drivers/tty/serial/kgdboc.c
  gpio: pcf857x: select IRQ_DOMAIN
  pinctrl: samsung: use __devinit section for init code
  time/jiffies: bring back unconditional LATCH definition

 arch/arm/mach-ixp4xx/include/mach/qmgr.h   |   12 ++++++------
 arch/arm/mach-ixp4xx/ixp4xx_qmgr.c         |    4 ++--
 drivers/ata/sata_highbank.c                |    2 +-
 drivers/gpio/Kconfig                       |    1 +
 drivers/mmc/host/dw_mmc-exynos.c           |    4 ++--
 drivers/mmc/host/dw_mmc-pltfm.c            |    2 +-
 drivers/mmc/host/dw_mmc-pltfm.h            |    2 +-
 drivers/mmc/host/dw_mmc.c                  |    2 +-
 drivers/mtd/nand/atmel_nand.c              |    8 ++++----
 drivers/pinctrl/pinctrl-samsung.c          |   10 +++++-----
 drivers/staging/iio/accel/lis3l02dq.h      |    1 +
 drivers/staging/iio/accel/lis3l02dq_core.c |   10 ++++++----
 drivers/staging/iio/accel/lis3l02dq_ring.c |    2 +-
 drivers/video/exynos/exynos_dp_core.c      |    2 +-
 include/linux/console.h                    |   10 ++++++++--
 include/linux/jiffies.h                    |    5 +++--
 include/linux/mmc/dw_mmc.h                 |    2 +-
 kernel/sched/fair.c                        |    2 +-
 scripts/Makefile.lib                       |    2 +-
 scripts/dtc/dtc.c                          |    5 +++--
 20 files changed, 50 insertions(+), 38 deletions(-)

-- 
1.7.10

From: horms@verge.net.au (Simon Horman)
Date: Sun, 28 Oct 2012 11:26:01 +0900
Subject: [GIT PULL v2] Renesas ARM-based SoC boards for v3.8
Message-ID: <1351391173-32379-1-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

please consider the following board enhancements for 3.8.

----------------------------------------------------------------
The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:

  Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git boards

for you to fetch changes up to 39fe22dd9b60c26a6e1a5279abfb6473d67723e6:

  ARM: mach-shmobile: Use DT_MACHINE for mackerel (2012-10-24 17:06:15 +0900)

----------------------------------------------------------------
Bastian Hecht (1):
      ARM: mach-shmobile: add FLCTL DMA slave definitions for sh7372

Kuninori Morimoto (6):
      ARM: shmobile: armadillo800eva: enable restart
      ARM: shmobile: r8a7779: add HSPI clock support
      ARM: shmobile: r8a7779: add I2C clock support
      ARM: shmobile: r8a7779: add I2C driver support
      ARM: shmobile: marzen: add HSPI support
      ARM: shmobile: r8a7740: fixup DT machine desc name typo

Nobuhiro Iwamatsu (2):
      ARM: shmobile: r8a7740: Enable PMU
      ARM: mach-shmobile: Use DT_MACHINE for mackerel

Tetsuyuki Kobayashi (3):
      ARM: shmobile: kzm9g: enable magnetometer ak8975.
      ARM: shmobile: kzm9g: enable three-axis digital accelerometer ADXL345
      ARM: shmobile: kzm9g: enable DMAEngine on SHDI0 and SDHI2

 arch/arm/boot/dts/Makefile                     |    3 +-
 arch/arm/boot/dts/sh7372-mackerel.dts          |   22 +++++++
 arch/arm/configs/armadillo800eva_defconfig     |    1 +
 arch/arm/configs/kzm9g_defconfig               |    4 ++
 arch/arm/configs/marzen_defconfig              |    4 ++
 arch/arm/mach-shmobile/Kconfig                 |    1 +
 arch/arm/mach-shmobile/board-armadillo800eva.c |    8 +++
 arch/arm/mach-shmobile/board-kzm9g.c           |   14 ++++-
 arch/arm/mach-shmobile/board-mackerel.c        |    8 ++-
 arch/arm/mach-shmobile/board-marzen.c          |   25 ++++++++
 arch/arm/mach-shmobile/clock-r8a7779.c         |   16 ++++-
 arch/arm/mach-shmobile/include/mach/sh7372.h   |    4 ++
 arch/arm/mach-shmobile/setup-r8a7740.c         |   18 +++++-
 arch/arm/mach-shmobile/setup-r8a7779.c         |   77 ++++++++++++++++++++++++
 arch/arm/mach-shmobile/setup-sh7372.c          |   20 ++++++
 15 files changed, 220 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/boot/dts/sh7372-mackerel.dts

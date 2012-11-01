From: horms@verge.net.au (Simon Horman)
Date: Thu,  1 Nov 2012 08:40:03 +0800
Subject: [GIT PULL v3] Renesas ARM-based SoC boards for v3.8
Message-ID: <1351730411-1874-1-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

please consider the following board enhancements for 3.8.

This differs from v2 of this pull request in that:
* Several patches have been moved to the soc branch which
  I will send a pull request for shortly.
  - ARM: shmobile: r8a7779: add HSPI clock support
  - ARM: shmobile: r8a7779: add I2C clock support
  - ARM: shmobile: r8a7779: add I2C driver support
  - ARM: shmobile: r8a7740: Enable PMU
* Several new patches have been added.
  - ARM: shmobile: Remove G4EVM machine support
  - ARM: shmobile: Remove G3EVM machine support

---------------------------------------------------------------
The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:

  Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git boards

for you to fetch changes up to 631a7b5d958d2ef2c2333b105794c693642f0641:

  ARM: shmobile: Remove G4EVM machine support (2012-10-30 15:25:59 +0800)

----------------------------------------------------------------
Kuninori Morimoto (2):
      ARM: shmobile: armadillo800eva: enable restart
      ARM: shmobile: marzen: add HSPI support

Nobuhiro Iwamatsu (3):
      ARM: mach-shmobile: Use DT_MACHINE for mackerel
      ARM: shmobile: Remove G3EVM machine support
      ARM: shmobile: Remove G4EVM machine support

Tetsuyuki Kobayashi (3):
      ARM: shmobile: kzm9g: enable magnetometer ak8975.
      ARM: shmobile: kzm9g: enable three-axis digital accelerometer ADXL345
      ARM: shmobile: kzm9g: enable DMAEngine on SHDI0 and SDHI2

 arch/arm/boot/dts/Makefile                     |    3 +-
 arch/arm/boot/dts/sh7372-mackerel.dts          |   22 ++
 arch/arm/configs/g3evm_defconfig               |   57 ----
 arch/arm/configs/g4evm_defconfig               |   57 ----
 arch/arm/configs/kzm9g_defconfig               |    4 +
 arch/arm/configs/marzen_defconfig              |    4 +
 arch/arm/mach-shmobile/Kconfig                 |   17 +-
 arch/arm/mach-shmobile/Makefile                |    2 -
 arch/arm/mach-shmobile/board-armadillo800eva.c |    8 +
 arch/arm/mach-shmobile/board-g3evm.c           |  343 ---------------------
 arch/arm/mach-shmobile/board-g4evm.c           |  384 ------------------------
 arch/arm/mach-shmobile/board-kzm9g.c           |   14 +-
 arch/arm/mach-shmobile/board-mackerel.c        |    8 +-
 arch/arm/mach-shmobile/board-marzen.c          |   25 ++
 14 files changed, 87 insertions(+), 861 deletions(-)
 create mode 100644 arch/arm/boot/dts/sh7372-mackerel.dts
 delete mode 100644 arch/arm/configs/g3evm_defconfig
 delete mode 100644 arch/arm/configs/g4evm_defconfig
 delete mode 100644 arch/arm/mach-shmobile/board-g3evm.c
 delete mode 100644 arch/arm/mach-shmobile/board-g4evm.c

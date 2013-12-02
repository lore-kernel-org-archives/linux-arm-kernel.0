From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  2 Dec 2013 11:18:47 +0900
Subject: [GIT PULL 00/28] Renesas ARM based SoC updates for v3.14 
Message-ID: <cover.1385950394.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin, Hi Olof, Hi Arnd,

please consider these Renesas ARM based SoC updates for v3.14.

This pull-request is based on "[GIT PULL 00/16] Renesas ARM based SoC
defconfig updates for v3.14" (tag: renesas-defconfig-for-v3.14) which I
send a pull-request for on Thursday. The reason for this is to include
defconfig updates for the emma2 based kzm9d which are required in order to
avoid a build regression when using the defconfig for that board.

This pull-request also includes defconfig changes related to renaming
ARCH_SHMOBILE to ARCH_SHMOBILE_LEGACY. These are also to avoid build
regressions when using defconfigs.


The following changes since commit 577092b3d11530acd8467074f6ea7e2dd36b5028:

  ARM: shmobile: kzm9d: Enable AUTO_ZRELADDR in defconfig (2013-11-24 15:13:43 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-for-v3.14

for you to fetch changes up to ab2a46c04ba1315831503cfb286780dc299ce888:

  ARM: shmobile: r8a7790: tidyup clock table order (2013-11-24 15:15:57 +0900)

----------------------------------------------------------------
Renesas ARM based SoC updates for v3.14

* Rename ARCH_SHMOBILE to ARCH_SHMOBILE_LEGACY
  - Includes defconfig change to avoid breaing bisection

* r8a7791 SoC (R-Car M2)
  - Add thermal platform device
  - Add DU and LVDS clocks
  - GPIO platform device support
  - PFC platform device support
  - Select IRQC

* r8a7790 SoC (R-Car H2)
  - Tidyup clock table order
  - Fixup I2C clock source
  - Correct EXTAL divider settings
  - Add clocks for thermal devices

* r8a7779 SoC (R-Car H1)
  - Add I2C clock for DT

* r8a7778 SoC (R-Car M1)
  - Add HSPI clocks for DT
  - Add I2C clock for DT

* emev2 SoC (Emma Mobile)
  - Move to Multi-platform
  - Remove legacy board code

* r7s72100 SoC (RZ/A1H)
  - Select GPIO

* r8a73a4 SoC (R-Mobile APE6)
  - Don't used named IRC for DMAEngine

----------------------------------------------------------------
Hiep Cao Minh (1):
      ARM: shmobile: r8a7790: add QSPI support

Kuninori Morimoto (10):
      ARM: shmobile: r8a7778: add I2C clock for DT
      ARM: shmobile: r8a7779: add I2C clock for DT
      ARM: shmobile: r8a73a4: don't use named irq for DMAEngine
      ARM: shmobile: r8a7778: add MMCIF clock support for DT
      ARM: shmobile: r8a7778: add SDHI clock support for DT
      ARM: shmobile: r8a7779: add SDHI clock support for DT
      ARM: shmobile: r8a7778: add HSPI clock support for DT
      ARM: shmobile: r8a7790: care EXTAL divider settings
      ARM: shmobile: r8a7790: fixup I2C clock source
      ARM: shmobile: r8a7790: tidyup clock table order

Laurent Pinchart (2):
      ARM: shmobile: r8a7791: Add DU and LVDS clocks
      ARM: Rename ARCH_SHMOBILE to ARCH_SHMOBILE_LEGACY

Magnus Damm (14):
      ARM: shmobile: Select IRQC in case of the r8a7791 SoC
      ARM: shmobile: r8a7791 PFC platform device support
      ARM: shmobile: Select GPIO in case of the r8a7791 SoC
      ARM: shmobile: r8a7791 GPIO platform device support
      ARM: shmobile: Select GPIO in case of the r7s72100 SoC
      ARM: shmobile: Enable MTU2 on r7s72100
      ARM: shmobile: Add shared EMEV2 code for ->init_machine()
      ARM: shmobile: Use ->init_late() in shared EMEV2 case
      ARM: shmobile: Remove legacy KZM9D board code
      ARM: shmobile: Remove legacy platform devices from EMEV2 SoC code
      ARM: shmobile: Select USE_OF on EMEV2
      ARM: shmobile: Add r8a7790 clocks for thermal devices
      ARM: shmobile: Add r8a7791 thermal platform device
      ARM: shmobile: Add r8a7791 clocks for thermal devices

Valentine Barshak (1):
      ARM: shmobile: r8a7790: Add USBHS clock support

 arch/arm/Kconfig                              |  14 ++-
 arch/arm/Makefile                             |   1 -
 arch/arm/boot/compressed/Makefile             |   2 +-
 arch/arm/boot/dts/Makefile                    |   2 +-
 arch/arm/configs/ape6evm_defconfig            |   2 +-
 arch/arm/configs/armadillo800eva_defconfig    |   2 +-
 arch/arm/configs/bockw_defconfig              |   2 +-
 arch/arm/configs/genmai_defconfig             |   2 +-
 arch/arm/configs/koelsch_defconfig            |   2 +-
 arch/arm/configs/kzm9d_defconfig              |   2 +-
 arch/arm/configs/kzm9g_defconfig              |   2 +-
 arch/arm/configs/lager_defconfig              |   2 +-
 arch/arm/configs/mackerel_defconfig           |   2 +-
 arch/arm/configs/marzen_defconfig             |   2 +-
 arch/arm/mach-shmobile/Kconfig                |  18 +--
 arch/arm/mach-shmobile/Makefile               |   1 -
 arch/arm/mach-shmobile/Makefile.boot          |   1 -
 arch/arm/mach-shmobile/board-kzm9d.c          |  92 ---------------
 arch/arm/mach-shmobile/clock-r7s72100.c       |   1 +
 arch/arm/mach-shmobile/clock-r8a7778.c        |  11 ++
 arch/arm/mach-shmobile/clock-r8a7779.c        |   8 ++
 arch/arm/mach-shmobile/clock-r8a7790.c        |  33 ++++--
 arch/arm/mach-shmobile/clock-r8a7791.c        |  14 ++-
 arch/arm/mach-shmobile/include/mach/emev2.h   |   5 -
 arch/arm/mach-shmobile/include/mach/r8a7791.h |   1 +
 arch/arm/mach-shmobile/setup-emev2.c          | 163 ++------------------------
 arch/arm/mach-shmobile/setup-r7s72100.c       |  22 ++++
 arch/arm/mach-shmobile/setup-r8a73a4.c        |   2 +-
 arch/arm/mach-shmobile/setup-r8a7791.c        |  65 ++++++++++
 drivers/Makefile                              |   2 +-
 30 files changed, 187 insertions(+), 291 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/board-kzm9d.c

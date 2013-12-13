From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:29:33 +0900
Subject: [GIT PULL v2 00/33] Renesas ARM based SoC updates for v3.14
Message-ID: <cover.1386897180.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin, Hi Olof, Hi Arnd,

please consider these Renesas ARM based SoC updates for v3.14.

As discussed elsewhere, this pull-request also includes defconfig changes
related to renaming ARCH_SHMOBILE to ARCH_SHMOBILE_LEGACY. These are also
to avoid build regressions when using defconfigs

As this pull request is based on v3.12, which does not include
genmai_defconfig, it has not been updated. Rather, I have queued up a patch
in my defconfig to switch it to use ARCH_SHMOBILE_LEGACY.  This does
involve breaking that defconfig. However as it is new and not in
wide-spread use it seems better to live with that temporary breakage than
to have soc depend on defconfig (as was the case in the previous version of
this pull request).


The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-for-v3.14

for you to fetch changes up to fee05eb3d2ce4813b5e9a70ab888d2bc0047f4e1:

  ARM: shmobile: r8a7779: add HSPI clock support for DT (2013-12-10 17:20:15 +0900)

----------------------------------------------------------------
Renesas ARM based SoC updates for v3.14

* Rename ARCH_SHMOBILE to ARCH_SHMOBILE_LEGACY

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
  - Add clocks for thermal devices and SSI

* r8a7779 SoC (R-Car H1)
  - Add I2C clock for DT

* r8a7778 SoC (R-Car M1)
  - Add HSPI clocks for DT
  - Add I2C clock for DT
  - Add HPBIFx DMAEngine support

* r8a7740 SoC (R-Mobile A1)
  - Add FSI clocks for DT

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

Kuninori Morimoto (13):
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
      ARM: shmobile: r8a7778: add HPBIFx DMAEngine support
      ARM: shmobile: r8a7790: add SSI MSTP clocks
      ARM: shmobile: r8a7740: add FSI clock support for DT

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

Simon Horman (2):
      ARM: shmobile: Select AUTO_ZRELADDR for EMEV2
      ARM: shmobile: r8a7779: add HSPI clock support for DT

Valentine Barshak (1):
      ARM: shmobile: r8a7790: Add USBHS clock support

 arch/arm/Kconfig                              |  14 ++-
 arch/arm/Makefile                             |   1 -
 arch/arm/boot/compressed/Makefile             |   2 +-
 arch/arm/boot/dts/Makefile                    |   2 +-
 arch/arm/configs/ape6evm_defconfig            |   2 +-
 arch/arm/configs/armadillo800eva_defconfig    |   2 +-
 arch/arm/configs/bockw_defconfig              |   2 +-
 arch/arm/configs/koelsch_defconfig            |   2 +-
 arch/arm/configs/kzm9d_defconfig              |   2 +-
 arch/arm/configs/kzm9g_defconfig              |   2 +-
 arch/arm/configs/lager_defconfig              |   2 +-
 arch/arm/configs/mackerel_defconfig           |   2 +-
 arch/arm/configs/marzen_defconfig             |   2 +-
 arch/arm/mach-shmobile/Kconfig                |  19 +--
 arch/arm/mach-shmobile/Makefile               |   1 -
 arch/arm/mach-shmobile/Makefile.boot          |   1 -
 arch/arm/mach-shmobile/board-kzm9d.c          |  92 ---------------
 arch/arm/mach-shmobile/clock-r7s72100.c       |   1 +
 arch/arm/mach-shmobile/clock-r8a7740.c        |   1 +
 arch/arm/mach-shmobile/clock-r8a7778.c        |  11 ++
 arch/arm/mach-shmobile/clock-r8a7779.c        |  11 ++
 arch/arm/mach-shmobile/clock-r8a7790.c        |  58 +++++++--
 arch/arm/mach-shmobile/clock-r8a7791.c        |  14 ++-
 arch/arm/mach-shmobile/include/mach/emev2.h   |   5 -
 arch/arm/mach-shmobile/include/mach/r8a7778.h |  18 +++
 arch/arm/mach-shmobile/include/mach/r8a7791.h |   1 +
 arch/arm/mach-shmobile/setup-emev2.c          | 163 ++------------------------
 arch/arm/mach-shmobile/setup-r7s72100.c       |  22 ++++
 arch/arm/mach-shmobile/setup-r8a73a4.c        |   2 +-
 arch/arm/mach-shmobile/setup-r8a7778.c        |  51 ++++++++
 arch/arm/mach-shmobile/setup-r8a7791.c        |  65 ++++++++++
 drivers/Makefile                              |   2 +-
 32 files changed, 285 insertions(+), 290 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/board-kzm9d.c

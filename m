From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Feb 2014 15:17:08 +0900
Subject: [GIT PULL 00/21] Renesas ARM based SoC Board Updates for v3.15
Message-ID: <cover.1391665225.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

please consider these Renesas ARM based SoC board updates for v3.15.


The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-boards-for-v3.15

for you to fetch changes up to 235cda29e4d5047622ff9b82b1f0b4cb6cf95f6c:

  ARM: shmobile: Remove Lager USBHS UDC ifdefs (2014-02-04 14:28:33 +0900)

----------------------------------------------------------------
Renesas ARM based SoC Board Updates for v3.15

* r8a7791 (R-Car M2) based Koelsch board
  - Fix error return code check from clk_get()
  - Add SATA0 support
  - Conditionally select MICREL_PHY for Multiplatform

* r8a7790 (R-Car H2) based Lager board
  - Add USBHS support
  - Fix error return code check from clk_get()
  - Add SATA support
  - Make spi_flash_data const
  - Add VIN1 SoC camera support
  - Conditionally select CONFIG_MICREL_PHY

* r8a7778 (R-Car M1) based Bock-W board
  - Add USB Func DMAEngine support
  - Use HPBIF DMAEngine for sound
  - Use SSI DMAEngine for sound

* emev2 (Emma Mobile EV2) based kzm9d board
  - Use common clock framework

* r8a773a0 (SH-Mobile AG5) based kzm9g board
  - Add zboot support

* Many boards
  - Conditionally select SMSC_PHY

----------------------------------------------------------------
Ben Dooks (2):
      ARM: shmobile: lager: fix error return code check from clk_get()
      ARM: shmobile: koelsch: fix error return code check from clk_get()

Geert Uytterhoeven (1):
      ARM: shmobile: lager: Make spi_flash_data const

Kuninori Morimoto (3):
      ARM: shmobile: bockw: use SSI DMAEngine for sound
      ARM: shmobile: bockw: use HPBIF DMAEngine for sound
      ARM: shmobile: bockw: add USB Func DMAEngine support

Magnus Damm (1):
      ARM: shmobile: Remove Lager USBHS UDC ifdefs

Sergei Shtylyov (1):
      ARM: shmobile: Lager: conditionally select CONFIG_MICREL_PHY

Simon Horman (7):
      ARM: shmobile: koelsch: Conditionally select MICREL_PHY for Multiplatform
      ARM: shmobile: ape6evm: Conditionally select SMSC_PHY
      ARM: shmobile: armadillo800eva: Conditionally select SMSC_PHY
      ARM: shmobile: bockw: Sort Kconfig node's selections
      ARM: shmobile: kzm9d: Conditionally select SMSC_PHY
      ARM: shmobile: mackerel: Conditionally select SMSC_PHY
      ARM: shmobile: marzen: Conditionally select SMSC_PHY

Takashi Yoshii (1):
      ARM: shmobile: kzm9d: Use common clock framework

Ulrich Hecht (1):
      ARM: mach-shmobile: kzm9g: add zboot support

Valentine Barshak (4):
      ARM: shmobile: lager: Add VIN1 SoC camera support
      ARM: shmobile: lager: Add SATA support
      ARM: shmobile: koelsch: Add SATA0 support
      ARM: shmobile: lager: Add USBHS support

 arch/arm/mach-shmobile/Kconfig                     |  15 +-
 arch/arm/mach-shmobile/board-bockw.c               |  24 +-
 arch/arm/mach-shmobile/board-koelsch-reference.c   |   4 +-
 arch/arm/mach-shmobile/board-koelsch.c             |  17 +
 arch/arm/mach-shmobile/board-kzm9d-reference.c     |   5 +-
 arch/arm/mach-shmobile/board-lager-reference.c     |   4 +-
 arch/arm/mach-shmobile/board-lager.c               | 229 +++++++++++-
 arch/arm/mach-shmobile/include/mach/head-kzm9g.txt | 410 +++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/zboot.h        |   3 +
 arch/arm/mach-shmobile/include/mach/zboot_macros.h |  43 +++
 10 files changed, 737 insertions(+), 17 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/include/mach/head-kzm9g.txt

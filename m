From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Dec 2013 11:06:53 +0900
Subject: [GIT PULL 00/26] Renesas ARM based SoC board updates for v3.14
Message-ID: <cover.1387763524.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ea8d8a911f4850312834a0ff45c3d5ebc31fb1f1:

  Merge tag 'renesas-cleanup-for-v3.14' into boards-base (2013-12-10 17:22:55 +0900)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-boards-for-v3.14

for you to fetch changes up to be0647d556985ae58a42e7fc3751a293c418c41e:

  ARM: shmobile: lager: add gpio/fixed regulator for SDHI (2013-12-10 17:24:50 +0900)

----------------------------------------------------------------
Renesas ARM based SoC board updates for v3.14

* Global
  - Kconfig: Mention Renesas ARM SoCs instead of SH-Mobile

* r7s72100 SoC (RZ/A1H) based Genmai Board
  - Add Multiplatform support
  - Add Reference DT

* r8a7791 (R-Car M2) based Koelsch board
  - Add pinctrl_register_mappings() for Koelsch
  - Hook up SW30-SW36 on Koelsch
  - Mark GPIO keys as wake-up sources
  - Use ->init_late()
  - Add Multiplatform support
  - Set .debounce_interval for GPIO keys
  - Add SW2 to GPIO keys
  - Add Led 6, 7 and 8 support
  - Add reference DT
  - Enable PFC/GPIO

* r8a7790 (R-Car H2) based Lager board
  - Add gpio/fixed regulator for SDHI
  - Add SPI FLASH support on QSPI
  - Mark GPIO keys as wake-up sources
  - Use ->init_late()
  - Set .debounce_interval for GPIO keys

* r8a7778 (R-Car M1) based Bock-W board
  - bockw: remove unused RSND_SSI_CLK_FROM_ADG
  - Set .debounce_interval for GPIO keys
  - Correct FPGA ioremap area
  - Use regulator for MMCIF

* r8a7740 (R-Mobile A1) based Armadillo board
  - Correct FSI address size

* sh7374 (SH-Mobile AP4) based Mackerel board
  - Use pinconf API to configure pin pull-down
  - clk_round_rate() can return a zero to indicate an error

----------------------------------------------------------------
Hiep Cao Minh (1):
      ARM: shmobile: Lager:add SPI FLASH support on QSPI

Kuninori Morimoto (6):
      ARM: shmobile: bockw: use regulator for MMCIF
      ARM: shmobile: bockw: fixup FPGA ioremap area
      ARM: shmobile: bockw: add pin pull-up setting for SDHI
      ARM: shmobile: armadillo: fixup FSI address size
      ARM: shmobile: bockw: remove unused RSND_SSI_CLK_FROM_ADG
      ARM: shmobile: lager: add gpio/fixed regulator for SDHI

Laurent Pinchart (2):
      ARM: shmobile: mackerel: Use pinconf API to configure pin pull-down
      ARM: Kconfig: Mention Renesas ARM SoCs instead of SH-Mobile

Magnus Damm (13):
      ARM: shmobile: Enable PFC/GPIO on the Koelsch board
      ARM: shmobile: Add Koelsch LED6, LED7 and LED8 support
      ARM: shmobile: Add Koelsch SW2 support
      ARM: shmobile: r8a7791 Koelsch DT reference C bits
      ARM: shmobile: Initial r8a7791 and Koelsch multiplatform support
      ARM: shmobile: r7s72100 Genmai DT reference DTS bits
      ARM: shmobile: r7s72100 Genmai DT reference C bits
      ARM: shmobile: r7s72100 Genmai Multiplatform
      ARM: shmobile: Use ->init_late() on Koelsch
      ARM: shmobile: koelsch: mark GPIO keys as wake-up sources
      ARM: shmobile: Hook up SW30-SW36 on Koelsch
      ARM: shmobile: Use ->init_late() on Lager
      ARM: shmobile: Add pinctrl_register_mappings() for Koelsch

Paul Walmsley (1):
      ARM: shmobile: mackerel: clk_round_rate() can return a zero to indicate an error

Shinya Kuribayashi (2):
      ARM: shmobile: lager: set .debounce_interval
      ARM: shmobile: lager: mark GPIO keys as wake-up sources

Simon Horman (1):
      ARM: shmobile: koelsch: set .debounce_interval

 arch/arm/Kconfig                                 |   7 +-
 arch/arm/boot/dts/Makefile                       |   5 +-
 arch/arm/boot/dts/r7s72100-genmai-reference.dts  |  31 +++++
 arch/arm/mach-shmobile/Kconfig                   |  55 +++++++--
 arch/arm/mach-shmobile/Makefile                  |   4 +
 arch/arm/mach-shmobile/Makefile.boot             |   4 +-
 arch/arm/mach-shmobile/board-armadillo800eva.c   |   2 +-
 arch/arm/mach-shmobile/board-bockw-reference.c   |  19 ++-
 arch/arm/mach-shmobile/board-bockw.c             |  17 ++-
 arch/arm/mach-shmobile/board-genmai-reference.c  |  49 ++++++++
 arch/arm/mach-shmobile/board-koelsch-reference.c |  53 ++++++++
 arch/arm/mach-shmobile/board-koelsch.c           |  73 ++++++++++-
 arch/arm/mach-shmobile/board-lager-reference.c   |   2 +
 arch/arm/mach-shmobile/board-lager.c             | 151 ++++++++++++++++++++++-
 arch/arm/mach-shmobile/board-mackerel.c          |  21 ++--
 arch/arm/mach-shmobile/sh-gpio.h                 |  19 ---
 include/sound/rcar_snd.h                         |   1 -
 17 files changed, 458 insertions(+), 55 deletions(-)
 create mode 100644 arch/arm/boot/dts/r7s72100-genmai-reference.dts
 create mode 100644 arch/arm/mach-shmobile/board-genmai-reference.c
 create mode 100644 arch/arm/mach-shmobile/board-koelsch-reference.c

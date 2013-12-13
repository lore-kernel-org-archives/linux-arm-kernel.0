From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:31:12 +0900
Subject: [GIT PULL 00/69] Renesas ARM based SoC DT updates for v3.14
Message-ID: <cover.1386901186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC DT updates for v3.14.

This pull request is based on renesas-soc-for-v3.14 (v2) which I
also sent a pull request for today.

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-for-v3.14

for you to fetch changes up to 1fd219561a4afc51b5f257692f3581546434db5b:

  ARM: shmobile: marzen: enable HSPI0 in DTS (2013-12-10 17:27:25 +0900)

----------------------------------------------------------------
Renesas ARM based SoC DT updates for v3.14

* Global
  - Use interrupt macros
  - Use #include in device tree sources
  - Tidyup DT node naming

* emev2 (Emma Mobile EV2) SoC
  - Setup internal peripheral interrupts as level high
  - Use interrupt macros in DT files
  - Add clock tree description in DT

* r8a7791 (R-Car M2) SoC
  - Correct GPIO resources

* r8a7791 (R-Car M2) based Koelsch board
  - Configure PFC and GPO
  - Use r8a7791 suffix for IRQC compat string
  - Add DT reference

* r8a7790 (R-Car H2) based Lager board
  - Include all 4 GiB of memory
  - Use r8a7790 suffix for IRQC and MMCIF compat strings
  - Enable MMCIF
  - Add default PFC settings

* r8a7778 (R-Car M1) SoC
  - Suffix for INTC compat string
  - Add HSPI, MMCIF, SDHI and I2C suppport on DTSI
  - Correct pin control device addresses

* r8a7778 (R-Car M1) based Bock-W board
  - Use falling edge IRQ for LAN9221 in DT reference
  - Enable I2C, HSPI0, MMCIF and SDHI
  - Correct MMC pin conflict
  - Remove manual PFC settings from DT reference
  - Add default PFC settings

* r8a7779 (R-Car H1) SoC
  - Add HSPI and SDHI support
  - Suffix for INTC compat string

* r8a7779 (R-Car H1) based Marzen board
  - Enable HSPI0 and SDHI in DTS
  - Remove SDHI0 WP pin setting
  - Use falling edge IRQ for LAN9221 in DT reference
  - Add SDHI support

* r8a7740 (R-Mobile A1) SoC
  - Suffix for INTC compat string
  - Add FSI support via DTSI
  - Use interrupt macros

* r8a7740 based Armadillo board
  - Add FSI support for DTS
  - Use low level IRQ for ST1231 in DT reference

* r8a73a4 (SH-Mobile APE6) SoC
  - Use interrupt macros in DT files

* r8a73a4 (R-Mobile APE6) based ape6evm board
  - Include all 2 GiB of memory

* r8a73a0 (SH-Mobile AG5) SoC
  - Correct SDHI compat string

* r8a73a0 (SH-Mobile AG5) based kzm9d board
  - Add GPIO keys and Add PCF8575 GPIO extender to DT
  - Enable DSW2 with gpio-keys
  - Use falling edge IRQ for LAN9221 in DT reference

----------------------------------------------------------------
Hiep Cao Minh (1):
      ARM: shmobile: r8a7790: add QSPI support

Kuninori Morimoto (46):
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
      ARM: shmobile: r8a7778: add I2C support on DTSI
      ARM: shmobile: r8a7779: tidyup I2C driver name on DTSI
      ARM: shmobile: lager: add default PFC settings on DTS
      ARM: shmobile: lager: add MMCIF support on DTS
      ARM: shmobile: bockw: add default PFC settings on DTS
      ARM: shmobile: bockw: remove manual PFC settings on reference
      ARM: shmobile: r8a7778: add MMCIF support on DTSI
      ARM: shmobile: bockw: add MMCIF support on DTS
      ARM: shmobile: bockw: fixup MMC pin conflict on DTS
      ARM: shmobile: r8a7778: add SDHI support on DTSI
      ARM: shmobile: bockw: add SDHI support on DTS
      ARM: shmobile: r8a7779: add SDHI support on DTSI
      ARM: shmobile: marzen: add SDHI support on DTS
      ARM: shmobile: r8a7740: tidyup DT node naming
      ARM: shmobile: r8a73a4: tidyup DT node naming
      ARM: shmobile: r8a7778: tidyup DT node naming
      ARM: shmobile: r8a7779: tidyup DT node naming
      ARM: shmobile: r8a7790: tidyup DT node naming
      ARM: shmobile: sh73a0: tidyup DT node naming
      ARM: shmobile: armadillo: tidyup DT node naming
      ARM: shmobile: ape6evm: tidyup DT node naming
      ARM: shmobile: kzm9g: tidyup DT node naming
      ARM: shmobile: bockw: tidyup DT node naming
      ARM: shmobile: marzen: tidyup DT node naming
      ARM: shmobile: lager: tidyup DT node naming
      ARM: shmobile: r8a7778: add I2C support on DTSI
      ARM: shmobile: r8a7778: add HSPI suppport on DTSI
      ARM: shmobile: bockw: enable HSPI0 on DTS
      ARM: shmobile: marzen: remove SDHI0 WP pin setting from DTS
      ARM: shmobile: marzen: remove SDHI0 WP pin setting
      ARM: shmobile: sh73a0: fixup sdhi compatible name
      ARM: shmobile: r8a7740: add FSI support via DTSI
      ARM: shmobile: armadillo: add FSI support for DTS

Laurent Pinchart (15):
      ARM: shmobile: r8a7791: Add DU and LVDS clocks
      ARM: Rename ARCH_SHMOBILE to ARCH_SHMOBILE_LEGACY
      ARM: shmobile: r8a7778: Fix pin control device address in DT
      ARM: shmobile: Use #include in device tree sources
      ARM: shmobile: Use interrupt macros in SoC DT files
      ARM: shmobile: Use interrupt macros in board DT files
      ARM: shmobile: marzen-reference: Use falling edge IRQ for LAN9221
      ARM: shmobile: bockw-reference: Use falling edge IRQ for LAN9221
      ARM: shmobile: kzm9g-reference: Use falling edge IRQ for LAN9221
      ARM: shmobile: armadillo-reference: Use low level IRQ for ST1231
      ARM: shmobile: kzm9g-reference: Add PCF8575 GPIO extender to DT
      ARM: shmobile: kzm9g-reference: Add GPIO keys to DT
      ARM: shmobile: Use interrupt macros in r8a73a4 and r8a7778 DT files
      ARM: shmobile: emev2: Use interrupt macros in DT files
      ARM: shmobile: emev2: Setup internal peripheral interrupts as level high

Magnus Damm (33):
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
      ARM: shmobile: r8a7791 PFC device tree node
      ARM: shmobile: r8a7791 GPIO device tree node
      ARM: shmobile: r8a7791 Koelsch DT reference DTS bits
      ARM: shmobile: Use r8a7791 suffix for IRQC compat string
      ARM: shmobile: Configure r8a7791 PFC on Koelsch via DTS
      ARM: shmobile: Add r8a7790 thermal device node to DTS
      ARM: shmobile: Add r8a7791 thermal device node to DTS
      ARM: shmobile: Use r8a7790 suffix for MMCIF compat string
      ARM: shmobile: Use r8a7790 suffix for IRQC compat string
      ARM: shmobile: Enable DSW2 with gpio-keys on KZM9D
      ARM: shmobile: Koelsch DT reference GPIO LED support
      ARM: shmobile: Include all 2 GiB of memory on APE6EVM DT Ref
      ARM: shmobile: Include all 4 GiB of memory on Lager
      ARM: shmobile: Include all 4 GiB of memory on Lager DT Ref
      ARM: shmobile: Fix r8a7791 GPIO resources in DTS
      ARM: shmobile: Use sh73a0 suffix for INTC compat string
      ARM: shmobile: Use r8a7740 suffix for INTC compat string
      ARM: shmobile: Use r8a7778 suffix for INTC compat string
      ARM: shmobile: Use r8a7779 suffix for INTC compat string

Simon Horman (4):
      ARM: shmobile: Select AUTO_ZRELADDR for EMEV2
      ARM: shmobile: r8a7779: add HSPI clock support for DT
      ARM: shmobile: r8a7779: add HSPI support to DTSI
      ARM: shmobile: marzen: enable HSPI0 in DTS

Takashi Yoshii (2):
      ARM: shmobile: emev2: Add clock tree description in DT
      ARM: shmobile: Include all 2 GiB of memory on APE6EVM

Valentine Barshak (1):
      ARM: shmobile: r8a7790: Add USBHS clock support

 arch/arm/Kconfig                                   |  14 +-
 arch/arm/Makefile                                  |   1 -
 arch/arm/boot/compressed/Makefile                  |   2 +-
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/emev2-kzm9d.dts                  |  42 ++++-
 arch/arm/boot/dts/emev2.dtsi                       | 116 ++++++++++++--
 arch/arm/boot/dts/r7s72100-genmai.dts              |   2 +-
 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts    |  15 +-
 arch/arm/boot/dts/r8a73a4-ape6evm.dts              |  10 +-
 arch/arm/boot/dts/r8a73a4.dtsi                     | 168 ++++++++++++--------
 .../boot/dts/r8a7740-armadillo800eva-reference.dts |  50 +++++-
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts      |   2 +-
 arch/arm/boot/dts/r8a7740.dtsi                     | 135 +++++++++-------
 arch/arm/boot/dts/r8a7778-bockw-reference.dts      |  57 ++++++-
 arch/arm/boot/dts/r8a7778-bockw.dts                |   2 +-
 arch/arm/boot/dts/r8a7778.dtsi                     | 172 +++++++++++++++++++--
 arch/arm/boot/dts/r8a7779-marzen-reference.dts     |  36 ++++-
 arch/arm/boot/dts/r8a7779-marzen.dts               |   2 +-
 arch/arm/boot/dts/r8a7779.dtsi                     | 114 +++++++++++---
 arch/arm/boot/dts/r8a7790-lager-reference.dts      |  46 +++++-
 arch/arm/boot/dts/r8a7790-lager.dts                |   7 +-
 arch/arm/boot/dts/r8a7790.dtsi                     |  73 +++++----
 arch/arm/boot/dts/r8a7791-koelsch-reference.dts    |  61 ++++++++
 arch/arm/boot/dts/r8a7791-koelsch.dts              |   2 +-
 arch/arm/boot/dts/r8a7791.dtsi                     | 144 +++++++++++++++--
 arch/arm/boot/dts/sh7372-mackerel.dts              |   2 +-
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts       |  70 ++++++++-
 arch/arm/boot/dts/sh73a0-kzm9g.dts                 |   2 +-
 arch/arm/boot/dts/sh73a0.dtsi                      | 150 +++++++++---------
 arch/arm/configs/ape6evm_defconfig                 |   2 +-
 arch/arm/configs/armadillo800eva_defconfig         |   2 +-
 arch/arm/configs/bockw_defconfig                   |   2 +-
 arch/arm/configs/koelsch_defconfig                 |   2 +-
 arch/arm/configs/kzm9d_defconfig                   |   2 +-
 arch/arm/configs/kzm9g_defconfig                   |   2 +-
 arch/arm/configs/lager_defconfig                   |   2 +-
 arch/arm/configs/mackerel_defconfig                |   2 +-
 arch/arm/configs/marzen_defconfig                  |   2 +-
 arch/arm/mach-shmobile/Kconfig                     |  19 ++-
 arch/arm/mach-shmobile/Makefile                    |   1 -
 arch/arm/mach-shmobile/Makefile.boot               |   1 -
 arch/arm/mach-shmobile/board-bockw-reference.c     |  12 --
 arch/arm/mach-shmobile/board-kzm9d.c               |  92 -----------
 arch/arm/mach-shmobile/board-marzen.c              |   2 -
 arch/arm/mach-shmobile/clock-r7s72100.c            |   1 +
 arch/arm/mach-shmobile/clock-r8a73a4.c             |  10 +-
 arch/arm/mach-shmobile/clock-r8a7740.c             |   9 +-
 arch/arm/mach-shmobile/clock-r8a7778.c             |  11 ++
 arch/arm/mach-shmobile/clock-r8a7779.c             |  11 ++
 arch/arm/mach-shmobile/clock-r8a7790.c             |  70 +++++++--
 arch/arm/mach-shmobile/clock-r8a7791.c             |  14 +-
 arch/arm/mach-shmobile/clock-sh73a0.c              |   8 +-
 arch/arm/mach-shmobile/include/mach/emev2.h        |   5 -
 arch/arm/mach-shmobile/include/mach/r8a7778.h      |  18 +++
 arch/arm/mach-shmobile/include/mach/r8a7791.h      |   1 +
 arch/arm/mach-shmobile/setup-emev2.c               | 163 ++-----------------
 arch/arm/mach-shmobile/setup-r7s72100.c            |  22 +++
 arch/arm/mach-shmobile/setup-r8a73a4.c             |   2 +-
 arch/arm/mach-shmobile/setup-r8a7778.c             |  51 ++++++
 arch/arm/mach-shmobile/setup-r8a7791.c             |  65 ++++++++
 drivers/Makefile                                   |   2 +-
 61 files changed, 1463 insertions(+), 645 deletions(-)
 create mode 100644 arch/arm/boot/dts/r8a7791-koelsch-reference.dts
 delete mode 100644 arch/arm/mach-shmobile/board-kzm9d.c

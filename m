From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:17:37 +0200
Subject: [GIT PULL] Renesas ARM Based SoC DT Updates for v4.18
Message-ID: <cover.1526641667.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC DT updates for v4.18.


The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-for-v4.18

for you to fetch changes up to 7fad92d05887319998b8d2bb40082b8b224d5ef5:

  ARM: dts: r8a7740: Add CEU1 (2018-05-16 10:54:50 +0200)

----------------------------------------------------------------
Renesas ARM Based SoC DT Updates for v4.18

* R-Mobile A1 (r8a7740) SoC
  - Describe CEU, IRQC, SYS-DMAC and USB devices

  - Cleanup for consistency with other Renesas SoCs and enhanced maintainability
    + Stop grouping clocks under a "clocks" subnode
    + Add soc node
    + Sort subnodes of root and soc nodes

* RZ/A1H (r7s72100) SoC
  - Describe CEU device

* R-Car Gen2, RZ/G1 and RZ/A1H SoCs
  - Add PMU device nodes

    Geert Uytterhoeven says: "This patch series enables support for the ARM
    Performance Monitor Units in Cortex-A7, Cortex-A9, and Cortex-A15 CPU
    cores on Renesas RZ/A1, R-Car Gen2, and RZ/G1 SoCs.  This allows for
    better performance analysis using the "perf" tool."

* RZ/A1H (r7s72100) SoC
  - Correct interrupt types

    Geert Uytterhoeven says "RZ/A1H peripherals use a mix of level and edge
    interrupts.

    This patch series corrects the interrupt types for watchdog and RTC from
    edge to level, to match the datasheet."

* R-Mobile APE6 (r8a73a4) APE4EVM board and SH-Mobile AG5 (sh73a0) SoC
  - Use generic disable-wp instead of now deprecated
    toshiba,mmc-wrprotect-disable property

* EMMA Mobile EV2 (emev2) and SH-Mobile AG5 (sh73a0) SoCs
  - Add missing interrupt-affinity to PMU

    Geert Uytterhoeven says "The Cortex-A9 PMU nodes on SH-Mobile AG5 and
    Emma Mobile EV2 reference two interrupts, but lack interrupt-affinity
    properties, leading to:

    hw perfevents: no interrupt-affinity property for /pmu, guessing.

    This series adds the missing properties to fix this."

* R-Car H2 (r8a7790) and R-Mobile APE6 (r8a73a4) SoCs
  - Correct mask for GIC PPI interrupts

    Geert Uytterhoeven says "R-Car H2 and R-Mobile APE6 contain four
    Cortex-A15 and four Cortex-A7 cores, hence the second interrupt
    specifier cell for Private Peripheral Interrupts should use
    "GIC_CPU_MASK_SIMPLE(8)", to make sure interrupts can be delivered to
    all 8 processor cores.

    This brings the predecessors of R-Car Gen3 in line with what we're
    doing on other big.LITTLE SoCs, like R-Car H3 and M3-W."

* Alt board for R-Car E2 (r8a7794) SoC

* RBoards for -Car Gen2 SoCs and kzm9d board for EMMA Mobile EV2 (emev2) SoC
  - Drop unnecessary address properties from VIN port nodes

    These are unnecessary as the nodes to not have bus addresses.

* R-Car H2 (r8a7790), M2-W (r8a7791), M2-N (r8a7793) and E2 (r8a7794) SoCs
  - Describe FDP1 instances

* iW-RainboW-G23S board for RZ/G1C (r8a77470) SoC
  - Initial SoC and board support

  - Enable EtherAVB

  - Describe all SCIF devices

* Boards for R-Car Gen2 SoCs
  - Enable watchdog support

    Geert Uytterhoeven says "This patch series enables the builtin watchdog
    timer on R-Car Gen2 SoCs on all supported boards, and builds on top of
    Fabrizio's "[RFC v4 00/26] Fix watchdog on Renesas R-Car Gen2 and
    RZ/G1"."

* R-Car Gen2 and RZ/G1 SoCs
  - Describe watchdog devices

  - For R-Car Gen2 this involves updating the SMP routine side as
    it is changed by a driver updated to allow watchdog device support

* Wheat board for V2H (r8a7792) SoC
  - Correct ADV7513 address usage

    Kieran Bingham says "The r8a7792 Wheat board has two ADV7513 devices
    sharing a single I2C bus, however in low power mode the ADV7513 will
    reset it's slave maps to use the hardware defined default addresses.

    The ADV7511 driver was adapted to allow the two devices to be
    registered correctly - but it did not take into account the fault
    whereby the devices reset the addresses.

    This results in an address conflict between the device using the
    default addresses, and the other device if it is in low-power-mode.

    Repair this issue by moving both devices away from the default address
    definitions."

----------------------------------------------------------------
Biju Das (8):
      ARM: dts: r8a77470: Initial SoC device tree
      ARM: dts: iwg23s-sbc: Add support for iWave G23S-SBC based on RZ/G1C
      ARM: dts: r8a77470: Add SYS-DMAC support
      ARM: dts: r8a77470: Add IRQC support
      ARM: dts: r8a77470: Add SCIF support
      ARM: dts: r8a77470: Add SCIF DMA support
      ARM: dts: r8a77470: Add EtherAVB support
      ARM: dts: iwg23s-sbc: Add EtherAVB support

Chris Brandt (1):
      ARM: dts: r7s72100: add USB device to device tree

Fabrizio Castro (14):
      ARM: dts: r8a7743: Adjust SMP routine size
      ARM: dts: r8a7745: Adjust SMP routine size
      ARM: dts: r8a7790: Adjust SMP routine size
      ARM: dts: r8a7791: Adjust SMP routine size
      ARM: dts: r8a7792: Adjust SMP routine size
      ARM: dts: r8a7793: Adjust SMP routine size
      ARM: dts: r8a7794: Adjust SMP routine size
      ARM: dts: r8a7743: Add watchdog support to SoC dtsi
      ARM: dts: r8a7745: Add watchdog support to SoC dtsi
      ARM: dts: r8a7790: Add watchdog support to SoC dtsi
      ARM: dts: r8a7791: Add watchdog support to SoC dtsi
      ARM: dts: r8a7794: Add watchdog support to SoC dtsi
      ARM: dts: iwg20m: Add watchdog support to SoM dtsi
      ARM: dts: iwg22m: Add watchdog support to SoM dtsi

Geert Uytterhoeven (24):
      ARM: dts: r8a7792: Add RWDT node
      ARM: dts: r8a7793: Add RWDT node
      ARM: dts: lager: Enable watchdog support
      ARM: dts: koelsch: Enable watchdog support
      ARM: dts: porter: Enable watchdog support
      ARM: dts: blanche: Enable watchdog support
      ARM: dts: wheat: Enable watchdog support
      ARM: dts: gose: Enable watchdog support
      ARM: dts: alt: Enable watchdog support
      ARM: dts: silk: Enable watchdog support
      ARM: dts: r8a7790: Correct mask for GIC PPI interrupts
      ARM: dts: r8a73a4: Correct mask for GIC PPI interrupts
      ARM: dts: sh73a0: Add missing interrupt-affinity to PMU node
      ARM: dts: emev2: Add missing interrupt-affinity to PMU node
      ARM: dts: r7s72100: Correct watchdog timer interrupt type
      ARM: dts: r7s72100: Correct RTC interrupt types
      ARM: dts: r7s72100: Add PMU device node
      ARM: dts: r8a7790: Add PMU device nodes
      ARM: dts: r8a7791: Add PMU device node
      ARM: dts: r8a7792: Add PMU device node
      ARM: dts: r8a7793: Add PMU device node
      ARM: dts: r8a7794: Add PMU device node
      ARM: dts: r8a7743: Add PMU device node
      ARM: dts: r8a7745: Add PMU device node

Jacopo Mondi (2):
      ARM: dts: r7s72100: Add Capture Engine Unit (CEU)
      ARM: dts: r8a7740: Add CEU0

Kieran Bingham (2):
      ARM: dts: wheat: Fix ADV7513 address usage
      ARM: dts: r8a7790: Fix sort order of VSP1/FDP1 nodes

Laurent Pinchart (4):
      ARM: dts: renesas: r8a7791: Add FDP1 instances
      ARM: dts: renesas: r8a7793: Add FDP1 instances
      ARM: dts: renesas: r8a7794: Add FDP1 instances
      ARM: dts: renesas: r8a7790: Add FDP1 instances

Masahiro Yamada (1):
      ARM: dts: renesas: replace toshiba, mmc-wrprotect-disable with disable-wp

Simon Horman (12):
      ARM: dts: r7s72100: add soc node
      ARM: dts: r7s72100: sort subnodes of soc node
      ARM: dts: r7s72100: stop grouping clocks under a "clocks" subnode
      ARM: dts: r7s72100: sort subnodes of root node
      ARM: dts: lager: Drop unnecessary address properties from port node
      ARM: dts: porter: Drop unnecessary address properties from vin port node
      ARM: dts: gose: Drop unnecessary address properties from port nodes
      ARM: dts: koelsch: Drop unnecessary address properties from port nodes
      ARM: dts: alt: Drop unnecessary address properties from vin port node
      ARM: dts: silk: Drop unnecessary address properties from vin port node
      ARM: dts: kzm9d: Drop unnecessary address properties from gpio_keys node
      ARM: dts: r8a7740: Add CEU1

Wolfram Sang (1):
      ARM: shmobile: r8a7794: alt: add EEPROM to DTS

 arch/arm/boot/dts/Makefile                |    1 +
 arch/arm/boot/dts/emev2-kzm9d.dts         |    3 -
 arch/arm/boot/dts/emev2.dtsi              |    5 +-
 arch/arm/boot/dts/r7s72100.dtsi           | 1038 +++++++++++++++--------------
 arch/arm/boot/dts/r8a73a4-ape6evm.dts     |    4 +-
 arch/arm/boot/dts/r8a73a4.dtsi            |   10 +-
 arch/arm/boot/dts/r8a7740.dtsi            |   18 +
 arch/arm/boot/dts/r8a7743-iwg20m.dtsi     |    5 +
 arch/arm/boot/dts/r8a7743.dtsi            |   19 +-
 arch/arm/boot/dts/r8a7745-iwg22m.dtsi     |    5 +
 arch/arm/boot/dts/r8a7745.dtsi            |   19 +-
 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts |   48 ++
 arch/arm/boot/dts/r8a77470.dtsi           |  336 ++++++++++
 arch/arm/boot/dts/r8a7790-lager.dts       |    8 +-
 arch/arm/boot/dts/r8a7790.dtsi            |   67 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts     |   11 +-
 arch/arm/boot/dts/r8a7791-porter.dts      |    8 +-
 arch/arm/boot/dts/r8a7791.dtsi            |   37 +-
 arch/arm/boot/dts/r8a7792-blanche.dts     |    5 +
 arch/arm/boot/dts/r8a7792-wheat.dts       |   16 +-
 arch/arm/boot/dts/r8a7792.dtsi            |   19 +-
 arch/arm/boot/dts/r8a7793-gose.dts        |   11 +-
 arch/arm/boot/dts/r8a7793.dtsi            |   37 +-
 arch/arm/boot/dts/r8a7794-alt.dts         |   14 +-
 arch/arm/boot/dts/r8a7794-silk.dts        |    8 +-
 arch/arm/boot/dts/r8a7794.dtsi            |   28 +-
 arch/arm/boot/dts/sh73a0.dtsi             |    9 +-
 27 files changed, 1235 insertions(+), 554 deletions(-)
 create mode 100644 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
 create mode 100644 arch/arm/boot/dts/r8a77470.dtsi

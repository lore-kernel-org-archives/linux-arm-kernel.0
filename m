From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 17:38:40 +0100
Subject: [GIT PULL v2] Renesas ARM Based SoC DT Updates for v4.17
Message-ID: <cover.1521218085.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC DT updates for v4.17.

Changes since v1
* Dropped r7s72100 to avoid conflict, I will see about resubmitting
  those still relevant for v4.18


The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-for-v4.17

for you to fetch changes up to a24a5821a684a62ae2c53a214eaf2ad4f4f0dbcf:

  ARM: dts: silk: Add GPIO keys to DT (2018-03-16 17:24:18 +0100)

----------------------------------------------------------------
Renesas ARM Based SoC DT Updates for v4.17

* Silk board with R-Car E2 (r8a7794) SoC
  - Add r1ex24002 EEPROM to DT

    Magnus Damm says "Extend the Silk board support to include U14 which is
    an I2C based EEPROM hooked up to the I2C1 bus."

  - Add GPIO keys to DT

    Magnus Damm says "Extend the Silk board support to include SW3, SW4,
    SW6 and SW12. They are all connected via GPIO lines and handled by the
    gpio-keys driver"

* Marzen board with R-Car H1 (r7a7779) SoC
  - Add SDHI0 VCCQ Regulator

    Magnus Damm says "Add support for the on-board voltage regulator hooked
    up to GPIO3_20 on r8a7779 Marzen. The board schematics describes the
    regulator as U4 TPS2110A. Input wise, U4 has D0 fixed to ground, D1
    tied to GPIO3_20 while IN1 is fixed to 3.3V and IN2 is fixed to 1.8V.
    OUT goes to the pull-ups for the data pins of SDHI0."

* Porter board with R-Car M3W (r8a7791) SoC
  - Fix HDMI output routing

    Laurent Pinchart says "The HDMI encoder is connected to the RGB output
    of the DU, which is port at 0, not port at 1."

* iWave Systems RZ/G1E SODIMM System On Module (iW-RainboW-G22M-SM) and
  iWave Systems RZ/G1M Qseven System On Module (iW-RainboW-G20M-Qseven)
  - Enable cmt0

* Stout board with R-Car H2 (r8a7790) SoC
  - Initial support

* Lager board with R-Car H2 (r8a7790) SoC
  - Add CEC clock for HDMI transmitter

    Niklas S?derlund says "The adv7511 on the Lager board has a 12 MHz
    fixed clock for the CEC block. Specify this in the dts to enable CEC
    support."

  - Move cec_clock to root node

    By definition nodes without a bus address do not belong on the bus

* kzm9d board with EMMA Mobile EV2 (EMEV2) SoC
  - Fix "debounce-interval" property misspelling

* RZ/G1M (r8a7743) and RZ/G1H (r8a7745) SoCs
  - Add IPMMU DT nodes
  - Add VSP support

* R-Car Gen2 boards
  - Use I2C demuxer for

    This allows run-time switching between alternate I2C IP blocks

* R-Car Gen2 and RZ/G1 SoCs
  - Clean up DT files to ease future maintenance
    + add soc node for IP attached to the bus
    + sort subnodes of soc and root node
    + consistently use single space after =

* R-Car H2 (r8a7790), M3-W (r8a7791) and M3-N (r7a7793) SoCs
  - Reduce size of thermal registers

    According to the "User's Manual: Hardware" v2.00 the registers at base
    0xe61f0000 extend to an offset of 0x10, rather than 0x14 which is the
    case on the r8a73a4 (R-Mobile APE6).

    This should not have any runtime affect as mapping granularity is
    PAGE_SIZE.

----------------------------------------------------------------
Biju Das (4):
      ARM: dts: r8a7743: Add IPMMU DT nodes
      ARM: dts: r8a7745: Add IPMMU DT nodes
      ARM: dts: r8a7743: Add VSP support
      ARM: dts: r8a7745: Add VSP support

Fabrizio Castro (2):
      ARM: dts: iwg20m: Enable cmt0
      ARM: dts: iwg22m: Enable cmt0

Geert Uytterhoeven (2):
      ARM: dts: kzm9d: Fix "debounce-interval" property misspelling
      ARM: dts: lager: Move cec_clock to root node

Laurent Pinchart (1):
      ARM: dts: porter: Fix HDMI output routing

Magnus Damm (3):
      ARM: dts: marzen: Add SDHI0 VCCQ Regulator
      ARM: dts: silk: Add r1ex24002 EEPROM to DT
      ARM: dts: silk: Add GPIO keys to DT

Marek Vasut (1):
      ARM: dts: stout: Initial r8a7790 Stout board support

Niklas S?derlund (1):
      ARM: dts: lager: Add CEC clock for HDMI transmitter

Simon Horman (24):
      ARM: dts: r8a7790: Reduce size of thermal registers
      ARM: dts: r8a7791: Reduce size of thermal registers
      ARM: dts: r8a7793: Reduce size of thermal registers
      ARM: dts: r8a7790: consistently use single space after =
      ARM: dts: r8a7790: add soc node
      ARM: dts: r8a7790: sort subnodes of soc node
      ARM: dts: r8a7790: sort subnodes of root node
      ARM: dts: r8a7791: consistently use single space after =
      ARM: dts: r8a7791: add soc node
      ARM: dts: r8a7791: sort subnodes of root node
      ARM: dts: r8a7792: sort subnodes of soc node
      ARM: dts: r8a7793: consistently use single space after =
      ARM: dts: r8a7793: add soc node
      ARM: dts: r8a7793: sort subnodes of soc node
      ARM: dts: r8a7793: sort subnodes of root node
      ARM: dts: r8a7794: consistently use single space after =
      ARM: dts: r8a7794: add soc node
      ARM: dts: r8a7794: sort subnodes of soc node
      ARM: dts: r8a7794: sort subnodes of root node
      ARM: dts: r8a7790: consistently use single space before =
      ARM: dts: r8a7791: consistently use single space before =
      ARM: dts: r8a7793: consistently use single space before =
      ARM: dts: r8a7743: sort subnodes of soc node
      ARM: dts: r8a7745: sort subnodes of soc node

Wolfram Sang (9):
      ARM: dts: lager: use demuxer for IIC2/I2C2
      ARM: dts: lager: use demuxer for IIC3/I2C3
      ARM: dts: koelsch: use demuxer for I2C2
      ARM: dts: koelsch: use demuxer for I2C4
      ARM: dts: porter: use demuxer for I2C2
      ARM: dts: alt: use demuxer for I2C1
      ARM: dts: silk: use demuxer for I2C1
      ARM: dts: gose: use demuxer for I2C2
      ARM: dts: gose: use demuxer for I2C4

 arch/arm/boot/dts/Makefile            |    1 +
 arch/arm/boot/dts/emev2-kzm9d.dts     |    8 +-
 arch/arm/boot/dts/r8a7743-iwg20m.dtsi |    4 +
 arch/arm/boot/dts/r8a7743.dtsi        | 1324 ++++++++-------
 arch/arm/boot/dts/r8a7745-iwg22m.dtsi |    4 +
 arch/arm/boot/dts/r8a7745.dtsi        | 1778 ++++++++++----------
 arch/arm/boot/dts/r8a7779-marzen.dts  |   14 +
 arch/arm/boot/dts/r8a7790-lager.dts   |  287 ++--
 arch/arm/boot/dts/r8a7790-stout.dts   |  363 ++++
 arch/arm/boot/dts/r8a7790.dtsi        | 2837 ++++++++++++++++---------------
 arch/arm/boot/dts/r8a7791-koelsch.dts |  232 ++-
 arch/arm/boot/dts/r8a7791-porter.dts  |  130 +-
 arch/arm/boot/dts/r8a7791.dtsi        | 2986 +++++++++++++++++----------------
 arch/arm/boot/dts/r8a7792.dtsi        |  498 +++---
 arch/arm/boot/dts/r8a7793-gose.dts    |  252 +--
 arch/arm/boot/dts/r8a7793.dtsi        | 2392 +++++++++++++-------------
 arch/arm/boot/dts/r8a7794-alt.dts     |   53 +-
 arch/arm/boot/dts/r8a7794-silk.dts    |  189 ++-
 arch/arm/boot/dts/r8a7794.dtsi        | 2421 +++++++++++++-------------
 19 files changed, 8436 insertions(+), 7337 deletions(-)
 create mode 100644 arch/arm/boot/dts/r8a7790-stout.dts

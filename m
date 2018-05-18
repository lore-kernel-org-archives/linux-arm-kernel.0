From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:16:00 +0200
Subject: [GIT PULL] Renesas ARM64 Based SoC DT Updates for v4.18
Message-ID: <cover.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM64 based SoC DT updates for v4.18.


The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt-for-v4.18

for you to fetch changes up to 908001d778eba06ee1d832863d4e9a1e2cfd4746:

  arm64: dts: renesas: salvator-common: Add ADV7482 support (2018-05-18 11:52:03 +0200)

----------------------------------------------------------------
Renesas ARM64 Based SoC DT Updates for v4.18

* Cleanups:
  - Corresct whitespace
  - sort subnodes of the root and soc nodes

* R-Car M3-N (r8a77965) SoC
  - Describe MSIOF SPI, PWM, SDHI and I2C devices in DT

  - Add thermal support

* R-Car H3 (r8a7795) and R-Car M3-W (r8a7796) SoCs
  - Decrease temperature hysteresis

    Niklas S?derlund says "... decrease the hysteresis from 2C to 1C for
    the two boards we have described upstream. They have no dependencies
    and are ready to be accepted if the review is in favor of them."

* R-Car H3 (r8a7795), M3-W (r8a7796) and M3-N (r8a77965) SoCs
  - Add address properties to rcar_sound port nodes

    The rcar_sound port nodes have unit names and thus should have register
    properties.

* R-Car H3 (r8a7795), M3-W (r8a7796) V3M (r8a77970) and D3 (r8a77995) SoCs
  - Enable IPMMU devices

    Magnus Damm says "Following the policy of using DT to describe the
    hardware and not software support state, this series makes sure all
    IPMMU devices are enabled in DT for SoCs such as r8a7795, r8a7796,
    r8a77970 and r8a77995."

* R-Car M3-N (r8a77965) and V3H (r8a77980) SoCs
  - Use sysc binding macros

    These can be used now that they are present in Linus's tree.
    This is a simple replacement of numeric values with symbolic ones.

  - Describe USB2 and USB3 devices in DT

* R-Car V3M (r8a77970) SoC
  - Add SMP Support

    Geert Uytterhoeven says "This patch series enables SMP support on the
    R-Car V3M SoC, by adding the second Cortex-A53 CPU core.  It also adds
    the performance monitor unit, and links it to both CPU cores."

  - Correct IPMMU DS1 bit number

    Magnus Damm says "Judging by "R-Car-Gen3-rev0.80" IPMMU IMSSTR register
    documentation for [R-Car V3M] the DS1 bit field should be bit 0."

* R-Car V3H (r8a77980) SoC
  - Use CPG clock binding macros

    These can be used now that they are present in Linus's tree.
    This is a simple replacement of numeric values with symbolic ones.

* R-Car V3H (r8a77980) and V3M (r8a77970) SoCs
  - Disable EtherAVB

    Sergei Shtylov says "I'm fixing the issue in the EtherAVB device nodes
    in the R8A779{7|8}0 device trees that missed the "status" prop, usually
    disabling the SoC devices in anticipation that the board device trees
    enable the devices according to their needs. There should be no issues
    with the current R8A779{7|8}0 board device trees, as all of them use
    EtherAVB anyway, so I'm sending the patches generated against the
    'devel' branch..."

* R-Car D3 (r8a77995) SoC
  - Describe VIN4 in DT

* Ebisu board with R-Car E3 (r8a77990) SoC
  - Initial support:
    + PSCI
    + CPU (single)
    + Cache controller
    + Main clocks and controller
    + Interrupt controller
    + Timer
    + PMU
    + Reset controller
    + Product register
    + System controller
    + UART for console

* Salvator-XS boards with R-Car H3 (r8a7795) SoC
  - Enable USB2.0 channel 3

* Salvator-X and Salvator-XS boards with M3-N (r8a77965) SoC
  - Enable DU

    Kieran Bingham "This series enables the DU for the M3-N R8A77965 SoC,
    and provides output on the VGA and HDMI connectors.

    LVDS is not yet supported or tested."

* Salvator-X and Salvator-XS boards with
  R-Car H3 (r8a7795), M3-W (r8a7796) and M3-N (r8a77965) SoCs
  - Enable nable VIN, CSI-2 and ADV7482

    Niklas S?derlund says "This series enable capture for H3, M3-W, M3-N
    Salvator-X and Salvator-XS boards. It also adds the VIN and CSI-2 nodes
    for V3M, but as the ADV7482 is on the V3M expansion boards I have
    chosen not include that enablement in this series."

  - Add PMIC DDR Backup Power config

    Geert Uytterhoeven says " The ROHM BD9571MWV PMIC on the Renesas
    Salvator-X(S) and ULCB development boards supports DDR Backup Power,
    which means that the DDR power rails can be kept powered while the main
    SoC is powered down.

    For this to function correctly, the DDR Backup Power configuration
    must be described in DT, which is the topic of this series:
      - The first patch adds the missing device node for the BD9571 PMIC on
        the ULCB boards,
      - The last two patches add DDR Backup Mode configuration for
        Salvator-X(S) and ULCB."

  - Add EEPROM

    Wolfram Sang says "Add the EEPROM found on Salvator-X and -XS boards
    for H3, M3-W, and M3-N on the IIC_DVFS bus."

  - Enable HDMI Sound

* Salvator-X and Salvator-XS boards with
  R-Car H3 (r8a7795), M3-W (r8a7796) and M3-N (r8a77965) SoCs, and
  Draak board with R-Car D3 (r8a77995) SoC
  - Consistently name EtherAVB mdio pin group

    Geert Uytterhoeven says "When initial support was added for R-Car H3,
    the MDIO pin was forgotten, and the MDC pin got its own group named
    "mdc".  During the addition of support for R-Car M3-W, this mistake was
    noticed.  But as R-Car H3 and M3-W are pin compatible, and can be
    mounted on the same boards, the decision was made to just add the MDIO
    pin to the existing "mdc" group.  Later this was extended to R-Car H3
    ES2.0, and M3-N, because of pin compatibility, and to R-Car D3, in the
    name of consistency among R-Car Gen3 SoCs.

    However, this decision keeps on being questioned when adding new SoC
    support.  Hence bite the bullet and admit our mistake, and rename the
    pin group from "mdc" to "mdio", like on R-Car Gen2 SoCs."

* Ebisu board with R-Car E3 (r8a77990) SoC
  - Initial support: Memory, Main crystal, Serial console

  - Enable Ethernet

  - Revise PSCI node

    Yoshihiro Shimoda says "The basic support patch 2d2dbadba421 ("arm64:
    dts: renesas: Add Renesas R8A77990 SoC support") lacks the compatible
    "arm,psci-1.0" in the psci node."

  - Revise cache controller node

    Yoshihiro Shimoda says "The cache controller node should not have
    unit-addresses and reg properties."

* V3HSK board with R-Car V3H (r8a77980) SoC
  - Initial board device tree

    Sergei Shtylov says "Add the initial device  tree for  the V3H Starter
    Kit board.  The board has 1 debug serial port (SCIF0); include support
    for it, so that the serial console can work."

  - Enable PFC support and use for EtherAVB

* V3MSK board with R-Car V3M (r8a77970) SoC
  - Add DU/LVDS/HDMI support

    Sergei Shtylyov says "Define the V3M Starter Kit board dependent part
    of the DU and LVDS device nodes. Also add the device nodes for Thine
    THC63LVD1024 LVDS decoder and Analog Devices ADV7511W HDMI
    transmitter..."

  - Enable PFC for EtherAVB

* Condor board with R-Car V3H (r8a77980) SoC
  - Enable eMMC

    Sergei Shtylyov says "We're adding the R8A77980 MMC (SDHI)
    device nodes and then enable eMMC support on the Condor board."

  - Enable PFC support and use for EtherAVB and SCIF0

* Eagle board with R-Car V3M (r8a77970) SoC
  - Enable HDMI output

* Eagle board with R-Car V3M (r8a77970) SoC and
  Condor board with R-Car V3H (r8a77980) SoC
  - Enable CAN-FD

    Adds the CAN-FD device nodes so the DT SoC files and enables
    single channel CAN-FD support in DT board files.

----------------------------------------------------------------
Geert Uytterhoeven (11):
      arm64: dts: renesas: draak: Rename EtherAVB "mdc" pin group to "mdio"
      arm64: dts: renesas: salvator-common: Rename EtherAVB "mdc" pin group to "mdio"
      arm64: dts: renesas: ulcb: Rename EtherAVB "mdc" pin group to "mdio"
      arm64: dts: renesas: r8a7795: Correct whitespace
      arm64: dts: renesas: r8a7796: Correct whitespace
      arm64: dts: renesas: r8a77965: Correct whitespace
      arm64: dts: renesas: ulcb: Add BD9571 PMIC
      arm64: dts: renesas: salvator-common: Add PMIC DDR Backup Power config
      arm64: dts: renesas: ulcb: Add PMIC DDR Backup Power config
      arm64: dts: renesas: r8a77970: Add secondary CA53 CPU core
      arm64: dts: renesas: r8a77970: Add Cortex-A53 PMU node

Jacopo Mondi (2):
      arm64: dts: renesas: eagle: Enable HDMI output
      arm64: dts: renesas: r8a77995: Add VIN4

Kieran Bingham (7):
      arm64: dts: renesas: r8a77965: Add FCPF and FCPV instances
      arm64: dts: renesas: r8a77965: Add VSP instances
      arm64: dts: renesas: r8a77965: Populate the DU instance placeholder
      arm64: dts: renesas: r8a77965: Add HDMI encoder instance
      arm64: dts: renesas: r8a77965-salvator-x: Enable DU external clocks and HDMI
      arm64: dts: renesas: r8a77965-salvator-xs: Enable DU external clocks and HDMI
      arm64: dts: renesas: salvator-common: Add ADV7482 support

Kuninori Morimoto (8):
      arm64: dts: renesas: r8a7795: add HDMI sound support
      arm64: dts: renesas: r8a7796: add HDMI sound support
      arm64: dts: renesas: salvator-common: use audio-graph-card for Sound
      arm64: dts: renesas: r8a7795-es1-salvator-x: enable HDMI sound
      arm64: dts: renesas: r8a7795-salvator-xs: enable HDMI sound
      arm64: dts: renesas: r8a7796-salvator-xs: enable HDMI sound
      arm64: dts: renesas: r8a7795-salvator-x: enable HDMI sound
      arm64: dts: renesas: r8a7796-salvator-x: enable HDMI sound

Magnus Damm (5):
      arm64: dts: renesas: r8a77970: Update IPMMU DS1 bit number
      arm64: dts: renesas: r8a7795: Enable IPMMU devices
      arm64: dts: renesas: r8a7796: Enable IPMMU devices
      arm64: dts: renesas: r8a77970: Enable IPMMU devices
      arm64: dts: renesas: r8a77995: Enable IPMMU devices

Niklas S?derlund (11):
      arm64: dts: renesas: r8a7795: decrease temperature hysteresis
      arm64: dts: renesas: r8a7796: decrease temperature hysteresis
      arm64: dts: renesas: r8a77965: use r8a77965-sysc binding definitions
      arm64: dts: renesas: r8a77965: Add R-Car Gen3 thermal support
      arm64: dts: renesas: r8a77965: add I2C support
      arm64: dts: renesas: r8a7795: add VIN and CSI-2 nodes
      arm64: dts: renesas: r8a7795-es1: add CSI-2 node
      arm64: dts: renesas: r8a7796: add VIN and CSI-2 nodes
      arm64: dts: renesas: r8a77965: add VIN and CSI-2 nodes
      arm64: dts: renesas: r8a77970: add VIN and CSI-2 nodes
      arm64: dts: renesas: salvator-common: enable VIN

Sergei Shtylyov (21):
      arm64: dts: renesas: r8a77970: add FCPVD support
      arm64: dts: renesas: r8a77970: add VSPD support
      arm64: dts: renesas: r8a77970: add DU support
      arm64: dts: renesas: r8a77970: add LVDS support
      arm64: dts: renesas: eagle: add EtherAVB pins
      arm64: dts: renesas: v3msk: add EtherAVB pins
      arm64: dts: renesas: r8a77980: add PFC support
      arm64: dts: renesas: condor: add SCIF0 pins
      arm64: dts: renesas: condor: add EtherAVB pins
      arm64: dts: renesas: r8a77980: add MMC support
      arm64: dts: renesas: condor: add eMMC support
      arm64: dts: renesas: v3msk: add DU/LVDS/HDMI support
      arm64: dts: renesas: r8a77980: use CPG core clock macros
      arm64: dts: renesas: r8a77980: use SYSC power domain macros
      arm64: dts: renesas: r8a77970: add CAN-FD support
      arm64: dts: renesas: eagle: add CAN-FD support
      arm64: dts: renesas: r8a77980: add CAN-FD support
      arm64: dts: renesas: condor: add CAN-FD support
      arm64: dts: renesas: r8a77970: disable EtherAVB
      arm64: dts: renesas: r8a77980: disable EtherAVB
      arm64: dts: renesas: initial V3HSK board device tree

Simon Horman (9):
      arm64: dts: renesas: r8a7796: sort subnodes of the root node
      arm64: dts: renesas: r8a7796: sort subnodes of the soc node
      arm64: dts: renesas: r8a7795: sort subnodes of the root node
      arm64: dts: renesas: r8a7795: sort subnodes of the soc node
      arm64: dts: renesas: r8a7795-es1: Enable IPMMU devices
      arm64: dts: renesas: r8a7795: Add address properties to rcar_sound port nodes
      arm64: dts: renesas: r8a7796: Add address properties to rcar_sound port nodes
      arm64: dts: renesas: r8a77965: Add address properties to rcar_sound port nodes
      arm64: dts: renesas: r8a77980: add resets property to CAN-FD node

Takeshi Kihara (3):
      arm64: dts: renesas: r8a77965: Add all MSIOF device nodes
      arm64: dts: renesas: Add Renesas Ebisu board support
      arm64: dts: renesas: r8a77965: Add SDHI device nodes

Wolfram Sang (1):
      arm64: dts: renesas: salvator-common: add eeprom

Yoshihiro Kaneko (5):
      arm64: dts: renesas: r8a77995: sort subnodes of the root node
      arm64: dts: renesas: r8a77995: sort subnodes of the soc node
      arm64: dts: renesas: r8a77965: sort subnodes of the root node
      arm64: dts: renesas: r8a77965: sort subnodes of the soc node
      arm64: dts: renesas: r8a77970: sort subnodes of the soc node

Yoshihiro Shimoda (19):
      arm64: dts: renesas: r8a77965: add usb2_phy nodes
      arm64: dts: renesas: r8a77965: add usb3_phy node
      arm64: dts: renesas: r8a77965: add USB 2.0 host nodes
      arm64: dts: renesas: r8a77965: add usb_dmac nodes
      arm64: dts: renesas: r8a77965: add HS-USB node
      arm64: dts: renesas: r8a77965: add USB 3.0 host node
      arm64: dts: renesas: r8a77965: add USB 3.0 peripheral node
      arm64: dts: renesas: r8a77965: Add PWM device nodes
      arm64: dts: renesas: Add Renesas R8A77990 Kconfig support
      arm64: dts: renesas: Add Renesas R8A77990 SoC support
      arm64: dts: renesas: r8a77990: Revise the psci node
      arm64: dts: renesas: r8a77990: Revise the cache controller node
      arm64: dts: renesas: r8a7795: salvator-xs: enable usb2_phy3 node
      arm64: dts: renesas: r8a7795: salvator-xs: enable hsusb channel 3 node
      arm64: dts: renesas: r8a7795: salvator-xs: enable USB2.0 host channel 3
      arm64: dts: renesas: r8a77990: Add PFC device node
      arm64: dts: renesas: r8a77990: Add GPIO device nodes
      arm64: dts: renesas: r8a77990: Add EthernetAVB device nodes
      arm64: dts: renesas: r8a77990: ebisu: Enable EthernetAVB

 arch/arm64/Kconfig.platforms                       |    6 +
 arch/arm64/boot/dts/renesas/Makefile               |    3 +-
 .../boot/dts/renesas/r8a7795-es1-salvator-x.dts    |   46 +
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi       |  144 +-
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |   46 +
 .../arm64/boot/dts/renesas/r8a7795-salvator-xs.dts |   85 +
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 2499 +++++++++++---------
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts |   28 +
 .../arm64/boot/dts/renesas/r8a7796-salvator-xs.dts |   28 +
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           | 2395 +++++++++++--------
 .../arm64/boot/dts/renesas/r8a77965-salvator-x.dts |   28 +
 .../boot/dts/renesas/r8a77965-salvator-xs.dts      |   28 +
 arch/arm64/boot/dts/renesas/r8a77965.dtsi          | 1601 +++++++++----
 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts     |  116 +
 arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts     |  137 ++
 arch/arm64/boot/dts/renesas/r8a77970.dtsi          |  661 ++++--
 arch/arm64/boot/dts/renesas/r8a77980-condor.dts    |   81 +
 arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts     |   60 +
 arch/arm64/boot/dts/renesas/r8a77980.dtsi          |   99 +-
 arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts     |   65 +
 arch/arm64/boot/dts/renesas/r8a77990.dtsi          |  281 +++
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts     |    2 +-
 arch/arm64/boot/dts/renesas/r8a77995.dtsi          |  730 +++---
 arch/arm64/boot/dts/renesas/salvator-common.dtsi   |  187 +-
 arch/arm64/boot/dts/renesas/ulcb.dtsi              |   37 +-
 25 files changed, 6324 insertions(+), 3069 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77990.dtsi

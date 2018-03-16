From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:51:34 +0100
Subject: [GIT PULL] Renesas ARM64 Based SoC DT Updates for v4.17
Message-ID: <cover.1521206129.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM64 based SoC DT updates for v4.17.


The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt-for-v4.17

for you to fetch changes up to ca565be2b526a731d02a2fbff96fb0572567ea55:

  arm64: dts: renesas: v3msk: add SCIF0 pins (2018-03-14 15:43:15 +0100)

----------------------------------------------------------------
Renesas ARM64 Based SoC DT Updates for v4.17

* R-Car Gen3 boards and SoCs
  - Make phy-mode of EtherAVB a board-specific property.

    The SoC DTs file now uses "rgmii" and boards override this with
    "rgmii-txid" as appropriate. Previously "rgmii-txid" was used
    in SoC DTs but this did not describe that more sophiticated
    functionality is a board rather than SoC property.

* Condor board with R-Car V3H (r8a77980) SoC
  - Initial upstream support

* Condor board with R-Car V3H (r8a77980) SoC
  - Initial upstream support

* R-Car D3 (r8a77995)
  - Add I2C nodes and then describing the PCA9654 I/O expander connected to
    the I2C0 bus.

* Eagle board with R-Car V3M (r8a77970) SoC
  - Enable PFC support for configuring SCIF0 pins
    This uses PFC support added to the V3M DT

  - Describe EtherAVB PHY IRQ
    This uses support for GPIO added to the V3M DT

  - Enable I2C0 support

    Sergei Shtylyov says "The I2C0 bus is populated by ON Semiconductor
    PCA9653 I/O expander and Analog Devices ADV7511W HDMI transmitter (but
    we're only describing the former chip now)."

* R-Car V3M (r8a77970) SoCs
  - Add PFC support
  - Describe GPIO devices
  - Describe I2C devices
  - Srt subnodes of root node alphabetically to eas future maintence overhead

* Draak board with R-Car D3 (r8a77995) SoC
  - Enable SDHI2

    Wolfram Sang says "The single SDHI controller is connected to eMMC."

  - Enable DU

    Kieran Bingham says "Enable the DU, providing only the VGA output for
    now."

* R-Car D3 (r8a77995) and V3M (r8a77970) SoCs
  - Move nodes which have no reg property out of bus
    By deffinition the bus only has hardware with an address on the bus

  - Remove non-existing STBE region from EtherAVB
    Stream Buffer for EtherAVB-IF (STBE) is not present on these SoCs

* R-Car D3 (r8a77995) SoC
  - Add FCPV, VSP and DU support

    Kieran Bingham says "The r8a77995-d3 platform supports 3 VSP instances.
    One VSPBS can be used as a dual-input image blender, while two VSPD
    instances can be utilised as part of a display (DU) pipeline.

    Add support for these, along with their required FCPV nodes."

* Salvator-X and Salvator-XS boards with R-Car Gen3 SoCs
  - Add GPIO extender
    This is a basis for follow-up work to configure the GPIOs of the extender

* Salvator-X and Salvator-XS board with R-Car M3-N (r8a77965) SoC
  - Initial upstream support

* R-Car H3 (r8a7795) and M3-W (r8a7796) SoCs
  - Add OPPs table for cpu devices
    This, along with recently upstreamed Z and Z2 clock support allows
    use of CPUFreq with both A57 and A53 CPUs.

  - Add thermal cooling management
    Allows the use of CPUFreq as a cooling device on A57 CPUs

  - Correct register size of thermal node

    Niklas S?derlund says "To be able to read fused calibration values from
    hardware the size of the register resource of TSC1 needs to be
    incremented to cover one more register which holds the information if
    the calibration values have been fused or not.

    Instead of increasing TSC1 size to the value from the datasheet update
    all TSC's size to the smallest granularity of the address decoder
    circuitry"

  - Fix register mappings on VSPs

    Kieran Bingham says "The VSPD includes a CLUT on RPF2. Ensure that the
    register space is mapped correctly to support this."

* R-Car H3 (r8a7795) SoC
  - Move SCIF node into alphabetical order to ease future maintenance overhead

  - Add IPMMU-PV1 device node

    This resolves an oversight when IPMMU nodes were added to the H3 DT.
    All IPMMU devices should now be described in DT.

  - Add missing SYS-DMAC2 dmas

    Geert Uytterhoeven says "On R-Car H3, on-chip peripheral modules that
    can make use of DMA are wired to either SYS-DMAC0 only, or to both
    SYS-DMAC1 and SYS-DMAC2.

    Add the missing DMA properties pointing to SYS-DMAC2 for HSCIF[0-2],
    SCIF[0125], and I2C[0-2].  These were initially left out because early
    firmware versions prohibited using SYS-DMAC2.  This restriction has
    been lifted in IPL and Secure Monitor Rev1.0.6 (released on Feb 25,
    2016)."

----------------------------------------------------------------
Dien Pham (4):
      arm64: dts: renesas: r8a7795: Add OPPs table for cpu devices
      arm64: dts: renesas: r8a7796: Add OPPs table for cpu devices
      arm64: dts: renesas: r8a7796: Update OPPs to support CA53 dfs
      arm64: dts: renesas: r8a7795: Update OPPs to support CA53 dfs

Geert Uytterhoeven (7):
      arm64: dts: renesas: r8a77970: Remove non-existing STBE region
      arm64: dts: renesas: r8a77995: Remove non-existing STBE region
      arm64: dts: renesas: r8a77965: Add IIC-DVFS device node
      arm64: dts: renesas: r8a77965: Add INTC-EX device node
      arm64: dts: renesas: r8a77965-salvator-xs: Add SoC name to file header
      arm64: dts: renesas: r8a77970: sort subnodes of root node alphabetically
      arm64: dts: renesas: r8a7795: Add missing SYS-DMAC2 dmas

Jacopo Mondi (23):
      arm64: add Renesas R8A77965 support
      arm64: dts: renesas: initial R8A77965 SoC device tree
      arm64: dts: renesas: Add R-Car Salvator-x M3-N support
      arm64: dts: renesas: r8a77965: Add dmac device nods
      arm64: dts: renesas: r8a77965: Add SCIF device nodes
      arm64: dts: renesas: r8a77965: Add GPIO nodes
      arm64: dts: renesas: r8a77965: Add "reg" properties
      arm64: dts: renesas: r8a77965: Add #address-cells and #size-cells
      arm64: dts: renesas: r8a77965: Remove stale reg property
      arm64: dts: renesas: r8a77965: Add #phy-cells property
      arm64: dts: renesas: r8a77965: Add #pwm-cells property
      arm64: dts: renesas: r8a77965: Add #interrupt-cells property
      arm64: dts: renesas: r8a77965: Move usb2_phy1 up
      arm64: dts: renesas: salvator-common: Override EtherAVB phy-mode
      arm64: dts: renesas: ulcb: Override EtherAVB phy-mode
      arm64: dts: renesas: draak: Override EtherAVB phy-mode
      arm64: dts: renesas: eagle: Override EtherAVB phy-mode
      arm64: dts: renesas: v3msk: Override EtherAVB phy-mode
      arm64: dts: renesas: r8a7796: Set EtherAVB phy mode to "rgmii"
      arm64: dts: renesas: r8a7795: Set EtherAVB phy mode to "rgmii"
      arm64: dts: renesas: r8a77995: Set EtherAVB phy mode to "rgmii"
      arm64: dts: renesas: r8a77970: Set EtherAVB phy mode to "rgmii"
      arm64: dts: renesas: r8a77965: Add EtherAVB device node

Kieran Bingham (7):
      arm64: dts: renesas: r8a77995: add FCPV nodes
      arm64: dts: renesas: r8a77995: add VSP instances
      arm64: dts: renesas: r8a77995: add DU support
      arm64: dts: renesas: r8a7795-es1: Fix register mappings on VSPs
      arm64: dts: renesas: r8a7795: Fix register mappings on VSPs
      arm64: dts: renesas: r8a7796: Fix register mappings on VSPs
      arm64: dts: renesas: draak: Enable DU

Niklas S?derlund (4):
      arm64: dts: renesas: r8a7796: add thermal cooling management
      arm64: dts: renesas: r8a7795: add thermal cooling management
      arm64: dts: renesas: r8a7795: update register size for thermal
      arm64: dts: renesas: r8a7796: update register size for thermal

Sergei Shtylyov (14):
      arm64: add Renesas R8A77980 support
      arm64: dts: renesas: initial R8A77980 SoC device tree
      arm64: dts: renesas: r8a77980: add SYS-DMAC support
      arm64: dts: renesas: r8a77970: add PFC support
      arm64: dts: renesas: eagle: add SCIF0 pins
      arm64: dts: renesas: r8a77970: add GPIO support
      arm64: dts: renesas: eagle: specify EtherAVB PHY IRQ
      arm64: dts: renesas: r8a77980: add [H]SCIF support
      arm64: dts: renesas: r8a77980: add EtherAVB support
      arm64: dts: renesas: initial Condor board device tree
      arm64: dts: renesas: condor: add EtherAVB support
      arm64: dts: renesas: r8a77970: add I2C support
      arm64: dts: renesas: eagle: add I2C0 support
      arm64: dts: renesas: v3msk: add SCIF0 pins

Simon Horman (4):
      arm64: dts: renesas: r8a7795: move scif node into alphabetical order
      arm64: dts: renesas: r8a77970: move node which has no reg property out of bus
      arm64: dts: renesas: r8a77995: move nodes which have no reg property out of bus
      arm64: dts: renesas: r8a7795: Add IPMMU-PV1 device node

Takeshi Kihara (1):
      arm64: dts: renesas: Add support for Salvator-XS with R-Car M3-N

Ulrich Hecht (4):
      arm64: dts: renesas: r8a77995: add I2C support
      arm64: dts: renesas: draak: enable I2C controller 0 and EEPROM
      arm64: dts: renesas: draak: enable I2C controller 1
      arm64: dts: renesas: draak: enable SDHI2

Wolfram Sang (1):
      arm64: dts: renesas: salvator-common: add GPIO extender

 arch/arm64/Kconfig.platforms                       |  12 +
 arch/arm64/boot/dts/renesas/Makefile               |   2 +
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi       |   3 +-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 194 ++++-
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           | 130 ++-
 .../arm64/boot/dts/renesas/r8a77965-salvator-x.dts |  21 +
 .../boot/dts/renesas/r8a77965-salvator-xs.dts      |  21 +
 arch/arm64/boot/dts/renesas/r8a77965.dtsi          | 878 +++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts     |  33 +
 arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts     |  11 +
 arch/arm64/boot/dts/renesas/r8a77970.dtsi          | 218 ++++-
 arch/arm64/boot/dts/renesas/r8a77980-condor.dts    |  58 ++
 arch/arm64/boot/dts/renesas/r8a77980.dtsi          | 385 +++++++++
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts     | 124 +++
 arch/arm64/boot/dts/renesas/r8a77995.dtsi          | 193 ++++-
 arch/arm64/boot/dts/renesas/salvator-common.dtsi   |   8 +
 arch/arm64/boot/dts/renesas/ulcb.dtsi              |   1 +
 17 files changed, 2216 insertions(+), 76 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77965.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77980-condor.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77980.dtsi

From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 31 Jul 2017 17:03:06 +0200
Subject: [GIT PULL] Renesas ARM64 Based SoC DT Updates for v4.14
Message-ID: <cover.1501509525.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM64 based SoC DT updates for v4.14.


The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt-for-v4.14

for you to fetch changes up to 4725f2b8805718a65dcbce8668710f145df797a8:

  arm64: dts: renesas: r8a7795: add hsusb ch3 device node (2017-07-27 17:19:05 +0200)

----------------------------------------------------------------
Renesas ARM64 Based SoC DT Updates for v4.14

* Add usb2.0 for R-Car H3 (r8a7795) ES2.0 SoC

* Add R-Car D3 (r8a77995) SoC and Draak board support

  Adds minimal support for the R-Car D3 SoC and the Draak development
  board, allowing to boot from a ramdisk using a serial console.

* Add Add VC6 clock generator to R-Car H3 (r8a7795)/Salvator-XS board

  The VC6 is an I2C-controlled programmable clock generator, used on the
  board to provide a display dot clock. Add it to DT.

* Add missing second pair of DMA names to MSIOF nodes to
  R-Car M3-W (r8a7796) SoC

  MSIOF0 and MSIOF1 are tied to two DMA controllers through two pairs of
  DMA specifiers.  However, the second pair of corresponding DMA names was
  missing.

* Add support for the DU to R-Car H3 (r8a7795) SoC

  Add a compatible string and VSP links to the DU node. The H3 ES1.x and H3
  ES2.0 are compatible save for the links to the VSPs that are described
  explicitly in DT, so there's no need for a new ES2-specific compatible
  string.

* Enable HDMI on R-Car H3 (r8a7795) and M3-W (r8a7796) ULCB boards

* Enable DU on R-Car M3-W (r8a7796) Salvator-X board

* Enable I2C for DVFS on R-Car H3 (r8a7795) and M3-W (r8a7796) ULCB boards

* Add Add DRIF support to R-Car H3 (r8a7795) and M3-W (r8a7796) SoCs

  Ramesh Shanmugasundaram says, "R-Car Gen3 DRIF is a SPI like receive only
  slave device."

* Move CPG_AUDIO_CLK_I from board to soc files

  Geert Uytterhoeven says, "The definition of CPG_AUDIO_CLK_I is
  SoC-specific, not board-specific."

* Add IMR-LX4 support to R-Car H3 (r8a7795) and M3-W (r8a7796) SoCs

  Sergei Shtylyov says, "The image renderer light extended 4 (IMR-LX4) or
  the distortion correction engine is a drawing processor with a simple
  instruction system capable of referencing data on an external memory as
  2D texture data and performing texture mapping and drawing with respect
  to any shape that is split into triangular objects."

----------------------------------------------------------------
Geert Uytterhoeven (6):
      arm64: dts: renesas: Move CPG_AUDIO_CLK_I from board to soc files
      arm64: dts: r8a7795: Add all MSIOF nodes
      arm64: dts: r8a7796: Add missing second pair of DMA names to MSIOF nodes
      arm64: renesas: Add Renesas R8A77995 Kconfig support
      arm64: dts: renesas: Add Renesas R8A77995 SoC support
      arm64: dts: renesas: Add Renesas Draak board support

Kazuya Mizuguchi (1):
      arm64: dts: renesas: r8a7795: Add usb companion property in EHCI

Laurent Pinchart (9):
      arm64: dts: r8a7796: Add FCPF and FCPV instances
      arm64: dts: r8a7796: Add VSP instances
      arm64: dts: r8a7796: Add DU device to DT
      arm64: dts: r8a7796: Add HDMI encoder instance
      arm64: dts: r8a7796: salvator-x: Add DU external dot clocks
      arm64: dts: r8a7796: salvator-x: Enable HDMI output
      arm64: dts: r8a7795: Add support for the DU
      arm64: dts: salvator-xs: Add VC6 clock generator
      arm64: dts: r8a7795: salvator-xs: Connect DU dot clocks 0 and 3

Ramesh Shanmugasundaram (2):
      arm64: dts: r8a7796: Add DRIF support
      arm64: dts: r8a7795: Add DRIF support

Sergei Shtylyov (2):
      arm64: dts: r8a7795: add IMR-LX4 support
      arm64: dts: r8a7796: add IMR-LX4 support

Vladimir Barinov (7):
      arm64: dts: ulcb: Enable I2C for DVFS device
      arm64: dts: ulcb: Enable I2C4
      arm64: dts: ulcb: Add DU external dot clock sources
      arm64: dts: r8a7795: h3ulcb: Add DU external dot clocks
      arm64: dts: r8a7796: m3ulcb: Add DU external dot clocks
      arm64: dts: ulcb: Add HDMI output connector
      arm64: dts: ulcb: Enable HDMI output

Yoshihiro Shimoda (4):
      arm64: dts: renesas: r8a7795: add usb2_phy ch3 device node
      arm64: dts: renesas: r8a7795: add usb2.0 host ch3 device nodes
      arm64: dts: renesas: r8a7795: add usb-dmac ch2 and ch3 device nodes
      arm64: dts: renesas: r8a7795: add hsusb ch3 device node

 arch/arm64/Kconfig.platforms                       |   6 +
 arch/arm64/boot/dts/renesas/Makefile               |   1 +
 arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb.dts |   2 -
 .../boot/dts/renesas/r8a7795-es1-salvator-x.dts    |   2 -
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi       |   9 +-
 arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts     |  16 +-
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |   2 -
 .../arm64/boot/dts/renesas/r8a7795-salvator-xs.dts |   8 +-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 311 +++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts     |  14 +-
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts |  31 +-
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           | 301 +++++++++++++++++++-
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts     |  46 +++
 arch/arm64/boot/dts/renesas/r8a77995.dtsi          | 150 ++++++++++
 arch/arm64/boot/dts/renesas/salvator-xs.dtsi       |  10 +
 arch/arm64/boot/dts/renesas/ulcb.dtsi              |  51 ++++
 16 files changed, 940 insertions(+), 20 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77995-draak.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77995.dtsi

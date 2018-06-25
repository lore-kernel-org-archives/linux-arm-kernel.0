From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Jun 2018 16:03:16 +0200
Subject: [GIT PULL] Renesas ARM64 Based SoC DT Updates for v4.19
Message-ID: <cover.1529933747.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM64 based SoC DT updates for v4.19.


The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt-for-v4.19

for you to fetch changes up to 6b284a81307848b4331453b02cf7a33c09719d4b:

  arm64: dts: renesas: r8a77995: Add MSIOF device nodes (2018-06-25 15:30:39 +0200)

----------------------------------------------------------------
Renesas ARM64 Based SoC DT Updates for v4.19

* All applicable R-Car Gen 3 SoCs
  - Correct VSPD registers range
  - Convert R-Car Gen3 SoC and board DT files to SPDX identifiers

* R-Car H3 (r8a7795), M3-W (r8a7796) and M3-N (r8a77965) SoCs
  - Salvator-X and Salvator-XS boards
    + Describe HSCIF1 device
    + Correct I2C ch4 clock to 400kHz
  - Salvator-X, Salvator-XS and ULCB boards
    + Add sdhi2_ds pin group to SDHI2 pinctrl groups

* R-Car H3 (r8a7795) SoC
  - Describe CryptoCAL (CCREE) device

* R-Car M3-W (r8a7796) SoC
  - Describe PCIe devices
  - Describe HSCIF nodes

* R-Car M3-N (r8a77965) SoC
  - Describe PCIe devices
  - Use CPG MSSR symbols instead of numeric indicies

* R-Car D3 (r8a77995) SoC
  - Describe Thermal device
  - Describe MSIOF devices
  - Add power domains to description of IPMMU devices
  - Do not use deprecated renesas,gpio-rcar compat string
  - Describe HDMI and CVBS input in DT of R-Car Gen3 D3 Draak board

* R-Car V3H (r8a77980) SoC
  - Describe secondary CA53 CPU cores, and GPIO and
    interconected FCPVD0, VSPD0, DU, and LVDS0 devices
  - Enable ethernet on V3HSK board
  - Specify Ethernet PHY IRQs in the DT of the Condor and V3HSK boards.
    This is possible now that GPIO support is present.
    Previously phylib had to resort to polling.
  - Enable I2C0 on Condor board

* R-Car E3 (r8a77990)
  - Enable Watchdog timer and USB2.0 host on Ebisu board
  - Enable secondary CA53 CPU core

----------------------------------------------------------------
Geert Uytterhoeven (2):
      arm64: dts: renesas: r8a77965: Use r8a77965-cpg-mssr binding definitions
      arm64: dts: renesas: r8a77990: Add secondary CA53 CPU core

Gilad Ben-Yossef (1):
      arm64: dts: renesas: r8a7795: add ccree to device tree

Harunobu Kurokawa (1):
      arm64: dts: renesas: r8a7796: Add PCIe device nodes

Hiromitsu Yamasaki (2):
      arm64: dts: renesas: salvator-common: Add HSCIF1 device support
      arm64: dts: renesas: r8a77995: Add MSIOF device nodes

Jacopo Mondi (2):
      arm64: dts: renesas: draak: Describe CVBS input
      arm64: dts: renesas: draak: Describe HDMI input

Laurent Pinchart (1):
      arm64: dts: renesas: Fix VSPD registers range

Magnus Damm (1):
      arm64: dts: renesas: r8a77995: Add IPMMU power domains

Masaharu Hayakawa (1):
      arm64: dts: renesas: Add sdhi2_ds pin group to SDHI2 pinctrl groups

Sergei Shtylyov (8):
      arm64: dts: renesas: r8a77980: add SMP support
      arm64: dts: renesas: r8a77980: add GEther support
      arm64: dts: renesas: v3hsk: add GEther support
      arm64: dts: renesas: r8a77980: add I2C support
      arm64: dts: renesas: condor: add I2C0 support
      arm64: dts: renesas: r8a77980: add GPIO support
      arm64: dts: renesas: condor/v3hsk: specify Ethernet PHY IRQs
      arm64: dts: renesas: r8a77980: add FCPVD/VSPD/DU/LVDS support

Simon Horman (1):
      arm64: dts: renesas: r8a77995: don't use deprecated renesas,gpio-rcar compat string

Takeshi Kihara (5):
      arm64: dts: renesas: r8a77965: Add Watchdog Timer controller node using RCLK Watchdog Timer
      arm64: dts: renesas: r8a77965: Add all HSCIF nodes
      arm64: dts: renesas: salvator-x(s): Update I2C ch4 clock to 400kHz
      arm64: dts: renesas: r8a77990: ebisu: Enable watchdog timer
      arm64: dts: renesas: r8a77965: Add PCIe device nodes

Ulrich Hecht (1):
      arm64: dts: renesas: draak: add X12 input dot clock

Wolfram Sang (1):
      arm64: dts: renesas: convert to SPDX identifiers

Yoshihiro Kaneko (1):
      arm64: dts: renesas: r8a77995: add thermal device support

Yoshihiro Shimoda (1):
      arm64: dts: renesas: r8a77990: Enable USB2.0 Host for Ebisu board

 .../boot/dts/renesas/r8a7795-es1-h3ulcb-kf.dts     |   5 +-
 arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb.dts |   5 +-
 .../boot/dts/renesas/r8a7795-es1-salvator-x.dts    |   5 +-
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi       |   7 +-
 arch/arm64/boot/dts/renesas/r8a7795-h3ulcb-kf.dts  |   5 +-
 arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts     |   5 +-
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |   5 +-
 .../arm64/boot/dts/renesas/r8a7795-salvator-xs.dts |   5 +-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |  20 +-
 arch/arm64/boot/dts/renesas/r8a7796-m3ulcb-kf.dts  |   5 +-
 arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts     |   5 +-
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts |   5 +-
 .../arm64/boot/dts/renesas/r8a7796-salvator-xs.dts |   5 +-
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           |  61 +++-
 arch/arm64/boot/dts/renesas/r8a77965.dtsi          | 159 +++++++++-
 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts     |   5 +-
 arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts     |   5 +-
 arch/arm64/boot/dts/renesas/r8a77970.dtsi          |   7 +-
 arch/arm64/boot/dts/renesas/r8a77980-condor.dts    |  29 ++
 arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts     |  23 ++
 arch/arm64/boot/dts/renesas/r8a77980.dtsi          | 324 ++++++++++++++++++++-
 arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts     |  25 ++
 arch/arm64/boot/dts/renesas/r8a77990.dtsi          |  74 ++++-
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts     | 133 ++++++++-
 arch/arm64/boot/dts/renesas/r8a77995.dtsi          | 133 +++++++--
 arch/arm64/boot/dts/renesas/salvator-common.dtsi   |  24 +-
 arch/arm64/boot/dts/renesas/salvator-x.dtsi        |   7 +-
 arch/arm64/boot/dts/renesas/salvator-xs.dtsi       |   7 +-
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi           |   5 +-
 arch/arm64/boot/dts/renesas/ulcb.dtsi              |   9 +-
 30 files changed, 960 insertions(+), 152 deletions(-)

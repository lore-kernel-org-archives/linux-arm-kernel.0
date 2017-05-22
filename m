From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 22 May 2017 15:58:46 +0200
Subject: [GIT PULL] Renesas ARM64 Based SoC DT Updates for v4.13
Message-ID: <cover.1495457812.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM64 based SoC DT updates for v4.13.


The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt-for-v4.13

for you to fetch changes up to 0b03c32db03d63de695c1e0ab1950eb12b135fa7:

  arm64: dts: r8a7795: salvator-x: Add support for R-Car H3 ES2.0 (2017-05-22 14:54:57 +0200)

----------------------------------------------------------------
Renesas ARM64 Based SoC DT Updates for v4.13

* Add support for R-Car H3 ES2.0
* Break out common board support
* Set drive-strength for ravb pins for r8a7795/h3ulcb and r8a7796/m3ulcb
* Enable HDMI outputs on r8a7795/salvator-x
* Add R-Car audio to DT of r8a7796 SoC
* Add current sense amplifiers to DT of r8a779[56]/salvator-x
* Enable NFS-root on r8a7796/salvator-x
* Enable HS200 for eMMC on r8a779[56]/salvator-x,
  r8a7795/h3ulcb and r8a7796/m3ulcb
* Enable EthernetAVB, I2C r8a7796/m3ulcb
* Update memory node to 2 GiB map on r8a7796/m3ulcb

----------------------------------------------------------------
Geert Uytterhoeven (9):
      arm64: dts: r8a7796: salvator-x: Enable NFS root
      arm64: dts: r8a7796: salvator-x: Set drive-strength for ravb pins
      arm64: dts: r8a7796: Add external audio clocks
      arm64: dts: r8a7796: Add external PCIe bus clock
      arm64: dts: r8a7796: Add placeholders for various devices
      arm64: dts: renesas: Extract common Salvator-X board support
      arm64: dts: renesas: Extract common ULCB board support
      arm64: dts: r8a7795: Add support for R-Car H3 ES2.0
      arm64: dts: r8a7795: salvator-x: Add support for R-Car H3 ES2.0

Jacopo Mondi (1):
      arm64: dts: salvator-x: Add current sense amplifiers

Koji Matsuoka (1):
      arm64: dts: renesas: r8a7795-salvator-x: Enable HDMI outputs

Kuninori Morimoto (7):
      arm64: dts: r8a7796: add AUDIO_DMAC support
      arm64: dts: r8a7796: add Sound SSI PIO support
      arm64: dts: r8a7796: add Sound SSI DMA support
      arm64: dts: r8a7796: add Sound SRC support
      arm64: dts: r8a7796: add Sound DVC support
      arm64: dts: r8a7796: add Sound CTU support
      arm64: dts: r8a7796: add Sound MIX support

Laurent Pinchart (4):
      arm64: dts: salvator-x: Add panel backlight support
      arm64: dts: renesas: salvator-x: Add DU external dot clock sources
      arm64: dts: renesas: salvator-x: Add HDMI output connectors
      arm64: dts: renesas: r8a7795-salvator-x: Add DU external dot clocks

Simon Horman (3):
      arm64: dts: m3ulcb: Fix EthernetAVB PHY timing
      arm64: dts: r8a7795: update PFC node name to pin-controller
      arm64: dts: ulcb: Set drive-strength for ravb pins

Takeshi Kihara (2):
      arm64: dts: r8a7795: salvator-x: Update memory node to 4 GiB map
      arm64: dts: r8a7796: Add PWM device nodes

Ulrich Hecht (1):
      arm64: dts: renesas: r8a7795: Add HDMI encoder support

Vladimir Barinov (5):
      arm64: dts: m3ulcb: enable I2C
      arm64: dts: m3ulcb: Update memory node to 2 GiB map
      arm64: dts: m3ulcb: enable EthernetAVB
      arm64: dts: m3ulcb: enable HS200 for eMMC
      arm64: dts: h3ulcb: enable HS200 for eMMC

Wolfram Sang (2):
      arm64: dts: r8a7795: salvator-x: enable HS200 for eMMC
      arm64: dts: r8a7796: salvator-x: enable HS200 for eMMC

 arch/arm64/boot/dts/renesas/Makefile               |   1 +
 .../boot/dts/renesas/r8a7795-es1-salvator-x.dts    | 115 ++++
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi       |  84 +++
 arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts     | 344 +----------
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 565 ++----------------
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 121 ++--
 arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts     | 168 +-----
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts | 244 +-------
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           | 409 +++++++++++++
 arch/arm64/boot/dts/renesas/salvator-x.dtsi        | 644 +++++++++++++++++++++
 arch/arm64/boot/dts/renesas/ulcb.dtsi              | 367 ++++++++++++
 11 files changed, 1734 insertions(+), 1328 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/salvator-x.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/ulcb.dtsi

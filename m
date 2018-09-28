From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 28 Sep 2018 12:20:16 +0200
Subject: [GIT PULL] Second Round of Renesas ARM64 Based SoC DT Updates for
 v4.20
Message-ID: <cover.1538125184.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM64 based SoC DT updates for v4.20.

This pull request is based on the previous round of
such requests, tagged as renesas-arm64-dt-for-v4.20,
which you have already pulled.


The following changes since commit 450d6079e8d3c40c7ce67ac8bb4a2da9baf56613:

  arm64: dts: r8a77965: add FDP1 device nodes (2018-09-13 09:48:13 +0200)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt2-for-v4.20

for you to fetch changes up to 158928f38e1c6f3ac4dd83cf2240ae412179005d:

  arm64: dts: renesas: r8a77965: Add Sound and Audio DMAC device nodes (2018-09-26 12:31:04 +0200)

----------------------------------------------------------------
Second Round of Renesas ARM64 Based SoC DT Updates for v4.20

* Remove unneeded status from thermal nodes

* R-Car Gen 3 SoCs:
  - Use 400kHz for I2C DVFS bus
  - Revise USB2.0 properties
* R-Car Gen 3 SoC based ULCB boards: Add default bootargs
* R-Car M3-N (r8a77965) SoC based boards: Enable audio with DMA

* R-Car V3M (r8a77970 and V3H (r8a77980) SoCs:
  - Add compare match timer (CMT) support
  - Add timer pulse unit (TPU) support
* R-Car V3H (r8a77980) and E3 (r8a77990) SoCs:
  - Attach the SYS-DMAC to the IPMMU
* E3 (r8a77990) SoC: Add display output support
* R-Car E3 (r8a77990) based Ebisu board:
  - Enable HDMI and CVBS input, and VGA and HDMI display output

* R-Car D3 (r8a77995) SoC: Add LVDS support
* R-Car D3 (r8a77995) based Draak board: Enable HDMI display output

----------------------------------------------------------------
Geert Uytterhoeven (1):
      arm64: dts: renesas: Remove unneeded status from thermal nodes

Jacopo Mondi (1):
      arm64: dts: renesas: ebisu: Add HDMI and CVBS input

Kieran Bingham (1):
      arm64: dts: renesas: r8a77995: Add LVDS support

Kuninori Morimoto (1):
      arm64: dts: renesas: ulcb: add default bootargs

Laurent Pinchart (2):
      arm64: dts: renesas: r8a77990: Add display output support
      arm64: dts: renesas: r8a77990: ebisu: Enable VGA and HDMI outputs

Magnus Damm (2):
      arm64: dts: renesas: r8a77990: Attach the SYS-DMAC to the IPMMU
      arm64: dts: renesas: r8a77980: Attach the SYS-DMAC to the IPMMU

Sergei Shtylyov (2):
      arm64: dts: renesas: r8a779{7|8}0: add CMT support
      arm64: dts: renesas: r8a779{7|8}0: add TPU support

Takeshi Kihara (1):
      arm64: dts: renesas: r8a77965: Add Sound and Audio DMAC device nodes

Ulrich Hecht (1):
      arm64: dts: renesas: r8a77995: draak: Enable HDMI display output

Wolfram Sang (1):
      arm64: dts: renesas: gen3: use 400kHz for I2C DVFS bus

Yoshihiro Shimoda (1):
      arm64: dts: renesas: revise properties for R-Car Gen3 SoCs' usb 2.0

 arch/arm64/boot/dts/renesas/r8a774a1.dtsi        |   1 -
 arch/arm64/boot/dts/renesas/r8a7795.dtsi         |  33 ++-
 arch/arm64/boot/dts/renesas/r8a7796.dtsi         |  17 +-
 arch/arm64/boot/dts/renesas/r8a77965.dtsi        | 262 +++++++++++++++++++++--
 arch/arm64/boot/dts/renesas/r8a77970.dtsi        |  80 +++++++
 arch/arm64/boot/dts/renesas/r8a77980.dtsi        |  97 +++++++++
 arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts   | 248 +++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a77990.dtsi        | 203 +++++++++++++++++-
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts   |  98 ++++++++-
 arch/arm64/boot/dts/renesas/r8a77995.dtsi        |  68 +++++-
 arch/arm64/boot/dts/renesas/salvator-common.dtsi |   2 +
 arch/arm64/boot/dts/renesas/ulcb.dtsi            |   3 +
 12 files changed, 1052 insertions(+), 60 deletions(-)

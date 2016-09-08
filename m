From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  8 Sep 2016 09:43:24 +0200
Subject: [GIT PULL] Renesas ARM64 Based SoC DT Updates for v4.9
Message-ID: <cover.1473320411.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM64 based SoC DT updates for v4.9.

This pull request is based on the sh-pfc-for-v4.9-tag2 of
Geert Uytterhoeven's renesas-driver's tree which is included in the
devel and for-next branches of Linus Walleij's linux-pinctrl tree.


The following changes since commit 374cf6992de89fc38d4d923c89b40816d341d678:

  pinctrl: sh-pfc: r8a7796: Add SDHI pins, groups and functions (2016-08-19 09:37:20 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt-for-v4.9

for you to fetch changes up to fa765e5ef49d57834ee66690ba8ed5932edb7968:

  arm64: dts: r8a7796: Add GPIO device nodes (2016-09-08 09:35:27 +0200)

----------------------------------------------------------------
Renesas ARM64 Based SoC DT Updates for v4.9

Clean up:
* Remove unnecessary cap-mmc-highspeed property from SDHI nodes on r8a7795 SoC
* Add SoC-specific compatible property to audio-dmac nodes on r8a7795 SoC

New Board:
* Add r8a7794/h3ulcb board

Enablement:
* Add PFC and GPIO to r8a7796 SoC
* Enable DU and USB 2.0 on r8a7795/salvator-x board
* Add VTP, FCPV, FCPF and FDP1 to r8a7795 SoC
* Set maximum frequency for SDHI clocks on r8a7795 SoC

----------------------------------------------------------------
Geert Uytterhoeven (1):
      arm64: dts: r8a7795: Add SoC-specific compatible property to audio-dmac nodes

Kieran Bingham (2):
      arm64: dts: r8a7795: add FCPF device nodes
      arm64: dts: r8a7795: add FDP1 device nodes

Laurent Pinchart (5):
      arm64: dts: renesas: r8a7795: Add FCPV nodes
      arm64: dts: renesas: r8a7795: Add VSP instances
      arm64: dts: renesas: r8a7795: Add DU device to DT
      arm64: dts: r8a7795: renesas: salvator-x: Enable DU
      arm64: dts: r8a7795: salvator-x: Configure pins for the DU RGB output

Simon Horman (1):
      arm64: dts: r8a7795: remove unnecessary cap-mmc-highspeed property

Takeshi Kihara (2):
      arm64: dts: r8a7796: Add pinctrl device node
      arm64: dts: r8a7796: Add GPIO device nodes

Ulrich Hecht (1):
      arm64: dts: r8a7796: salvator-x: add serial console pins

Vladimir Barinov (13):
      arm64: dts: h3ulcb: add H3ULCB board DT bindings
      arm64: dts: h3ulcb: initial device tree
      arm64: dts: h3ulcb: enable SCIF clk and pins
      arm64: dts: h3ulcb: enable EthernetAVB
      arm64: dts: h3ulcb: enable I2C2
      arm64: dts: h3ulcb: enable EXTALR clk
      arm64: dts: h3ulcb: enable WDT
      arm64: dts: h3ulcb: enable USB2 PHY of channel 1
      arm64: dts: h3ulcb: enable USB2.0 Host channel 1
      arm64: dts: h3ulcb: enable GPIO keys
      arm64: dts: h3ulcb: enable SDHI0
      arm64: dts: h3ulcb: Sound SSI support
      arm64: dts: h3ulcb: enable GPIO leds

Wolfram Sang (1):
      arm64: dts: r8a7795: set maximum frequency for SDHI clocks

Yoshihiro Shimoda (4):
      arm64: dts: r8a7795: Add HSUSB device node
      arm64: dts: r8a7795: salvator-x: enable usb2_phy of channel 0
      arm64: dts: r8a7795: salvator-x: enable USB 2.0 Host channel 0
      arm64: dts: r8a7795: salvator-x: enable HSUSB

 Documentation/devicetree/bindings/arm/shmobile.txt |   2 +
 arch/arm64/boot/dts/renesas/Makefile               |   2 +-
 arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts     | 328 +++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |  87 ++++++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 276 ++++++++++++++++-
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts |  16 +
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           | 117 ++++++++
 7 files changed, 823 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts

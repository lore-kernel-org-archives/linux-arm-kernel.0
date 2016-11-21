From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 21 Nov 2016 13:05:10 +0100
Subject: [GIT PULL v2] Second Round of Renesas ARM64 Based SoC DT Updates for
 v4.10
Message-ID: <cover.1479726397.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM64 based SoC DT updates for v4.10.

This pull request is based on the previous round of
such requests, tagged as renesas-arm64-dt-for-v4.10,
which I have already sent a pull-request for.

Changes since v1:
* No longer includes unnecessary dependencies in base


The following changes since commit 935085209343a0c507e3d9a3e01883b25c8f743e:

  arm64: renesas: r8a7796: add SYS-DMAC controller nodes (2016-11-04 10:18:07 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt2-for-v4.10

for you to fetch changes up to 5de68961cf5618c1ce5bb15848b36121247f23d5:

  arm64: dts: r8a7796: Add device node for PRR (2016-11-21 10:18:53 +0100)

----------------------------------------------------------------
Second Round of Renesas ARM64 Based SoC DT Updates for v4.10

Enhancements:
* Add device nodes for PRR
* Add m3ulcb board
* Enable I2C on r8a7796/salvator-x board
* Enable SDHI0 on h3ulcb board

----------------------------------------------------------------
Geert Uytterhoeven (2):
      arm64: dts: r8a7795: Add device node for PRR
      arm64: dts: r8a7796: Add device node for PRR

Ulrich Hecht (3):
      arm64: dts: r8a7796: add I2C support
      arm64: dts: r8a7796: Enable I2C DMA
      arm64: dts: r8a7796: salvator-x: enable I2C

Vladimir Barinov (13):
      arm64: dts: h3ulcb: update documentation with official board name
      arm64: dts: h3ulcb: update header
      arm64: dts: m3ulcb: add M3ULCB board DT bindings
      arm64: dts: m3ulcb: initial device tree
      arm64: dts: m3ulcb: enable SCIF clk and pins
      arm64: dts: m3ulcb: enable GPIO leds
      arm64: dts: m3ulcb: enable GPIO keys
      arm64: dts: m3ulcb: enable EXTALR clk
      arm64: dts: m3ulcb: enable WDT
      arm64: dts: m3ulcb: enable SDHI0
      arm64: dts: m3ulcb: enable SDHI2
      arm64: dts: h3ulcb: enable SDHI2
      arm64: dts: h3ulcb: rename SDHI0 pins

 Documentation/devicetree/bindings/arm/shmobile.txt |   4 +-
 arch/arm64/boot/dts/renesas/Makefile               |   2 +-
 arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts     |  53 +++++-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |   5 +
 arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts     | 189 +++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts |  12 ++
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           | 116 +++++++++++++
 7 files changed, 374 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts

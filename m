From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Oct 2015 10:58:00 +0900
Subject: [GIT PULL v2] Renesas ARM Based SoC DT Updates for v4.4
Message-ID: <cover.1444182812.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC DT updates for v4.4.

This pull request is based on
"Renesas ARM Based SoC Cleanup for v4.4,
tagged as renesas-cleanup-for-v4.4,
which you have already pulled.

The main differences since v1 of this pull-request are:

* Removed "Add missing CPG/MSTP Clock Domain for sound "* patches
  which are fixes now present in the ARM SoC fixes branch
  via the renesas-fixes-for-v4.3 tag of the renesas tree.
* Enable more hardware via DT
  + Enable PCI, USB PHY and HS, and VIN support on r8a7794/Silk
  + Add initial support for r8a7791/porter
  + Add common file for AA121TD01 panel

The following changes since commit 04418c23a9411b85b8789eab5f4397bcbd62b7b4:

  ARM: shmobile: Remove legacy clock support leftovers (2015-09-14 10:06:56 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-for-v4.4

for you to fetch changes up to 0877098d82fd1823878534b116a4a725e729701f:

  ARM: shmobile: porter: add Ether DT support (2015-10-06 09:44:53 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC DT Updates for v4.4

* Add missing CPG/MSTP Clock Domain for sound on r8a779[01] SoCs
* Tidy up SCI resource region on r8a779[018] SoCs
* Add pinmux for iic0 on Lager board
* Use CCF for audio clock on Lager and Koelsch boards
* Use serial0 and 1 as serial ports on Marzen board
* Use adxl345-specific compatible property for KZM9G board
* Document compat string for Silk board
* Enable GPIO, I2C, PCI, QSPI, USB PHY and HS, and VIN support on r8a7794/Silk
* Add initial support for r8a7791/porter
* Add common file for AA121TD01 panel

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ARM: shmobile: kzm9g dts: Use adxl345-specific compatible property

Kuninori Morimoto (6):
      ARM: shmobile: koelsch: use CCF for audio clock
      ARM: shmobile: lager: use CCF for audio clock
      ARM: shmobile: r8a7790: tidyup SSI resource region
      ARM: shmobile: r8a7791: tidyup SSI resource region
      ARM: shmobile: r8a7778: tidyup SSI resource region
      ARM: shmobile: dts: Add common file for AA121TD01 panel

Magnus Damm (1):
      ARM: shmobile: marzen: Board specific serial port order

Sergei Shtylyov (18):
      ARM: shmobile: r8a7794: add GPIO clocks
      ARM: shmobile: r8a7794: add GPIO DT support
      ARM: shmobile: r8a7794: add QSPI DT support
      ARM: shmobile: silk: add QSPI DT support
      ARM: shmobile: r8a7794: add I2C DT support
      ARM: shmobile: silk: add I2C1 DT support
      ARM: shmobile: r8a7794: add VIN DT support
      ARM: shmobile: silk: add VIN0/ADV7180 DT support
      ARM: shmobile: r8a7794: add internal PCI bridge nodes
      ARM: shmobile: silk: enable internal PCI
      ARM: shmobile: add Porter board DT bindings
      ARM: shmobile: porter: initial device tree
      ARM: shmobile: r8a7794: add USB PHY DT support
      ARM: shmobile: silk: enable USB PHY
      ARM: shmobile: r8a7794: link PCI USB devices to USB PHY
      ARM: shmobile: r8a7794: add HS-USB DT support
      ARM: shmobile: fix SILK board name
      ARM: shmobile: porter: add Ether DT support

Simon Horman (1):
      ARM: shmobile: Add silk device tree bindings documentation

Wolfram Sang (1):
      ARM: shmobile: r8a7790: lager: add pinmux for iic0

 Documentation/devicetree/bindings/arm/shmobile.txt |   4 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/r8a7778.dtsi                     |   2 +-
 arch/arm/boot/dts/r8a7779-marzen.dts               |   6 +-
 arch/arm/boot/dts/r8a7790-lager.dts                |  16 +-
 arch/arm/boot/dts/r8a7790.dtsi                     |   2 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts              |   9 +-
 arch/arm/boot/dts/r8a7791-porter.dts               |  80 +++++
 arch/arm/boot/dts/r8a7791.dtsi                     |   2 +-
 arch/arm/boot/dts/r8a7794-silk.dts                 | 114 +++++++
 arch/arm/boot/dts/r8a7794.dtsi                     | 326 ++++++++++++++++++++-
 arch/arm/boot/dts/r8a77xx-aa121td01-panel.dtsi     |  41 +++
 arch/arm/boot/dts/sh73a0-kzm9g.dts                 |   2 +-
 13 files changed, 588 insertions(+), 17 deletions(-)
 create mode 100644 arch/arm/boot/dts/r8a7791-porter.dts
 create mode 100644 arch/arm/boot/dts/r8a77xx-aa121td01-panel.dtsi

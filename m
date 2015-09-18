From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Sep 2015 09:47:03 +0900
Subject: [GIT PULL] Renesas ARM Based SoC DT Updates for v4.4
Message-ID: <cover.1442536920.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC DT updates for v4.4.

This pull request is based on
"Renesas ARM Based SoC Cleanup for v4.4, tagged as renesas-cleanup-for-v4.4,
which I have also sent a pull-request for.


The following changes since commit 04418c23a9411b85b8789eab5f4397bcbd62b7b4:

  ARM: shmobile: Remove legacy clock support leftovers (2015-09-14 10:06:56 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-for-v4.4

for you to fetch changes up to 2529493c288c109cf734235d1eb3de1b23d9bcef:

  ARM: shmobile: r8a7791 dtsi: Add CPG/MSTP Clock Domain for sound (2015-09-14 10:25:58 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC DT Updates for v4.4

* Add missing CPG/MSTP Clock Domain for sound on r8a779[01] SoCs
* Tidy up SCI resource region on r8a779[018] SoCs
* Add pinmux for iic0 on Lager board
* Use CCF for audio clock on Lager and Koelsch boards
* Use serial0 and 1 as serial ports on Marzen board
* Use adxl345-specific compatible property for KZM9G board
* Document compat string for Silk board
* Enable GPIO, I2C, QSPI and VIN support on r8a7794/Silk

----------------------------------------------------------------
Geert Uytterhoeven (3):
      ARM: shmobile: kzm9g dts: Use adxl345-specific compatible property
      ARM: shmobile: r8a7790 dtsi: Add CPG/MSTP Clock Domain for sound
      ARM: shmobile: r8a7791 dtsi: Add CPG/MSTP Clock Domain for sound

Kuninori Morimoto (5):
      ARM: shmobile: koelsch: use CCF for audio clock
      ARM: shmobile: lager: use CCF for audio clock
      ARM: shmobile: r8a7790: tidyup SSI resource region
      ARM: shmobile: r8a7791: tidyup SSI resource region
      ARM: shmobile: r8a7778: tidyup SSI resource region

Magnus Damm (1):
      ARM: shmobile: marzen: Board specific serial port order

Sergei Shtylyov (8):
      ARM: shmobile: r8a7794: add GPIO clocks
      ARM: shmobile: r8a7794: add GPIO DT support
      ARM: shmobile: r8a7794: add QSPI DT support
      ARM: shmobile: silk: add QSPI DT support
      ARM: shmobile: r8a7794: add I2C DT support
      ARM: shmobile: silk: add I2C1 DT support
      ARM: shmobile: r8a7794: add VIN DT support
      ARM: shmobile: silk: add VIN0/ADV7180 DT support

Simon Horman (1):
      ARM: shmobile: Add silk device tree bindings documentation

Wolfram Sang (1):
      ARM: shmobile: r8a7790: lager: add pinmux for iic0

 Documentation/devicetree/bindings/arm/shmobile.txt |   2 +
 arch/arm/boot/dts/r8a7778.dtsi                     |   2 +-
 arch/arm/boot/dts/r8a7779-marzen.dts               |   6 +-
 arch/arm/boot/dts/r8a7790-lager.dts                |  16 +-
 arch/arm/boot/dts/r8a7790.dtsi                     |   3 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts              |   9 +-
 arch/arm/boot/dts/r8a7791.dtsi                     |   3 +-
 arch/arm/boot/dts/r8a7794-silk.dts                 |  88 ++++++++
 arch/arm/boot/dts/r8a7794.dtsi                     | 224 ++++++++++++++++++++-
 arch/arm/boot/dts/sh73a0-kzm9g.dts                 |   2 +-
 10 files changed, 338 insertions(+), 17 deletions(-)

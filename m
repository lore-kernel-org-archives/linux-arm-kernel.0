From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Jun 2016 16:15:54 +0200
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC DT Updates for v4.8
Message-ID: <cover.1467294011.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC DT updates for v4.8.

This pull request is based on the previous round of
such requests, tagged as renesas-dt-for-v4.8,
which you have already pulled.


The following changes since commit b6960f19676e19f37a5e5a8af059fdf3b435d2f4:

  ARM: dts: silk: Fix W=1 dtc warnings (2016-05-30 09:37:13 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt2-for-v4.8

for you to fetch changes up to 8fd763c75c3ab8e72e5d7f0d4c53531e6ff76197:

  ARM: dts: r8a7792: add SMP support (2016-06-30 14:26:14 +0200)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC DT Updates for v4.8

* Use APMU on R-Car Gen2 and provide SMP for r8a7793 SoC
* Update console parameters to uniformly use chosen/stdout-path,
  serial0, not provide kernel unnecessary command line parameters
* Add DU pins to silk board
* Add support for blanche/r8a7792
* Name pfc subnodes after device name

----------------------------------------------------------------
Geert Uytterhoeven (24):
      ARM: dts: ape6evm: Name serial port pfc subnode after device name
      ARM: dts: ape6evm: Name mmc pfc subnode after device name
      ARM: dts: armadillo800eva: Name serial port pfc subnode after device name
      ARM: dts: bockw: Name serial port pfc subnode after device name
      ARM: dts: marzen: Name serial port pfc subnodes after device names
      ARM: dts: lager: Name serial port pfc subnodes after device names
      ARM: dts: lager: Name spi pfc subnodes after device names
      ARM: dts: lager: Name vin pfc subnode after device name
      ARM: dts: koelsch: Name serial port pfc subnodes after device names
      ARM: dts: koelsch: Name spi pfc subnodes after device names
      ARM: dts: porter: Name serial port pfc subnode after device name
      ARM: dts: porter: Name spi pfc subnode after device name
      ARM: dts: gose: Name serial port pfc subnodes after device names
      ARM: dts: gose: Name spi pfc subnode after device name
      ARM: dts: alt: Name serial port pfc subnode after device name
      ARM: dts: alt: Name spi pfc subnode after device name
      ARM: dts: silk: Name serial port pfc subnode after device name
      ARM: dts: silk: Name spi pfc subnode after device name
      ARM: dts: kzm9g: Name serial port pfc subnode after device name
      ARM: dts: armadillo800eva: Update console parameters
      ARM: dts: genmai: Update console parameters
      ARM: dts: marzen: Add serial port config to chosen/stdout-path
      ARM: dts: kzm9d: Update console parameters
      ARM: dts: kzm9g: Update console parameters

Magnus Damm (4):
      devicetree: bindings: Renesas APMU and SMP Enable method
      ARM: dts: r8a7790: Add APMU nodes
      ARM: dts: r8a7791: Add APMU node
      ARM: dts: r8a7793: Add APMU node and second CPU core

Sergei Shtylyov (13):
      ARM: dts: r8a7792: add clock index macros
      ARM: dts: r8a7792: add power domain index macros
      ARM: dts: r8a7792: initial SoC device tree
      ARM: dts: r8a7792: add SYS-DMAC support
      ARM: dts: r8a7792: add [H]SCIF support
      ARM: dts: r8a7792: add IRQC support
      ARM: dts: blanche: document Blanche board
      ARM: dts: blanche: initial device tree
      ARM: dts: blanche: add Ethernet support
      ARM: dts: silk: add DU pins
      ARM: dts: r8a7792: add JPU clocks
      ARM: dts: r8a7792: add JPU support
      ARM: dts: r8a7792: add SMP support

 Documentation/devicetree/bindings/arm/cpus.txt     |   1 +
 Documentation/devicetree/bindings/arm/shmobile.txt |   2 +
 .../devicetree/bindings/power/renesas,apmu.txt     |  31 ++
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/emev2-kzm9d.dts                  |   8 +-
 arch/arm/boot/dts/r7s72100-genmai.dts              |   4 +-
 arch/arm/boot/dts/r8a73a4-ape6evm.dts              |   4 +-
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts      |   8 +-
 arch/arm/boot/dts/r8a7778-bockw.dts                |   2 +-
 arch/arm/boot/dts/r8a7779-marzen.dts               |   6 +-
 arch/arm/boot/dts/r8a7790-lager.dts                |  10 +-
 arch/arm/boot/dts/r8a7790.dtsi                     |  13 +
 arch/arm/boot/dts/r8a7791-koelsch.dts              |   8 +-
 arch/arm/boot/dts/r8a7791-porter.dts               |   4 +-
 arch/arm/boot/dts/r8a7791.dtsi                     |   7 +
 arch/arm/boot/dts/r8a7792-blanche.dts              |  66 ++++
 arch/arm/boot/dts/r8a7792.dtsi                     | 378 +++++++++++++++++++++
 arch/arm/boot/dts/r8a7793-gose.dts                 |   6 +-
 arch/arm/boot/dts/r8a7793.dtsi                     |  15 +
 arch/arm/boot/dts/r8a7794-alt.dts                  |   4 +-
 arch/arm/boot/dts/r8a7794-silk.dts                 |  16 +-
 arch/arm/boot/dts/sh73a0-kzm9g.dts                 |   8 +-
 include/dt-bindings/clock/r8a7792-clock.h          | 103 ++++++
 include/dt-bindings/power/r8a7792-sysc.h           |  26 ++
 24 files changed, 695 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/renesas,apmu.txt
 create mode 100644 arch/arm/boot/dts/r8a7792-blanche.dts
 create mode 100644 arch/arm/boot/dts/r8a7792.dtsi
 create mode 100644 include/dt-bindings/clock/r8a7792-clock.h
 create mode 100644 include/dt-bindings/power/r8a7792-sysc.h

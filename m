From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  8 Jun 2016 09:59:59 +0900
Subject: [GIT PULL] Renesas ARM Based SoC DT Updates for v4.8
Message-ID: <cover.1465346599.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC DT updates for v4.8.


The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-for-v4.8

for you to fetch changes up to b6960f19676e19f37a5e5a8af059fdf3b435d2f4:

  ARM: dts: silk: Fix W=1 dtc warnings (2016-05-30 09:37:13 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC DT Updates for v4.8

* Fix W=1 dtc warnings
* Reverence both DMA controllers on R-Car Gen 2 SoCs
* Remove nonexistent thermal sensor clock from r8a7794 SoC
* Correct unit names for cpu nodes on r8a7790 SoC
* Add MMCIF0 to r8a7793 SoC
* RTS/CTS hardware flow control for kzm9g and bockw boards

----------------------------------------------------------------
Geert Uytterhoeven (25):
      ARM: dts: bockw: SCIF0 supports RTS/CTS hardware flow control
      ARM: dts: kzm9g: SCIFA4 supports RTS/CTS hardware flow control
      ARM: dts: r8a7790: Correct unit names for cpu nodes
      ARM: dts: r8a7794: Remove nonexistent thermal sensor clock
      ARM: dts: emev2: Fix W=1 dtc warnings
      ARM: dts: r8a73a4: Fix W=1 dtc warnings
      ARM: dts: r8a7740: Fix W=1 dtc warnings
      ARM: dts: r8a7778: Fix W=1 dtc warnings
      ARM: dts: r8a7790: Fix W=1 dtc warnings
      ARM: dts: r8a7791: Fix W=1 dtc warnings
      ARM: dts: r8a7793: Fix W=1 dtc warnings
      ARM: dts: r8a7794: Fix W=1 dtc warnings
      ARM: dts: sh73a0: Fix W=1 dtc warnings
      ARM: dts: ape6evm: Fix W=1 dtc warnings
      ARM: dts: armadillo800eva: Fix W=1 dtc warnings
      ARM: dts: bockw: Fix W=1 dtc warnings
      ARM: dts: genmai: Fix W=1 dtc warnings
      ARM: dts: gose: Fix W=1 dtc warnings
      ARM: dts: koelsch: Fix W=1 dtc warnings
      ARM: dts: kzm9d: Fix W=1 dtc warnings
      ARM: dts: kzm9g: Fix W=1 dtc warnings
      ARM: dts: lager: Fix W=1 dtc warnings
      ARM: dts: marzen: Fix W=1 dtc warnings
      ARM: dts: porter: Fix W=1 dtc warnings
      ARM: dts: silk: Fix W=1 dtc warnings

Niklas S?derlund (4):
      ARM: dts: r8a7790: Reference both DMA controllers
      ARM: dts: r8a7791: Reference both DMA controllers
      ARM: dts: r8a7793: Reference both DMA controllers
      ARM: dts: r8a7794: Reference both DMA controllers

Ulrich Hecht (1):
      ARM: dts: r8a7793: Add MMCIF0

 arch/arm/boot/dts/emev2-kzm9d.dts             |  16 +-
 arch/arm/boot/dts/emev2.dtsi                  |  26 +--
 arch/arm/boot/dts/r7s72100-genmai.dts         |   2 +-
 arch/arm/boot/dts/r8a73a4-ape6evm.dts         |   8 +-
 arch/arm/boot/dts/r8a73a4.dtsi                |  34 ++--
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts |  12 +-
 arch/arm/boot/dts/r8a7740.dtsi                |   2 +-
 arch/arm/boot/dts/r8a7778-bockw.dts           |   5 +-
 arch/arm/boot/dts/r8a7778.dtsi                |  28 ++--
 arch/arm/boot/dts/r8a7779-marzen.dts          |   4 +-
 arch/arm/boot/dts/r8a7790-lager.dts           |  20 +--
 arch/arm/boot/dts/r8a7790.dtsi                | 232 +++++++++++++++-----------
 arch/arm/boot/dts/r8a7791-koelsch.dts         |  12 +-
 arch/arm/boot/dts/r8a7791-porter.dts          |   8 +-
 arch/arm/boot/dts/r8a7791.dtsi                | 224 ++++++++++++++-----------
 arch/arm/boot/dts/r8a7793-gose.dts            |  12 +-
 arch/arm/boot/dts/r8a7793.dtsi                | 198 +++++++++++++---------
 arch/arm/boot/dts/r8a7794-silk.dts            |   6 +-
 arch/arm/boot/dts/r8a7794.dtsi                | 132 +++++++++------
 arch/arm/boot/dts/sh73a0-kzm9g.dts            |  11 +-
 arch/arm/boot/dts/sh73a0.dtsi                 |   2 +-
 include/dt-bindings/clock/r8a7794-clock.h     |   1 -
 22 files changed, 564 insertions(+), 431 deletions(-)

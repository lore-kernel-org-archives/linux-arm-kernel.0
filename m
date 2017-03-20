From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 20 Mar 2017 09:58:08 +0100
Subject: [GIT PULL] Renesas ARM Based SoC DT Updates for v4.12
Message-ID: <cover.1489999062.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC DT updates for v4.12.

* Conflicts

  "Add watchdog timer to r7s72100 SoC", which is part of this patch-set,
  has a minor conflict with "ARM: 8661/1: dts: r7s72100: add l2 cache",
  which I believe Russell King has in his tree.

  The resolution is to take both.


The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-for-v4.12

for you to fetch changes up to d01ff18992218f3a13f45f45a886b3bf8f250f14:

  ARM: dts: silk: Drop superfluous status update for frequency override (2017-03-13 10:19:35 +0100)

----------------------------------------------------------------
Renesas ARM Based SoC DT Updates for v4.12

Cleanup:
* Drop superfluous status update for frequency override on various boards
* Always use status "okay" to enable devices on porger board
* Add INTC-SYS clock to device tree of various SoCs
* Tidyup Audio-DMAC channel for DVC on r8a779[013] SoCs
* Remove unit-address and reg from integrated cache on various SoCs
* Switch from ARCH_SHMOBILE_MULTI to ARCH_RENESAS
* Fix SCIFB0 dmas indentation on r8a774[35] SoCs

Enhancements:
* Add watchdog timer to r7s72100 SoC
* Update sdhi clock bindings on r7s72100 SoC

----------------------------------------------------------------
Chris Brandt (2):
      ARM: dts: r7s72100: update sdhi clock bindings
      ARM: dts: r7s72100: Add watchdog timer

Geert Uytterhoeven (26):
      ARM: dts: r8a7743: Fix SCIFB0 dmas indentation
      ARM: dts: r8a7745: Fix SCIFB0 dmas indentation
      ARM: dts: renesas: Switch from ARCH_SHMOBILE_MULTI to ARCH_RENESAS
      ARM: dts: r8a73a4: Remove unit-addresses and regs from integrated caches
      ARM: dts: r8a7743: Remove unit-address and reg from integrated cache
      ARM: dts: r8a7745: Remove unit-address and reg from integrated cache
      ARM: dts: r8a7790: Remove unit-addresses and regs from integrated caches
      ARM: dts: r8a7791: Remove unit-address and reg from integrated cache
      ARM: dts: r8a7792: Remove unit-address and reg from integrated cache
      ARM: dts: r8a7793: Remove unit-address and reg from integrated cache
      ARM: dts: r8a7794: Remove unit-address and reg from integrated cache
      ARM: dts: r8a73a4: Add INTC-SYS clock to device tree
      ARM: dts: r8a7790: Add INTC-SYS clock to device tree
      ARM: dts: r8a7791: Add INTC-SYS clock to device tree
      ARM: dts: r8a7792: Add INTC-SYS clock to device tree
      ARM: dts: r8a7794: Add INTC-SYS clock to device tree
      ARM: dts: r8a7793: Add INTC-SYS clock to device tree
      ARM: dts: porter: Always use status "okay" to enable devices
      ARM: dts: bockw: Drop superfluous status update for frequency override
      ARM: dts: marzen: Drop superfluous status update for frequency override
      ARM: dts: lager: Drop superfluous status update for frequency override
      ARM: dts: koelsch: Drop superfluous status updates for frequency overrides
      ARM: dts: porter: Drop superfluous status update for frequency override
      ARM: dts: gose: Drop superfluous status update for frequency override
      ARM: dts: alt: Drop superfluous status update for frequency override
      ARM: dts: silk: Drop superfluous status update for frequency override

Kuninori Morimoto (3):
      ARM: dts: r8a7790: Tidyup Audio-DMAC channel for DVC
      ARM: dts: r8a7791: Tidyup Audio-DMAC channel for DVC
      ARM: dts: r8a7793: Tidyup Audio-DMAC channel for DVC

 arch/arm/boot/dts/Makefile                 | 38 +++++++++++++++---------------
 arch/arm/boot/dts/r7s72100.dtsi            | 24 +++++++++++++++----
 arch/arm/boot/dts/r8a73a4.dtsi             | 19 ++++++++-------
 arch/arm/boot/dts/r8a7743.dtsi             |  5 ++--
 arch/arm/boot/dts/r8a7745.dtsi             |  5 ++--
 arch/arm/boot/dts/r8a7778-bockw.dts        |  1 -
 arch/arm/boot/dts/r8a7779-marzen.dts       |  1 -
 arch/arm/boot/dts/r8a7790-lager.dts        |  1 -
 arch/arm/boot/dts/r8a7790.dtsi             | 19 ++++++++-------
 arch/arm/boot/dts/r8a7791-koelsch.dts      |  2 --
 arch/arm/boot/dts/r8a7791-porter.dts       |  5 ++--
 arch/arm/boot/dts/r8a7791.dtsi             | 16 +++++++------
 arch/arm/boot/dts/r8a7792.dtsi             | 14 +++++++----
 arch/arm/boot/dts/r8a7793-gose.dts         |  1 -
 arch/arm/boot/dts/r8a7793.dtsi             | 18 ++++++++------
 arch/arm/boot/dts/r8a7794-alt.dts          |  1 -
 arch/arm/boot/dts/r8a7794-silk.dts         |  1 -
 arch/arm/boot/dts/r8a7794.dtsi             | 12 ++++++----
 include/dt-bindings/clock/r7s72100-clock.h |  6 +++--
 include/dt-bindings/clock/r8a73a4-clock.h  |  1 +
 include/dt-bindings/clock/r8a7790-clock.h  |  1 +
 include/dt-bindings/clock/r8a7791-clock.h  |  1 +
 include/dt-bindings/clock/r8a7792-clock.h  |  1 +
 include/dt-bindings/clock/r8a7793-clock.h  |  5 ++--
 include/dt-bindings/clock/r8a7794-clock.h  |  1 +
 25 files changed, 113 insertions(+), 86 deletions(-)

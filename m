From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Oct 2017 12:29:04 +0200
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC DT Updates for v4.15
Message-ID: <cover.1508493785.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC DT updates for
v4.15.

This pull request is based on the previous round of
such requests, tagged as renesas-dt-for-v4.15,
which you have already pulled.


The following changes since commit 7031a219f649d12acda8a70a4b6b816ee123c8e2:

  ARM: dts: r8a7743: Add MSIOF[012] support (2017-09-28 08:02:04 +0200)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt2-for-v4.15

for you to fetch changes up to b6d3b649441936621c87b79bff8dd436e2397e3c:

  ARM: dts: r8a7743: Add xhci support to SoC dtsi (2017-10-18 07:21:36 +0200)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC DT Updates for v4.15

* r8a77430 (RZ/G1M) SoC
  - Add XHCI support to SoC DT. Boards may enable this as appropriate

* All Renesas ARM based SoCs
  - Add missing clocks for ARM CPU cores

    Geert Uytterhoeven says "This series improves DT hardware descriptions
    for Renesas arm32 SoCs by adding missing clocks properties to the
    device nodes corresponding to ARM CPU cores."

* R-Car Gen 1 and 2, and RZ/G SoCs
  - Use R-Car Fallback compat strings for GPIO

    Simon Horman says "Use newly added R-Car GPIO Gen 1, 2 and 3 fallback
    compat strings in peace of now deprecated non-generation specific R-Car
    GPIO fallback compat string in the DT of Renesas ARM and arm64 based
    SoCs.

    As noted in the changelogs for the r8a777[89] changes, this introduces
    an incompatibility with pre-v4.14 kernels used with new DTBs. There is
    no run-time effect for other SoCs updated by this changeset."

* r7s72100 (RZ/A1H) GR-Peach board
  - Add pin configuration subnode for ETHER pin group.
    This avoids relying on boot-loader configuration of these pins.

  - Enable ostm0 and ostm1 timers

    Jacopo Mondi says these are "to be used as clock source and clockevent
    source. The timers provides greater accuracy than the already enabled
    mtu2 one."

  - Correct leds node name indent

  - Enable MTU2 timer pulse unit

   Jacopo Mondi says "MTU2 multi-function/multi-channel timer/counter is
   not enabled for GR-Peach board. The timer is used as clock event source
   to schedule wake-ups, and without this enabled all sleeps not performed
   through busy waiting hang the board."

* r8a7743 (RZ/G1M) iW-RainboW-G20M-Qseven SoM
  - Add USB function support

* r8a7745 (RZ/G1E) iW-RainboW-G22D development platform
  - Add USB2.0 Host support

* r8a7743 (RZ/G1M) iW-RainboW-G20D-Qseven development platform
  - Rework DT architecture and add DT for camera DB

    Fabrizio Castro says "Some of the serial interfaces are exposed on the
    camera daughter board.  The camera daughter board can be connected to
    the carrier board by means of expansion connectors 1, 2 and 3. The
    carrier board may host an RZ/G1M or an RZ/G1N based SoM.

    While adding support for the serial interfaces on the camera daughter
    board we faced the dilemma of how to properly describe all of the
    possible HW configurations and how to maximize code reuse.

    The best option would be to use device tree overlays, however there is
    still some work to be done on that front before actually using them,
    therefore for the time being we decided to provide .dtsi files to
    describe the carrier board and the camera daughter board, and provide
    .dts files to describe the HW configurations we need to support."

* r8a779[0-4] R-Car Gen2 SoCs
  - Use generic node name for VSP1 nodes

    Geert Uytterhoeven says "This patch series replaces the specific node
    names used for the VSP1 nodes by the preferred generic node names, cfr.
    commit 0e1bfb72b076b07d ("v4l: vsp1: Use generic node name")."

----------------------------------------------------------------
Biju Das (9):
      ARM: dts: r8a7745: Add internal PCI bridge nodes
      ARM: dts: r8a7745: Add USB PHY DT support
      ARM: dts: r8a7745: Link PCI USB devices to USB PHY
      ARM: dts: iwg22d-sodimm: Enable internal PCI
      ARM: dts: iwg22d-sodimm: Enable USB PHY
      ARM: dts: r8a7743: Add HS-USB device node
      ARM: dts: iwg20d-q7: Enable HS-USB
      ARM: dts: r8a7743: Add USB-DMAC device nodes
      ARM: dts: r8a7743: Enable DMA for HSUSB

Dietmar Eggemann (1):
      ARM: dts: r8a7790: add cpu capacity-dmips-mhz information

Fabrizio Castro (3):
      ARM: dts: iwg20d-q7: Rework DT architecture
      ARM: dts: iwg20d-q7-dbcm-ca: Add device trees for camera DB
      ARM: dts: r8a7743: Add xhci support to SoC dtsi

Geert Uytterhoeven (17):
      ARM: dts: r8a7790: Use generic node name for VSP1 nodes
      ARM: dts: r8a7791: Use generic node name for VSP1 nodes
      ARM: dts: r8a7792: Use generic node name for VSP1 nodes
      ARM: dts: r8a7794: Use generic node name for VSP1 nodes
      ARM: dts: r8a73a4: Add clock for CA15 CPU0 core
      ARM: dts: r8a7743: Add missing clock for secondary CA15 CPU core
      ARM: dts: r8a7778: Add clock for CA9 CPU core
      ARM: dts: r8a7779: Add clocks for CA9 CPU cores
      ARM: dts: r8a7790: Add missing clocks for secondary CA15 CPU cores
      ARM: dts: r8a7790: Add clocks for CA7 CPU cores
      ARM: dts: r8a7791: Add missing clock for secondary CA15 CPU core
      ARM: dts: r8a7792: Add missing clock for secondary CA15 CPU core
      ARM: dts: r8a7793: Add missing clock for secondary CA15 CPU core
      ARM: dts: r8a7794: Add missing clock for secondary CA7 CPU core
      ARM: dts: sh73a0: Add clocks for CA9 CPU cores
      dt-bindings: clk: r7s72100: Add missing I and G clocks
      ARM: dts: r7s72100: Add clock for CA9 CPU core

Jacopo Mondi (4):
      ARM: dts: gr-peach: Fix 'leds' node name indent
      ARM: dts: gr-peach: Enable MTU2 timer pulse unit
      ARM: dts: gr-peach: Add ETHER pin group
      ARM: dts: gr-peach: Enable ostm0 and ostm1 timers

Simon Horman (8):
      ARM: dts: r8a7778: Use R-Car GPIO Gen1 fallback compat string
      ARM: dts: r8a7779: Use R-Car GPIO Gen1 fallback compat string
      ARM: dts: r8a7743: Use R-Car GPIO Gen2 fallback compat string
      ARM: dts: r8a7790: Use R-Car GPIO Gen2 fallback compat string
      ARM: dts: r8a7791: Use R-Car GPIO Gen2 fallback compat string
      ARM: dts: r8a7792: Use R-Car GPIO Gen2 fallback compat string
      ARM: dts: r8a7793: Use R-Car GPIO Gen2 fallback compat string
      ARM: dts: r8a7794: Use R-Car GPIO Gen2 fallback compat string

 arch/arm/boot/dts/Makefile                      |   1 +
 arch/arm/boot/dts/iwg20d-q7-common.dtsi         | 152 ++++++++++++++++++++++++
 arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi        |  43 +++++++
 arch/arm/boot/dts/r7s72100-gr-peach.dts         |  53 ++++++++-
 arch/arm/boot/dts/r7s72100.dtsi                 |   1 +
 arch/arm/boot/dts/r8a73a4.dtsi                  |   1 +
 arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dts |  19 +++
 arch/arm/boot/dts/r8a7743-iwg20d-q7.dts         | 139 +---------------------
 arch/arm/boot/dts/r8a7743.dtsi                  |  82 +++++++++++--
 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts     |  15 +++
 arch/arm/boot/dts/r8a7745.dtsi                  |  92 ++++++++++++++
 arch/arm/boot/dts/r8a7778.dtsi                  |  11 +-
 arch/arm/boot/dts/r8a7779.dtsi                  |  18 +--
 arch/arm/boot/dts/r8a7790.dtsi                  |  35 ++++--
 arch/arm/boot/dts/r8a7791.dtsi                  |  23 ++--
 arch/arm/boot/dts/r8a7792.dtsi                  |  31 ++---
 arch/arm/boot/dts/r8a7793.dtsi                  |  17 +--
 arch/arm/boot/dts/r8a7794.dtsi                  |  19 +--
 arch/arm/boot/dts/sh73a0.dtsi                   |   2 +
 include/dt-bindings/clock/r7s72100-clock.h      |   2 +
 20 files changed, 545 insertions(+), 211 deletions(-)
 create mode 100644 arch/arm/boot/dts/iwg20d-q7-common.dtsi
 create mode 100644 arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi
 create mode 100644 arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dts

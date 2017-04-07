From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  7 Apr 2017 11:58:21 -0400
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC DT Updates for v4.12
Message-ID: <cover.1491580547.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC DT updates for
v4.12.

This pull request is based on the previous round of
such requests, tagged as renesas-dt-for-v4.12,
which you have already pulled.


The following changes since commit d01ff18992218f3a13f45f45a886b3bf8f250f14:

  ARM: dts: silk: Drop superfluous status update for frequency override (2017-03-13 10:19:35 +0100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt2-for-v4.12

for you to fetch changes up to eb77d7260c4c25206e2a455be0dbe6443e0856b5:

  ARM: dts: r8a7791: Drop _clk suffix from external CAN clock node name (2017-04-05 14:16:34 -0400)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC DT Updates for v4.12

Corrections:
* Correct clock frequency of X2 DU clock input for r8a7791/koelsch board
* Correct Z clock for r8a7792 SoC
* Correct parent of SSI[0-9] clocks for r8a779[013] SoCs
* Correct ethernet clock parent on r7s72100 SoC
* Correct DU clock for r8a7794/silk board

Cleanups:
* Drop _clk suffix from external CAN clock node name on r8a779[01] SoCs

Enhancements:
* Enable rtc r7s72100/genmai board
* Add Z2 clock for r8a7794 SoC
* Add DU clock for r8a7794 SoC
* Add power-domains to SDHI for r8a7794 and r7s72100 SoCs
* Add reset control properties for r8a774[35] SoCs

----------------------------------------------------------------
Chris Brandt (7):
      ARM: dts: r7s72100: add power-domains to sdhi
      ARM: dts: r7s72100: fix ethernet clock parent
      ARM: dts: r7s72100: add rtc clock to device tree
      ARM: dts: r7s72100: add RTC_X clock inputs to device tree
      ARM: dts: r7s72100: add rtc to device tree
      ARM: dts: rskrza1: set rtc_x1 clock value
      ARM: dts: rskrza1: add rtc DT support

Geert Uytterhoeven (14):
      ARM: dts: r8a7743: Add reset control properties
      ARM: dts: r8a7745: Add reset control properties
      ARM: dts: r8a7794: Add DU1 clock to device tree
      ARM: dts: r8a7794: Correct clock of DU1
      ARM: dts: alt: Correct clock of DU1
      ARM: dts: silk: Correct clock of DU1
      ARM: dts: r8a7790: Correct parent of SSI[0-9] clocks
      ARM: dts: r8a7791: Correct parent of SSI[0-9] clocks
      ARM: dts: r8a7793: Correct parent of SSI[0-9] clocks
      ARM: dts: r8a7792: Correct Z clock
      ARM: dts: r8a7794: Add Z2 clock
      ARM: dts: koelsch: Correct clock frequency of X2 DU clock input
      ARM: dts: r8a7790: Drop _clk suffix from external CAN clock node name
      ARM: dts: r8a7791: Drop _clk suffix from external CAN clock node name

Jacopo Mondi (1):
      ARM: dts: genmai: Enable rtc and rtc_x1 clock

 arch/arm/boot/dts/r7s72100-genmai.dts      |  8 ++++++
 arch/arm/boot/dts/r7s72100-rskrza1.dts     |  8 ++++++
 arch/arm/boot/dts/r7s72100.dtsi            | 41 +++++++++++++++++++++++++++++-
 arch/arm/boot/dts/r8a7743.dtsi             | 24 +++++++++++++++++
 arch/arm/boot/dts/r8a7745.dtsi             | 24 +++++++++++++++++
 arch/arm/boot/dts/r8a7790.dtsi             |  9 ++++---
 arch/arm/boot/dts/r8a7791-koelsch.dts      |  2 +-
 arch/arm/boot/dts/r8a7791.dtsi             |  9 ++++---
 arch/arm/boot/dts/r8a7792.dtsi             | 11 ++++++--
 arch/arm/boot/dts/r8a7793.dtsi             |  7 +++--
 arch/arm/boot/dts/r8a7794-alt.dts          |  2 +-
 arch/arm/boot/dts/r8a7794-silk.dts         |  2 +-
 arch/arm/boot/dts/r8a7794.dtsi             | 18 ++++++++++---
 include/dt-bindings/clock/r7s72100-clock.h |  3 +++
 include/dt-bindings/clock/r8a7792-clock.h  |  1 -
 include/dt-bindings/clock/r8a7794-clock.h  |  1 +
 16 files changed, 151 insertions(+), 19 deletions(-)

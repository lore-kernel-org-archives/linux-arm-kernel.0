From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  4 Nov 2016 10:44:27 +0100
Subject: [GIT PULL] Renesas ARM Based SoC DT Updates for v4.10
Message-ID: <cover.1478252308.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC DT updates for v4.10.


The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-for-v4.10

for you to fetch changes up to 68cc085a4daaa32f7138de1e918331c05165a484:

  ARM: dts: r8a7794: remove Z clock (2016-11-04 10:36:47 +0100)

----------------------------------------------------------------
Renesas ARM Based SoC DT Updates for v4.10

Clean-Ups and Corrections:
* Removed Z clock from r8a7794 SoC; it is not present in hardware
* Use generic pinctrl properties in SDHI nodes in gose board
* Correct W=1 dtc warnings on r8a7794 SoC
* Correct DU reg property on r8a7779 SoC
* Correct SCIFB reg properties to cover all registers

Enhancements:
* Configure pinmuxing for the DU0 input clock on the Marzen board
* Enable VIN 0 - 2 on r8a7793 SoC
* Enable HDMI input on Koelsch and Lager boards
* Enable SDHI1 on rskrza1 board
* Add MMCIF nodes to r7s72100 SoC
* Add MSIOF clocks to r8a7792 SoC
* Enable UHS for SDHI 0 & 1 on koelsch and alt boards

----------------------------------------------------------------
Chris Brandt (5):
      ARM: dts: r7s72100: add mmcif clock to device tree
      ARM: dts: r7s72100: add mmcif to device tree
      ARM: dts: r7s72100: add sdhi clock to device tree
      ARM: dts: r7s72100: add sdhi to device tree
      ARM: dts: rskrza1: add sdhi1 DT support

Geert Uytterhoeven (10):
      ARM: dts: r8a7790: Correct SCIFB reg properties to cover all registers
      ARM: dts: r8a7791: Correct SCIFB reg properties to cover all registers
      ARM: dts: r8a7793: Correct SCIFB reg properties to cover all registers
      ARM: dts: r8a7794: Correct SCIFB reg properties to cover all registers
      ARM: dts: r8a7794: Fix W=1 dtc warnings
      ARM: dts: emev2: Remove skeleton.dtsi inclusion
      ARM: dts: r8a7778: Remove skeleton.dtsi inclusion
      ARM: dts: r8a7779: Remove skeleton.dtsi inclusion
      ARM: dts: r8a7740: Remove skeleton.dtsi inclusion
      ARM: dts: sh73a0: Remove skeleton.dtsi inclusion

Hans Verkuil (1):
      ARM: dts: koelsch: add HDMI input

Laurent Pinchart (2):
      ARM: dts: r8a7779: Fix DU reg property
      ARM: dts: r8a7779: marzen: Configure pinmuxing for the DU0 input clock

Sergei Shtylyov (4):
      ARM: dts: wheat: add DU support
      ARM: dts: r8a7792: add MSIOF clocks
      ARM: dts: r8a7792: add MSIOF support
      ARM: dts: r8a7794: remove Z clock

Simon Horman (5):
      ARM: dts: r8a7791: set maximum frequency for SDHI clocks
      ARM: dts: koelsch: enable UHS for SDHI 0, 1 & 3
      ARM: dts: r8a7794: set maximum frequency for SDHI clocks
      ARM: dts: alt: enable UHS for SDHI 0 & 1
      ARM: dts: gose: use generic pinctrl properties in SDHI nodes

Ulrich Hecht (1):
      ARM: dts: r8a7793: Enable VIN0-VIN2

William Towle (1):
      ARM: dts: lager: Add entries for VIN HDMI input support

 arch/arm/boot/dts/emev2.dtsi               |   3 +-
 arch/arm/boot/dts/r7s72100-rskrza1.dts     |   5 ++
 arch/arm/boot/dts/r7s72100.dtsi            |  55 +++++++++++++
 arch/arm/boot/dts/r8a7740.dtsi             |   4 +-
 arch/arm/boot/dts/r8a7778.dtsi             |   4 +-
 arch/arm/boot/dts/r8a7779-marzen.dts       |   2 +-
 arch/arm/boot/dts/r8a7779.dtsi             |   6 +-
 arch/arm/boot/dts/r8a7790-lager.dts        |  66 ++++++++++++++-
 arch/arm/boot/dts/r8a7790.dtsi             |   6 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts      | 101 +++++++++++++++++++++--
 arch/arm/boot/dts/r8a7791.dtsi             |   9 ++-
 arch/arm/boot/dts/r8a7792-wheat.dts        | 126 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7792.dtsi             |  51 +++++++++++-
 arch/arm/boot/dts/r8a7793-gose.dts         |  12 +--
 arch/arm/boot/dts/r8a7793.dtsi             |  33 +++++++-
 arch/arm/boot/dts/r8a7794-alt.dts          |  22 ++++-
 arch/arm/boot/dts/r8a7794.dtsi             |  70 ++++++++--------
 arch/arm/boot/dts/sh73a0.dtsi              |   4 +-
 include/dt-bindings/clock/r7s72100-clock.h |   7 ++
 include/dt-bindings/clock/r8a7794-clock.h  |   3 +-
 20 files changed, 516 insertions(+), 73 deletions(-)

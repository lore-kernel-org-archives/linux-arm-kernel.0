From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Jun 2016 16:15:06 +0200
Subject: [GIT PULL] Second Round of Renesas ARM64 Based SoC DT Updates for v4.8
Message-ID: <cover.1467291676.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM64 based SoC DT updates
for v4.8.

The support for the new r8a7796 SoC depends on clk definitions which
I have taken the liberty of including in this branch to avoid depending
on another branch. The definitions in question are derived from the
datasheet and in keeping with the approach taken for other Renesas SoCs.

This pull request is based on the previous round of
such requests, tagged as renesas-arm64-dt-for-v4.8,
which you have already pulled.


The following changes since commit 21cc405c8a6332ddad2d2751a9723b2b3e227a05:

  arm64: dts: r8a7795: Drop 0x from unit address of gic (2016-05-30 10:18:01 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt2-for-v4.8

for you to fetch changes up to 2c9616a1fc01c656f04f03feb58fa12d9b30802a:

  arm64: dts: r8a7796/salvator-x: Enable watchdog timer (2016-06-28 07:04:44 +0200)

----------------------------------------------------------------
Second Round of Renesas ARM64 Based SoC DT Updates for v4.8

* Add support for  r8a7796/salvator-x (R-Car Gen 3 M3-W)
* Add CAN support to r8a7795 ((R-Car Gen 3 H3)

----------------------------------------------------------------
Geert Uytterhoeven (6):
      arm64: dts: r8a7795: Add missing blank lines between cpu nodes
      clk: renesas: Add r8a7796 CPG Core Clock Definitions
      arm64: dts: r8a7796: Add SYSC PM Domains
      arm64: dts: r8a7796: Use SYSC "always-on" PM Domain
      arm64: dts: r8a7796: Add RWDT node
      arm64: dts: r8a7796/salvator-x: Enable watchdog timer

Ramesh Shanmugasundaram (1):
      arm64: dts: r8a7795: Add CAN FD support

Simon Horman (1):
      arm64: dts: r8a7796: Add Renesas R8A7796 SoC support

Takeshi Kihara (1):
      arm64: dts: salvator-x: add Salvator-X board on R8A7796 SoC

 Documentation/devicetree/bindings/arm/shmobile.txt |   4 +
 arch/arm64/Kconfig.platforms                       |   6 +
 arch/arm64/boot/dts/renesas/Makefile               |   1 +
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |  26 ++++
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts |  50 ++++++++
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           | 138 +++++++++++++++++++++
 include/dt-bindings/clock/r8a7796-cpg-mssr.h       |  69 +++++++++++
 7 files changed, 294 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7796.dtsi
 create mode 100644 include/dt-bindings/clock/r8a7796-cpg-mssr.h

From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  5 Mar 2015 10:58:14 +0900
Subject: [GIT PULL] Renesas ARM Based SoC r8a7778 CCF and Multiplatform
 Updates for v4.1
Message-ID: <cover.1425518337.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC r8a7778 CCF and multiplatform
updates for v4.1.

This pull request is based on "Renesas ARM Based SoC Simple PM Bus Updates
for v4.1", tagged as renesas-simple-pm-bus-for-v4.1, which you have already
pulled. That pull request provides run-time dependencies for this one.


The following changes since commit 89d463ea106dba530786a2815fd174f9e6eab71f:

  drivers: bus: Add Simple Power-Managed Bus Driver (2015-02-24 06:36:18 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-r8a7778-ccf-and-multiplatform-for-v4.1

for you to fetch changes up to 3915d36fabf143dffdf91c5372d3b0a23722af52:

  ARM: shmobile: r8a7778: enable multiplatform target (2015-03-01 11:04:44 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC r8a7778 CCF and Multiplatform Updates for v4.1

* Add CCF and them multiplatform support to r8a7778 SoC and its
  bockw board.

----------------------------------------------------------------
Ulrich Hecht (16):
      ARM: shmobile: r8a7778: synchronize dts with reference platform
      ARM: shmobile: r8a7778: add CPG register bits header
      ARM: shmobile: r8a7778: Common clock framework DT description
      ARM: shmobile: r8a7778: implement SoC and board CCF support
      ARM: shmobile: r8a7778: add MSTP clock assignments to DT
      ARM: shmobile: r8a7778: add internal ethernet controller to DT
      ARM: shmobile: bockw: add USB, VIN pin descriptions to DT
      ARM: shmobile: r8a7778 dtsi: Add Bus State Controller node
      ARM: shmobile: bockw dts: Move Ethernet node to BSC
      ARM: shmobile: bockw dts: set extal clock frequency
      ARM: shmobile: r8a7778: common clock framework CPG driver
      DT: i2c: add trivial binding for OKI ML86V7667 video decoder
      ARM: shmobile: bockw: add devices hooked up to i2c0 to DT
      ARM: shmobile: r8a7778: add sound to DT
      ARM: shmobile: bockw: add sound to DT
      ARM: shmobile: r8a7778: enable multiplatform target

 .../bindings/clock/renesas,r8a7778-cpg-clocks.txt  |  25 ++
 .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/r8a7778-bockw.dts                | 174 ++++++++++++
 arch/arm/boot/dts/r8a7778.dtsi                     | 293 +++++++++++++++++++++
 arch/arm/mach-shmobile/Kconfig                     |   4 +
 arch/arm/mach-shmobile/board-bockw-reference.c     |   2 +
 arch/arm/mach-shmobile/setup-r8a7778.c             |  19 ++
 drivers/clk/shmobile/Makefile                      |   1 +
 drivers/clk/shmobile/clk-r8a7778.c                 | 143 ++++++++++
 include/dt-bindings/clock/r8a7778-clock.h          |  71 +++++
 include/linux/clk/shmobile.h                       |   1 +
 12 files changed, 735 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,r8a7778-cpg-clocks.txt
 create mode 100644 drivers/clk/shmobile/clk-r8a7778.c
 create mode 100644 include/dt-bindings/clock/r8a7778-clock.h

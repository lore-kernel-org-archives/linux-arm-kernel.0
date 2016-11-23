From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 23 Nov 2016 21:14:33 +0100
Subject: [GIT PULL v2] Second Round of Renesas ARM Based SoC DT Updates for
 v4.10
Message-ID: <cover.1479931686.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC DT updates for
v4.10.


This pull request is based on an octopus merge of:
* "Renesas RZ/G1M and RZ/G1E CPG Core Clock Definitions" sent by
  Geert Uytterhoeven which corresponds to the rzg-clock-defs-tag1
  in his renesas-drivers tree. These are already present in the clock
  tree.
* Commit 538321bd9718 ("ARM: shmobile: r8a7743: add power domain index macros")
  which is the first commit (of two) of "Renesas ARM Based SoC Drivers
  Updates for v4.10", tagged as renesas-drivers-for-v4.10, which you have
  already pulled.
* Commit 97ca8402997c ("ARM: shmobile: r8a7745: add power domain index macros")
  which is the first commit (of two) of "Renesas ARM Based SoC r8a7745 SYSC
  Driver Updates for v4.10", tagged as renesas-r8a7745-sysc-for-v4.10,
  which I have also sent a pull request for.

The reason for each of the above is to provide header files with macros
used in the DT files for the newly added r8a7743 and r8a7745 SoCs.

I understand that it is not usual practice to include merges individual commits
as the basis for a pull-request. In this case it has been done to provide
a minimal set of dependencies. And in particular pull in only header files
and no driver code.

In this scheme the two commits in question will also end up merged into the
next/drivers branch of the arm-soc tree. Each of the two commits in
question is based on v4.9-rc1. It was concluded in discussion with Arnd
on IRC that this is the best (least bad?) option available in this case.


This pull request is targeted at the next/dt branch of the arm-soc tree.

It introduces some minor merge conflicts in:
  Documentation/devicetree/bindings/arm/shmobile.txt
The resolution is to take both sides. A sample merge resolution is
provided in the renesas-next-20161123v2-v4.9-rc1 tag of the renesas tree.


This pull request is an update of a previous pull request containing
the same patches. The motivation for reposting is to provide a pull-request
based on minimal dependencies.


The following changes since commit 028289536c6e46fbaa949124a934e7445ccbcf64:

  Merge tag 'rzg-clock-defs-tag1'; commit '538321bd9718'; commit '97ca8402997c' into dt-for-v4.10 (2016-11-23 20:51:44 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt2-for-v4.10

for you to fetch changes up to 2357adb625f15e7f2b05a1464076c79876563636:

  ARM: dts: r8a7794: Add device node for PRR (2016-11-23 20:52:36 +0100)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC DT Updates for v4.10

Enhancements:
* Add device nodes for PRR
* Add r8a7745 SoC and sk-rzg1e board
* Add r8a7743 SoC and sk-rzg1m board
* Enable SDR-104 and I2C demuxer on alt, koelsch and lager boards

Corrections:
* Use SYSC "always-on" PM Domain for sound on r8a7794 SoC
* Correct hsusb parent clock on r8a7794 SoC
* Correct PFC names for DU on alt board

----------------------------------------------------------------
Geert Uytterhoeven (9):
      ARM: dts: r8a7794: Correct hsusb parent clock
      ARM: dts: r8a7794: Use SYSC "always-on" PM Domain for sound
      ARM: dts: r8a73a4: Add device node for PRR
      ARM: dts: r8a7779: Add device node for PRR
      ARM: dts: r8a7790: Add device node for PRR
      ARM: dts: r8a7791: Add device node for PRR
      ARM: dts: r8a7792: Add device node for PRR
      ARM: dts: r8a7793: Add device node for PRR
      ARM: dts: r8a7794: Add device node for PRR

Jacopo Mondi (1):
      ARM: dts: alt: Fix PFC names for DU

Sergei Shtylyov (14):
      ARM: dts: r8a7743: initial SoC device tree
      ARM: dts: r8a7743: add SYS-DMAC support
      ARM: dts: r8a7743: add [H]SCIF{A|B} support
      ARM: dts: r8a7743: add Ether support
      ARM: dts: r8a7743: add IRQC support
      ARM: dts: sk-rzg1m: initial device tree
      ARM: dts: sk-rzg1m: add Ether support
      ARM: dts: r8a7745: initial SoC device tree
      ARM: dts: r8a7745: add SYS-DMAC support
      ARM: dts: r8a7745: add [H]SCIF{|A|B} support
      ARM: dts: r8a7745: add Ether support
      ARM: dts: r8a7745: add IRQC support
      ARM: dts: sk-rzg1e: initial device tree
      ARM: dts: sk-rzg1e: add Ether support

Simon Horman (7):
      ARM: dts: lager: rename and reindex i2cexio
      ARM: dts: lager: use demuxer for IIC1/I2C1
      ARM: dts: koelsch: use demuxer for I2C1
      ARM: dts: alt: use demuxer for I2C4
      ARM: dts: lager: Enable UHS-I SDR-104
      ARM: dts: koelsch: Enable UHS-I SDR-104
      ARM: dts: alt: Enable UHS-I SDR-104

 arch/arm/boot/dts/Makefile             |   2 +
 arch/arm/boot/dts/r8a73a4.dtsi         |   5 +
 arch/arm/boot/dts/r8a7743-sk-rzg1m.dts |  57 ++++
 arch/arm/boot/dts/r8a7743.dtsi         | 476 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7745-sk-rzg1e.dts |  52 ++++
 arch/arm/boot/dts/r8a7745.dtsi         | 476 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7779.dtsi         |   5 +
 arch/arm/boot/dts/r8a7790-lager.dts    |  52 +++-
 arch/arm/boot/dts/r8a7790.dtsi         |   5 +
 arch/arm/boot/dts/r8a7791-koelsch.dts  |  36 +++
 arch/arm/boot/dts/r8a7791.dtsi         |   5 +
 arch/arm/boot/dts/r8a7792.dtsi         |   5 +
 arch/arm/boot/dts/r8a7793.dtsi         |   5 +
 arch/arm/boot/dts/r8a7794-alt.dts      |  40 ++-
 arch/arm/boot/dts/r8a7794.dtsi         |  11 +-
 15 files changed, 1220 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm/boot/dts/r8a7743-sk-rzg1m.dts
 create mode 100644 arch/arm/boot/dts/r8a7743.dtsi
 create mode 100644 arch/arm/boot/dts/r8a7745-sk-rzg1e.dts
 create mode 100644 arch/arm/boot/dts/r8a7745.dtsi

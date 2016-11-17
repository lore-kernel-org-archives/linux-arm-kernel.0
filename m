From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Nov 2016 15:11:45 +0100
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC DT Updates for v4.10
Message-ID: <cover.1479391750.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC DT updates for v4.10.

This pull request is based on a merge of:

* The previous round of such requests, tagged as renesas-dt-for-v4.10,
  which I have already sent a pull-request for.
* The rzg-clock-defs tag of Geert Uytterhoeven's renesas-driver's tree.
  This is to provide dependencies for adding the r8a7743 and r8a7745 SoCs.
* The "Second Round of Renesas ARM Based SoC Drivers Updates for v4.10",
  tagged as renesas-drivers2-for-v4.10, which I have also sent a pull
  request for. This is included to provide dependencies for adding device
  nodes for PRR, and adding the r8a7743 and r8a7745 SoCs..


The following changes since commit 71eaf88fb7784932956a998968f609c9a89cd739:

  Merge branch 'rzg-clock-defs' of https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into dt-for-v4.10 (2016-11-17 14:58:57 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt2-for-v4.10

for you to fetch changes up to cb74f5808db5105baaf127c51660bbb1a10313c4:

  ARM: dts: r8a7794: Add device node for PRR (2016-11-17 15:07:49 +0100)

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

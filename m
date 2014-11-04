From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  4 Nov 2014 10:51:00 +0900
Subject: [GIT PULL] Renesas ARM Based SoC DT Updates for v3.19
Message-ID: <cover.1415059587.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC DT updates for v3.19.


This pull request is based on a merge of:

* "Renesas ARM Based SoC DT DU Updates for v3.19",
  tagged as renesas-dt-du-for-v3.19.

* "Renesas ARM Based SoC r8a73a4 DT Timers Updates for v3.19",
  tagged as renesas-r8a73a4-dt-timers-for-v3.19.

Both of which I have also sent a pull-request for.


The following changes since commit 4df49d9e1f2592338b5e8d0b5ce9f2485e295cc0:

  Merge tag 'renesas-r8a73a4-dt-timers-for-v3.19' into dt-for-v3.19.base (2014-10-30 09:54:13 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-for-v3.19

for you to fetch changes up to 25af9c83151822eb6d413b4d15d5f89804606ac7:

  ARM: shmobile: r8a7779 dtsi: Add SoC-specific SATA compatible property (2014-10-30 10:01:37 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC DT Updates for v3.19

* Add Add SoC-specific SATA compatible property to r8a7779
* Enable DMA for MMCIF on r8a7791 and r8a7790
* Enable USB-PHY, HS-USB and USB3.0 on r8a7791 and r8a7790
* Enable TMU timer via DT on r8a7778
* Enable CMT timer via DT on r8a73a4
* Add MMP and {SR}GX clocks to  r8a7791 and r8a7790
* Correct scifa2 clock index on r8a7740
* Add missing INTCA for irqpin on r8a7740

----------------------------------------------------------------
Geert Uytterhoeven (7):
      ARM: shmobile: r8a7740 dtsi: Add missing INTCA clock for irqpin module
      ARM: shmobile: r8a7740 dtsi: Fix clock index for scifa2
      ARM: shmobile: r8a7740 dtsi: Add TMU0 and TMU1 device nodes
      ARM: shmobile: armadillo800eva dts: Enable TMU0
      ARM: shmobile: r8a73a4: Add SoC-specific CMT compatible property
      ARM: shmobile: r8a7778: Add SoC-specific TMU compatible property
      ARM: shmobile: r8a7779 dtsi: Add SoC-specific SATA compatible property

Hisashi Nakamura (1):
      ARM: shmobile: r8a7794: Add arch_timer to device tree

Kouei Abe (2):
      ARM: shmobile: r8a7790: Add RGX clock to device tree
      ARM: shmobile: r8a7791: Add SGX clock to device tree

Laurent Pinchart (4):
      ARM: shmobile: r8a7790: Rename mmcif node to mmc
      ARM: shmobile: r8a7791: Add MMCIF0 DT node
      ARM: shmobile: r8a7790: Reference DMA channels in MMCIF DT nodes
      ARM: shmobile: r8a7791: Reference DMA channels in MMCIF DT node

Sergei Shtylyov (7):
      ARM: shmobile: r8a7790: add USB PHY DT support
      ARM: shmobile: lager: enable USB PHY
      ARM: shmobile: r8a7791: add USB PHY DT support
      ARM: shmobile: koelsch: enable USB PHY
      ARM: shmobile: henninger: enable USB PHY
      ARM: shmobile: r8a7790: link PCI USB devices to USB PHY
      ARM: shmobile: r8a7791: link PCI USB devices to USB PHY

Simon Horman (2):
      ARM: shmobile: r8a7778: Add TMU nodes
      ARM: shmobile: bockw-reference: Initialise TMU device using DT

Wolfram Sang (1):
      ARM: shmobile: r8a7790: switch from scif to scifa

Yoshifumi Hosoya (2):
      ARM: shmobile: r8a7790: Add MMP clock to device tree
      ARM: shmobile: r8a7791: Add MMP clock to device tree

Yoshihiro Shimoda (8):
      ARM: shmobile: r8a7790: add USB3.0 device node
      ARM: shmobile: lager: enable USB3.0
      ARM: shmobile: r8a7791: add USB3.0 device node
      ARM: shmobile: r8a7790: add HS-USB device node
      ARM: shmobile: lager: enable HS-USB
      ARM: shmobile: r8a7791: add HS-USB device node
      ARM: shmobile: koelsch: enable HS-USB
      ARM: shmobile: henninger: enable HS-USB

 arch/arm/boot/dts/r8a73a4.dtsi                |   2 +-
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts |   4 +
 arch/arm/boot/dts/r8a7740.dtsi                |  44 +++++++++--
 arch/arm/boot/dts/r8a7778-bockw-reference.dts |   4 +
 arch/arm/boot/dts/r8a7778.dtsi                |  36 +++++++++
 arch/arm/boot/dts/r8a7779.dtsi                |   2 +-
 arch/arm/boot/dts/r8a7790-lager.dts           |  46 +++++++++---
 arch/arm/boot/dts/r8a7790.dtsi                |  97 ++++++++++++++++++++++---
 arch/arm/boot/dts/r8a7791-henninger.dts       |  11 +++
 arch/arm/boot/dts/r8a7791-koelsch.dts         |  11 +++
 arch/arm/boot/dts/r8a7791.dtsi                | 101 ++++++++++++++++++++++++--
 arch/arm/boot/dts/r8a7794.dtsi                |   8 ++
 arch/arm/mach-shmobile/setup-r8a7778.c        |   3 +-
 include/dt-bindings/clock/r8a7740-clock.h     |   1 +
 include/dt-bindings/clock/r8a7790-clock.h     |  12 ++-
 include/dt-bindings/clock/r8a7791-clock.h     |   9 ++-
 16 files changed, 351 insertions(+), 40 deletions(-)

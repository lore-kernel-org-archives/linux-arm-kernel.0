From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 26 Feb 2015 15:21:25 +0900
Subject: [GIT PULL] Renesas ARM Based SoC DT Updates for v4.1
Message-ID: <cover.1424849129.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC DT updates for v4.1.


The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-for-v4.1

for you to fetch changes up to b8e8ea127d00f1b0c18d8c1ae1b8388e190d5052:

  ARM: shmobile: r8a7794: add SDHI DT support (2015-02-24 08:18:47 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC DT Updates for v4.1

* Increase hardware coverage of DT for various SoCs
* Add PFC information for emev2 SoC
* Remap entire APMU region for r8a7791 and r8a7790 SoCs
* Declare the full 512 MiB of RAM for kzm9g board
* Add selectable sources to DIV6 clocks to sh73a0 SoC
* Add missing INTCA0 clock for irqpin module on sh73a0 SoC
* Set control-parent for all irqpin node on sh73a0 SoC

----------------------------------------------------------------
Geert Uytterhoeven (7):
      ARM: shmobile: kzm9g-reference dts: Sort i2c0 children by unit address
      ARM: shmobile: kzm9g-reference dts: Add ak8975 magnetometer node
      ARM: shmobile: kzm9g-reference dts: Add adxl345 accelerometer node
      ARM: shmobile: kzm9g-reference dts: Add r2025sd rtc node
      ARM: shmobile: sh73a0 dtsi: Add missing INTCA0 clock for irqpin module
      ARM: shmobile: kzm9g dts: Declare the full 512 MiB of RAM
      ARM: shmobile: kzm9g-reference dts: Declare the full 512 MiB of RAM

Laurent Pinchart (9):
      ARM: shmobile: sh73a0 dtsi: Set control-parent for all irqpin nodes
      ARM: shmobile: kzm9g-reference dts: Add st1232 touchscreen node
      ARM: shmobile: r8a7794: Add DMAC devices to DT
      ARM: shmobile: r8a7790: Add IPMMU DT nodes
      ARM: shmobile: r8a7791: Add IPMMU DT nodes
      ARM: shmobile: r8a7794: Add IPMMU DT nodes
      ARM: shmobile: r8a7794: Add ethernet controller to device tree
      ARM: shmobile: r8a7794: alt: Enable ethernet controller
      ARM: shmobile: koelsch: Add DU HDMI output support

Niklas S?derlund (2):
      ARM: shmobile: emev2 dtsi: Add PFC information
      ARM: shmobile: emev2-kzm9d dts: Add PFC information for uart1

Sergei Shtylyov (8):
      ARM: shmobile: r8a7790: add CAN clocks
      ARM: shmobile: r8a7790: add CAN DT support
      ARM: shmobile: r8a7791: add CAN clocks
      ARM: shmobile: r8a7791: add CAN DT support
      ARM: shmobile: henninger: add CAN0 DT support
      ARM: shmobile: r8a7791: add ADSP clocks
      ARM: shmobile: r8a7790: add ADSP clocks
      ARM: shmobile: r8a7794: add SDHI DT support

Simon Horman (2):
      ARM: shmobile: r8a7794: Correct SDHI clock base address, labels and output-names
      ARM: shmobile: r8a7791: Correct SDHI clock labels and output-names

Ulrich Hecht (2):
      ARM: shmobile: r8a7740 dtsi: add remaining DIV6 clocks
      ARM: shmobile: sh73a0 dtsi: Add selectable sources to DIV6 clocks

Wolfram Sang (2):
      ARM: shmobile: r8a7790: smp: remap whole apmu region
      ARM: shmobile: r8a7791: smp: remap whole apmu region

 arch/arm/boot/dts/emev2-kzm9d.dts            |  13 +++
 arch/arm/boot/dts/emev2.dtsi                 |  10 ++
 arch/arm/boot/dts/r8a7740.dtsi               |  79 +++++++++++++-
 arch/arm/boot/dts/r8a7790.dtsi               | 102 ++++++++++++++++-
 arch/arm/boot/dts/r8a7791-henninger.dts      |  11 ++
 arch/arm/boot/dts/r8a7791-koelsch.dts        |  50 ++++++++-
 arch/arm/boot/dts/r8a7791.dtsi               | 122 +++++++++++++++++++--
 arch/arm/boot/dts/r8a7794-alt.dts            |  13 +++
 arch/arm/boot/dts/r8a7794.dtsi               | 157 ++++++++++++++++++++++++++-
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |  42 ++++++-
 arch/arm/boot/dts/sh73a0-kzm9g.dts           |   2 +-
 arch/arm/boot/dts/sh73a0.dtsi                |  82 ++++++++++----
 arch/arm/mach-shmobile/smp-r8a7790.c         |   4 +-
 arch/arm/mach-shmobile/smp-r8a7791.c         |   2 +-
 include/dt-bindings/clock/r8a7790-clock.h    |   3 +
 include/dt-bindings/clock/r8a7791-clock.h    |   3 +
 include/dt-bindings/clock/sh73a0-clock.h     |   3 +
 17 files changed, 647 insertions(+), 51 deletions(-)

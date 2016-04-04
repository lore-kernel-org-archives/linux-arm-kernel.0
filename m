From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Apr 2016 10:23:15 +0900
Subject: [GIT PULL] Renesas ARM Based SoC DT Updates for v4.7
Message-ID: <cover.1459732726.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC DT updates for v4.7.


The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-for-v4.7

for you to fetch changes up to 64abfd0a89ae1c7e0edcc6744198842e706c0b52:

  ARM: dts: r8a7791: Use USB3.0 fallback compatibility string (2016-03-28 09:03:37 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC DT Updates for v4.7

* Correct interrupt type for ARM TWD in DT of r8a7779 and sh73a0 SoCs
* Add IIC support to DT of r8a7794 SoC
* Add CAN support to DT of r8a7793 and r8a7794 SoCs
* Add SCIF2 support to r8a7790 device tree
* Reference both DMA controllers in MMCIF, SDHI, QSPI HSCIF, SFIFA, SCIFB
  and IIC nodes of r8a7790, r8a7791 r8a7793 and r8a7794 SoCs.
* Use CAN, JPU and USB3.0 fallback compatibility string
  in DT of r8a7791 and r8a7790 SoCs

----------------------------------------------------------------
Geert Uytterhoeven (4):
      ARM: dts: r8a7790: Add SCIF2 clock
      ARM: dts: r8a7790: Add SCIF2 device node
      ARM: dts: sh73a0: Correct interrupt type for ARM TWD
      ARM: dts: r8a7779: Correct interrupt type for ARM TWD

Niklas S?derlund (31):
      ARM: dts: r8a7790: Reference both DMA controllers in SCIFA nodes
      ARM: dts: r8a7790: Reference both DMA controllers in SCIFB nodes
      ARM: dts: r8a7790: Reference both DMA controllers in HSCIF nodes
      ARM: dts: r8a7790: Reference both DMA controllers in SCIF nodes
      ARM: dts: r8a7790: Reference both DMA controllers in MSIOF nodes
      ARM: dts: r8a7790: Reference both DMA controllers in QSPI node
      ARM: dts: r8a7790: Reference both DMA controllers in IIC nodes
      ARM: dts: r8a7790: Reference both DMA controllers in SDHI nodes
      ARM: dts: r8a7790: Reference both DMA controllers in MMCIF nodes
      ARM: dts: r8a7791: Reference both DMA controllers in SCIFA nodes
      ARM: dts: r8a7791: Reference both DMA controllers in SCIFB nodes
      ARM: dts: r8a7791: Reference both DMA controllers in HSCIF nodes
      ARM: dts: r8a7791: Reference both DMA controllers in SCIF nodes
      ARM: dts: r8a7791: Reference both DMA controllers in MSIOF nodes
      ARM: dts: r8a7791: Reference both DMA controllers in QSPI node
      ARM: dts: r8a7791: Reference both DMA controllers in IIC nodes
      ARM: dts: r8a7791: Reference both DMA controllers in SDHI nodes
      ARM: dts: r8a7791: Reference both DMA controllers in MMCIF node
      ARM: dts: r8a7793: Reference both DMA controllers in SCIFA nodes
      ARM: dts: r8a7793: Reference both DMA controllers in SCIFB nodes
      ARM: dts: r8a7793: Reference both DMA controllers in HSCIF nodes
      ARM: dts: r8a7793: Reference both DMA controllers in SCIF nodes
      ARM: dts: r8a7793: Reference both DMA controllers in QSPI node
      ARM: dts: r8a7793: Reference both DMA controllers in IIC nodes
      ARM: dts: r8a7794: Reference both DMA controllers in SCIFA nodes
      ARM: dts: r8a7794: Reference both DMA controllers in SCIFB nodes
      ARM: dts: r8a7794: Reference both DMA controllers in HSCIF nodes
      ARM: dts: r8a7794: Reference both DMA controllers in SCIF nodes
      ARM: dts: r8a7794: Reference both DMA controllers in QSPI node
      ARM: dts: r8a7794: Reference both DMA controllers in SDHI nodes
      ARM: dts: r8a7794: Reference both DMA controllers in MMCIF node

Simon Horman (12):
      ARM: dts: r8a7790: use fallback jpu compatibility string
      ARM: dts: r8a7791: use fallback jpu compatibility string
      ARM: dts: r8a7791: use fallback can compatibility string
      ARM: dts: r8a7790: use fallback can compatibility string
      ARM: dts: r8a7794: add CAN clocks to device tree
      ARM: dts: r8a7794: add CAN nodes to device tree
      ARM: dts: r8a7793: add CAN clocks to device tree
      ARM: dts: r8a7793: add CAN nodes to device tree
      ARM: dts: r8a7794: add IIC clocks
      ARM: dts: r8a7794: Add IIC nodes
      ARM: dts: r8a7790: Use USB3.0 fallback compatibility string
      ARM: dts: r8a7791: Use USB3.0 fallback compatibility string

 arch/arm/boot/dts/r8a7779.dtsi            |   2 +-
 arch/arm/boot/dts/r8a7790.dtsi            | 154 ++++++++++++++---------
 arch/arm/boot/dts/r8a7791.dtsi            | 153 ++++++++++++++---------
 arch/arm/boot/dts/r8a7793.dtsi            | 159 ++++++++++++++++-------
 arch/arm/boot/dts/r8a7794.dtsi            | 201 ++++++++++++++++++++++--------
 arch/arm/boot/dts/sh73a0.dtsi             |   2 +-
 include/dt-bindings/clock/r8a7790-clock.h |   1 +
 include/dt-bindings/clock/r8a7794-clock.h |   5 +
 8 files changed, 458 insertions(+), 219 deletions(-)

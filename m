From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Apr 2016 14:27:31 +1000
Subject: [GIT PULL v2] Renesas ARM Based SoC DT Updates for v4.7
Message-ID: <cover.1461558315.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC DT updates for v4.7.

This pull request is based on "[GIT PULL] Renesas ARM Based SoC Cleanup for
v4.7", tagged as renesas-cleanup-for-v4.7, which you have previously pulled.
The reason for that base is to avoid conflicts.

The differences between v1 of this pull request are:
* Dropped changes to reference both DMA controllers pending further
  discussion
* Added:
  - Configire NMI key as wakeup source in DT of kzm9g board
  - Add SDHI support to DT of gose board
  - Add support of UHS-I SDR-50 for SDHI to DT of r8a7790 SoC


The following changes since commit 000025cfbb9e8bafd0a1fa84d8d83526d24bde42:

  ARM: dts: sh73a0: Remove unnecessary clock-output-names properties (2016-03-28 08:56:11 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-for-v4.7

for you to fetch changes up to 6f92cb2f454c26d9bdada902e22af4bc361a5202:

  ARM: dts: gose: Enable SDHI controllers (2016-04-25 14:10:11 +1000)

----------------------------------------------------------------
Renesas ARM Based SoC DT Updates for v4.7

* Configure NMI key as wakeup source in DT of kzm9g board
* Add SDHI support to DT of gose board
* Add support of UHS-I SDR-50 for SDHI to DT of r8a7790 SoC
* Correct interrupt type for ARM TWD in DT of r8a7779 and sh73a0 SoCs
* Add IIC support to DT of r8a7794 SoC
* Add CAN support to DT of r8a7793 and r8a7794 SoCs
* Add SCIF2 support to r8a7790 device tree
* Use CAN, JPU and USB3.0 fallback compatibility string
  in DT of r8a7791 and r8a7790 SoCs

----------------------------------------------------------------
Ben Hutchings (1):
      ARM: dts: r8a7790: Set maximum frequencies for SDHI clocks

Geert Uytterhoeven (5):
      ARM: dts: r8a7790: Add SCIF2 clock
      ARM: dts: r8a7790: Add SCIF2 device node
      ARM: dts: sh73a0: Correct interrupt type for ARM TWD
      ARM: dts: r8a7779: Correct interrupt type for ARM TWD
      ARM: dts: kzm9g: Configure NMI key as wake-up source

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

Ulrich Hecht (2):
      ARM: dts: r8a7793: Add SDHI controllers
      ARM: dts: gose: Enable SDHI controllers

Wolfram Sang (2):
      ARM: dts: r8a7790: lager: Enable UHS-I SDR-50
      ARM: dts: r8a7790: fix max-frequency for SDHI

 arch/arm/boot/dts/r8a7779.dtsi            |   2 +-
 arch/arm/boot/dts/r8a7790-lager.dts       |  22 +++++-
 arch/arm/boot/dts/r8a7790.dtsi            |  32 ++++++--
 arch/arm/boot/dts/r8a7791.dtsi            |   8 +-
 arch/arm/boot/dts/r8a7793-gose.dts        | 119 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7793.dtsi            |  82 +++++++++++++++++++-
 arch/arm/boot/dts/r8a7794.dtsi            |  92 ++++++++++++++++++++---
 arch/arm/boot/dts/sh73a0-kzm9g.dts        |   7 ++
 arch/arm/boot/dts/sh73a0.dtsi             |   2 +-
 include/dt-bindings/clock/r8a7790-clock.h |   1 +
 include/dt-bindings/clock/r8a7794-clock.h |   5 ++
 11 files changed, 343 insertions(+), 29 deletions(-)

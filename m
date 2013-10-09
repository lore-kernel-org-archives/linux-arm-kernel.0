From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  9 Oct 2013 15:50:12 +0900
Subject: [GIT PULL] Second Round of Renesas ARM-based SoC DT updates for v3.13
Message-ID: <cover.1381298964.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Kevin and Arnd,

please consider this second round of Renesas ARM-based SoC DT updates for v3.13.

This pull request is based on a merge of renesas-soc-for-v3.13
into renesas-dt-for-v3.13, both of which you have previously pulled.
The reason for the merge is to eliminate conflicts.


The following changes since commit 50128df2c0164a3510da2af9d2dfed2da3987bd3:

  Merge tag 'renesas-soc-for-v3.13' into dt2-base (2013-10-08 09:24:24 +0900)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt2-for-v3.13

for you to fetch changes up to 73c79afa61cdee2553461ee714bb4716372bdd55:

  ARM: shmobile: bockw: fixup ether node naming (2013-10-08 10:37:49 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM-based SoC DT updates for v3.13

* Correct SMSC ethernet IRQ number on marzen board
* Add SMSC ethernet node to bockw board
* Add SDHI, MMCIF and PWM backlight  nodes to armadillo800eva-reference board
* Add irqpin default status to r8a7779 SoC
* Add irqpin node to r8a7778 SoC
* Add SMP, Arch timer and IRQC nodes to r8a7791 SoC
* Add DMAC node to r8a73a4 SoC
* Add I2C nodes to r8a7790 SoC
* Only enable used I2C interfaces in DT on all Renesas boards

----------------------------------------------------------------
Guennadi Liakhovetski (4):
      ARM: shmobile: only enable used I2C interfaces in DT on all Renesas boards
      ARM: shmobile: r8a7790: add I2C DT nodes
      ARM: shmobile: r8a73a4: add a DT node for the DMAC
      ARM: shmobile: armadillo800eva-reference: add SDHI and MMCIF interfaces

Kuninori Morimoto (5):
      ARM: shmobile: r8a7778: add renesas_intc_irqpin support on DTSI
      ARM: shmobile: bockw: add SMSC support on DTS
      ARM: shmobile: marzen: fixup SMSC IRQ number on DTS
      ARM: shmobile: r8a7779: add irqpin default status on DTSI
      ARM: shmobile: bockw: fixup ether node naming

Laurent Pinchart (1):
      ARM: shmobile: armadillo-reference: Add PWM backlight node to DT

Magnus Damm (3):
      ARM: shmobile: r8a7791 IRQC device tree node
      ARM: shmobile: r8a7791 Arch timer device tree node
      ARM: shmobile: r8a7791 SMP device tree node

 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts    |  1 +
 arch/arm/boot/dts/r8a73a4-ape6evm.dts              |  1 +
 arch/arm/boot/dts/r8a73a4.dtsi                     | 52 +++++++++++++++
 .../boot/dts/r8a7740-armadillo800eva-reference.dts | 78 ++++++++++++++++++++++
 arch/arm/boot/dts/r8a7740.dtsi                     | 35 ++++++++++
 arch/arm/boot/dts/r8a7778-bockw-reference.dts      | 27 +++++++-
 arch/arm/boot/dts/r8a7778.dtsi                     | 19 ++++++
 arch/arm/boot/dts/r8a7779-marzen-reference.dts     |  8 ++-
 arch/arm/boot/dts/r8a7779.dtsi                     |  5 ++
 arch/arm/boot/dts/r8a7790.dtsi                     | 40 +++++++++++
 arch/arm/boot/dts/r8a7791.dtsi                     | 33 +++++++++
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts       |  2 +
 arch/arm/boot/dts/sh73a0.dtsi                      |  5 ++
 13 files changed, 303 insertions(+), 3 deletions(-)

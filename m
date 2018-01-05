From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 05 Jan 2018 17:10:52 +0100
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.16 (#2) (version 2)
Message-ID: <87k1ww9tgz.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second pull request for dt64 for mvebu for v4.16 which
replace the previous one.

Indeed I had to push a fix which conflicted with the change done on the
armada-cp110 files. Resolving the conflict was not automatic, so I chose
to merge the mvebu/fixes branch in the mvebu/dt64 branch, as at the end
during the merge window for 4.16 the content of mvebu/fixes would have
been already merged in 4.15.

Gregory

The following changes since commit 4cada03801992d09ccceaf5f462e9dadb75a9613:

  ARM64: dts: marvell: Add thermal support for A7K/A8K (2017-12-18 17:13:17 +0100)

are available in the Git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt64-4.16-2

for you to fetch changes up to 474c5885582c4a79c21bcf01ed98f98c935f1f4a:

  arm64: dts: marvell: add Ethernet aliases (2018-01-05 17:02:45 +0100)

----------------------------------------------------------------
mvebu dt64 for 4.16 (part 2)

The main change here are the series of commits doing the Armada 7K/8K
CP110 DT de-duplication, they include the de-duplication itself and
small fixes in the device tree files.

Besides them there are 2 other patches:
 - One adding the crypto support for Armada 37xx SoCs
 - An other adding Ethernet aliases on A7K/A8K base boards

----------------------------------------------------------------
Antoine Tenart (1):
      arm64: dts: marvell: armada-37xx: add a crypto node

Gregory CLEMENT (2):
      ARM64: dts: marvell: armada-cp110: Fix clock resources for various node
      Merge branch 'mvebu/fixes' into HEAD

Thomas Petazzoni (9):
      ARM: dts: kirkwood: fix pin-muxing of MPP7 on OpenBlocks A7
      arm64: dts: marvell: fix watchdog unit address in Armada AP806
      arm64: dts: marvell: use lower case for unit address and reg property
      arm64: dts: marvell: fix typos in comment describing the NAND controller
      arm64: dts: marvell: fix compatible string list for Armada CP110 slave NAND
      arm64: dts: marvell: use mvebu-icu.h where possible
      arm64: dts: marvell: use aliases for SPI busses on Armada 7K/8K
      arm64: dts: marvell: de-duplicate CP110 description
      arm64: dts: marvell: replace cpm by cp0, cps by cp1

Yan Markman (1):
      arm64: dts: marvell: add Ethernet aliases

 arch/arm/boot/dts/kirkwood-openblocks_a7.dts       |  10 +-
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |  14 +
 arch/arm64/boot/dts/marvell/armada-7040-db.dts     |  52 +--
 arch/arm64/boot/dts/marvell/armada-70x0.dtsi       |  37 +-
 arch/arm64/boot/dts/marvell/armada-8020.dtsi       |   2 +-
 arch/arm64/boot/dts/marvell/armada-8040-db.dts     |  87 ++--
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts  |  82 ++--
 arch/arm64/boot/dts/marvell/armada-8040.dtsi       |   2 +-
 arch/arm64/boot/dts/marvell/armada-80x0.dtsi       |  80 +++-
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |   8 +-
 arch/arm64/boot/dts/marvell/armada-common.dtsi     |  10 +
 .../boot/dts/marvell/armada-cp110-master.dtsi      | 449 ---------------------
 .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi | 448 --------------------
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi      | 424 +++++++++++++++++++
 14 files changed, 678 insertions(+), 1027 deletions(-)
 create mode 100644 arch/arm64/boot/dts/marvell/armada-common.dtsi
 delete mode 100644 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
 delete mode 100644 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-cp110.dtsi

From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 13 Oct 2017 17:30:23 +0200
Subject: [GIT PULL] ARM: mvebu: fixes for v4.14 (#2)
Message-ID: <87r2u783qo.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second pull request for fixes for mvebu for v4.14.

Gregory

The following changes since commit 9e7460fc325dad06d2066abdbc1f4dd49456f9a4:

  arm64: dt marvell: Fix AP806 system controller size (2017-09-19 16:40:07 +0200)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-4.14-2

for you to fetch changes up to 2bbbd96357ce76cc45ec722c00f654aa7b189112:

  bus: mbus: fix window size calculation for 4GB windows (2017-10-12 15:01:30 +0200)

----------------------------------------------------------------
mvebu fixes for 4.14 (part 2)

Two device tree related fixes:

- One on Armada 38x using a other compatible string for I2C in order
  to cover an errata.

- One for Armada 7K/8K fixing a typo on interrupt-map property for
  PCIe leading to fail PME and AER root port service initialization

And the last one for the mbus fixing the window size calculation when
it exceed 32bits

----------------------------------------------------------------
Jan Luebbe (1):
      bus: mbus: fix window size calculation for 4GB windows

Kalyan Kinthada (1):
      ARM: dts: Fix I2C repeated start issue on Armada-38x

Thomas Petazzoni (1):
      arm64: dts: marvell: fix interrupt-map property for Armada CP110 PCIe controller

 arch/arm/boot/dts/armada-38x.dtsi                    | 4 ++--
 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 6 +++---
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  | 6 +++---
 drivers/bus/mvebu-mbus.c                             | 2 +-
 include/linux/mbus.h                                 | 4 ++--
 5 files changed, 11 insertions(+), 11 deletions(-)

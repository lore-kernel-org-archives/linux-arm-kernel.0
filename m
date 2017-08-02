From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 02 Aug 2017 16:03:57 +0200
Subject: [GIT PULL] ARM: mvebu: fixes for v4.13 (#2)
Message-ID: <87fuda9icy.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second pull request for fixes for mvebu for v4.13.

Gregory

The following changes since commit 8d4514173211586c6238629b1ef1e071927735f5:

  ARM: dts: armada-38x: Fix irq type for pca955 (2017-07-18 11:26:30 +0200)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-4.13-2

for you to fetch changes up to d7a65c4905bc9c304ecf3d8aa566802f6119480f:

  ARM64: dts: marvell: armada-37xx: Fix the number of GPIO on south bridge (2017-08-02 16:00:00 +0200)

----------------------------------------------------------------
mvebu fixes for 4.13 (part 2)

All the fixes are for ARM64 mvebu:

 - Fix the RTC interrupt on A7K/A8K which was missed when switching
   from GIC to ICU
 - Mark the A7K/A8K crypto engine as dma coherent
 - Fix the number of GPIO on south bridge on Armada 3700

----------------------------------------------------------------
Antoine Tenart (1):
      arm64: dts: marvell: mark the cp110 crypto engine as dma coherent

Gregory CLEMENT (1):
      ARM64: dts: marvell: armada-37xx: Fix the number of GPIO on south bridge

Thomas Petazzoni (1):
      arm64: dts: marvell: use ICU for the CP110 slave RTC

 arch/arm64/boot/dts/marvell/armada-37xx.dtsi         | 2 +-
 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 1 +
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  | 3 ++-
 3 files changed, 4 insertions(+), 2 deletions(-)

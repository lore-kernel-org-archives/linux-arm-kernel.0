From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 05 Jan 2018 16:42:47 +0100
Subject: [GIT PULL] ARM: mvebu: fixes for v4.15 (#1)
Message-ID: <87lghc9urs.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for fixes for mvebu for v4.15.

Gregory

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the Git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-4.15-1

for you to fetch changes up to fefb476bc7fdda4cb1e768493128c15a896f2c4e:

  ARM64: dts: marvell: armada-cp110: Fix clock resources for various node (2018-01-05 16:04:53 +0100)

----------------------------------------------------------------
mvebu fixess for 4.15 (part 1)

2 device tree related fixes fixing 2 issues:
 - broken pinctrl support since 4.11 on OpenBlocks A7
 - implicit clock dependency making the kernel hang if the Xenon sdhci
   module was loaded before the mvpp2 Ethernet support (for this one
   the driver had to be fixed which was done in v4.14)

----------------------------------------------------------------
Gregory CLEMENT (1):
      ARM64: dts: marvell: armada-cp110: Fix clock resources for various node

Thomas Petazzoni (1):
      ARM: dts: kirkwood: fix pin-muxing of MPP7 on OpenBlocks A7

 arch/arm/boot/dts/kirkwood-openblocks_a7.dts         | 10 ++++++++--
 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 13 ++++++++-----
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  |  9 ++++++---
 3 files changed, 22 insertions(+), 10 deletions(-)

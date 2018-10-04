From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 04 Oct 2018 18:02:07 +0200
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.20 (#2)
Message-ID: <87woqxlmyo.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second pull request for dt64 for mvebu for v4.20. It comes
later that usual but the driver part of the System Error Interrupt
support was accepted only on the beginning of the week. And while I
was on adding more dts patch, I also add the CPU idle patches that
were pending since a few weeks.

Gregory

The following changes since commit 620cfb31bad4c5be7d9250f1e47a592750fc364b:

  arm64: dts: marvell: armada-37xx: add nodes to support watchdog (2018-09-28 10:00:17 +0200)

are available in the Git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt64-4.20-2

for you to fetch changes up to 91f84690b502075550ca01d853d5c49b319921eb:

  arm64: dts: clearfog-gt-8k: add PCIe slot description (2018-10-03 17:22:34 +0200)

----------------------------------------------------------------
mvebu dt64 for 4.20 (part 2)

 - Add System Error Interrupt support to Armada SoCs (7K/8K)
 - Add CPU idle support on Armada 8K

----------------------------------------------------------------
Baruch Siach (1):
      arm64: dts: clearfog-gt-8k: add PCIe slot description

Gregory CLEMENT (1):
      arm64: dts: marvell: Add node labels for the cpus

Miquel Raynal (3):
      arm64: dts: marvell: add AP806 SEI subnode
      arm64: dts: marvell: use new bindings for CP110 interrupts
      arm64: dts: marvell: add CP110 ICU SEI subnode

orenbh (1):
      arm64: dts: marvell: add CPU Idle power state support on Armada 7K/8K

 arch/arm64/boot/dts/marvell/armada-372x.dtsi       |   2 +-
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |   2 +-
 .../dts/marvell/armada-8040-clearfog-gt-8k.dts     |   7 +
 arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi |   4 +-
 arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi |  12 +-
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |  36 +++++
 .../dts/marvell/armada-ap810-ap0-octa-core.dtsi    |  16 +--
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi      | 149 ++++++++++++---------
 8 files changed, 145 insertions(+), 83 deletions(-)

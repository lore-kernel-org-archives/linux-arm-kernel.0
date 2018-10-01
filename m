From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 01 Oct 2018 11:50:27 +0200
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.20 (#1)
Message-ID: <87o9cenggs.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for dt64 for mvebu for v4.20.

Gregory

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt64-4.20-1

for you to fetch changes up to 620cfb31bad4c5be7d9250f1e47a592750fc364b:

  arm64: dts: marvell: armada-37xx: add nodes to support watchdog (2018-09-28 10:00:17 +0200)

----------------------------------------------------------------
mvebu dt64 for 4.20 (part 1)

 - Add watchdog node on Armada 37xx
 - Update PPv2 interrupts name
 - Add support for the SolidRun Clearfog GT 8K (Armada 8040 based)
 - Add thermal-zone nodes for Armada 7K/8K

----------------------------------------------------------------
Antoine Tenart (2):
      arm64: dts: marvell: armada-cp110: change the PPv2 IRQ names
      arm64: dts: marvell: armada-cp110: describe more PPv2 interrupts

Baruch Siach (1):
      arm64: dts: add support for SolidRun Clearfog GT 8K

Marek Beh?n (1):
      arm64: dts: marvell: armada-37xx: add nodes to support watchdog

Miquel Raynal (4):
      arm64: dts: marvell: move AP806/CP110 thermal nodes into a new syscon
      arm64: dts: marvell: add thermal-zone node in ap806 DTSI file
      arm64: dts: marvell: add macro to make distinction between node names
      arm64: dts: marvell: add thermal-zone node in cp110 DTSI file

 arch/arm64/boot/dts/marvell/Makefile               |   1 +
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |  13 +
 .../dts/marvell/armada-8040-clearfog-gt-8k.dts     | 434 +++++++++++++++++++++
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |  74 +++-
 arch/arm64/boot/dts/marvell/armada-common.dtsi     |   1 +
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi      |  64 ++-
 6 files changed, 571 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts

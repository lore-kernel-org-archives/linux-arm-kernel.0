From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sat, 19 Nov 2016 09:33:04 +0100
Subject: [GIT PULL] ARM: mvebu: dt for v4.10 (#1)
Message-ID: <8760njamyn.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for dt for mvebu for v4.10. It repalces
the previous one sent 2 days ago as requested by Olof.

I take the opportunity to add new commits:
"ARM: dts: kirkwood: fix spelling mistake" which as applied recently but
which is harmless and trivial.

I also add all the non controversial patches removing the DTC
warning. They wre posted two weeks ago and was in linux-next since this
day. As there is still some discussions about MBUS_ID and ranges, I will
prepare a new series for them which I still hope mnage to be part of
4.10.

Gregory

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.10-1

for you to fetch changes up to 2f7132852038deb8e364bee155f51cb477c8d2f4:

  ARM: dts: armada-375: Fixup ethernet child DT warning (2016-11-19 09:16:52 +0100)

----------------------------------------------------------------
mvebu dt for 4.10 (part 1)

Add missing pinmux declaration for netgear NASes
Fix i2c compatible string for netgear NASes
Fix on a wrong comment about PLL frequency
Fix spelling mistake of the manufacturer's name of the Topkick
Add dt support for the orion5x ls-chl Linkstation device
First step of fixing DTC warning for Armada 370, 375 and XP

----------------------------------------------------------------
Ashley Hughes (1):
      ARM: dts: orion5x: convert ls-chl to FDT

Chris Packham (1):
      ARM: dts: mvebu: Update comment for main PLL frequency

Gregory CLEMENT (21):
      ARM: dts: armada-xp-matrix: Fix the location of the pcie-controller node
      ARM: dts: armada-370-xp: move the cpurst node in the common file
      ARM: dts: armada-370-xp: add node labels
      ARM: dts: armada-370-xp: Use the node labels
      ARM: dts: armada-370-xp: Fixup mdio DT warning
      ARM: dts: armada-xp: Fixup pcie DT warnings
      ARM: dts: armada-370: Fixup pcie DT warnings
      ARM: dts: armada-370-xp: Remove skeleton.dtsi
      ARM: dts: armada-370-xp: Fixup l2-cache DT warning
      ARM: dts: armada-370-xp: Fixup memory DT warning
      ARM: dts: armada-370-xp: Remove address from dsa unit name
      ARM: dts: armada-370-xp: Remove button address and fixup names
      ARM: dts: armada-370-xp: Fixup regulator DT warning
      ARM: dts: armada-375: Add node labels
      ARM: dts: armada-375: Use the node labels
      ARM: dts: armada-375: Fixup mdio DT warning
      ARM: dts: armada-375: Fixup pcie DT warnings
      ARM: dts: armada-375: Fixup pinctrl DT warnings
      ARM: dts: armada-375: Remove skeleton.dtsi
      ARM: dts: armada-375: Fixup memory DT warning
      ARM: dts: armada-375: Fixup ethernet child DT warning

Paul Wassi (1):
      ARM: dts: kirkwood: fix spelling mistake

Uwe Kleine-K?nig (6):
      ARM: dts: armada-370-rn104: add pinmuxing for i2c0
      ARM: dts: armada-370-rn104: drop specification of compatible for i2c0
      ARM: dts: armada-xp-rn2120: drop wrong compatible for i2c0
      ARM: dts: armada-xp-rn2120: add pinmuxing for ethernet
      ARM: dts: armada-370-rn102: drop specification of compatible for i2c0
      ARM: dts: armada-370-rn102: add pinmuxing for i2c0

 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/armada-370-db.dts                |  63 ++---
 arch/arm/boot/dts/armada-370-dlink-dns327l.dts     |  30 +--
 arch/arm/boot/dts/armada-370-mirabox.dts           |  57 ++---
 arch/arm/boot/dts/armada-370-netgear-rn102.dts     |  55 +++--
 arch/arm/boot/dts/armada-370-netgear-rn104.dts     |  63 ++---
 arch/arm/boot/dts/armada-370-rd.dts                |  57 ++---
 arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts  |  27 +-
 arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi |  45 ++--
 .../dts/armada-370-seagate-personal-cloud.dtsi     |  44 ++--
 arch/arm/boot/dts/armada-370-synology-ds213j.dts   |  18 +-
 arch/arm/boot/dts/armada-370-xp.dtsi               |  39 +--
 arch/arm/boot/dts/armada-370.dtsi                  | 136 +++++------
 arch/arm/boot/dts/armada-375-db.dts                | 271 +++++++++++----------
 arch/arm/boot/dts/armada-375.dtsi                  |  72 +++---
 arch/arm/boot/dts/armada-38x.dtsi                  |   2 +-
 arch/arm/boot/dts/armada-39x.dtsi                  |   2 +-
 arch/arm/boot/dts/armada-xp-axpwifiap.dts          |  68 +++---
 arch/arm/boot/dts/armada-xp-db.dts                 | 104 ++++----
 arch/arm/boot/dts/armada-xp-gp.dts                 |  80 +++---
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts    |  53 ++--
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts      |  52 ++--
 arch/arm/boot/dts/armada-xp-matrix.dts             |  20 +-
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           |  12 +-
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           |  20 +-
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           |  22 +-
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts     |  74 +++---
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts   |  58 ++---
 arch/arm/boot/dts/armada-xp-synology-ds414.dts     |  75 +++---
 arch/arm/boot/dts/armada-xp.dtsi                   |  94 +++----
 arch/arm/boot/dts/kirkwood-topkick.dts             |   2 +-
 arch/arm/boot/dts/orion5x-lschl.dts                | 171 +++++++++++++
 32 files changed, 1042 insertions(+), 845 deletions(-)
 create mode 100644 arch/arm/boot/dts/orion5x-lschl.dts

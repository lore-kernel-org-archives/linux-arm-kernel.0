From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 27 Dec 2013 14:26:11 -0500
Subject: [GIT PULL] ARM: mvebu: DT changes for v3.14 (incr. #5)
Message-ID: <20131227192611.GD19878@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

Another week, another round of changes.  All have been in -next for a
while, and as with previous requests, this is an incremental pull from
tags/mvebu-dt-3.14-4 to tags/mvebu-dt-3.14-5 on the mvebu/dt branch.

Thanks and Merry Christmas!

Jason.


The following changes since commit a095b1c78a35f05755ca2f0e106d84792974aef5:

  ARM: mvebu: sort DT nodes by address (2013-12-12 15:00:44 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-3.14-5

for you to fetch changes up to 2cc64b5655da65bbb6a760a722b5ab1f53f92cf7:

  ARM: Kirkwood: DT board setup for LaPlug (2013-12-25 02:03:52 +0000)

----------------------------------------------------------------
mvebu DT changes for v3.14 (incremental #5)

 - mvebu
    - add rtc chip isl12057 node to ReadyNAS boards
    - fix register length in Armada XP pmsu

 - kirkwood
    - sort ocp nodes by address in 6282 dtsi file
    - add 6192 dtsi file
    - add LaPlug board
    - add sata phy node

 - dove
    - add sata phy node

----------------------------------------------------------------
Andrew Lunn (1):
      Phy: Add DT nodes on kirkwood and Dove for the SATA PHY

Arnaud Ebalard (3):
      ARM: mvebu: Enable ISL12057 RTC chip in ReadyNAS 102 .dts file
      ARM: mvebu: Enable ISL12057 RTC chip in ReadyNAS 104 .dts file
      ARM: mvebu: Enable ISL12057 RTC chip in ReadyNAS 2120 .dts file

Jason Cooper (1):
      ARM: kirkwood: 6282: sort DT nodes by address

Maxime Hadjinlian (2):
      ARM: Kirkwood: Add 6192 DTSI file
      ARM: Kirkwood: DT board setup for LaPlug

Thomas Petazzoni (1):
      ARM: mvebu: fix register length for Armada XP PMSU

 arch/arm/boot/dts/Makefile                     |   1 +
 arch/arm/boot/dts/armada-370-netgear-rn102.dts |   5 +
 arch/arm/boot/dts/armada-370-netgear-rn104.dts |   5 +
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts |   5 +
 arch/arm/boot/dts/armada-xp.dtsi               |   2 +-
 arch/arm/boot/dts/dove.dtsi                    |  11 ++
 arch/arm/boot/dts/kirkwood-6192.dtsi           | 107 +++++++++++++++
 arch/arm/boot/dts/kirkwood-6281.dtsi           |   2 +
 arch/arm/boot/dts/kirkwood-6282.dtsi           |  37 +++---
 arch/arm/boot/dts/kirkwood-laplug.dts          | 175 +++++++++++++++++++++++++
 arch/arm/boot/dts/kirkwood.dtsi                |  18 +++
 11 files changed, 349 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-6192.dtsi
 create mode 100644 arch/arm/boot/dts/kirkwood-laplug.dts

From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 7 Mar 2014 12:56:16 -0500
Subject: [GIT PULL] ARM: mvebu: dt changes for v3.15 (incr. #4)
Message-ID: <20140307175616.GH18707@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

Here's the last pull request for mvebu/dt for v3.15.  This is an
incremental pull request from tags/mvebu-dt-3.15-3 in the mvebu/dt
branch up to tags/mvebu-dt-3.15-4.

Please pull.

thx,

Jason.

The following changes since commit e2b15689dcb052b8c4c6580c79aef50052c55581:

  ARM: kirkwood: Add dts file describing HP T5325 thin client (2014-03-04 02:18:08 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-3.15-4

for you to fetch changes up to df76299fecb3d921e4762ae540e33d8b9b1c3c1e:

  ARM: dove: drop pinctrl PMU reg property (2014-03-06 20:20:33 +0000)

----------------------------------------------------------------
mvebu dt changes for v3.15 (incremental #4)

 - dove
    - add system controller node
    - drop pinctrl PMU reg property _before_ it hits mainline and becomes ABI

 - mvebu
    - XP/370
       - change default PCIe apertures
       - switch GP and DB boards internal registers to 0xf1000000
       - correct RAM size on Matrix board
    - 385
       - correct phy connection type for DB board
       - add RD board

----------------------------------------------------------------
Gregory CLEMENT (1):
      ARM: mvebu: add Device Tree for the Armada 385 RD board

Sebastian Hesselbarth (2):
      ARM: dove: add system controller node
      ARM: dove: drop pinctrl PMU reg property

Thomas Petazzoni (5):
      ARM: mvebu: change the default PCIe apertures for Armada 370/XP
      ARM: mvebu: switch the Armada XP DB to use internal registers at 0xf1000000
      ARM: mvebu: switch the Armada XP GP to use internal registers at 0xf1000000
      ARM: mvebu: the Armada XP Matrix board has 4 GB
      ARM: mvebu: use the correct phy connection mode on Armada 385 DB

 arch/arm/boot/dts/Makefile             |  3 +-
 arch/arm/boot/dts/armada-370-xp.dtsi   |  4 +-
 arch/arm/boot/dts/armada-385-db.dts    |  4 +-
 arch/arm/boot/dts/armada-385-rd.dts    | 94 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/armada-xp-db.dts     | 13 ++++-
 arch/arm/boot/dts/armada-xp-gp.dts     | 22 +++++---
 arch/arm/boot/dts/armada-xp-matrix.dts |  7 ++-
 arch/arm/boot/dts/dove.dtsi            |  8 ++-
 8 files changed, 139 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm/boot/dts/armada-385-rd.dts

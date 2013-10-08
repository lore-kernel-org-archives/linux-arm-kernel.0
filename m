From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 8 Oct 2013 13:40:31 -0400
Subject: [GIT PULL] ARM: mvebu: dt changes for v3.13 (round 2)
Message-ID: <20131008174031.GS5402@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

Latest round of DT changes for mvebu.  Nothing really of note here.
More dt, less code :)

thx,

Jason.


The following changes since commit 37078732998e51c2645db99e7434ccc6774dafed:

  ARM: dove: add initial DT file for Globalscale D3Plug (2013-09-30 15:00:54 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/dt-3.13-2

for you to fetch changes up to 7837feff0d881835309fced7a7c4b5f32866d632:

  arm: mvebu: add support for the Armada XP Matrix board (2013-10-03 15:13:01 +0000)

----------------------------------------------------------------
mvebu dt changes for v3.13 (round 2)

 - kirkwood
    - use MBus DT binding for setting up the windows
    - move crypto and nand underneath the mbus node
    - ib62x0 has a u-boot env partition

 - mvebu
    - add the Armada XP matrix board

----------------------------------------------------------------
Jason Gunthorpe (3):
      ARM: kirkwood: Remove kirkwood_setup_wins and rely on the DT binding
      ARM: kirkwood: Move the crypto node under the mbus node
      ARM: kirkwood: Move the nand node under the mbus node

Luka Perkov (1):
      ARM: kirkwood: ib62x0: add u-boot environment partition

Thomas Petazzoni (1):
      arm: mvebu: add support for the Armada XP Matrix board

 arch/arm/boot/dts/Makefile                         |  1 +
 arch/arm/boot/dts/armada-xp-matrix.dts             | 75 +++++++++++++++++++
 arch/arm/boot/dts/kirkwood-db-88f6281.dts          |  1 -
 arch/arm/boot/dts/kirkwood-db-88f6282.dts          |  1 -
 arch/arm/boot/dts/kirkwood-db.dtsi                 | 44 +++++------
 arch/arm/boot/dts/kirkwood-dnskw.dtsi              | 76 +++++++++----------
 arch/arm/boot/dts/kirkwood-dockstar.dts            | 40 +++++-----
 arch/arm/boot/dts/kirkwood-goflexnet.dts           | 51 ++++++-------
 .../arm/boot/dts/kirkwood-guruplug-server-plus.dts | 40 +++++-----
 arch/arm/boot/dts/kirkwood-ib62x0.dts              | 53 +++++++------
 arch/arm/boot/dts/kirkwood-iconnect.dts            | 59 ++++++++-------
 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts      | 51 ++++++-------
 arch/arm/boot/dts/kirkwood-km_kirkwood.dts         | 14 ++--
 arch/arm/boot/dts/kirkwood-mplcec4.dts             | 63 ++++++++--------
 .../boot/dts/kirkwood-netgear_readynas_duo_v2.dts  | 61 ++++++++-------
 arch/arm/boot/dts/kirkwood-nsa310-common.dtsi      | 86 +++++++++++-----------
 arch/arm/boot/dts/kirkwood-nsa310.dts              |  1 -
 arch/arm/boot/dts/kirkwood-openblocks_a6.dts       | 74 +++++++++----------
 arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi  | 42 +++++------
 arch/arm/boot/dts/kirkwood-topkick.dts             | 62 ++++++++--------
 arch/arm/boot/dts/kirkwood-ts219-6282.dts          |  1 -
 arch/arm/boot/dts/kirkwood.dtsi                    | 57 +++++++-------
 arch/arm/mach-kirkwood/board-dt.c                  |  1 -
 23 files changed, 517 insertions(+), 437 deletions(-)
 create mode 100644 arch/arm/boot/dts/armada-xp-matrix.dts

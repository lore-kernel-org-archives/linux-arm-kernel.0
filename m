From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 14 Dec 2013 17:21:39 -0500
Subject: [GIT PULL] ARM: mvebu: DT changes for v3.14 (incr #3)
Message-ID: <20131214222139.GG2609@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

Here's another round of DT changes.  They've all been in -next for at
least a few days.  This is an incremental pull from tags/mvebu-dt-3.14-2
in the mvebu/dt branch.

thx,

Jason.


The following changes since commit 46ca506c43d64e11257a0a113701e9bcccf52416:

  ARM: kirkwood: Add support for NETGEAR ReadyNAS NV+ v2 (2013-12-01 22:18:44 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-3.14-3

for you to fetch changes up to 69e18e26b5773092276a9702244784faf9b6c65f:

  ARM: mvebu: Enable NAND controller in A370 Reference Design board (2013-12-12 14:04:34 +0000)

----------------------------------------------------------------
mvebu DT changes for v3.14 (incr. #3)

 - kirkwood
    - use symbolic names for gpios and key inputs

 - mvebu
    - add the pxa nand controller to the ReadyNAS and A370-RD boards

----------------------------------------------------------------
Andrew Lunn (2):
      ARM: DT: Kirkwood: Use symbolic names from input.h
      ARM: DT: Kirkwood: Use symbolic names from gpio.h

Arnaud Ebalard (3):
      ARM: mvebu: Enable NAND controller in ReadyNAS 102 .dts file
      ARM: mvebu: Enable NAND controller in ReadyNAS 104 .dts file
      ARM: mvebu: Enable NAND controller in ReadyNAS 2120 .dts file

Ezequiel Garcia (1):
      ARM: mvebu: Enable NAND controller in A370 Reference Design board

 arch/arm/boot/dts/armada-370-netgear-rn102.dts     | 36 ++++++++++++++++++++++
 arch/arm/boot/dts/armada-370-netgear-rn104.dts     | 36 ++++++++++++++++++++++
 arch/arm/boot/dts/armada-370-rd.dts                | 21 +++++++++++++
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts     | 36 ++++++++++++++++++++++
 arch/arm/boot/dts/kirkwood-cloudbox.dts            | 10 +++---
 arch/arm/boot/dts/kirkwood-db.dtsi                 |  4 +--
 arch/arm/boot/dts/kirkwood-dns320.dts              | 10 +++---
 arch/arm/boot/dts/kirkwood-dns325.dts              | 10 +++---
 arch/arm/boot/dts/kirkwood-dnskw.dtsi              | 18 +++++------
 arch/arm/boot/dts/kirkwood-dockstar.dts            |  4 +--
 arch/arm/boot/dts/kirkwood-dreamplug.dts           |  6 ++--
 arch/arm/boot/dts/kirkwood-goflexnet.dts           | 22 ++++++-------
 .../arm/boot/dts/kirkwood-guruplug-server-plus.dts |  8 ++---
 arch/arm/boot/dts/kirkwood-ib62x0.dts              | 16 +++++-----
 arch/arm/boot/dts/kirkwood-iconnect.dts            | 24 +++++++--------
 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts      | 20 ++++++------
 arch/arm/boot/dts/kirkwood-km_kirkwood.dts         |  4 +--
 arch/arm/boot/dts/kirkwood-lsxl.dtsi               | 28 ++++++++---------
 arch/arm/boot/dts/kirkwood-mplcec4.dts             | 14 ++++-----
 arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts     | 14 ++++-----
 .../boot/dts/kirkwood-netgear_readynas_duo_v2.dts  |  2 --
 .../boot/dts/kirkwood-netgear_readynas_nv+_v2.dts  |  2 --
 arch/arm/boot/dts/kirkwood-ns2-common.dtsi         |  8 ++---
 arch/arm/boot/dts/kirkwood-ns2lite.dts             |  2 +-
 arch/arm/boot/dts/kirkwood-ns2max.dts              | 10 +++---
 arch/arm/boot/dts/kirkwood-ns2mini.dts             | 10 +++---
 arch/arm/boot/dts/kirkwood-nsa310-common.dtsi      |  4 +--
 arch/arm/boot/dts/kirkwood-nsa310.dts              | 32 +++++++++----------
 arch/arm/boot/dts/kirkwood-nsa310a.dts             | 30 +++++++++---------
 arch/arm/boot/dts/kirkwood-openblocks_a6.dts       | 10 +++---
 arch/arm/boot/dts/kirkwood-openblocks_a7.dts       | 10 +++---
 arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts    |  6 ++--
 arch/arm/boot/dts/kirkwood-sheevaplug.dts          |  4 +--
 arch/arm/boot/dts/kirkwood-topkick.dts             | 10 +++---
 arch/arm/boot/dts/kirkwood-ts219-6281.dts          |  8 ++---
 arch/arm/boot/dts/kirkwood-ts219-6282.dts          |  8 ++---
 arch/arm/boot/dts/kirkwood.dtsi                    |  2 ++
 37 files changed, 313 insertions(+), 186 deletions(-)

From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 18 Jul 2014 18:27:06 -0400
Subject: [GIT PULL] ARM: mvebu: DT changes for v3.17 (round 2)
Message-ID: <20140718222706.GP24496@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

Here's the accumulated DT changes for v3.17.

Incremental pull request from tags/mvebu-dt-3.17 up to
tags/mvebu-dt-3.17-2 on the mvebu/dt branch.

Please pull.

thx,

Jason.


The following changes since commit d854fa8a1500bec982ed9cb26b82d96bd5ae8dab:

  ARM: kirkwood: fix net5big regulator gpio assignments (2014-06-21 19:21:13 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-3.17-2

for you to fetch changes up to 3843607838cc5436d02a6771e661969a54c2fee0:

  ARM: mvebu: update Armada XP DT for dynamic frequency scaling (2014-07-16 12:54:13 +0000)

----------------------------------------------------------------
mvebu DT changes for v3.17 (round 2)

 - kirkwood
   - Add d2 Network v2 board

 - mvebu
   - Add Armada 375 ethernet node
   - Add CA9 MPcore SoC controller node
   - Add support for dynamic freq scaling on Armada XP

----------------------------------------------------------------
Ezequiel Garcia (2):
      ARM: mvebu: Add support for the network controller in Armada 375 SoC
      ARM: mvebu: Enable the network controller in Armada 375 DB board

Gregory CLEMENT (1):
      ARM: mvebu: add CA9 MPcore SoC Controller node

Simon Guinot (2):
      ARM: Kirkwood: allow to use netxbig DTSI for d2net_v2 DTS
      ARM: Kirkwood: add DT support for d2 Network v2

Thomas Petazzoni (1):
      ARM: mvebu: update Armada XP DT for dynamic frequency scaling

 .../bindings/arm/armada-380-mpcore-soc-ctrl.txt    | 14 ++++++++
 arch/arm/boot/dts/Makefile                         |  1 +
 arch/arm/boot/dts/armada-375-db.dts                | 26 ++++++++++++++
 arch/arm/boot/dts/armada-375.dtsi                  | 31 ++++++++++++++++
 arch/arm/boot/dts/armada-38x.dtsi                  |  5 +++
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           |  2 ++
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           |  2 ++
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           |  4 +++
 arch/arm/boot/dts/armada-xp.dtsi                   |  2 +-
 arch/arm/boot/dts/kirkwood-d2net.dts               | 42 ++++++++++++++++++++++
 arch/arm/boot/dts/kirkwood-net2big.dts             | 30 ++++++++++++++++
 arch/arm/boot/dts/kirkwood-net5big.dts             | 28 +++++++++++++++
 arch/arm/boot/dts/kirkwood-netxbig.dtsi            | 26 --------------
 13 files changed, 186 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/armada-380-mpcore-soc-ctrl.txt
 create mode 100644 arch/arm/boot/dts/kirkwood-d2net.dts

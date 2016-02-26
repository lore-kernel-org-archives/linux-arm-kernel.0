From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 26 Feb 2016 15:29:16 +0100
Subject: [GIT PULL] ARM: mvebu: dt for v4.6 (#2)
Message-ID: <87d1rjo88z.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second pull request for dt for mvebu for v4.6. There is a
dependency with the fixes branches for the orion5x device tree file, so
these commits are also part of this PR.

Gregory

The following changes since commit 5dda254d0cc5cbdcc81dbce0985c35b68dd5e3b1:

  ARM: dts: kirkwood: add device tree for buffalo linkstation ls-qvl (2016-02-09 11:00:26 +0100)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.6-2

for you to fetch changes up to af5ece3967c697d6d3264f1ca949a8633f97de25:

  ARM: dts: mvebu: add NAND description to Armada 370 DB and Armada XP DB (2016-02-12 17:45:49 +0100)

----------------------------------------------------------------
mvebu dt for 4.6 (part 2)

- Reorder Ethernet node on Armada 38x SoCs
- Add device tree for buffalo linkstation ls-gl
- Use the more accurate armada-370-sata string for SATA on Armada 375
- Add NAND description to Armada 370 DB and Armada XP DB

----------------------------------------------------------------
Gregory CLEMENT (1):
      Merge branch 'mvebu/fixes' into mvebu/dt

Heinrich Schuchardt (1):
      ARM: dts: kirkwood: use unique machine name for ds112

Lior Amsalem (1):
      ARM: dts: armada-375: use armada-370-sata for SATA

Roger Shimizu (3):
      ARM: dts: orion5x: fix the missing mtd flash on linkstation lswtgl
      ARM: dts: orion5x: split linkstation lswtgl into common and device parts
      ARM: dts: orion5x: add device tree for buffalo linkstation ls-gl

Thomas Petazzoni (3):
      ARM: dts: armada-38x: change order of ethernet DT nodes on Armada 38x
      ARM: dts: armada-38x: add reference to ETH connectors for A385-AP
      ARM: dts: mvebu: add NAND description to Armada 370 DB and Armada XP DB

 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/armada-370-db.dts                |  27 +++
 arch/arm/boot/dts/armada-375.dtsi                  |   2 +-
 arch/arm/boot/dts/armada-385-db-ap.dts             |   3 +
 arch/arm/boot/dts/armada-38x.dtsi                  |  30 ++-
 arch/arm/boot/dts/armada-xp-db.dts                 |  28 +++
 arch/arm/boot/dts/kirkwood-ds112.dts               |   2 +-
 arch/arm/boot/dts/mvebu-linkstation-fan.dtsi       |  72 +++++++
 .../boot/dts/mvebu-linkstation-gpio-simple.dtsi    | 105 ++++++++++
 arch/arm/boot/dts/orion5x-linkstation-lsgl.dts     |  87 +++++++++
 arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts   | 214 +++++----------------
 arch/arm/boot/dts/orion5x-linkstation.dtsi         | 180 +++++++++++++++++
 12 files changed, 572 insertions(+), 179 deletions(-)
 create mode 100644 arch/arm/boot/dts/mvebu-linkstation-fan.dtsi
 create mode 100644 arch/arm/boot/dts/mvebu-linkstation-gpio-simple.dtsi
 create mode 100644 arch/arm/boot/dts/orion5x-linkstation-lsgl.dts
 create mode 100644 arch/arm/boot/dts/orion5x-linkstation.dtsi

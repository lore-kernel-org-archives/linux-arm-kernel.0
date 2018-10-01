From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 01 Oct 2018 11:48:44 +0200
Subject: [GIT PULL] ARM: mvebu: dt for v4.20 (#1)
Message-ID: <87pnwungjn.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for dt for mvebu for v4.20.

Gregory

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.20-1

for you to fetch changes up to e807f0298144c06740022a2f900d86b7f115595e:

  ARM: dts: clearfog: fix sdhci supply property name (2018-09-21 16:06:08 +0200)

----------------------------------------------------------------
mvebu dt for 4.20 (part 1)

- updates the armada-xp-98dx3236 SoC and related boards to use the new
  style dts bindings for nand

- add db-88f6820-amc board: plugin card for some of Marvell's switch
  development kits

- fix SPI and I2C bus warnings coming with the new checks in dtc

- add new compatible string "marvell,prestera" to the armada-xp-98dx*

- fix sdhci supply property name on the clearfog (the '-supply' suffix
  was missing)

----------------------------------------------------------------
Baruch Siach (1):
      ARM: dts: clearfog: fix sdhci supply property name

Chris Packham (5):
      ARM: dts: mvebu: 98dx3236: Rename nand controller node
      ARM: dts: mvebu: db-dxbc2: use new style nand binding
      ARM: dts: mvebu: db-xc3-24g4: use new style nand binding
      ARM: dts: mvebu: Add device tree for db-88f6820-amc board
      ARM: dts: mvebu: add "marvell,prestera" to PP nodes

Rob Herring (1):
      ARM: dts: marvell: Fix SPI and I2C bus warnings

 arch/arm/boot/dts/Makefile                      |   1 +
 arch/arm/boot/dts/armada-385-db-88f6820-amc.dts | 157 ++++++++++++++++++++++++
 arch/arm/boot/dts/armada-388-clearfog.dtsi      |   2 +-
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi       |   4 +-
 arch/arm/boot/dts/armada-xp-98dx3336.dtsi       |   2 +-
 arch/arm/boot/dts/armada-xp-98dx4251.dtsi       |   2 +-
 arch/arm/boot/dts/armada-xp-db-dxbc2.dts        |  18 +--
 arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts   |  18 +--
 arch/arm/boot/dts/dove-cubox.dts                |   2 +-
 arch/arm/boot/dts/dove.dtsi                     |   6 +-
 arch/arm/boot/dts/orion5x-linkstation.dtsi      |   2 +-
 11 files changed, 190 insertions(+), 24 deletions(-)
 create mode 100644 arch/arm/boot/dts/armada-385-db-88f6820-amc.dts

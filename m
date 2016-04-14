From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 14 Apr 2016 19:14:28 +0200
Subject: [GIT PULL v2] ARM: mvebu: dt for v4.7 (#1)
Message-ID: <87lh4gyux7.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for dt for mvebu for v4.7, but in in
his second version after having fixed the patch title.

Gregory

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.7-1

for you to fetch changes up to c134043ed396b06addf5866d977fed7ba6a393a9:

  ARM: dts: kirkwood: Add DTS for Linksys EA4200v2/EA4500 (2016-04-14 19:06:50 +0200)

----------------------------------------------------------------
mvebu dt for 4.7 (part 1)

- add hardware monitor support in the NSA320 device tree
- update makefile with kirkwood-ds112.dtb and kirkwood-nsa320.dtb
- fix GPIO config on the Linksys boards
- various Kirkwood DT warning fixup from the newer DT compiler

----------------------------------------------------------------
Adam Baker (1):
      ARM: dts: kirkwood: Add the hardware monitor to the NSA320 device tree

Andrew Lunn (8):
      ARM: dts: kirkwood: Remove button address and fixup names
      ARM: dts: kirkwood: Remove node address from leds
      ARM: dts: kirkwood: Remove address from dsa unit name
      ARM: dts: kirkwood: Add address to ethernet-phy unit name
      ARM: dts: kirkwood: Fixup pcie DT warnings
      ARM: dts: kirkwood: Remove address from gpio-i2c unit name
      ARM: dts: kirkwood: Add address to mbus unit name
      ARM: dts: kirkwood: Add address go regulator unit name

Bert Vermeulen (1):
      ARM: dts: kirkwood: Add DTS for Linksys EA4200v2/EA4500

Heinrich Schuchardt (2):
      ARM: dts: kirkwood: add kirkwood-ds112.dtb to Makefile
      ARM: dts: kirkwood: add kirkwood-nsa320.dtb to Makefile

Imre Kaloz (1):
      ARM: mvebu: fix GPIO config on the Linksys boards

Roger Shimizu (1):
      ARM: dts: orion5x: add device tree for kurobox-pro

 arch/arm/boot/dts/Makefile                         |   4 +
 arch/arm/boot/dts/armada-385-linksys.dtsi          |   6 +-
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts      |   4 +-
 arch/arm/boot/dts/kirkwood-6192.dtsi               |   4 +-
 arch/arm/boot/dts/kirkwood-6281.dtsi               |   4 +-
 arch/arm/boot/dts/kirkwood-6282.dtsi               |   4 +-
 arch/arm/boot/dts/kirkwood-98dx4122.dtsi           |   4 +-
 arch/arm/boot/dts/kirkwood-b3.dts                  |  19 +-
 arch/arm/boot/dts/kirkwood-blackarmor-nas220.dts   |   4 +-
 arch/arm/boot/dts/kirkwood-cloudbox.dts            |   2 +-
 arch/arm/boot/dts/kirkwood-db-88f6281.dts          |  14 +-
 arch/arm/boot/dts/kirkwood-db-88f6282.dts          |  20 +-
 arch/arm/boot/dts/kirkwood-dir665.dts              |  20 +-
 arch/arm/boot/dts/kirkwood-dnskw.dtsi              |   6 +-
 arch/arm/boot/dts/kirkwood-ds111.dts               |   2 +-
 arch/arm/boot/dts/kirkwood-ds112.dts               |   6 +-
 arch/arm/boot/dts/kirkwood-ds212.dts               |   2 +-
 arch/arm/boot/dts/kirkwood-ds411.dts               |   6 +-
 arch/arm/boot/dts/kirkwood-ds411slim.dts           |   2 +-
 arch/arm/boot/dts/kirkwood-ib62x0.dts              |   4 +-
 arch/arm/boot/dts/kirkwood-iconnect.dts            |  22 +-
 arch/arm/boot/dts/kirkwood-km_common.dtsi          |  20 +-
 arch/arm/boot/dts/kirkwood-laplug.dts              |  19 +-
 arch/arm/boot/dts/kirkwood-linkstation.dtsi        |  17 +-
 arch/arm/boot/dts/kirkwood-linksys-viper.dts       | 240 +++++++++++++++++++++
 arch/arm/boot/dts/kirkwood-lsxl.dtsi               |  16 +-
 arch/arm/boot/dts/kirkwood-mplcec4.dts             |  18 +-
 arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts     |  24 +--
 arch/arm/boot/dts/kirkwood-nas2big.dts             |  18 +-
 .../boot/dts/kirkwood-netgear_readynas_duo_v2.dts  |  20 +-
 .../boot/dts/kirkwood-netgear_readynas_nv+_v2.dts  |  23 +-
 arch/arm/boot/dts/kirkwood-netxbig.dtsi            |   8 +-
 arch/arm/boot/dts/kirkwood-ns2-common.dtsi         |   4 +-
 arch/arm/boot/dts/kirkwood-nsa310.dts              |  18 +-
 arch/arm/boot/dts/kirkwood-nsa320.dts              |  31 +--
 arch/arm/boot/dts/kirkwood-nsa325.dts              |  17 +-
 arch/arm/boot/dts/kirkwood-nsa3x0-common.dtsi      |  24 +--
 arch/arm/boot/dts/kirkwood-openblocks_a6.dts       |   2 +-
 arch/arm/boot/dts/kirkwood-openblocks_a7.dts       |   2 +-
 arch/arm/boot/dts/kirkwood-openrd.dtsi             |  14 +-
 arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts   |   2 +-
 arch/arm/boot/dts/kirkwood-rd88f6192.dts           |  20 +-
 arch/arm/boot/dts/kirkwood-rd88f6281-a.dts         |   2 +-
 arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts        |   2 +-
 arch/arm/boot/dts/kirkwood-rd88f6281.dtsi          |  20 +-
 arch/arm/boot/dts/kirkwood-rs212.dts               |   6 +-
 arch/arm/boot/dts/kirkwood-synology.dtsi           |  22 +-
 arch/arm/boot/dts/kirkwood-t5325.dts               |  22 +-
 arch/arm/boot/dts/kirkwood-ts219-6281.dts          |   4 +-
 arch/arm/boot/dts/kirkwood-ts219-6282.dts          |  16 +-
 arch/arm/boot/dts/kirkwood-ts219.dtsi              |  20 +-
 arch/arm/boot/dts/kirkwood-ts419-6282.dts          |  15 +-
 arch/arm/boot/dts/kirkwood-ts419.dtsi              |   4 +-
 arch/arm/boot/dts/kirkwood.dtsi                    |   2 +-
 arch/arm/boot/dts/orion5x-kuroboxpro.dts           | 127 +++++++++++
 55 files changed, 649 insertions(+), 329 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-linksys-viper.dts
 create mode 100644 arch/arm/boot/dts/orion5x-kuroboxpro.dts

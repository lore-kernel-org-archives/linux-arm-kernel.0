From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sun, 04 Sep 2016 17:57:04 +0200
Subject: [GIT PULL] ARM: mvebu: dt for v4.9 (#1)
Message-ID: <87inubzmi7.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for dt for mvebu for v4.9.

Gregory

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.9-1

for you to fetch changes up to a305cc2fce217510dd255356d783e2c01cbc3a8f:

  ARM: dts: mvebu: fix reference to a390 spi controller (2016-08-29 11:26:11 +0200)

----------------------------------------------------------------
mvebu dt for 4.9 (part 1)

- update for Armada XP/38x allowing using direct access SPI
- various improvement for Armada 39x platforms
- add pinctrl information for NANd on Armada 38x
- fix the kirkwood based Openblock A6 external GPIO pins

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: dts: mvebu: fix reference to a390 spi controller

Chris Packham (1):
      ARM: dts: armada-38x: Add NAND pinctrl information

Grzegorz Jaszczyk (14):
      ARM: dts: mvebu: a385-db-ap: enable USB (orion-ehci) port
      ARM: dts: mvebu: a385-db-ap: add default partition description for NAND
      ARM: dts: mvebu: armada-390: add missing compatibility string and bracket
      ARM: dts: mvebu: armada-39x: update the SDHCI node on Armada 39x
      ARM: dts: mvebu: armada-39x: enable PMU, CA9 SoC Controller and Coherency fabric
      ARM: dts: mvebu: armada-39x: enable the thermal sensor in Armada-39x SoCs
      ARM: dts: mvebu: armada-39x: enable watchdog for all Armada-39x SoCs
      ARM: dts: mvebu: armada-39x: add missing nodes describing GPIO's
      ARM: dts: mvebu: armada-39x: enable rtc for all Armada-39x SoCs
      ARM: dts: mvebu: armada-395: add support for the Armada 395 SoC family
      ARM: dts: mvebu: armada-398: update the dtsi about missing interfaces
      ARM: dts: mvebu: armada-398-db: enable supported usb interfaces
      ARM: dts: mvebu: armada-390-db: add support for the Armada 390 DB board
      ARM: dts: mvebu: armada-395-gp: add support for the Armada 395 GP Board

Jason Cooper (1):
      ARM: dts: kirkwood: Fix Openblock A6 external GPIO pins

Stefan Roese (3):
      ARM: dts: mvebu: Add SPI1 pinctrl defines for Armada XP
      ARM: dts: mvebu: A37x/XP/38x/39x: Move SPI controller nodes into 'soc' node
      ARM: dts: mvebu: armada-370-xp: Add MBus mappings for all SPI devices

 .../devicetree/bindings/arm/marvell/armada-39x.txt |  15 +-
 arch/arm/boot/dts/armada-370-db.dts                |  29 ++--
 .../dts/armada-370-seagate-personal-cloud.dtsi     |  40 ++---
 arch/arm/boot/dts/armada-370-synology-ds213j.dts   | 112 ++++++-------
 arch/arm/boot/dts/armada-370-xp.dtsi               |  56 ++++---
 arch/arm/boot/dts/armada-370.dtsi                  |  34 ++--
 arch/arm/boot/dts/armada-385-db-ap.dts             |  58 +++++--
 arch/arm/boot/dts/armada-385-linksys.dtsi          |   9 +-
 arch/arm/boot/dts/armada-388-clearfog.dts          |  48 +++---
 arch/arm/boot/dts/armada-388-db.dts                |  25 +--
 arch/arm/boot/dts/armada-388-gp.dts                |  30 ++--
 arch/arm/boot/dts/armada-388-rd.dts                |  25 +--
 arch/arm/boot/dts/armada-38x.dtsi                  |  57 ++++---
 arch/arm/boot/dts/armada-390-db.dts                | 175 +++++++++++++++++++++
 arch/arm/boot/dts/armada-390.dtsi                  |   3 +
 arch/arm/boot/dts/armada-395-gp.dts                | 163 +++++++++++++++++++
 arch/arm/boot/dts/armada-395.dtsi                  |  76 +++++++++
 arch/arm/boot/dts/armada-398-db.dts                |  56 ++++---
 arch/arm/boot/dts/armada-398.dtsi                  |  10 +-
 arch/arm/boot/dts/armada-39x.dtsi                  | 126 ++++++++++++---
 arch/arm/boot/dts/armada-xp-axpwifiap.dts          |  24 +--
 arch/arm/boot/dts/armada-xp-db.dts                 |  24 +--
 arch/arm/boot/dts/armada-xp-gp.dts                 |  24 +--
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts      |  24 +--
 arch/arm/boot/dts/armada-xp-synology-ds414.dts     | 112 ++++++-------
 arch/arm/boot/dts/armada-xp.dtsi                   |  31 ++--
 arch/arm/boot/dts/kirkwood-openblocks_a6.dts       |   9 +-
 27 files changed, 988 insertions(+), 407 deletions(-)
 create mode 100644 arch/arm/boot/dts/armada-390-db.dts
 create mode 100644 arch/arm/boot/dts/armada-395-gp.dts
 create mode 100644 arch/arm/boot/dts/armada-395.dtsi

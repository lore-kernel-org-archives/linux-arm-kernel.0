From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 13 Jan 2015 15:51:12 +0100
Subject: [GIT PULL] mvebu: dt for v3.20
Message-ID: <20150113145112.GC13100@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd

Here is the first dt pull request for mvebu for v3.20.

     Andrew

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-3.20

for you to fetch changes up to 928413bd859c0936f03f6a3504c4721e83a3d1d7:

  ARM: mvebu: Add Armada 388 General Purpose Development Board support (2015-01-09 09:20:00 -0600)

----------------------------------------------------------------
mvebu dt changes for v3.20 (part #1)

- Add Armada 388 General Purpose Development Board support
- Add Device Tree description of the Armada 388 SoC
- Document the Device Tree binding for the Armada 388 SoC
- a38x: Add missing labels
- a38x: Add more pinctrl functions
- Add Armada 385 Access Point Development Board support
- Add a number of pinctrl functions
- A38x: Remove redundant pinctrl informations
- a38x: Fix node names
- Add support for Seagate BlackArmor NAS220
- kirkwood: enable phy driver for SATA controller on 88f6192
- gpio_poweroff support for Iomega ix2-200
- Use all remaining MTD space foor rootfs of Iomega ix2-200

----------------------------------------------------------------
Evgeni Dobrev (2):
      ARM: dts: kirkwood: enable phy driver for SATA controller on 88f6192
      Kirkwood: add support for Seagate BlackArmor NAS220

Gregory CLEMENT (5):
      ARM: mvebu: a38x: Add more pinctrl functions
      ARM: mvebu: a38x: Add missing labels
      ARM: mvebu: Document the Device Tree binding for the Armada 388 SoC
      ARM: mvebu: Add Device Tree description of the Armada 388 SoC
      ARM: mvebu: Add Armada 388 General Purpose Development Board support

Maxime Ripard (4):
      ARM: mvebu: a38x: Fix node names
      ARM: mvebu: A38x: Remove redundant pinctrl informations
      ARM: mvebu: Add a number of pinctrl functions
      ARM: mvebu: Add Armada 385 Access Point Development Board support

Richard Kunze (2):
      ARM: dts: use all remaining MTD space foor rootfs of Iomega ix2-200
      ARM: dts: add gpio_poweroff support for Iomega ix2-200

 .../devicetree/bindings/arm/armada-38x.txt         |   7 +
 arch/arm/boot/dts/Makefile                         |   7 +-
 arch/arm/boot/dts/armada-380.dtsi                  |   3 +-
 arch/arm/boot/dts/armada-385-db-ap.dts             | 178 +++++++++++++
 arch/arm/boot/dts/armada-385.dtsi                  |   3 +-
 .../dts/{armada-385-db.dts => armada-388-db.dts}   |   9 +-
 arch/arm/boot/dts/armada-388-gp.dts                | 288 +++++++++++++++++++++
 .../dts/{armada-385-rd.dts => armada-388-rd.dts}   |   9 +-
 arch/arm/boot/dts/armada-388.dtsi                  |  70 +++++
 arch/arm/boot/dts/armada-38x.dtsi                  |  93 ++++++-
 arch/arm/boot/dts/kirkwood-6192.dtsi               |   2 +
 arch/arm/boot/dts/kirkwood-blackarmor-nas220.dts   | 173 +++++++++++++
 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts      |   8 +-
 13 files changed, 830 insertions(+), 20 deletions(-)
 create mode 100644 arch/arm/boot/dts/armada-385-db-ap.dts
 rename arch/arm/boot/dts/{armada-385-db.dts => armada-388-db.dts} (92%)
 create mode 100644 arch/arm/boot/dts/armada-388-gp.dts
 rename arch/arm/boot/dts/{armada-385-rd.dts => armada-388-rd.dts} (88%)
 create mode 100644 arch/arm/boot/dts/armada-388.dtsi
 create mode 100644 arch/arm/boot/dts/kirkwood-blackarmor-nas220.dts

From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 09 Mar 2015 20:44:12 +0100
Subject: [GIT PULL] ARM: mvebu: dt changes for v4.1
Message-ID: <54FDF80C.6030407@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for dt for mvebu for v4.1

Gregory

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.1

for you to fetch changes up to 538da83ddbeaa422a48e9bd0a12a0bc246c567f4:

  ARM: mvebu: add Device Tree files for Armada 39x SoC and board (2015-03-04 15:42:34 +0100)

----------------------------------------------------------------
mvebu dt changes for v4.1 (part #1)

- fix SDHCI nodes on Armada 38x
- add Linksys WRT1900AC (Mamba) support (including the Ethernet switch)
- add several fixes and improvement for dove
- enable GPIO fan alarm support for 2Big Network v2
- add several fixes about unit address
- add support for Armada 39x SoC and board

----------------------------------------------------------------
Andrew Lunn (1):
      ARM: ARMADA XP: WRT1900AC: Add support for the Ethernet switch

Gregory CLEMENT (3):
      ARM: mvebu: Use macros for interrupt flags on Armada 38x sdhci node
      ARM: mvebu: Update the SDHCI node on Armada 38x
      ARM: mvebu: Add Device Tree description of SDHCI for Armada 388 RD

Imre Kaloz (1):
      ARM: mvebu: add Linksys WRT1900AC (Mamba) support

Maxime Ripard (2):
      ARM: mvebu: Fix MPIC unit address
      ARM: mvebu: a385-db-ap: Enable the NAND

Sebastian Hesselbarth (4):
      ARM: dts: dove: Fix uart[23] reg property
      ARM: dts: dove: Always include gpio and interrupt-controller headers
      ARM: dts: dove: Add node labels for PCIe ports 0 and 1
      ARM: dts: dove: Add some more common pinctrl settings

Simon Guinot (1):
      ARM: Kirkwood: enable GPIO fan alarm support for 2Big Network v2

Thomas Petazzoni (8):
      ARM: mvebu: fix usb@ unit address on Armada 38x to match register address
      ARM: mvebu: add missing UART labels on Armada 38x
      ARM: mvebu: add UART labels to Armada 375
      ARM: mvebu: remove aliases for Ethernet devices on Armada 370/375/38x/XP
      ARM: mvebu: add serial port aliases on Armada 370/375/38x/XP
      ARM: mvebu: use stdout-path in all armada-*.dts
      ARM: mvebu: fix unit address of MPIC nodes
      ARM: mvebu: add Device Tree files for Armada 39x SoC and board

 arch/arm/boot/dts/Makefile                       |   3 +
 arch/arm/boot/dts/armada-370-db.dts              |   2 +-
 arch/arm/boot/dts/armada-370-mirabox.dts         |   2 +-
 arch/arm/boot/dts/armada-370-netgear-rn102.dts   |   2 +-
 arch/arm/boot/dts/armada-370-netgear-rn104.dts   |   2 +-
 arch/arm/boot/dts/armada-370-rd.dts              |   2 +-
 arch/arm/boot/dts/armada-370-synology-ds213j.dts |   3 +-
 arch/arm/boot/dts/armada-370-xp.dtsi             |   6 +-
 arch/arm/boot/dts/armada-370.dtsi                |   2 +-
 arch/arm/boot/dts/armada-375-db.dts              |   2 +-
 arch/arm/boot/dts/armada-375.dtsi                |  10 +--
 arch/arm/boot/dts/armada-385-db-ap.dts           |  16 +++-
 arch/arm/boot/dts/armada-388-db.dts              |   4 +-
 arch/arm/boot/dts/armada-388-gp.dts              |   5 +-
 arch/arm/boot/dts/armada-388-rd.dts              |  12 ++-
 arch/arm/boot/dts/armada-38x.dtsi                |  18 +++--
 arch/arm/boot/dts/armada-390.dtsi                |  57 +++++++++++++++
 arch/arm/boot/dts/armada-398-db.dts              | 153 ++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/armada-398.dtsi                |  60 +++++++++++++++
 arch/arm/boot/dts/armada-39x.dtsi                | 508 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/armada-xp-axpwifiap.dts        |   2 +-
 arch/arm/boot/dts/armada-xp-db.dts               |   2 +-
 arch/arm/boot/dts/armada-xp-gp.dts               |   2 +-
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts  |   3 +-
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts    | 393 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/armada-xp-matrix.dts           |   2 +-
 arch/arm/boot/dts/armada-xp-mv78260.dtsi         |   1 -
 arch/arm/boot/dts/armada-xp-mv78460.dtsi         |   1 -
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts   |   2 +-
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts |   2 +-
 arch/arm/boot/dts/armada-xp-synology-ds414.dts   |   3 +-
 arch/arm/boot/dts/armada-xp.dtsi                 |   5 +-
 arch/arm/boot/dts/dove.dtsi                      |  63 +++++++++++++++-
 arch/arm/boot/dts/kirkwood-net2big.dts           |   5 ++
 34 files changed, 1304 insertions(+), 51 deletions(-)
 create mode 100644 arch/arm/boot/dts/armada-390.dtsi
 create mode 100644 arch/arm/boot/dts/armada-398-db.dts
 create mode 100644 arch/arm/boot/dts/armada-398.dtsi
 create mode 100644 arch/arm/boot/dts/armada-39x.dtsi
 create mode 100644 arch/arm/boot/dts/armada-xp-linksys-mamba.dts
-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

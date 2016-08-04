From: jaz@semihalf.com (Grzegorz Jaszczyk)
Date: Thu,  4 Aug 2016 12:14:03 +0200
Subject: [PATCH v2 00/17] ARM: mvebu: misc Armada 38x/39x DT and v7 defconfig
 improvements
Message-ID: <1470305660-6601-1-git-send-email-jaz@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is the second version of patch-set which enables some commonly used
features in mvebu_v7_defconfig and updates old or introduces new dts/dtsi
related to Armada 38x and Armada 39x SoC family. All comments from
v1 are included, more details in a changelog below.

Any comments or remarks would be welcome.

Best regards,
Grzegorz

Changelog:
v1 -> v2

- Add at least one line of commit log entry for those patches, which
contained only commit title.

Suggested by Andrew Lunn and Gregory Clement.

- Drop patch "ARM: mvebu: enable E1000E in mvebu_v7_defconfig", since it
enables PCIe card which is not a part of the SoC.

Suggested by Russell King and Thomas Petazzoni.

- Change dts prefixes in commit title from "ARM: mvebu: <board_name>" to
"ARM: dts: mvebu: <board_name>"

Suggested by Gregory Clement.

- Add nodes describing the eeproms connected to I2C buses in
armada-390-db.dts and armada-395-gp.dts. Also add information about
connectors used and described in mentioned dts's.

Suggested by Gregory Clement.

- Improve devicetree bindings about required property for Marvell Armada 39x
family: Armada 398 based boards should have only "marvell,armada398" and not
"marvell,armada395".

Suggested by Rob Herring.

Grzegorz Jaszczyk (17):
  ARM: mvebu: enable MTD command line partition table in
    mvebu_v7_defconfig
  ARM: mvebu: enable UBI and UBIFS in mvebu_v7_defconfig
  ARM: dts: mvebu: a385-db-ap: enable USB (orion-ehci) port
  ARM: dts: mvebu: a385-db-ap: add default partition description for
    NAND
  ARM: dts: mvebu: armada-390: add missing compatibility string and
    bracket
  ARM: dts: mvebu: armada-39x: update the SDHCI node on Armada 39x
  ARM: dts: mvebu: armada-39x: enable PMU, CA9 SoC Controller and
    Coherency fabric
  ARM: dts: mvebu: armada-39x: enable the thermal sensor in Armada-39x
    SoCs
  ARM: dts: mvebu: armada-39x: enable watchdog for all Armada-39x SoCs
  ARM: dts: mvebu: armada-39x: add missing nodes describing GPIO's
  ARM: dts: mvebu: armada-39x: add missing nodes describing USB2.0 and
    USB3.0
  ARM: dts: mvebu: armada-39x: enable rtc for all Armada-39x SoCs
  ARM: dts: mvebu: armada-395: add support for the Armada 395 SoC family
  ARM: dts: mvebu: armada-398: update the dtsi about missing interfaces
  ARM: dts: mvebu: armada-398-db: enable supported usb interfaces
  ARM: dts: mvebu: armada-390-db: add support for the Armada 390 DB
    board
  ARM: dts: mvebu: armada-395-gp: add support for the Armada 395 GP
    Board

 .../devicetree/bindings/arm/marvell/armada-39x.txt |  15 +-
 arch/arm/boot/dts/armada-385-db-ap.dts             |  30 +++-
 arch/arm/boot/dts/armada-390-db.dts                | 175 +++++++++++++++++++++
 arch/arm/boot/dts/armada-390.dtsi                  |   3 +
 arch/arm/boot/dts/armada-395-gp.dts                | 163 +++++++++++++++++++
 arch/arm/boot/dts/armada-395.dtsi                  |  76 +++++++++
 arch/arm/boot/dts/armada-398-db.dts                |   8 +
 arch/arm/boot/dts/armada-398.dtsi                  |  10 +-
 arch/arm/boot/dts/armada-39x.dtsi                  |  94 ++++++++++-
 arch/arm/configs/mvebu_v7_defconfig                |   3 +
 10 files changed, 570 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/boot/dts/armada-390-db.dts
 create mode 100644 arch/arm/boot/dts/armada-395-gp.dts
 create mode 100644 arch/arm/boot/dts/armada-395.dtsi

-- 
1.8.3.1

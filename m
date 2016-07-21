From: jaz@semihalf.com (Grzegorz Jaszczyk)
Date: Thu, 21 Jul 2016 14:43:56 +0200
Subject: [PATCH 00/18] ARM: mvebu: misc Armada 38x/39x DT and v7 defconfig
 improvements
Message-ID: <1469105055-25181-1-git-send-email-jaz@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

First 3 patches enables some commonly used features in mvebu_v7_defconfig.

Patches 4 and 5 updates armada-385-db-ap.dts. Then patch 6 is currently a fix
for broken Armada 390 dtsi.

Patches 7 to 13 updates the armada-39x.dtsi about features which all can be
supported with existing drivers.

Patch 14 introduces armada-395.dtsi which describes Armada 395 SoC family and
patch 15 updates armada-398.dtsi. Next patch updates Armada 398 DB dts about
supported usb interfaces and finally last 2 patches introduces description for 2
board: Armada 390 DB and Armada 395 GP.

Grzegorz Jaszczyk (18):
  ARM: mvebu: enable MTD command line partition table in
    mvebu_v7_defconfig
  ARM: mvebu: enable UBI and UBIFS in mvebu_v7_defconfig
  ARM: mvebu: enable E1000E in mvebu_v7_defconfig
  ARM: mvebu: a385-db-ap: enable USB (orion-ehci) port
  ARM: mvebu: a385-db-ap: add default partition description for NAND
  ARM: mvebu: a390: add missing compatibility string and add missing
    bracket
  ARM: mvebu: a39x: update the SDHCI node on Armada 39x
  ARM: mvebu: a39x: enable PMU, CA9 MPcore SoC Controller and Coherency
    fabric
  ARM: mvebu: a39x: enable the thermal sensor in Armada-39x SoCs
  ARM: mvebu: a39x: enable watchdog for all Armada-39x SoCs
  ARM: mvebu: a39x: add missing nodes describing GPIO's
  ARM: mvebu: a39x: add missing nodes describing USB2.0 and USB3.0
  ARM: mvebu: a39x: enable rtc for all Armada-39x SoCs
  ARM: mvebu: add support for the Armada 395 SoC family
  ARM: mvebu: a398: update the dtsi about missing interfaces
  ARM: mvebu: a398-db: enable supported usb interfaces
  ARM: mvebu: a390-db: add support for the Armada 390 DB board
  ARM: mvebu: a395-gp: add support for the Armada 395 GP Board

 .../devicetree/bindings/arm/marvell/armada-39x.txt |   2 +-
 arch/arm/boot/dts/armada-385-db-ap.dts             |  30 +++-
 arch/arm/boot/dts/armada-390-db.dts                | 164 +++++++++++++++++++++
 arch/arm/boot/dts/armada-390.dtsi                  |   3 +
 arch/arm/boot/dts/armada-395-gp.dts                | 147 ++++++++++++++++++
 arch/arm/boot/dts/armada-395.dtsi                  |  76 ++++++++++
 arch/arm/boot/dts/armada-398-db.dts                |   8 +
 arch/arm/boot/dts/armada-398.dtsi                  |  10 +-
 arch/arm/boot/dts/armada-39x.dtsi                  |  94 +++++++++++-
 arch/arm/configs/mvebu_v7_defconfig                |   4 +
 10 files changed, 532 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/boot/dts/armada-390-db.dts
 create mode 100644 arch/arm/boot/dts/armada-395-gp.dts
 create mode 100644 arch/arm/boot/dts/armada-395.dtsi

-- 
1.8.3.1

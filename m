From: rjui@broadcom.com (Ray Jui)
Date: Mon, 21 Sep 2015 15:12:41 -0700
Subject: [PATCH v3 0/9] Broadcom Cygnus device tree changes
Message-ID: <1442873570-20947-1-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series cleans up the Broadcom Cygnus device tree files and makes it
more consistent with the rest of Broadcom iProc device tree files. This patch
series also enables various peripherals on Cygnus boards. They include:

bcm11360_entphn:
NAND

bcm958300k:
touchscreen

bcm958305k:
I2C, PCIe, NAND, touchscreen

Code is based on v4.3-rc1 and is available on GITHUB:
https://github.com/Broadcom/cygnus-linux/tree/cygnus-dt-v3

Changes from V2:
 - Drop PCIe device node change that removes the I/O resource
 - Set up appropriate address range for the 'core' bus
 - Rename the 'soc' bus node to 'axi'
 - Remove incorrect 3rd compatible string 'brcm,brcmnand' in the NAND node

Chages from V1:
 - Break the major clean up change into separate patches

Ray Jui (9):
  ARM: dts: consolidate aliases for Cygnus dt files
  ARM: dts: Use label for device nodes in Cygnus dts
  ARM: dts: Put Cygnus core components under core bus
  ARM: dts: Move all Cygnus peripherals into axi bus
  ARM: dts: Reorder Cygnus peripherals
  ARM: dts: Enable various peripherals on bcm958305k
  ARM: dts: Enable NAND support on bcm911360_entphn
  ARM: dts: enable touchscreen support on Cygnus
  ARM: dts: fix Cygnus nand device node

 arch/arm/boot/dts/bcm-cygnus.dtsi      | 338 +++++++++++++++++----------------
 arch/arm/boot/dts/bcm911360_entphn.dts |  28 ++-
 arch/arm/boot/dts/bcm911360k.dts       |  10 +-
 arch/arm/boot/dts/bcm958300k.dts       |  45 ++---
 arch/arm/boot/dts/bcm958305k.dts       |  41 +++-
 arch/arm/boot/dts/bcm9hmidc.dtsi       |  42 ++++
 6 files changed, 300 insertions(+), 204 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm9hmidc.dtsi

-- 
1.9.1

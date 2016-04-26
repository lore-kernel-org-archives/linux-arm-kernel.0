From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 26 Apr 2016 09:58:28 +0200
Subject: [PATCH v3 00/11] arm64: marvell: improve support for Armada 7K/8K
Message-ID: <1461657519-11939-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is the third version of the set of patches improving support for
Marvell Armada 7K/8K. It brings:

 - Cleanups to the existing Device Tree files, suggested by Andreas
   F?rber.

 - Switch to the new clock binding for the AP806 and misc other
   improvements (stdout-path, SPI flash description improvements,
   etc.)

 - Addition of the description for the CP110 part of the Armada 7K/8K,
   which brings features like PCIe, SATA, USB3, more I2C and SPI
   controllers.

Changes since v3:

 - Integration of the patches from Andreas F?rber regarding the 7K/8K
   platform. I took them in my patch series as they
   interacted/conflicted badly with the other changes I had.

 - Addition of a patch making use of stdout-path, as suggested by
   Andreas F?rber.

 - Addition of a patch improving the SPI flash description, for the
   SPI flash connected to the AP part.

 - Addition of a patch fixing the AP I2C controller description to
   make use of the bridge/offload functionality.

 - Addition of support for SATA, USB3, I2C and SPI in the description
   of the CP110.

 - Addition of patches updating the arm64 defconfig with necessary
   additional drivers, and updating the MAINTAINERS entry for Armada
   platforms.

Thanks!

Thomas

Andreas F?rber (2):
  arm64: dts: marvell: clean up armada-7040-db
  arm64: dts: marvell: rename armada-ap806 XOR nodes

Thomas Petazzoni (9):
  arm64: marvell: enable AP806 and CP110 syscon driver
  arm64: dts: marvell: add UART aliases and define stdout-path
  arm64: dts: marvell: use new clock binding on Armada AP806
  arm64: dts: marvell: improve SPI flash description on Armada 7040-DB
  arm64: dts: marvell: use the proper I2C controller compatible string
    for 7K/8K
  arm64: dts: marvell: initial DT description of Armada 7K/8K CP110
    master
  arm64: dts: marvell: enable several CP interfaces on Armada 7040-DB
  arm64: configs: add options useful for Armada 7K/8K support
  MAINTAINERS: update entry for Marvell ARM platform maintainers

 MAINTAINERS                                        |   2 +-
 arch/arm64/Kconfig.platforms                       |   4 +-
 arch/arm64/boot/dts/marvell/armada-7020.dtsi       |   1 +
 arch/arm64/boot/dts/marvell/armada-7040-db.dts     | 108 +++++++---
 arch/arm64/boot/dts/marvell/armada-7040.dtsi       |   1 +
 arch/arm64/boot/dts/marvell/armada-8020.dtsi       |   1 +
 arch/arm64/boot/dts/marvell/armada-8040.dtsi       |   1 +
 arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi |   1 -
 arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi |   2 -
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |  56 +++--
 .../boot/dts/marvell/armada-cp110-master.dtsi      | 228 +++++++++++++++++++++
 arch/arm64/configs/defconfig                       |   4 +
 12 files changed, 345 insertions(+), 64 deletions(-)
 create mode 100644 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi

-- 
2.6.4

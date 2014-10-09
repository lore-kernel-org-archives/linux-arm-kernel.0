From: sbranden@broadcom.com (Scott Branden)
Date: Thu, 9 Oct 2014 15:44:24 -0700
Subject: [PATCH V4 0/7] Add initial support for Broadcom Cygnus SoC
In-Reply-To: <Scott Branden <sbranden@broadcom.com>
References: <Scott Branden <sbranden@broadcom.com>
Message-ID: <1412894671-5921-1-git-send-email-sbranden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains initial support for Broadcom's Cygnus SoC based on our
iProc architecture. Initial support is minimal and includes just the mach
platform code, clock driver, and a basic device tree configuration. Peripheral
drivers will be submitted soon, as will device tree configurations for other
Cygnus board variants.

Changes from v3:
 - restart functionality removed.  Will be added in a different patchset
   in drivers/power
 - removed NEON init sequence.  Will be moved to bootloader
 - cleaned up Kconfigs for ARCH_BCM_CYGNUS by removing unnecessary selects
 - consolidated ARCH_BCM_IPROC with select from ARCH_BCM_CYGNUS and
   ARCH_BCM5301X
 - removed bcm911360_entphn binding
 - added documentation for SoCs currently supported in Cygnus family


Changes from v2:
 - rebased to 3.17 kernel

Changes from v1:
 - Address code review comments as per previous responses.
 - Copyright headers updated to remove Broadcom URL.
 - mach platform code still contains hard coded addresses. These address are
   the same for all Cygnus variants. Could you please provide guidance on where
   they should go if you would still like them changed.  There does not seem to
   be a reason to change them to device tree as they do not change.


Jonathan Richardson (5):
  ARM: cygnus: Initial support for Broadcom Cygnus SoC
  clk: Clock driver support for Broadcom Cygnus SoC
  dt-bindings: Document Broadcom Cygnus SoC and clock driver
  ARM: cygnus defconfig : Initial defconfig for Broadcom Cygnus SoC
  ARM: dts: Enable Broadcom Cygnus SoC

Scott Branden (2):
  MAINTAINERS: Entry for Cygnus/iproc arm architecture and clock
    drivers
  ARM: multi_v7_defconfig: Enable ARCH_BCM_CYGNUS config

 .../devicetree/bindings/arm/bcm/cygnus.txt         |   31 +
 .../devicetree/bindings/clock/clk-cygnus.txt       |  121 ++
 .../devicetree/bindings/clock/clk-iproc.txt        |   48 +
 MAINTAINERS                                        |   17 +-
 arch/arm/Kconfig.debug                             |    2 +-
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |  349 ++++++
 arch/arm/boot/dts/bcm911360_entphn.dts             |   22 +
 arch/arm/configs/bcm_cygnus_defconfig              |  221 ++++
 arch/arm/configs/multi_v7_defconfig                |    1 +
 arch/arm/mach-bcm/Kconfig                          |   68 +-
 arch/arm/mach-bcm/Makefile                         |    3 +
 arch/arm/mach-bcm/bcm_cygnus.c                     |   26 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/bcm/Makefile                           |    2 +
 drivers/clk/bcm/clk-cygnus.c                       | 1186 ++++++++++++++++++++
 drivers/clk/bcm/clk-iproc.c                        |  451 ++++++++
 17 files changed, 2527 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/cygnus.txt
 create mode 100644 Documentation/devicetree/bindings/clock/clk-cygnus.txt
 create mode 100644 Documentation/devicetree/bindings/clock/clk-iproc.txt
 create mode 100644 arch/arm/boot/dts/bcm-cygnus.dtsi
 create mode 100644 arch/arm/boot/dts/bcm911360_entphn.dts
 create mode 100644 arch/arm/configs/bcm_cygnus_defconfig
 create mode 100644 arch/arm/mach-bcm/bcm_cygnus.c
 create mode 100644 drivers/clk/bcm/clk-cygnus.c
 create mode 100644 drivers/clk/bcm/clk-iproc.c

-- 
1.7.9.5

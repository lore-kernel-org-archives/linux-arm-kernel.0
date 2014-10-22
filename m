From: sbranden@broadcom.com (Scott Branden)
Date: Wed, 22 Oct 2014 13:57:47 -0700
Subject: [PATCH v7 0/7] Add initial support for Broadcom Cygnus SoC
In-Reply-To: <Scott Branden <sbranden@broadcom.com>
References: <Scott Branden <sbranden@broadcom.com>
Message-ID: <1414011474-11821-1-git-send-email-sbranden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains initial support for Broadcom's Cygnus SoC based on our
iProc architecture. Initial support is minimal and includes just the mach
platform code, clock driver, and a basic device tree configuration. Peripheral
drivers will be submitted soon, as will device tree configurations for other
Cygnus board variants.

Changes from v6:
 - Additional patch added for cleanup of other areas of mach-bcm/Kconfig
   discovered during Cygnus submission review to:
   - removed one level of menu for ARCH_BCM_MOBILE in mach-bcm-Kconfig based
     on feedback from Arnd
   - added comment sections to Kconfig to identify SoC architecture groupings

Changes from v5:
 - removed one level of menu used in mach-bcm/Kconfig
 - changed MAINTAINERS to use N: to support all files associated with iproc
   and cygnus going forward
 - updated bcm_cygnus_defconfig to remove some DEBUG options that greatly
   hamper performance

Changes from v4:
 - simple clock tree used. reworked clock driver will be submitted later
 - fixed MAINTAINERS patchset error
 - removed DEBUG_UART_8250 Kconfig.debug legacy support
 - made ARCH_BCM_IPROC a silent Kconfig option
 - removed multi_v7_defconfig as it is not needed at this time, can
   support in future patchset but does not seem optimal configs for our
   current usage.
 
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

Jonathan Richardson (3):
  ARM: cygnus: Initial support for Broadcom Cygnus SoC
  dt-bindings: Document Broadcom Cygnus SoC and clocks
  ARM: cygnus defconfig : Initial defconfig for Broadcom Cygnus SoC

Scott Branden (4):
  ARM: dts: Enable Broadcom Cygnus SoC
  MAINTAINERS: Entry for Cygnus/iproc arm architecture
  ARM: mach-bcm: Consolidate currently supported IPROC SoCs
  ARM: mach-bcm: ARCH_BCM_MOBILE: remove one level of menu from Kconfig

 .../devicetree/bindings/arm/bcm/cygnus.txt         |   31 +++
 .../devicetree/bindings/clock/bcm-cygnus-clock.txt |   34 +++
 MAINTAINERS                                        |   14 ++
 arch/arm/boot/dts/Makefile                         |    4 +
 arch/arm/boot/dts/bcm-cygnus-clock.dtsi            |   73 ++++++
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |  109 +++++++++
 arch/arm/boot/dts/bcm911360_entphn.dts             |   22 ++
 arch/arm/boot/dts/bcm911360k.dts                   |   22 ++
 arch/arm/boot/dts/bcm958300k.dts                   |   22 ++
 arch/arm/configs/bcm_cygnus_defconfig              |  237 ++++++++++++++++++++
 arch/arm/configs/bcm_defconfig                     |    3 +-
 arch/arm/configs/multi_v7_defconfig                |    3 +-
 arch/arm/mach-bcm/Kconfig                          |   93 +++++---
 arch/arm/mach-bcm/Makefile                         |    3 +
 arch/arm/mach-bcm/bcm_cygnus.c                     |   26 +++
 15 files changed, 658 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/cygnus.txt
 create mode 100644 Documentation/devicetree/bindings/clock/bcm-cygnus-clock.txt
 create mode 100644 arch/arm/boot/dts/bcm-cygnus-clock.dtsi
 create mode 100644 arch/arm/boot/dts/bcm-cygnus.dtsi
 create mode 100644 arch/arm/boot/dts/bcm911360_entphn.dts
 create mode 100644 arch/arm/boot/dts/bcm911360k.dts
 create mode 100644 arch/arm/boot/dts/bcm958300k.dts
 create mode 100644 arch/arm/configs/bcm_cygnus_defconfig
 create mode 100644 arch/arm/mach-bcm/bcm_cygnus.c

-- 
1.7.9.5

From: marc.ceeeee@gmail.com (Marc Carino)
Date: Tue, 14 Jan 2014 15:48:46 -0800
Subject: [PATCH v3 0/7] ARM: brcmstb: Add Broadcom STB SoC support
Message-ID: <1389743333-16741-1-git-send-email-marc.ceeeee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains the board support package for the
Broadcom BCM7445 ARM-based SoC [1]. These changes contain a
minimal set of code needed for a BCM7445-based board to boot
the Linux kernel.

These changes heavily leverage the OF/devicetree framework.

v3:
- rebased to v3.13-rc8
- switched to using 'multi_v7_defconfig'
- eliminated dependence on compile-time peripheral register access
- moved DT node iomap out from 'init_early'
- misc. minor cleanups from mailing-list discussion for v2

v2:
- rebased to v3.13-rc1
- moved implementation to 'mach-bcm' folder
- added CPU init for B15

v1:
- initial submission

[1] http://www.broadcom.com/products/Cable/Cable-Set-Top-Box-Solutions/BCM7445

Marc Carino (7):
  ARM: brcmstb: add infrastructure for ARM-based Broadcom STB SoCs
  ARM: brcmstb: add debug UART for earlyprintk support
  ARM: do CPU-specific init for Broadcom Brahma15 cores
  ARM: brcmstb: add CPU binding for Broadcom Brahma15
  ARM: brcmstb: add misc. DT bindings for brcm,brcmstb-*
  ARM: brcmstb: gic: add compatible string for Broadcom Brahma15
  ARM: brcmstb: dts: add a reference DTS for Broadcom 7445

 .../devicetree/bindings/arm/brcm-brcmstb.txt       |   43 ++++
 Documentation/devicetree/bindings/arm/cpus.txt     |    1 +
 Documentation/devicetree/bindings/arm/gic.txt      |    1 +
 arch/arm/Kconfig.debug                             |   16 ++-
 arch/arm/boot/dts/brcmstb-7445.dts                 |  104 ++++++++
 arch/arm/configs/multi_v7_defconfig                |    1 +
 arch/arm/mach-bcm/Kconfig                          |   14 +
 arch/arm/mach-bcm/Makefile                         |    4 +
 arch/arm/mach-bcm/brcmstb.c                        |  146 +++++++++++
 arch/arm/mach-bcm/brcmstb.h                        |   46 ++++
 arch/arm/mach-bcm/headsmp-brcmstb.S                |   34 +++
 arch/arm/mach-bcm/hotplug-brcmstb.c                |  252 ++++++++++++++++++++
 arch/arm/mm/proc-v7.S                              |   11 +
 13 files changed, 672 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/brcm-brcmstb.txt
 create mode 100644 arch/arm/boot/dts/brcmstb-7445.dts
 create mode 100644 arch/arm/mach-bcm/brcmstb.c
 create mode 100644 arch/arm/mach-bcm/brcmstb.h
 create mode 100644 arch/arm/mach-bcm/headsmp-brcmstb.S
 create mode 100644 arch/arm/mach-bcm/hotplug-brcmstb.c

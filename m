From: marc.ceeeee@gmail.com (Marc C)
Date: Fri, 22 Nov 2013 17:20:39 -0800
Subject: [PATCH RESEND 0/5] ARM: brcmstb: Add Broadcom STB SoC support
Message-ID: <529002E7.6030603@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains the board support package for the
Broadcom BCM7445 ARM-based SoC [1]. These changes contain a
minimal set of code needed for a BCM7445-based board to boot
the Linux kernel.

These changes heavily leverage the OF/devicetree framework.

(The previous send had broken indentation. Resending. Sorry for the noise.)

[1] 
http://www.broadcom.com/products/Cable/Cable-Set-Top-Box-Solutions/BCM7445

Marc Carino (5):
   ARM: brcmstb: add infrastructure for ARM-based Broadcom STB SoCs
   ARM: brcmstb: add CPU binding for Broadcom Brahma15
   ARM: brcmstb: add misc. DT bindings for brcm,brcmstb
   ARM: brcmstb: gic: add compatible string for Broadcom Brahma15
   ARM: brcmstb: dts: add a reference DTS for Broadcom 7445

  .../devicetree/bindings/arm/brcm-brcmstb.txt       |   72 +++++++
  Documentation/devicetree/bindings/arm/cpus.txt     |    1 +
  Documentation/devicetree/bindings/arm/gic.txt      |    1 +
  arch/arm/Kconfig                                   |    2 +
  arch/arm/Kconfig.debug                             |   16 ++-
  arch/arm/Makefile                                  |    1 +
  arch/arm/boot/dts/brcmstb-7445.dts                 |  115 +++++++++++
  arch/arm/configs/brcmstb_defconfig                 |  126 ++++++++++++
  arch/arm/mach-brcmstb/Kconfig                      |   24 +++
  arch/arm/mach-brcmstb/Makefile                     |   13 ++
  arch/arm/mach-brcmstb/common.c                     |  153 ++++++++++++++
  arch/arm/mach-brcmstb/common.h                     |   74 +++++++
  arch/arm/mach-brcmstb/headsmp.S                    |   33 +++
  arch/arm/mach-brcmstb/hotplug.c                    |  208 
++++++++++++++++++++
  arch/arm/mach-brcmstb/platsmp.c                    |   79 ++++++++
  15 files changed, 917 insertions(+), 1 deletions(-)
  create mode 100644 Documentation/devicetree/bindings/arm/brcm-brcmstb.txt
  create mode 100644 arch/arm/boot/dts/brcmstb-7445.dts
  create mode 100644 arch/arm/configs/brcmstb_defconfig
  create mode 100644 arch/arm/mach-brcmstb/Kconfig
  create mode 100644 arch/arm/mach-brcmstb/Makefile
  create mode 100644 arch/arm/mach-brcmstb/common.c
  create mode 100644 arch/arm/mach-brcmstb/common.h
  create mode 100644 arch/arm/mach-brcmstb/headsmp.S
  create mode 100644 arch/arm/mach-brcmstb/hotplug.c
  create mode 100644 arch/arm/mach-brcmstb/platsmp.c

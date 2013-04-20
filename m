From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 20 Apr 2013 15:55:24 +0200
Subject: [RESEND PATCH 00/12] Integrator/AP PCI DT mappings
Message-ID: <1366466124-15336-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a resend of this patch series - it appears that the mail
servers do not like that I'm sending my mails from a certain
mail server. Retry using the apropriate linaro.org SMTP
server.

Linus Walleij (12):
  Documentation/devicetree: add a small note on PCI
  ARM: pci: create pci_common_init_dev()
  ARM: integrator: merge PCIv3 driver into one file
  ARM: integrator: convert PCIv3 bridge to platform device
  ARM: integrator: grab PCI error IRQ in probe()
  ARM: integrator: move PCI base address grab to probe
  ARM: integrator: move V3 register definitions into driver
  ARM: integrator: remap PCIv3 base dynamically
  ARM: integrator: move VGA base assignment
  ARM: integrator: move static ioremapping into PCIv3 driver
  ARM: integrator: basic PCIv3 device tree support
  ARM: integrator: get PCI device IRQs from device tree

 Documentation/devicetree/bindings/pci/pci.txt      |   9 +
 .../devicetree/bindings/pci/v3-v360epc-pci.txt     |  15 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/integratorap.dts                 |  41 ++
 arch/arm/include/asm/hardware/pci_v3.h             | 186 --------
 arch/arm/include/asm/mach/pci.h                    |  17 +-
 arch/arm/kernel/bios32.c                           |   9 +-
 arch/arm/mach-integrator/Makefile                  |   2 +-
 arch/arm/mach-integrator/include/mach/platform.h   |  23 -
 arch/arm/mach-integrator/integrator_ap.c           |  31 +-
 arch/arm/mach-integrator/pci.c                     | 113 -----
 arch/arm/mach-integrator/pci_v3.c                  | 521 +++++++++++++++++++--
 arch/arm/mach-integrator/pci_v3.h                  |   2 +
 13 files changed, 564 insertions(+), 406 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/pci.txt
 create mode 100644 Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt
 delete mode 100644 arch/arm/include/asm/hardware/pci_v3.h
 delete mode 100644 arch/arm/mach-integrator/pci.c
 create mode 100644 arch/arm/mach-integrator/pci_v3.h

-- 
1.8.1.4

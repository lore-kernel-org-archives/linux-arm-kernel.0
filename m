From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 12 May 2015 16:28:18 -0700
Subject: [PATCH v3 0/5] AHCI and SATA PHY support for Broadcom STB SoCs
Message-ID: <1431473303-18873-1-git-send-email-computersforpeace@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Few changes since v2, and the changes are *only* to the SATA driver, not to any
of the DT bindings or the PHY driver. I'm resending the whole series for
completeness.

I'll list the changelog in each patch, but in summary:

v2 -> v3:
 - straighten out endianness for big endian MIPS and ARM in AHCI driver
 - rename sata_brcmstb.c to ahci_brcmstb.c
 - bind ahci_brcmstb.c against the specific string, "brcm,bcm7445-ahci" instead
   of the generic one

Brian

Brian Norris (5):
  Documentation: devicetree: add Broadcom SATA binding
  Documentation: devicetree: add Broadcom SATA PHY binding
  ata: add Broadcom AHCI SATA3 driver for STB chips
  phy: add Broadcom SATA3 PHY driver for Broadcom STB SoCs
  ARM: dts: brcmstb: add nodes for SATA controller and PHY

 .../devicetree/bindings/ata/brcm,sata-brcmstb.txt  |  35 +++
 .../bindings/phy/brcm,brcmstb-sata-phy.txt         |  40 +++
 arch/arm/boot/dts/bcm7445.dtsi                     |  37 +++
 drivers/ata/Kconfig                                |   9 +
 drivers/ata/Makefile                               |   1 +
 drivers/ata/ahci_brcmstb.c                         | 322 +++++++++++++++++++++
 drivers/phy/Kconfig                                |   9 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-brcmstb-sata.c                     | 216 ++++++++++++++
 9 files changed, 670 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,brcmstb-sata-phy.txt
 create mode 100644 drivers/ata/ahci_brcmstb.c
 create mode 100644 drivers/phy/phy-brcmstb-sata.c

-- 
1.9.1

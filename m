From: yendapally.reddy@broadcom.com (Yendapally Reddy Dhananjaya Reddy)
Date: Thu, 16 Jun 2016 09:53:28 -0400
Subject: [PATCH 0/7] Add SATA3 support for Broadcom NSP SoC
Message-ID: <1466085215-10246-1-git-send-email-yendapally.reddy@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds support for SATA3 interface available in Broadcom
NSP SoC.

The first patch removes the "stb" references in the ahci documentation
to make it generic for Broadcom SoC's. The second patch adds NSP support
to the ahci documentation. The third patch adds the NSP SATA phy
documentation.

The fourth patch renames the Broadcom stb ahci driver to common Broadcom
ahci driver and fifth patch supports NSP ahci. The sixth patch adds
support for NSP SATA3 phy.

The seventh patch contains the device tree changes for NSP SoC.

This patch set has been tested on NSP bcm958625HR board.
This patch set is based on v4.7.0-rc1 and is available from github
repo: https://github.com/Broadcom/cygnus-linux.git
branch: nsp-sata-v1

Yendapally Reddy Dhananjaya Reddy (7):
  dt-bindings: ata: rename brcm,sata-brcmstb.txt to brcm,sata-brcm.txt
  dt-bindings: ata: add support for Broadcom NSP SoC ahci
  dt-bindings: phy: Add documentation for NSP SATA PHY
  ata: ahci_brcmstb: rename to support across Broadcom SoC's
  ata: ahci_brcm: Add support for Broadcom NSP SoC
  phy: Add SATA3 PHY support for Broadcom NSP SoC
  ARM: dts: nsp: Add sata device tree entry

 .../{brcm,sata-brcmstb.txt => brcm,sata-brcm.txt}  |  9 +--
 .../devicetree/bindings/phy/brcm-sata-phy.txt      |  4 +-
 arch/arm/boot/dts/bcm-nsp.dtsi                     | 42 +++++++++++
 arch/arm/boot/dts/bcm958625k.dts                   | 12 ++++
 drivers/ata/Kconfig                                |  8 +--
 drivers/ata/Makefile                               |  2 +-
 drivers/ata/{ahci_brcmstb.c => ahci_brcm.c}        | 46 +++++++++---
 drivers/phy/phy-brcm-sata.c                        | 81 ++++++++++++++++++++++
 8 files changed, 184 insertions(+), 20 deletions(-)
 rename Documentation/devicetree/bindings/ata/{brcm,sata-brcmstb.txt => brcm,sata-brcm.txt} (81%)
 rename drivers/ata/{ahci_brcmstb.c => ahci_brcm.c} (91%)

-- 
2.1.0

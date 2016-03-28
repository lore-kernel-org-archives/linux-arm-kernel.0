From: anup.patel@broadcom.com (Anup Patel)
Date: Mon, 28 Mar 2016 10:18:25 +0530
Subject: [PATCH v2 0/5] Add SATA3 support for Broadcom NS2 SVK
Message-ID: <1459140510-5317-1-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Broadcom NS2 SoC has a AHCI compliant SATA3 controller with
two ports.

This patchset adds common Broadcom SATA3 PHY driver and related
DT bindings document. It also adds appropriate DT nodes in NS2 DT.

The patchset is based on v4.6-rc1 tag and is available in branch
ns2_sata3_v2 of https://github.com/Broadcom/arm64-linux.git

All patches have been tested on Broadcom NS2 SVK.

Changes since v1:
 - Added ACKed by Rob for DT bindings related patches

Anup Patel (5):
  phy: Rename phy-brcmstb-sata driver to phy-brcm-sata driver
  phy: Add support for NS2 SATA3 PHY in Broadcom SATA3 PHY driver
  dt-bindings: phy: bindings document for common Broadcom SATA3 PHY
    driver
  dt-bindings: ata: add compatible string for iProc AHCI controller
  arm64: dts: Add SATA3 AHCI and SATA3 PHY DT nodes for NS2

 .../devicetree/bindings/ata/ahci-platform.txt      |   1 +
 ...brcm,brcmstb-sata-phy.txt => brcm-sata-phy.txt} |  15 +-
 arch/arm64/boot/dts/broadcom/ns2-svk.dts           |  12 +
 arch/arm64/boot/dts/broadcom/ns2.dtsi              |  43 +++
 drivers/phy/Kconfig                                |  18 +-
 drivers/phy/Makefile                               |   2 +-
 drivers/phy/phy-brcm-sata.c                        | 412 +++++++++++++++++++++
 drivers/phy/phy-brcmstb-sata.c                     | 250 -------------
 8 files changed, 487 insertions(+), 266 deletions(-)
 rename Documentation/devicetree/bindings/phy/{brcm,brcmstb-sata-phy.txt => brcm-sata-phy.txt} (69%)
 create mode 100644 drivers/phy/phy-brcm-sata.c
 delete mode 100644 drivers/phy/phy-brcmstb-sata.c

-- 
1.9.1

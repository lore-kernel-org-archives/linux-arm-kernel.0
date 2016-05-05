From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu,  5 May 2016 12:14:58 -0700
Subject: [PATCH v2 0/2] pci: host: Broadcom STB PCIE RC controller support
Message-ID: <1462475700-1654-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patch series adds support for Broadcom STB SoC's PCIe root complex driver.

This was primarily tested on BCM7445 (ARM) and BCM7435 (MIPS).

Jim is the original author, and I picked up our downstream 4.1 driver and
updated it to utilize the non-ARM hw_pci functions as well as made some
stylistic changes.

Thanks!

Jim Quinlan (2):
  Documentation: DT: bindings: Add Broadcom STB PCIe bindings
  pci: host: Add Broadcom STB PCIE RC controller

 .../devicetree/bindings/pci/brcm,brcmstb-pcie.txt  |  98 +++
 MAINTAINERS                                        |   1 +
 drivers/pci/host/Kconfig                           |  17 +
 drivers/pci/host/Makefile                          |   2 +
 drivers/pci/host/pcie-brcmstb-msi.c                | 305 ++++++++
 drivers/pci/host/pcie-brcmstb.c                    | 772 +++++++++++++++++++++
 drivers/pci/host/pcie-brcmstb.h                    | 169 +++++
 7 files changed, 1364 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/brcm,brcmstb-pcie.txt
 create mode 100644 drivers/pci/host/pcie-brcmstb-msi.c
 create mode 100644 drivers/pci/host/pcie-brcmstb.c
 create mode 100644 drivers/pci/host/pcie-brcmstb.h

-- 
2.1.0

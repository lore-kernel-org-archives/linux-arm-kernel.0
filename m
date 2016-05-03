From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon,  2 May 2016 18:25:47 -0700
Subject: [PATCH 0/2] pci: host: Broadcom STB PCIE RC controller support
Message-ID: <1462238749-19715-1-git-send-email-f.fainelli@gmail.com>
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

 .../devicetree/bindings/pci/brcm,brcmstb-pcie.txt  |   81 ++
 MAINTAINERS                                        |    1 +
 drivers/pci/host/Kconfig                           |    9 +
 drivers/pci/host/Makefile                          |    1 +
 drivers/pci/host/pcie-brcmstb.c                    | 1243 ++++++++++++++++++++
 5 files changed, 1335 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/brcm,brcmstb-pcie.txt
 create mode 100644 drivers/pci/host/pcie-brcmstb.c

-- 
2.1.0

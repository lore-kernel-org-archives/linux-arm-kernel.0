From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 26 Apr 2016 10:31:44 +0200
Subject: [PATCH v3 0/2] pci: host: new driver for Marvell Armada 7K/8K PCIe
 controller
Message-ID: <1461659506-10387-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Here is the third iteration of the PCIe host controller driver needed
for the ARM64 Marvell Armada 7K/8K platform.

Changes since v2:

 - Added Rob Herring's Acked-by on the Device Tree binding patch.

 - Reworked the PCIe host driver following the suggestion of Bjorn
   Helgaas: creation of armada8k_add_pcie_port() and
   armada8k_pcie_establish_link() in order to follow the convention of
   other Designware based drivers.

Thanks!

Thomas

Thomas Petazzoni (2):
  dt-bindings: pci: add DT binding for Marvell Armada 7K/8K PCIe
    controller
  pci: host: new driver for Marvell Armada 7K/8K PCIe controller

 .../devicetree/bindings/pci/pci-armada8k.txt       |  38 +++
 drivers/pci/host/Kconfig                           |  11 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pcie-armada8k.c                   | 276 +++++++++++++++++++++
 4 files changed, 326 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/pci-armada8k.txt
 create mode 100644 drivers/pci/host/pcie-armada8k.c

-- 
2.6.4

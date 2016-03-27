From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 27 Mar 2016 11:30:56 +0200
Subject: [PATCH 0/2] pci: host: new driver for Marvell Armada 7K/8K PCIe
 controller
Message-ID: <1459071058-18328-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This set of two patches add support for the PCIe controller found in
the Marvell Armada 7K/8K ARM processors. The first patch adds the
Device Tree binding documentation, the second patch the driver itself.

The driver is really simple, since the PCIe controller is based on the
Designware design, and only a little bit of vendor-specific glue is
needed.

Thanks!

Thomas

Thomas Petazzoni (2):
  dt-bindings: pci: add DT binding for Marvell Armada 7K/8K PCIe
    controller
  pci: host: new driver for Marvell Armada 7K/8K PCIe controller

 .../devicetree/bindings/pci/pci-armada8k.txt       |  41 ++++
 drivers/pci/host/Kconfig                           |  11 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pcie-armada8k.c                   | 261 +++++++++++++++++++++
 4 files changed, 314 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/pci-armada8k.txt
 create mode 100644 drivers/pci/host/pcie-armada8k.c

-- 
2.6.4

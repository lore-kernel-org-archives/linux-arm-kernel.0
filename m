From: ddaney.cavm@gmail.com (David Daney)
Date: Thu, 17 Sep 2015 11:00:57 -0700
Subject: [PATCH 0/2] irqchip/gicv3-its: Handle "msi-map" properties.
Message-ID: <1442512859-31633-1-git-send-email-ddaney.cavm@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Daney <david.daney@cavium.com>

The first patch from Mark Rutland adds the OF device tree binding
description, which explains what we are attempting to do here.  For
MSI messages on GICv3 systems there is some side-band data that
accompanies the message, this data is specified in the OF device tree
"msi-map" property of the PCI host driver.

The second patch parses the required information out of the device tree.

David Daney (1):
  irqchip/gicv3-its:  Handle OF device tree "msi-map" properties.

Mark Rutland (1):
  Docs: dt: Add PCI MSI map bindings

 Documentation/devicetree/bindings/pci/pci-msi.txt | 220 ++++++++++++++++++++++
 drivers/irqchip/irq-gic-v3-its-pci-msi.c          |  73 +++++++
 2 files changed, 293 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/pci-msi.txt

-- 
1.9.1

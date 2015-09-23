From: ddaney.cavm@gmail.com (David Daney)
Date: Tue, 22 Sep 2015 17:00:03 -0700
Subject: [PATCH v2 0/3] of, irqchip/gicv3-its: Handle "msi-map" properties.
Message-ID: <1442966406-13198-1-git-send-email-ddaney.cavm@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Daney <david.daney@cavium.com>

The first patch from Mark Rutland adds the OF device tree binding
description, which explains what we are attempting to do here.  For
MSI messages on GICv3 systems there is some side-band data that
accompanies the message, this data is specified in the OF device tree
"msi-map" property of the PCI host driver.

The second patch adds a parser to get the required information out of
the device tree.

The third and final patch adds the "msi-map" parsing to gicv3-its.

Changes from v1: Factor out the device tree access code to a separate
function in drivers/of/irq.c

David Daney (2):
  of/irq: Add new function of_msi_map_rid()
  irqchip/gicv3-its:  Handle OF device tree "msi-map" properties.

Mark Rutland (1):
  Docs: dt: Add PCI MSI map bindings

 Documentation/devicetree/bindings/pci/pci-msi.txt | 220 ++++++++++++++++++++++
 drivers/irqchip/irq-gic-v3-its-pci-msi.c          |   3 +-
 drivers/of/irq.c                                  |  86 +++++++++
 include/linux/of_irq.h                            |   7 +
 4 files changed, 315 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pci/pci-msi.txt

-- 
1.9.1

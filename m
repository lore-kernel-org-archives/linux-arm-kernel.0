From: bhelgaas@google.com (Bjorn Helgaas)
Date: Fri, 08 Jan 2016 09:53:55 -0600
Subject: [PATCH 0/2] PCI: dra7xx: Mark driver broken and remove
Message-ID: <20160108153427.32755.63673.stgit@bhelgaas-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dra7xx driver in the mainline tree doesn't work because of a device
reset issue.  I intend to send the first patch (Richard's change to mark it
BROKEN) to Linus now for inclusion in v4.4.

We can talk about including the second patch (to remove the driver
altogether) in v4.5 (unless the reset issue is resolved, of course).

---

Bjorn Helgaas (1):
      PCI: dra7xx: Remove non-working driver

Richard Cochran (1):
      PCI: dra7xx: Mark driver as broken


 Documentation/devicetree/bindings/pci/ti-pci.txt |   62 --
 MAINTAINERS                                      |    8 
 drivers/pci/host/Kconfig                         |    9 
 drivers/pci/host/Makefile                        |    1 
 drivers/pci/host/pci-dra7xx.c                    |  571 ----------------------
 5 files changed, 651 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/ti-pci.txt
 delete mode 100644 drivers/pci/host/pci-dra7xx.c

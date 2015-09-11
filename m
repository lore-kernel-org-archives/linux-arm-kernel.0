From: ddaney.cavm@gmail.com (David Daney)
Date: Fri, 11 Sep 2015 16:21:53 -0700
Subject: [PATCH 0/6] PCI: generic: Misc. bug fixes and enhanced support for
 MSI.
Message-ID: <1442013719-5001-1-git-send-email-ddaney.cavm@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Daney <david.daney@cavium.com>

While using the pci-host-generic driver to add PCI support for the
Cavium ThunderX processors, several bugs were discovered.  We also
need the ability to specify a per-bus MSI controller, so support for
that was added.

David Daney (6):
  PCI: Make global and export pdev_fixup_irq().
  PCI: generic: Only fixup irqs for bus we are creating.
  PCI: generic: Quit clobbering our pci_ops.
  PCI: generic: Correct, and avoid overflow, in bus_max calculation.
  PCI: generic: Pass proper starting bus number to pci_scan_root_bus().
  PCI: generic: Allow bus default MSI controller to be specified.

 .../devicetree/bindings/pci/host-generic-pci.txt   |  5 ++
 drivers/pci/host/pci-host-generic.c                | 55 +++++++++++++++-------
 drivers/pci/setup-irq.c                            |  7 +--
 include/linux/pci.h                                |  3 ++
 4 files changed, 50 insertions(+), 20 deletions(-)

-- 
1.7.11.7

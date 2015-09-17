From: ddaney.cavm@gmail.com (David Daney)
Date: Thu, 17 Sep 2015 15:02:07 -0700
Subject: [PATCH v2 0/5] PCI: generic: Misc. bug fixes
Message-ID: <1442527332-1174-1-git-send-email-ddaney.cavm@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Daney <david.daney@cavium.com>

While using the pci-host-generic driver to add PCI support for the
Cavium ThunderX processors, several bugs were discovered.  This patch
set fixes the bugs, a follow-on set will add the ThunderX support.

Changes from v1:

  - "PCI: generic: Allow bus default MSI controller to be specified."
    patch was dropped as it is no longer necessary.

  - "PCI: Make global and export pdev_fixup_irq()." and "PCI: generic:
    Only fixup irqs for bus we are creating." were rewritten to move
    the support into a somewhat more generic form in setup-irq.c.

  - Add some clarifying text to host-generic-pci.txt

  - Add some Acked-by:

David Daney (5):
  PCI: Add pci_bus_fixup_irqs().
  PCI: generic: Only fixup irqs for bus we are creating.
  PCI: generic: Quit clobbering our pci_ops.
  PCI: generic: Correct, and avoid overflow, in bus_max calculation.
  PCI: generic: Pass proper starting bus number to pci_scan_root_bus().

 .../devicetree/bindings/pci/host-generic-pci.txt   |  4 ++-
 drivers/pci/host/pci-host-generic.c                | 38 ++++++++++++----------
 drivers/pci/setup-irq.c                            | 30 +++++++++++++++++
 include/linux/pci.h                                |  4 +++
 4 files changed, 58 insertions(+), 18 deletions(-)

-- 
1.9.1

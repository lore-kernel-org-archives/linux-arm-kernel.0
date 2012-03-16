From: bhelgaas@google.com (Bjorn Helgaas)
Date: Fri, 16 Mar 2012 17:48:04 -0600
Subject: [PATCH v2 2/7] arm/PCI: don't export pci_flags
In-Reply-To: <20120316234653.6649.59492.stgit@bhelgaas.mtv.corp.google.com>
References: <20120316234653.6649.59492.stgit@bhelgaas.mtv.corp.google.com>
Message-ID: <20120316234804.6649.3554.stgit@bhelgaas.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's no need to export pci_flags; it's not exported by any other
architecture, and no modules reference it.

CC: Rob Herring <rob.herring@calxeda.com>
CC: Russell King <linux@arm.linux.org.uk>
CC: linux-arm-kernel at lists.infradead.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/arm/kernel/bios32.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index be5d3b2..632df9a 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -498,7 +498,6 @@ void __init pci_common_init(struct hw_pci *hw)
 		pci_bus_add_devices(bus);
 	}
 }
-EXPORT_SYMBOL(pci_flags);
 
 #ifndef CONFIG_PCI_HOST_ITE8152
 void pcibios_set_master(struct pci_dev *dev)

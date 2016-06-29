From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 29 Jun 2016 04:27:34 -0400
Subject: [PATCH V2 0/4] ACPI,PCI,IRQ: correct ISA penalty calculation
Message-ID: <1467188859-28188-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 103544d86976 ("ACPI,PCI,IRQ: reduce resource requirements")
the penalty values are calculated on the fly rather than boot time.

This works fine for PCI interrupts but not so well for the ISA interrupts.
Whether an ISA interrupt is in use or not information is not available
inside the pci_link.c file. This information gets sent externally via
acpi_penalize_isa_irq function. If active is true, then the IRQ is in use
by ISA. Otherwise, IRQ is in use by PCI.

Sinan Kaya (4):
  ACPI,PCI,IRQ: factor in PCI possible
  Revert "ACPI,PCI,IRQ: remove redundant code in
    acpi_irq_penalty_init()"
  ACPI,PCI,IRQ: separate ISA penalty calculation
  ACPI,PCI,IRQ: correct operator precedence

 arch/x86/pci/acpi.c         |  1 +
 drivers/acpi/pci_link.c     | 65 ++++++++++++++++++++++++++++++++++-----------
 include/acpi/acpi_drivers.h |  1 +
 3 files changed, 51 insertions(+), 16 deletions(-)

-- 
1.8.2.1

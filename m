From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 29 Jun 2016 04:27:38 -0400
Subject: [PATCH V2 4/4] ACPI,PCI,IRQ: correct operator precedence
In-Reply-To: <1467188859-28188-1-git-send-email-okaya@codeaurora.org>
References: <1467188859-28188-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1467188859-28188-5-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The omitted parenthesis prevents the addition operation when
acpi_penalize_isa_irq function is called.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/acpi/pci_link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 8c08971..c983bf7 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -872,7 +872,7 @@ void acpi_penalize_isa_irq(int irq, int active)
 {
 	if ((irq >= 0) && (irq < ARRAY_SIZE(acpi_isa_irq_penalty)))
 		acpi_isa_irq_penalty[irq] = acpi_irq_get_penalty(irq) +
-			active ? PIRQ_PENALTY_ISA_USED : PIRQ_PENALTY_PCI_USING;
+		  (active ? PIRQ_PENALTY_ISA_USED : PIRQ_PENALTY_PCI_USING);
 }
 
 bool acpi_isa_irq_available(int irq)
-- 
1.8.2.1

From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 17 Jun 2016 16:05:05 +0100
Subject: [PATCH 1/9] ARM/PCI: Add declaration of pcibios_report_status
In-Reply-To: <1466175913-19067-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1466175913-19067-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1466175913-19067-2-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function pcibios_report_status() needs a declaration to avoid
the following warning, so declare it in <asm/pci.h>.

/home/ben/kernel/linux/arch/arm/kernel/bios32.c:58:6: warning: symbol 'pcibios_report_status' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: linux-arm-kernel at lists.infradead.org
Cc: Russell King <linux@armlinux.org.uk>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/arm/include/asm/pci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/pci.h b/arch/arm/include/asm/pci.h
index 057d381..4b5ea93 100644
--- a/arch/arm/include/asm/pci.h
+++ b/arch/arm/include/asm/pci.h
@@ -37,5 +37,7 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 	return channel ? 15 : 14;
 }
 
+extern void pcibios_report_status(unsigned int status_mask, int warn);
+
 #endif /* __KERNEL__ */
 #endif
-- 
2.8.1

From: saeed@marvell.com (Saeed Bishara)
Date: Thu,  3 Jun 2010 14:58:46 +0300
Subject: [PATCH 3/4] [ARM] PCI: add platform private data to pci_sys_data
Message-ID: <1275566327-1764-1-git-send-email-saeed@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add private_data pointer to the pci_sys_data, this pointer can be
used for holding platform specific data for each pci controller.

Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 arch/arm/include/asm/mach/pci.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
index 52f0da1..16330bd 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -46,6 +46,7 @@ struct pci_sys_data {
 					/* IRQ mapping				*/
 	int		(*map_irq)(struct pci_dev *, u8, u8);
 	struct hw_pci	*hw;
+	void		*private_data;	/* platform controller private data	*/
 };
 
 /*
-- 
1.6.0.4

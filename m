From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 26 Apr 2017 12:18:04 +0100
Subject: [RFC/RFT PATCH 13/18] PCI: Add IRQ mapping function pointers to
 pci_host_bridge struct
In-Reply-To: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
References: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170426111809.19922-14-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthew Minter <matt@masarand.com>

In order to defer IRQ assignment arches must be able to register functions
to map and swizzle interrupts. These registered functions are stored in
the pci_host_bridge struct.

Signed-off-by: Matthew Minter <matt@masarand.com>
---
 include/linux/pci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 6aa0090..722a770 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -424,6 +424,8 @@ struct pci_host_bridge {
 	void *sysdata;
 	int busnr;
 	struct list_head windows;	/* resource_entry */
+	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* platform irq swizzler */
+	int (*map_irq)(const struct pci_dev *, u8, u8);
 	void (*release_fn)(struct pci_host_bridge *);
 	void *release_data;
 	struct msi_controller *msi;
-- 
2.10.0

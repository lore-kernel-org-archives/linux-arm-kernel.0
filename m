From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 23 Aug 2017 00:56:08 -0400
Subject: [PATCH V12 2/5] PCI: add pci_bus_crs_visibility_pending() function to
 detect CRS response
In-Reply-To: <1503464171-6471-1-git-send-email-okaya@codeaurora.org>
References: <1503464171-6471-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1503464171-6471-2-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need a wrapper function to determine when a particular device is
returning Configuration Request Retry Status (CRS) response. This will only
happen if the root port supports CRS visibility.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pci.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 22e0617..7fa583a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -235,6 +235,10 @@ enum pci_bar_type {
 	pci_bar_mem64,		/* A 64-bit memory BAR */
 };
 
+static inline bool pci_bus_crs_visibility_pending(u32 l)
+{
+	return (l & 0xffff) == 0x0001;
+}
 bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *pl,
 				int crs_timeout);
 int pci_setup_device(struct pci_dev *dev);
-- 
1.9.1

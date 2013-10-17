From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 17 Oct 2013 18:43:34 +0100
Subject: [PATCH v8 19/19] swiotlb-xen: static inline xen_phys_to_bus,
 xen_bus_to_phys, xen_virt_to_bus and range_straddles_page_boundary
In-Reply-To: <alpine.DEB.2.02.1310171833520.26077@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1310171833520.26077@kaball.uk.xensource.com>
Message-ID: <1382031814-8782-19-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This functions are small and called frequently. Static inline them.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 drivers/xen/swiotlb-xen.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 6d9ca61..9045517 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -72,17 +72,17 @@ static unsigned long xen_io_tlb_nslabs;
 
 static u64 start_dma_addr;
 
-static dma_addr_t xen_phys_to_bus(phys_addr_t paddr)
+static inline dma_addr_t xen_phys_to_bus(phys_addr_t paddr)
 {
 	return phys_to_machine(XPADDR(paddr)).maddr;
 }
 
-static phys_addr_t xen_bus_to_phys(dma_addr_t baddr)
+static inline phys_addr_t xen_bus_to_phys(dma_addr_t baddr)
 {
 	return machine_to_phys(XMADDR(baddr)).paddr;
 }
 
-static dma_addr_t xen_virt_to_bus(void *address)
+static inline dma_addr_t xen_virt_to_bus(void *address)
 {
 	return xen_phys_to_bus(virt_to_phys(address));
 }
@@ -105,7 +105,7 @@ static int check_pages_physically_contiguous(unsigned long pfn,
 	return 1;
 }
 
-static int range_straddles_page_boundary(phys_addr_t p, size_t size)
+static inline int range_straddles_page_boundary(phys_addr_t p, size_t size)
 {
 	unsigned long pfn = PFN_DOWN(p);
 	unsigned int offset = p & ~PAGE_MASK;
-- 
1.7.2.5

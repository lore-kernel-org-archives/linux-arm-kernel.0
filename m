From: chuck.tuffli@emulex.com (Chuck Tuffli)
Date: Sun, 21 Dec 2014 12:30:58 -0800
Subject: [PATCH] arm64: Relax licensing of arm64 Xen DMA operations
Message-ID: <d7204be5-f199-456c-9587-c87e1d8d4dd5@CMEXHTCAS1.ad.emulex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With Xen configured into the arm64 kernel, any driver allocating
DMA'able memory for PCI operations, must be GPL compatible, regardless
of its interaction with Xen. This patch relaxes the GPL requirement of
xen_dma_ops and its dependencies to allow open source drivers to be
compiled for the arm64 architecture.

Signed-off-by: Chuck Tuffli <chuck.tuffli@emulex.com>
---
 arch/arm/xen/enlighten.c | 4 ++--
 arch/arm/xen/mm.c        | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index c7ca936..263a204 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -29,10 +29,10 @@
 
 struct start_info _xen_start_info;
 struct start_info *xen_start_info = &_xen_start_info;
-EXPORT_SYMBOL_GPL(xen_start_info);
+EXPORT_SYMBOL(xen_start_info);
 
 enum xen_domain_type xen_domain_type = XEN_NATIVE;
-EXPORT_SYMBOL_GPL(xen_domain_type);
+EXPORT_SYMBOL(xen_domain_type);
 
 struct shared_info xen_dummy_shared_info;
 struct shared_info *HYPERVISOR_shared_info = (void *)&xen_dummy_shared_info;
diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index 351b24a..793551d 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -149,7 +149,7 @@ void xen_destroy_contiguous_region(phys_addr_t pstart, unsigned int order)
 EXPORT_SYMBOL_GPL(xen_destroy_contiguous_region);
 
 struct dma_map_ops *xen_dma_ops;
-EXPORT_SYMBOL_GPL(xen_dma_ops);
+EXPORT_SYMBOL(xen_dma_ops);
 
 static struct dma_map_ops xen_swiotlb_dma_ops = {
 	.mapping_error = xen_swiotlb_dma_mapping_error,
-- 
1.9.1

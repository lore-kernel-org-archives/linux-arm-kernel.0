From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 31 Jul 2013 14:51:59 +0200
Subject: [PATCH v4 4/4] ARM: init: add support for reserved memory defined by
 device tree
In-Reply-To: <1375275119-12787-1-git-send-email-m.szyprowski@samsung.com>
References: <1375275119-12787-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1375275119-12787-5-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable reserved memory initialization from device tree.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mm/init.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 15225d8..82db8d8 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -20,6 +20,7 @@
 #include <linux/highmem.h>
 #include <linux/gfp.h>
 #include <linux/memblock.h>
+#include <linux/dma-mapping.h>
 #include <linux/dma-contiguous.h>
 #include <linux/sizes.h>
 
@@ -377,6 +378,8 @@ void __init arm_memblock_init(struct meminfo *mi, struct machine_desc *mdesc)
 	if (mdesc->reserve)
 		mdesc->reserve();
 
+	dma_reserved_mem_of_reserve();
+
 	/*
 	 * reserve memory for DMA contigouos allocations,
 	 * must come from DMA area inside low memory
-- 
1.7.9.5

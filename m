From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 09 Aug 2013 13:51:59 +0200
Subject: [PATCH v5 3/3] ARM: init: add support for reserved memory defined by
 device tree
In-Reply-To: <1376049119-12655-1-git-send-email-m.szyprowski@samsung.com>
References: <1376049119-12655-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1376049119-12655-4-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable reserved memory initialization from device tree.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
Acked-by: Michal Nazarewicz <mina86@mina86.com>
---
 arch/arm/mm/init.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 15225d8..7c1c4b2 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -17,6 +17,7 @@
 #include <linux/nodemask.h>
 #include <linux/initrd.h>
 #include <linux/of_fdt.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/highmem.h>
 #include <linux/gfp.h>
 #include <linux/memblock.h>
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

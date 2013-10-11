From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 11 Oct 2013 09:27:27 +0200
Subject: [PATCH 1/2] Revert
 "ARM: init: add support for reserved memory defined by device tree"
In-Reply-To: <1381476448-14548-1-git-send-email-m.szyprowski@samsung.com>
References: <1381476448-14548-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1381476448-14548-2-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 10bcdfb8ba24760f715f0a700c3812747eddddf5. There is
no consensus on the bindings for the reserved memory, so the code for
handing it will be reverted.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mm/init.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index febaee7..18ec4c5 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -17,7 +17,6 @@
 #include <linux/nodemask.h>
 #include <linux/initrd.h>
 #include <linux/of_fdt.h>
-#include <linux/of_reserved_mem.h>
 #include <linux/highmem.h>
 #include <linux/gfp.h>
 #include <linux/memblock.h>
@@ -379,8 +378,6 @@ void __init arm_memblock_init(struct meminfo *mi,
 	if (mdesc->reserve)
 		mdesc->reserve();
 
-	early_init_dt_scan_reserved_mem();
-
 	/*
 	 * reserve memory for DMA contigouos allocations,
 	 * must come from DMA area inside low memory
-- 
1.7.9.5

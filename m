From: joshc@codeaurora.org (Josh Cartwright)
Date: Wed, 22 Jan 2014 12:58:51 -0600
Subject: [PATCH RFC 3/4] ARM: init: add support for reserved memory defined by
 device tree
In-Reply-To: <1390417133-6650-1-git-send-email-joshc@codeaurora.org>
References: <1390417133-6650-1-git-send-email-joshc@codeaurora.org>
Message-ID: <1390417133-6650-4-git-send-email-joshc@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

Enable reserved memory initialization from device tree.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Laura Abbott <lauraa@codeaurora.org>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mm/init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 403ba90..5efe0b4 100644
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
@@ -323,6 +324,8 @@ void __init arm_memblock_init(struct meminfo *mi,
 	if (mdesc->reserve)
 		mdesc->reserve();
 
+	early_init_dt_scan_reserved_mem();
+
 	/*
 	 * reserve memory for DMA contigouos allocations,
 	 * must come from DMA area inside low memory
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

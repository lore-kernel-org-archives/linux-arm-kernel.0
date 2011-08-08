From: tixy@yxit.co.uk (Jon Medhurst)
Date: Mon,  8 Aug 2011 15:28:30 +0100
Subject: [PATCH 10/12] ARM: mach-bcmring: Setup consistent dma size at boot
	time
In-Reply-To: <1312813712-22808-1-git-send-email-tixy@yxit.co.uk>
References: <1312813712-22808-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1312813712-22808-11-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
CC: Jiandong Zheng <jdzheng@broadcom.com>
CC: Scott Branden <sbranden@broadcom.com>
---
 arch/arm/mach-bcmring/include/mach/memory.h |    5 -----
 arch/arm/mach-bcmring/mm.c                  |    3 +++
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-bcmring/include/mach/memory.h b/arch/arm/mach-bcmring/include/mach/memory.h
index 15162e4..8848a5b 100644
--- a/arch/arm/mach-bcmring/include/mach/memory.h
+++ b/arch/arm/mach-bcmring/include/mach/memory.h
@@ -25,9 +25,4 @@
 
 #define PLAT_PHYS_OFFSET CFG_GLOBAL_RAM_BASE
 
-/*
- * Maximum DMA memory allowed is 14M
- */
-#define CONSISTENT_DMA_SIZE (SZ_16M - SZ_2M)
-
 #endif
diff --git a/arch/arm/mach-bcmring/mm.c b/arch/arm/mach-bcmring/mm.c
index 0f1c37e..8616876 100644
--- a/arch/arm/mach-bcmring/mm.c
+++ b/arch/arm/mach-bcmring/mm.c
@@ -13,6 +13,7 @@
 *****************************************************************************/
 
 #include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
 #include <asm/mach/map.h>
 
 #include <mach/hardware.h>
@@ -53,4 +54,6 @@ void __init bcmring_map_io(void)
 {
 
 	iotable_init(bcmring_io_desc, ARRAY_SIZE(bcmring_io_desc));
+	/* Maximum DMA memory allowed is 14M */
+	init_consistent_dma_size(14 << 20);
 }
-- 
1.7.2.5

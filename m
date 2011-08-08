From: tixy@yxit.co.uk (Jon Medhurst)
Date: Mon,  8 Aug 2011 15:28:24 +0100
Subject: [PATCH 04/12] ARM: mach-s5p64x0: Setup consistent dma size at boot
	time
In-Reply-To: <1312813712-22808-1-git-send-email-tixy@yxit.co.uk>
References: <1312813712-22808-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1312813712-22808-5-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
CC: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p64x0/include/mach/memory.h |    1 -
 arch/arm/mach-s5p64x0/cpu.c                 |    3 +++
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s5p64x0/include/mach/memory.h b/arch/arm/mach-s5p64x0/include/mach/memory.h
index 365a6eb..b14cbc3 100644
--- a/arch/arm/mach-s5p64x0/include/mach/memory.h
+++ b/arch/arm/mach-s5p64x0/include/mach/memory.h
@@ -14,6 +14,5 @@
 #define __ASM_ARCH_MEMORY_H __FILE__
 
 #define PLAT_PHYS_OFFSET		UL(0x20000000)
-#define CONSISTENT_DMA_SIZE	SZ_8M
 
 #endif /* __ASM_ARCH_MEMORY_H */
diff --git a/arch/arm/mach-s5p64x0/cpu.c b/arch/arm/mach-s5p64x0/cpu.c
index a5c0095..8a93854 100644
--- a/arch/arm/mach-s5p64x0/cpu.c
+++ b/arch/arm/mach-s5p64x0/cpu.c
@@ -20,6 +20,7 @@
 #include <linux/serial_core.h>
 #include <linux/platform_device.h>
 #include <linux/sched.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -111,6 +112,7 @@ void __init s5p6440_map_io(void)
 
 	iotable_init(s5p64x0_iodesc, ARRAY_SIZE(s5p64x0_iodesc));
 	iotable_init(s5p6440_iodesc, ARRAY_SIZE(s5p6440_iodesc));
+	init_consistent_dma_size(SZ_8M);
 }
 
 void __init s5p6450_map_io(void)
@@ -120,6 +122,7 @@ void __init s5p6450_map_io(void)
 
 	iotable_init(s5p64x0_iodesc, ARRAY_SIZE(s5p64x0_iodesc));
 	iotable_init(s5p6450_iodesc, ARRAY_SIZE(s5p6450_iodesc));
+	init_consistent_dma_size(SZ_8M);
 }
 
 /*
-- 
1.7.2.5

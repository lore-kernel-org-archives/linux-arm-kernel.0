From: tixy@yxit.co.uk (Jon Medhurst)
Date: Mon,  8 Aug 2011 15:28:25 +0100
Subject: [PATCH 05/12] ARM: mach-s5pv210: Setup consistent dma size at boot
	time
In-Reply-To: <1312813712-22808-1-git-send-email-tixy@yxit.co.uk>
References: <1312813712-22808-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1312813712-22808-6-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
CC: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv210/include/mach/memory.h |    1 -
 arch/arm/mach-s5pv210/cpu.c                 |    2 ++
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s5pv210/include/mach/memory.h b/arch/arm/mach-s5pv210/include/mach/memory.h
index 7b5fcf0..2d3cfa2 100644
--- a/arch/arm/mach-s5pv210/include/mach/memory.h
+++ b/arch/arm/mach-s5pv210/include/mach/memory.h
@@ -14,7 +14,6 @@
 #define __ASM_ARCH_MEMORY_H
 
 #define PLAT_PHYS_OFFSET		UL(0x20000000)
-#define CONSISTENT_DMA_SIZE	(SZ_8M + SZ_4M + SZ_2M)
 
 /*
  * Sparsemem support
diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/cpu.c
index 79907ec..9114572 100644
--- a/arch/arm/mach-s5pv210/cpu.c
+++ b/arch/arm/mach-s5pv210/cpu.c
@@ -20,6 +20,7 @@
 #include <linux/sysdev.h>
 #include <linux/platform_device.h>
 #include <linux/sched.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -119,6 +120,7 @@ static void s5pv210_sw_reset(void)
 void __init s5pv210_map_io(void)
 {
 	iotable_init(s5pv210_iodesc, ARRAY_SIZE(s5pv210_iodesc));
+	init_consistent_dma_size(14 << 20);
 
 	/* initialise device information early */
 	s5pv210_default_sdhci0();
-- 
1.7.2.5

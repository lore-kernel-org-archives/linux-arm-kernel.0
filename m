From: tixy@yxit.co.uk (Jon Medhurst)
Date: Mon,  8 Aug 2011 15:28:23 +0100
Subject: [PATCH 03/12] ARM: mach-s3c64xx: Setup consistent dma size at boot
	time
In-Reply-To: <1312813712-22808-1-git-send-email-tixy@yxit.co.uk>
References: <1312813712-22808-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1312813712-22808-4-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
CC: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c64xx/include/mach/memory.h |    2 --
 arch/arm/mach-s3c64xx/cpu.c                 |    2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/include/mach/memory.h b/arch/arm/mach-s3c64xx/include/mach/memory.h
index 4760cda..b704669 100644
--- a/arch/arm/mach-s3c64xx/include/mach/memory.h
+++ b/arch/arm/mach-s3c64xx/include/mach/memory.h
@@ -15,6 +15,4 @@
 
 #define PLAT_PHYS_OFFSET     UL(0x50000000)
 
-#define CONSISTENT_DMA_SIZE	SZ_8M
-
 #endif
diff --git a/arch/arm/mach-s3c64xx/cpu.c b/arch/arm/mach-s3c64xx/cpu.c
index 374e45e..8dc0576 100644
--- a/arch/arm/mach-s3c64xx/cpu.c
+++ b/arch/arm/mach-s3c64xx/cpu.c
@@ -20,6 +20,7 @@
 #include <linux/serial_core.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/dma-mapping.h>
 
 #include <mach/hardware.h>
 #include <mach/map.h>
@@ -145,6 +146,7 @@ void __init s3c64xx_init_io(struct map_desc *mach_desc, int size)
 	/* initialise the io descriptors we need for initialisation */
 	iotable_init(s3c_iodesc, ARRAY_SIZE(s3c_iodesc));
 	iotable_init(mach_desc, size);
+	init_consistent_dma_size(SZ_8M);
 
 	idcode = __raw_readl(S3C_VA_SYS + 0x118);
 	if (!idcode) {
-- 
1.7.2.5

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 10:42:36 +0000
Subject: [PATCH 2/2] MTD: sa11x0: remove definitions and code left for
 documentation purposes
Message-ID: <E1RoBvY-0005qc-FK@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

/*
 * This is here for documentation purposes only - until these people
 * submit their machine types.  It will be gone January 2005.
 */

It's now seven years after that date, so let's remove this.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mtd/maps/sa1100-flash.c |  100 ---------------------------------------
 1 files changed, 0 insertions(+), 100 deletions(-)

diff --git a/drivers/mtd/maps/sa1100-flash.c b/drivers/mtd/maps/sa1100-flash.c
index c735569..cbc3b78 100644
--- a/drivers/mtd/maps/sa1100-flash.c
+++ b/drivers/mtd/maps/sa1100-flash.c
@@ -23,106 +23,6 @@
 #include <asm/sizes.h>
 #include <asm/mach/flash.h>
 
-#if 0
-/*
- * This is here for documentation purposes only - until these people
- * submit their machine types.  It will be gone January 2005.
- */
-static struct mtd_partition consus_partitions[] = {
-	{
-		.name		= "Consus boot firmware",
-		.offset		= 0,
-		.size		= 0x00040000,
-		.mask_flags	= MTD_WRITABLE, /* force read-only */
-	}, {
-		.name		= "Consus kernel",
-		.offset		= 0x00040000,
-		.size		= 0x00100000,
-		.mask_flags	= 0,
-	}, {
-		.name		= "Consus disk",
-		.offset		= 0x00140000,
-		/* The rest (up to 16M) for jffs.  We could put 0 and
-		   make it find the size automatically, but right now
-		   i have 32 megs.  jffs will use all 32 megs if given
-		   the chance, and this leads to horrible problems
-		   when you try to re-flash the image because blob
-		   won't erase the whole partition. */
-		.size		= 0x01000000 - 0x00140000,
-		.mask_flags	= 0,
-	}, {
-		/* this disk is a secondary disk, which can be used as
-		   needed, for simplicity, make it the size of the other
-		   consus partition, although realistically it could be
-		   the remainder of the disk (depending on the file
-		   system used) */
-		 .name		= "Consus disk2",
-		 .offset	= 0x01000000,
-		 .size		= 0x01000000 - 0x00140000,
-		 .mask_flags	= 0,
-	}
-};
-
-/* Frodo has 2 x 16M 28F128J3A flash chips in bank 0: */
-static struct mtd_partition frodo_partitions[] =
-{
-	{
-		.name		= "bootloader",
-		.size		= 0x00040000,
-		.offset		= 0x00000000,
-		.mask_flags	= MTD_WRITEABLE
-	}, {
-		.name		= "bootloader params",
-		.size		= 0x00040000,
-		.offset		= MTDPART_OFS_APPEND,
-		.mask_flags	= MTD_WRITEABLE
-	}, {
-		.name		= "kernel",
-		.size		= 0x00100000,
-		.offset		= MTDPART_OFS_APPEND,
-		.mask_flags	= MTD_WRITEABLE
-	}, {
-		.name		= "ramdisk",
-		.size		= 0x00400000,
-		.offset		= MTDPART_OFS_APPEND,
-		.mask_flags	= MTD_WRITEABLE
-	}, {
-		.name		= "file system",
-		.size		= MTDPART_SIZ_FULL,
-		.offset		= MTDPART_OFS_APPEND
-	}
-};
-
-static struct mtd_partition jornada56x_partitions[] = {
-	{
-		.name		= "bootldr",
-		.size		= 0x00040000,
-		.offset		= 0,
-		.mask_flags	= MTD_WRITEABLE,
-	}, {
-		.name		= "rootfs",
-		.size		= MTDPART_SIZ_FULL,
-		.offset		= MTDPART_OFS_APPEND,
-	}
-};
-
-static void jornada56x_set_vpp(int vpp)
-{
-	if (vpp)
-		GPSR = GPIO_GPIO26;
-	else
-		GPCR = GPIO_GPIO26;
-	GPDR |= GPIO_GPIO26;
-}
-
-/*
- * Machine        Phys          Size    set_vpp
- * Consus    : SA1100_CS0_PHYS SZ_32M
- * Frodo     : SA1100_CS0_PHYS SZ_32M
- * Jornada56x: SA1100_CS0_PHYS SZ_32M jornada56x_set_vpp
- */
-#endif
-
 struct sa_subdev_info {
 	char name[16];
 	struct map_info map;
-- 
1.7.4.4

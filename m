From: jdzheng@broadcom.com (Jiandong Zheng)
Date: Mon, 7 May 2012 12:35:48 -0700
Subject: [PATCH] ARM: BCMRING: fix IO mem static mapping
Message-ID: <4FA82414.7070407@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix bcmring IO mem static mapping.

This causes bcmring booting issue since v3.2

Signed-off-by: Jiandong Zheng<jdzheng@broadcom.com  <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>>
---
   arch/arm/mach-bcmring/mm.c |   27 +++++++++++----------------
   1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-bcmring/mm.c b/arch/arm/mach-bcmring/mm.c
index 1adec78..b46ea07 100644
--- a/arch/arm/mach-bcmring/mm.c
+++ b/arch/arm/mach-bcmring/mm.c
@@ -31,24 +31,19 @@
       .type = MT_MEMORY }

   static struct map_desc bcmring_io_desc[] __initdata = {
-    IO_DESC(MM_IO_BASE_NAND, SZ_64K),    /* phys:0x28000000-0x28000FFF
virt:0xE8000000-0xE8000FFF  size:0x00010000 */
-    IO_DESC(MM_IO_BASE_UMI, SZ_64K),    /* phys:0x2C000000-0x2C000FFF
virt:0xEC000000-0xEC000FFF  size:0x00010000 */
-
       IO_DESC(MM_IO_BASE_BROM, SZ_64K),    /*
phys:0x30000000-0x3000FFFF  virt:0xF3000000-0xF300FFFF  size:0x00010000 */
-    MEM_DESC(MM_IO_BASE_ARAM, SZ_1M),    /* phys:0x31000000-0x31FFFFFF
virt:0xF3100000-0xF31FFFFF  size:0x01000000 */
-    IO_DESC(MM_IO_BASE_DMA0, SZ_1M),    /* phys:0x32000000-0x32FFFFFF
virt:0xF3200000-0xF32FFFFF  size:0x01000000 */
-    IO_DESC(MM_IO_BASE_DMA1, SZ_1M),    /* phys:0x33000000-0x33FFFFFF
virt:0xF3300000-0xF33FFFFF  size:0x01000000 */
-    IO_DESC(MM_IO_BASE_ESW, SZ_1M),    /* phys:0x34000000-0x34FFFFFF
virt:0xF3400000-0xF34FFFFF  size:0x01000000 */
-    IO_DESC(MM_IO_BASE_CLCD, SZ_1M),    /* phys:0x35000000-0x35FFFFFF
virt:0xF3500000-0xF35FFFFF  size:0x01000000 */
-    IO_DESC(MM_IO_BASE_APM, SZ_1M),    /* phys:0x36000000-0x36FFFFFF
virt:0xF3600000-0xF36FFFFF  size:0x01000000 */
-    IO_DESC(MM_IO_BASE_SPUM, SZ_1M),    /* phys:0x37000000-0x37FFFFFF
virt:0xF3700000-0xF37FFFFF  size:0x01000000 */
-    IO_DESC(MM_IO_BASE_VPM_PROG, SZ_1M),    /*
phys:0x38000000-0x38FFFFFF  virt:0xF3800000-0xF38FFFFF  size:0x01000000 */
-    IO_DESC(MM_IO_BASE_VPM_DATA, SZ_1M),    /*
phys:0x3A000000-0x3AFFFFFF  virt:0xF3A00000-0xF3AFFFFF  size:0x01000000 */
-
+    MEM_DESC(MM_IO_BASE_ARAM, SZ_1M),    /* phys:0x31000000-0x31FFFFFF
virt:0xF3100000-0xF31FFFFF  size:0x00100000 */
+    IO_DESC(MM_IO_BASE_DMA0, SZ_1M),    /* phys:0x32000000-0x32FFFFFF
virt:0xF3200000-0xF32FFFFF  size:0x00100000 */
+    IO_DESC(MM_IO_BASE_DMA1, SZ_1M),    /* phys:0x33000000-0x33FFFFFF
virt:0xF3300000-0xF33FFFFF  size:0x00100000 */
+    IO_DESC(MM_IO_BASE_ESW, SZ_1M),            /*
phys:0x34000000-0x34FFFFFF  virt:0xF3400000-0xF34FFFFF  size:0x00100000 */
+    IO_DESC(MM_IO_BASE_CLCD, SZ_1M),    /* phys:0x35000000-0x35FFFFFF
virt:0xF3500000-0xF35FFFFF  size:0x00100000 */
+    IO_DESC(MM_IO_BASE_APM, SZ_1M),            /*
phys:0x36000000-0x36FFFFFF  virt:0xF3600000-0xF36FFFFF  size:0x00100000 */
+    IO_DESC(MM_IO_BASE_SPUM, SZ_1M),    /* phys:0x37000000-0x37FFFFFF
virt:0xF3700000-0xF37FFFFF  size:0x00100000 */
+    IO_DESC(MM_IO_BASE_VPM_PROG, SZ_1M),    /*
phys:0x38000000-0x38FFFFFF  virt:0xF3800000-0xF38FFFFF  size:0x00100000 */
+    IO_DESC(MM_IO_BASE_VPM_DATA, SZ_1M),    /*
phys:0x3A000000-0x3AFFFFFF  virt:0xF3A00000-0xF3AFFFFF  size:0x00100000 */
       IO_DESC(MM_IO_BASE_VRAM, SZ_64K),    /*
phys:0x40000000-0x4000FFFF  virt:0xF4000000-0xF400FFFF  size:0x00010000 */
-    IO_DESC(MM_IO_BASE_CHIPC, SZ_16M),    /*
phys:0x80000000-0x80FFFFFF  virt:0xF8000000-0xF8FFFFFF  size:0x01000000 */
-    IO_DESC(MM_IO_BASE_VPM_EXTMEM_RSVD,
-        SZ_16M),    /* phys:0x0F000000-0x0FFFFFFF
virt:0xF0000000-0xF0FFFFFF  size:0x01000000 */
+    IO_DESC(MM_IO_BASE_CHIPC, SZ_8M),    /* phys:0x80000000-0x807FFFFF
virt:0xF8000000-0xF87FFFFF  size:0x00800000 */
+    IO_DESC(MM_IO_BASE_VPM_EXTMEM_RSVD, SZ_16M), /*
phys:0x0F000000-0x0FFFFFFF virt:0xF0000000-0xF0FFFFFF  size:0x01000000 */
   };

   void __init bcmring_map_io(void)
-- 
1.7.9.5

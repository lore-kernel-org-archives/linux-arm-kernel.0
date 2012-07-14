From: cavokz@gmail.com (Domenico Andreoli)
Date: Sat, 14 Jul 2012 22:49:54 +0200
Subject: [PATCH] OMAP: remove unused parameter arch_id from uncompress.h
Message-ID: <20120714204952.GA4798@raptus.dandreoli.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Domenico Andreoli <domenico.andreoli@linux.com>

There is not point in having arch_id as parameter of __arch_decomp_setup(),
nothing in it uses arch_id. The machine id is already exported (and used)
with symbol __machine_arch_type as per mach-types.h.

Removing the pointless macro as well.

Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
---
 arch/arm/plat-omap/include/plat/uncompress.h |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

Index: b/arch/arm/plat-omap/include/plat/uncompress.h
===================================================================
--- a/arch/arm/plat-omap/include/plat/uncompress.h
+++ b/arch/arm/plat-omap/include/plat/uncompress.h
@@ -103,7 +103,7 @@ static inline void flush(void)
 	_DEBUG_LL_ENTRY(mach, TI81XX_UART##p##_BASE, OMAP_PORT_SHIFT,	\
 		TI81XXUART##p)
 
-static inline void __arch_decomp_setup(unsigned long arch_id)
+static inline void arch_decomp_setup(void)
 {
 	int port = 0;
 
@@ -186,8 +186,6 @@ static inline void __arch_decomp_setup(u
 	} while (0);
 }
 
-#define arch_decomp_setup()	__arch_decomp_setup(arch_id)
-
 /*
  * nothing to do
  */

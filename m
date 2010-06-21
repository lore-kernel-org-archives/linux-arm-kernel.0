From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 21 Jun 2010 11:30:08 +0100
Subject: [PATCH v4 7/8] ARM: VExpress: Align the machine_desc.phys_io to 1MB
	section
In-Reply-To: <20100621102639.9353.37648.stgit@e102109-lin.cambridge.arm.com>
References: <20100621102639.9353.37648.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100621103008.9353.17436.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When not aligned, random bits could be written in the initial page table
by the __create_page_tables() function.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mach-vexpress/ct-ca9x4.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index e6f7303..dcbe39e 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -9,6 +9,7 @@
 #include <linux/amba/clcd.h>
 
 #include <asm/clkdev.h>
+#include <asm/pgtable.h>
 #include <asm/hardware/arm_timer.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/hardware/gic.h>
@@ -235,7 +236,7 @@ static void ct_ca9x4_init(void)
 }
 
 MACHINE_START(VEXPRESS, "ARM-Versatile Express CA9x4")
-	.phys_io	= V2M_UART0,
+	.phys_io	= V2M_UART0 & SECTION_MASK,
 	.io_pg_offst	= (__MMIO_P2V(V2M_UART0) >> 18) & 0xfffc,
 	.boot_params	= PHYS_OFFSET + 0x00000100,
 	.map_io		= ct_ca9x4_map_io,

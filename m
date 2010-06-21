From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 21 Jun 2010 11:30:14 +0100
Subject: [PATCH v4 8/8] ARM: RealView: Align the machine_desc.phys_io to 1MB
	section
In-Reply-To: <20100621102639.9353.37648.stgit@e102109-lin.cambridge.arm.com>
References: <20100621102639.9353.37648.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100621103014.9353.82108.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When not aligned, random bits could be written in the initial page table
by the __create_page_tables() function.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mach-realview/realview_eb.c     |    3 ++-
 arch/arm/mach-realview/realview_pb1176.c |    3 ++-
 arch/arm/mach-realview/realview_pb11mp.c |    3 ++-
 arch/arm/mach-realview/realview_pba8.c   |    3 ++-
 arch/arm/mach-realview/realview_pbx.c    |    3 ++-
 5 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index 422ccd7..4425018 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -32,6 +32,7 @@
 #include <asm/leds.h>
 #include <asm/mach-types.h>
 #include <asm/pmu.h>
+#include <asm/pgtable.h>
 #include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/localtimer.h>
@@ -457,7 +458,7 @@ static void __init realview_eb_init(void)
 
 MACHINE_START(REALVIEW_EB, "ARM-RealView EB")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
-	.phys_io	= REALVIEW_EB_UART0_BASE,
+	.phys_io	= REALVIEW_EB_UART0_BASE & SECTION_MASK,
 	.io_pg_offst	= (IO_ADDRESS(REALVIEW_EB_UART0_BASE) >> 18) & 0xfffc,
 	.boot_params	= PHYS_OFFSET + 0x00000100,
 	.fixup		= realview_fixup,
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index 96568eb..099a1f1 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -32,6 +32,7 @@
 #include <asm/leds.h>
 #include <asm/mach-types.h>
 #include <asm/pmu.h>
+#include <asm/pgtable.h>
 #include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
 
@@ -351,7 +352,7 @@ static void __init realview_pb1176_init(void)
 
 MACHINE_START(REALVIEW_PB1176, "ARM-RealView PB1176")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
-	.phys_io	= REALVIEW_PB1176_UART0_BASE,
+	.phys_io	= REALVIEW_PB1176_UART0_BASE & SECTION_MASK,
 	.io_pg_offst	= (IO_ADDRESS(REALVIEW_PB1176_UART0_BASE) >> 18) & 0xfffc,
 	.boot_params	= PHYS_OFFSET + 0x00000100,
 	.fixup		= realview_pb1176_fixup,
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index 7fbefbb..0e07a5c 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -32,6 +32,7 @@
 #include <asm/leds.h>
 #include <asm/mach-types.h>
 #include <asm/pmu.h>
+#include <asm/pgtable.h>
 #include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/localtimer.h>
@@ -373,7 +374,7 @@ static void __init realview_pb11mp_init(void)
 
 MACHINE_START(REALVIEW_PB11MP, "ARM-RealView PB11MPCore")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
-	.phys_io	= REALVIEW_PB11MP_UART0_BASE,
+	.phys_io	= REALVIEW_PB11MP_UART0_BASE & SECTION_MASK,
 	.io_pg_offst	= (IO_ADDRESS(REALVIEW_PB11MP_UART0_BASE) >> 18) & 0xfffc,
 	.boot_params	= PHYS_OFFSET + 0x00000100,
 	.fixup		= realview_fixup,
diff --git a/arch/arm/mach-realview/realview_pba8.c b/arch/arm/mach-realview/realview_pba8.c
index d3c113b..ac2f06f 100644
--- a/arch/arm/mach-realview/realview_pba8.c
+++ b/arch/arm/mach-realview/realview_pba8.c
@@ -31,6 +31,7 @@
 #include <asm/leds.h>
 #include <asm/mach-types.h>
 #include <asm/pmu.h>
+#include <asm/pgtable.h>
 #include <asm/hardware/gic.h>
 
 #include <asm/mach/arch.h>
@@ -323,7 +324,7 @@ static void __init realview_pba8_init(void)
 
 MACHINE_START(REALVIEW_PBA8, "ARM-RealView PB-A8")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
-	.phys_io	= REALVIEW_PBA8_UART0_BASE,
+	.phys_io	= REALVIEW_PBA8_UART0_BASE & SECTION_MASK,
 	.io_pg_offst	= (IO_ADDRESS(REALVIEW_PBA8_UART0_BASE) >> 18) & 0xfffc,
 	.boot_params	= PHYS_OFFSET + 0x00000100,
 	.fixup		= realview_fixup,
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index a235ba3..08fd683 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -31,6 +31,7 @@
 #include <asm/mach-types.h>
 #include <asm/pmu.h>
 #include <asm/smp_twd.h>
+#include <asm/pgtable.h>
 #include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
 
@@ -409,7 +410,7 @@ static void __init realview_pbx_init(void)
 
 MACHINE_START(REALVIEW_PBX, "ARM-RealView PBX")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
-	.phys_io	= REALVIEW_PBX_UART0_BASE,
+	.phys_io	= REALVIEW_PBX_UART0_BASE & SECTION_MASK,
 	.io_pg_offst	= (IO_ADDRESS(REALVIEW_PBX_UART0_BASE) >> 18) & 0xfffc,
 	.boot_params	= PHYS_OFFSET + 0x00000100,
 	.fixup		= realview_pbx_fixup,

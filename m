From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 05 Jun 2013 16:55:31 +0900
Subject: [PATCH 02/02] ARM: shmobile: Remove romImage CONFIG_MEMORY_START
In-Reply-To: <20130605075514.17653.77135.sendpatchset@w520>
References: <20130605075514.17653.77135.sendpatchset@w520>
Message-ID: <20130605075531.17653.38073.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Instead of relying on CONFIG_MEMORY_START for memory
base address, let each romImage board header file
specify this information.

This is reworks code not to rely on CONFIG_MEMORY_START
which in turn is needed for ARCH_MULTIPLATFORM.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/compressed/head-shmobile.S    |    2 +-
 arch/arm/mach-shmobile/include/mach/zboot.h |    2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

--- 0025/arch/arm/boot/compressed/head-shmobile.S
+++ work/arch/arm/boot/compressed/head-shmobile.S	2013-06-05 11:56:07.000000000 +0900
@@ -46,7 +46,7 @@ __image_start:
 __image_end:
 	.long	_got_end
 __load_base:
-	.long	CONFIG_MEMORY_START + 0x02000000 @ Load at 32Mb into SDRAM
+	.long	MEMORY_START + 0x02000000 @ Load at 32Mb into SDRAM
 __loaded:
 	.long	__continue
 	.align
--- 0001/arch/arm/mach-shmobile/include/mach/zboot.h
+++ work/arch/arm/mach-shmobile/include/mach/zboot.h	2013-06-05 11:55:55.000000000 +0900
@@ -12,9 +12,11 @@
 
 #ifdef CONFIG_MACH_AP4EVB
 #define MACH_TYPE	MACH_TYPE_AP4EVB
+#define MEMORY_START	0x40000000
 #include "mach/head-ap4evb.txt"
 #elif defined(CONFIG_MACH_MACKEREL)
 #define MACH_TYPE	MACH_TYPE_MACKEREL
+#define MEMORY_START	0x40000000
 #include "mach/head-mackerel.txt"
 #else
 #error "unsupported board."

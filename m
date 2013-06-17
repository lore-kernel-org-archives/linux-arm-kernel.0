From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 17 Jun 2013 17:12:36 +0900
Subject: [PATCH 03/15] ARM: shmobile: Remove romImage CONFIG_MEMORY_START
In-Reply-To: <1371456768-1084-1-git-send-email-horms+renesas@verge.net.au>
References: <1371456768-1084-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1371456768-1084-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Instead of relying on CONFIG_MEMORY_START for memory
base address, let each romImage board header file
specify this information.

This is reworks code not to rely on CONFIG_MEMORY_START
which in turn is needed for ARCH_MULTIPLATFORM.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/compressed/head-shmobile.S    |    2 +-
 arch/arm/mach-shmobile/include/mach/zboot.h |    2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/head-shmobile.S b/arch/arm/boot/compressed/head-shmobile.S
index 19b2304..e2d6363 100644
--- a/arch/arm/boot/compressed/head-shmobile.S
+++ b/arch/arm/boot/compressed/head-shmobile.S
@@ -46,7 +46,7 @@ __image_start:
 __image_end:
 	.long	_got_end
 __load_base:
-	.long	CONFIG_MEMORY_START + 0x02000000 @ Load at 32Mb into SDRAM
+	.long	MEMORY_START + 0x02000000 @ Load at 32Mb into SDRAM
 __loaded:
 	.long	__continue
 	.align
diff --git a/arch/arm/mach-shmobile/include/mach/zboot.h b/arch/arm/mach-shmobile/include/mach/zboot.h
index 9320aff..308b5cf 100644
--- a/arch/arm/mach-shmobile/include/mach/zboot.h
+++ b/arch/arm/mach-shmobile/include/mach/zboot.h
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
-- 
1.7.10.4

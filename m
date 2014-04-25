From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:35:43 +0100
Subject: [PATCH 056/222] ARM: l2c: exynos: remove cache size override
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdePv-0007Gt-2o@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-exynos/exynos.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index e6828fb46034..a51bf25e7523 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -32,9 +32,6 @@
 #include "mfc.h"
 #include "regs-pmu.h"
 
-#define L2_AUX_VAL 0x3c470001
-#define L2_AUX_MASK 0xc200ffff
-
 static struct map_desc exynos4_iodesc[] __initdata = {
 	{
 		.virtual	= (unsigned long)S3C_VA_SYS,
@@ -323,7 +320,7 @@ static int __init exynos4_l2x0_cache_init(void)
 {
 	int ret;
 
-	ret = l2x0_of_init(L2_AUX_VAL, L2_AUX_MASK);
+	ret = l2x0_of_init(0x3c400001, 0xc20fffff);
 	if (ret)
 		return ret;
 
-- 
1.8.3.1

From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 28 Mar 2014 15:19:12 +0000
Subject: [PATCH 56/75] ARM: l2c: exynos: remove cache size override
In-Reply-To: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
Message-ID: <E1WTYYq-0007Ge-SD@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-exynos/common.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index cd53b72449a0..0d19a1b0444e 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -45,9 +45,6 @@
 #include "common.h"
 #include "regs-pmu.h"
 
-#define L2_AUX_VAL 0x3c470001
-#define L2_AUX_MASK 0xc200ffff
-
 static const char name_exynos4210[] = "EXYNOS4210";
 static const char name_exynos4212[] = "EXYNOS4212";
 static const char name_exynos4412[] = "EXYNOS4412";
@@ -400,7 +397,7 @@ static int __init exynos4_l2x0_cache_init(void)
 {
 	int ret;
 
-	ret = l2x0_of_init(L2_AUX_VAL, L2_AUX_MASK);
+	ret = l2x0_of_init(0x3c400001, 0xc20fffff);
 	if (ret)
 		return ret;
 
-- 
1.8.3.1

From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 10 Dec 2012 10:08:56 +0900
Subject: [PATCH] ARM: EXYNOS: fix skip scu_enable() for EXYNOS5440
Message-ID: <030d01cdd672$ed68da20$c83a8e60$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/platsmp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 4ca8ff1..c5c840e 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -198,7 +198,7 @@ static void __init exynos_smp_prepare_cpus(unsigned int max_cpus)
 {
 	int i;
 
-	if (!soc_is_exynos5250())
+	if (!(soc_is_exynos5250() || soc_is_exynos5440()))
 		scu_enable(scu_base_addr());
 
 	/*
-- 
1.7.4.1

From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 08 Jul 2014 14:03:37 +0200
Subject: [PATCH] ARM: EXYNOS: use u8 for val[] in struct exynos_pmu_conf
Message-ID: <2379473.Yu7PYOQ3m0@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Values stored in val[] are never bigger than a byte.

   text    data     bss     dec     hex filename
   5264       4       4    5272    1498 arch/arm/mach-exynos/pmu.o.before
   2992       4       4    3000     bb8 arch/arm/mach-exynos/pmu.o.after

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index b850db4..55ff019 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -101,7 +101,7 @@ enum sys_powerdown {
 
 struct exynos_pmu_conf {
 	void __iomem *reg;
-	unsigned int val[NUM_SYS_POWERDOWN];
+	u8 val[NUM_SYS_POWERDOWN];
 };
 
 extern void exynos_sys_powerdown_conf(enum sys_powerdown mode);
-- 
1.8.2.3

From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 10 Jul 2015 19:20:58 +0900
Subject: [PATCH] ARM: EXYNOS: Use IOMEM_ERR_PTR when function returns iomem
Message-ID: <1436523658-11182-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Function returns 'void __iomem *' so use IOMEM_ERR_PTR for returning
an error. This fixes sparse warning:

arch/arm/mach-exynos/platsmp.c:185:31: warning: incorrect type in return expression (different address spaces)
arch/arm/mach-exynos/platsmp.c:185:31:    expected void [noderef] <asn:2>*
arch/arm/mach-exynos/platsmp.c:185:31:    got void *

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/mach-exynos/platsmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 58e05a2eae57..98a2c0cbb833 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -182,7 +182,7 @@ static inline void __iomem *cpu_boot_reg(int cpu)
 
 	boot_reg = cpu_boot_reg_base();
 	if (!boot_reg)
-		return ERR_PTR(-ENODEV);
+		return IOMEM_ERR_PTR(-ENODEV);
 	if (soc_is_exynos4412())
 		boot_reg += 4*cpu;
 	else if (soc_is_exynos5420() || soc_is_exynos5800())
-- 
1.9.1

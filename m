From: chander.kashyap@linaro.org (Chander Kashyap)
Date: Tue, 18 Jun 2013 11:59:21 +0530
Subject: [PATCH v4 09/10] ARM: Exynos: add secondary CPU boot base location
 for Exynos5420
In-Reply-To: <1371536962-13322-1-git-send-email-chander.kashyap@linaro.org>
References: <1371536962-13322-1-git-send-email-chander.kashyap@linaro.org>
Message-ID: <1371536962-13322-10-git-send-email-chander.kashyap@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The location at which the boot address is specified for secondary CPUs of
Exynos5420 is SYSRAM base + 4. Update the cpu_boot_reg function accordingly.

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-exynos/platsmp.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 85ea4ca..7b4c03e 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -50,6 +50,8 @@ static inline void __iomem *cpu_boot_reg(int cpu)
 	boot_reg = cpu_boot_reg_base();
 	if (soc_is_exynos4412())
 		boot_reg += 4*cpu;
+	else if (soc_is_exynos5420())
+		boot_reg += 4;
 	return boot_reg;
 }
 
-- 
1.7.9.5

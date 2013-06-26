From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 26 Jun 2013 17:06:36 +0530
Subject: [PATCH 1/2] ARM: EXYNOS: Remove combiner_init declaration
Message-ID: <1372246597-32323-1-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit d243997f ("ARM: EXYNOS: Remove legacy interrupt initialization
code") removed the call to combiner_init(). Since there are no more
users in the machine code, remove the declaration as well.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 arch/arm/mach-exynos/common.h |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 3e156bc..c4abde2 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -72,8 +72,6 @@ void exynos4212_register_clocks(void);
 #endif
 
 struct device_node;
-void combiner_init(void __iomem *combiner_base, struct device_node *np,
-			unsigned int max_nr, int irq_base);
 
 extern struct smp_operations exynos_smp_ops;
 
-- 
1.7.9.5

From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 14 Jun 2013 21:32:51 +0200
Subject: [PATCH 15/28] ARM: EXYNOS: Provide compatibility stubs for PM code in
 pm-core.h header
In-Reply-To: <1371238384-1504-1-git-send-email-t.figa@samsung.com>
References: <1371238384-1504-1-git-send-email-t.figa@samsung.com>
Message-ID: <1371238384-1504-16-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds several compatibility definitions that are not relevant
for Exynos, but are required by Samsung PM core.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/include/mach/pm-core.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-exynos/include/mach/pm-core.h b/arch/arm/mach-exynos/include/mach/pm-core.h
index 296090e..dd62559 100644
--- a/arch/arm/mach-exynos/include/mach/pm-core.h
+++ b/arch/arm/mach-exynos/include/mach/pm-core.h
@@ -69,4 +69,8 @@ static inline void samsung_pm_saved_gpios(void)
 	/* nothing here yet */
 }
 
+/* Compatibility definitions to make plat-samsung/pm.c compile */
+#define s3c_irqwake_intallow	0
+#define s3c_irqwake_eintallow	0
+
 #endif /* __ASM_ARCH_PM_CORE_H */
-- 
1.8.2.1

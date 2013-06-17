From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 17 Jun 2013 18:34:11 +0200
Subject: [PATCH v2 26/38] ARM: EXYNOS: Select SPARSE_IRQ for Exynos
In-Reply-To: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
References: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
Message-ID: <1371486863-12398-27-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds selection of CONFIG_SPARSE_IRQ for ARCH_EXYNOS, since it
is required by multiplatform and allows to remove the legacy mach/irqs.h
header.

To make this possible, a dummy IRQ_EINT_BIT macro is added to pm-core.h
header to allow plat-samsung/pm.c compile. This macro is irrelevant for
Exynos and will be removed after reworking Samsung pm code for
multiplatform compatibility.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/Kconfig                            | 1 +
 arch/arm/mach-exynos/include/mach/pm-core.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 61dff79..ff2fe0f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -807,6 +807,7 @@ config ARCH_EXYNOS
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	select HAVE_S3C_RTC if RTC_CLASS
 	select NEED_MACH_MEMORY_H
+	select SPARSE_IRQ
 	select USE_OF
 	help
 	  Support for SAMSUNG's EXYNOS SoCs (EXYNOS4/5)
diff --git a/arch/arm/mach-exynos/include/mach/pm-core.h b/arch/arm/mach-exynos/include/mach/pm-core.h
index dd62559..71e6b89 100644
--- a/arch/arm/mach-exynos/include/mach/pm-core.h
+++ b/arch/arm/mach-exynos/include/mach/pm-core.h
@@ -70,6 +70,7 @@ static inline void samsung_pm_saved_gpios(void)
 }
 
 /* Compatibility definitions to make plat-samsung/pm.c compile */
+#define IRQ_EINT_BIT(x)		1
 #define s3c_irqwake_intallow	0
 #define s3c_irqwake_eintallow	0
 
-- 
1.8.2.1

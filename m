From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 10 Jun 2014 12:51:28 +0200
Subject: [PATCH 15/24] ARM: exynos: Leave disabling of unused pm domains to
 genpd
In-Reply-To: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
References: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1402397497-26737-16-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since genpd at late init, will try to disable unused domains we don't
need to handle it from here as well.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/mach-exynos/exynos.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index bc43e22..82ab996 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -193,7 +193,6 @@ void __init exynos_init_late(void)
 		/* to be supported later */
 		return;
 
-	pm_genpd_poweroff_unused();
 	exynos_pm_init();
 }
 
-- 
1.7.9.5

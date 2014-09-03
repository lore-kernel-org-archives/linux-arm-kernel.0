From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed,  3 Sep 2014 12:52:27 +0200
Subject: [PATCH 11/15] ARM: exynos: Leave disabling of unused PM domains to
 genpd
In-Reply-To: <1409741551-16437-1-git-send-email-ulf.hansson@linaro.org>
References: <1409741551-16437-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1409741551-16437-12-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since genpd at late init, will try to disable unused PM domains we
don't need to do it from here as well.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/mach-exynos/exynos.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 6a24e11..b89e5f3 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -193,7 +193,6 @@ static void __init exynos_init_late(void)
 		/* to be supported later */
 		return;
 
-	pm_genpd_poweroff_unused();
 	exynos_pm_init();
 }
 
-- 
1.9.1

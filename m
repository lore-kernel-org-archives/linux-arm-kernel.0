From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 12 Apr 2013 09:38:52 +0800
Subject: [PATCH] ARM: tegra: pm: fix build error w/o PM_SLEEP
Message-ID: <1365730733-22701-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes the building error when the PM_SLEEP is disabled. The fucntional
defintion of "tegra_pm_validate_suspend_mode" without "static inline"
would become a multiple definition error.

Reported-by: Rhyland Klein <rklein@nvidia.com>
Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/pm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/pm.h b/arch/arm/mach-tegra/pm.h
index 9d2d038..778a4aa 100644
--- a/arch/arm/mach-tegra/pm.h
+++ b/arch/arm/mach-tegra/pm.h
@@ -39,7 +39,7 @@ enum tegra_suspend_mode tegra_pm_validate_suspend_mode(
 				enum tegra_suspend_mode mode);
 void tegra_init_suspend(void);
 #else
-enum tegra_suspend_mode tegra_pm_validate_suspend_mode(
+static inline enum tegra_suspend_mode tegra_pm_validate_suspend_mode(
 				enum tegra_suspend_mode mode)
 {
 	return TEGRA_SUSPEND_NONE;
-- 
1.8.2

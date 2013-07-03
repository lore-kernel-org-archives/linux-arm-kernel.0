From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 3 Jul 2013 17:50:45 +0800
Subject: [PATCH V2 09/11] ARM: tegra: remove the limitation that Tegra114
 can't support suspend
In-Reply-To: <1372845047-25147-1-git-send-email-josephl@nvidia.com>
References: <1372845047-25147-1-git-send-email-josephl@nvidia.com>
Message-ID: <1372845047-25147-10-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Tegra114 can support suspend function now, removing the limitation.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V2:
* no change
---
 arch/arm/mach-tegra/pm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 3d07cd5..5792872 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -173,10 +173,6 @@ void tegra_idle_lp2_last(void)
 enum tegra_suspend_mode tegra_pm_validate_suspend_mode(
 				enum tegra_suspend_mode mode)
 {
-	/* Tegra114 didn't support any suspending mode yet. */
-	if (tegra_chip_id == TEGRA114)
-		return TEGRA_SUSPEND_NONE;
-
 	/*
 	 * The Tegra devices only support suspending to LP2 currently.
 	 */
-- 
1.8.3.2

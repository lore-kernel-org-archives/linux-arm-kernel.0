From: jhbird.choi@samsung.com (jhbird.choi at samsung.com)
Date: Sun,  8 Jan 2012 09:58:52 +0900
Subject: [PATCH] ARM: EXYNOS: Fix "warning: initialization from incompatible
 pointer type"
Message-ID: <1325984332-32146-1-git-send-email-jhbird.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonghwan Choi <jhbird.choi@samsung.com>

Fix the wrong function prototype.

Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>
---
 arch/arm/mach-exynos/pm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index c4f792d..db33f47 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -205,7 +205,7 @@ static void exynos4_pm_prepare(void)
 
 }
 
-static int exynos4_pm_add(struct device *dev)
+static int exynos4_pm_add(struct device *dev, struct subsys_interface *sif)
 {
 	pm_cpu_prep = exynos4_pm_prepare;
 	pm_cpu_sleep = exynos4_cpu_suspend;
-- 
1.7.1

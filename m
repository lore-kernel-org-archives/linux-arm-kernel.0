From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Tue, 06 Nov 2012 11:42:35 +0530
Subject: [PATCH 4/5] ARM: EXYNOS5: Remove scu_enable from cpuidle
In-Reply-To: <1352182356-28989-1-git-send-email-a.kesavan@samsung.com>
References: <1352182356-28989-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1352182356-28989-5-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cortex A9 based exynos4 has a memory mapped SCU while the Cortex
A15 based exynos5 does not. Hence, remove the call to scu_enable
for exynos5.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Signed-off-by: Inderpal Singh <inderpal.singh@samsung.com>
---
 arch/arm/mach-exynos/cpuidle.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index cff0595..8e4ec21 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -116,7 +116,8 @@ static int exynos4_enter_core0_aftr(struct cpuidle_device *dev,
 	cpu_suspend(0, idle_finisher);
 
 #ifdef CONFIG_SMP
-	scu_enable(S5P_VA_SCU);
+	if (!soc_is_exynos5250())
+		scu_enable(S5P_VA_SCU);
 #endif
 	cpu_pm_exit();
 
-- 
1.6.6.1

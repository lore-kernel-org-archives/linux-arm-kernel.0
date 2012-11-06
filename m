From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Tue, 06 Nov 2012 11:42:34 +0530
Subject: [PATCH 3/5] ARM: EXYNOS: Fix soft reboot hang after suspend/resume
In-Reply-To: <1352182356-28989-1-git-send-email-a.kesavan@samsung.com>
References: <1352182356-28989-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1352182356-28989-4-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Inderpal Singh <inderpal.singh@samsung.com>

Upon wake-up, clear the sleep mode set in INFORM1 register.

Signed-off-by: Inderpal Singh <inderpal.singh@samsung.com>
Tested-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 arch/arm/mach-exynos/pm.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index c06c992..8dedeb2 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -312,6 +312,10 @@ static void exynos_pm_resume(void)
 	}
 
 early_wakeup:
+
+	/* Clear SLEEP mode set in INFORM1 */
+	__raw_writel(0x0, S5P_INFORM1);
+
 	return;
 }
 
-- 
1.6.6.1

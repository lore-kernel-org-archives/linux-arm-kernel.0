From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Tue, 06 Nov 2012 11:42:36 +0530
Subject: [PATCH 5/5] ARM: EXYNOS5: Add flush_cache_all in suspend finisher
In-Reply-To: <1352182356-28989-1-git-send-email-a.kesavan@samsung.com>
References: <1352182356-28989-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1352182356-28989-6-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The core cpu_suspend code no longer calls flush_cache_all to
optimize the cpu idle flow. Add a call for the same in the
exynos specific suspend code.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 arch/arm/mach-exynos/pm.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 8dedeb2..8df6ec5 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -81,6 +81,9 @@ static int exynos_cpu_suspend(unsigned long arg)
 	outer_flush_all();
 #endif
 
+	if (soc_is_exynos5250())
+		flush_cache_all();
+
 	/* issue the standby signal into the pm unit. */
 	cpu_do_idle();
 
-- 
1.6.6.1

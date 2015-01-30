From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 30 Jan 2015 13:52:52 +0100
Subject: [PATCH v2 4/4] ARM: EXYNOS: cpuidle: allow driver usage on Exynos3250
 SoC
In-Reply-To: <1422622373-24769-1-git-send-email-b.zolnierkie@samsung.com>
References: <1422622373-24769-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1422622373-24769-5-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register cpuidle platform device on Exynos3250 SoC allowing EXYNOS
cpuidle driver usage on this SoC.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/exynos.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index c599a0f..2652024 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -244,6 +244,7 @@ static void __init exynos_dt_machine_init(void)
 	    of_machine_is_compatible("samsung,exynos4212") ||
 	    (of_machine_is_compatible("samsung,exynos4412") &&
 	     of_machine_is_compatible("samsung,trats2")) ||
+	    of_machine_is_compatible("samsung,exynos3250") ||
 	    of_machine_is_compatible("samsung,exynos5250"))
 		platform_device_register(&exynos_cpuidle);
 
-- 
1.8.2.3

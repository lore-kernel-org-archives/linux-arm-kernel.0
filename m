From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Wed, 09 Jul 2014 19:17:54 +0200
Subject: [PATCH v3 4/4] ARM: EXYNOS: cpuidle: allow driver usage on Exynos4x12
 SoCs
In-Reply-To: <1404926274-18411-1-git-send-email-b.zolnierkie@samsung.com>
References: <1404926274-18411-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1404926274-18411-5-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register cpuidle platform device on Exynos4x12 SoCs allowing EXYNOS
cpuidle driver usage on these SoCs.

AFTR mode reduces power consumption on Trats2 board (Exynos4412 SoC
with secure firmware enabled) by ~12% when EXYNOS cpuidle driver is
enabled (in both cases the default exynos_defconfig config is used
and CPU1-3 are offlined).

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
v3:
- new patch

 arch/arm/mach-exynos/exynos.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 4361abd..23003d9 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -173,7 +173,8 @@ static struct platform_device exynos_cpuidle = {
 
 void __init exynos_cpuidle_init(void)
 {
-	if (soc_is_exynos4210() || soc_is_exynos5250())
+	if (soc_is_exynos4210() || soc_is_exynos4212() ||
+	    soc_is_exynos4412() || soc_is_exynos5250())
 		platform_device_register(&exynos_cpuidle);
 }
 
-- 
1.8.2.3

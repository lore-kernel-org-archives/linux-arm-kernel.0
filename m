From: chander.kashyap@linaro.org (Chander Kashyap)
Date: Fri, 16 May 2014 13:33:57 +0530
Subject: [PATCH v6 5/6] exynos: cpuidle: do not allow cpuidle registration for
 Exynos5420
In-Reply-To: <1400227438-27155-1-git-send-email-chander.kashyap@linaro.org>
References: <CANuQgHGSA+R__raSa_tzrgpceqLD2SZw+s0XQUHGF4wscgh6Kg@mail.gmail.com>
 <1400227438-27155-1-git-send-email-chander.kashyap@linaro.org>
Message-ID: <1400227438-27155-6-git-send-email-chander.kashyap@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos5420 is big.Little Soc. It uses cpuidle-big-litle generic cpuidle driver.
Hence do not allow exynos cpuidle driver registration for Exynos5420.

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
Signed-off-by: Chander Kashyap <k.chander@samsung.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
Changes in v6:
	1. Move cpuidle registration check to exynos.c from cpuidle.c and
	   use "samsung,exynos5420" compatible string to avvoid registration
 arch/arm/mach-exynos/exynos.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 4df3452..ef24edf 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -286,7 +286,9 @@ static void __init exynos_dt_machine_init(void)
 		}
 	}
 
-	exynos_cpuidle_init();
+	if (!of_machine_is_compatible("samsung,exynos5420"))
+		exynos_cpuidle_init();
+
 	exynos_cpufreq_init();
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-- 
1.7.9.5

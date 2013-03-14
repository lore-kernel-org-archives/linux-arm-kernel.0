From: amit.daniel@samsung.com (Amit Daniel Kachhap)
Date: Thu, 14 Mar 2013 11:32:59 +0530
Subject: [PATCH 3/3] ARM: EXYNOS: cpuidle: Allow C1 state only in supported
 SOC's.
In-Reply-To: <1363240979-1939-1-git-send-email-amit.daniel@samsung.com>
References: <1363240979-1939-1-git-send-email-amit.daniel@samsung.com>
Message-ID: <1363240979-1939-4-git-send-email-amit.daniel@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch registers the basic C0 state for all exynos SOC's but
limits the C1(AFTR -Arm off top running) state in only the supported
SOC's(ie. EXYNOS 4210, 4212, 4412 and 5250).

Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 arch/arm/mach-exynos/cpuidle.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index 4fc1f4f..459979a 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -177,7 +177,9 @@ static int __init exynos4_init_cpuidle(void)
 		device->cpu = cpu_id;
 
 		/* Support IDLE only */
-		if (cpu_id != 0)
+		if (!(soc_is_exynos4210() || soc_is_exynos4212() ||
+			soc_is_exynos4412() || soc_is_exynos5250()) ||
+			cpu_id != 0)
 			device->state_count = 1;
 
 		ret = cpuidle_register_device(device);
-- 
1.7.1

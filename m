From: k.chander@samsung.com (Chander Kashyap)
Date: Mon, 16 Jun 2014 15:56:20 +0530
Subject: [Patch v7 3/6] cpuidle: config: Add ARCH_EXYNOS entry to select
 cpuidle-big-little driver
In-Reply-To: <1402914383-20471-1-git-send-email-k.chander@samsung.com>
References: <1402914383-20471-1-git-send-email-k.chander@samsung.com>
Message-ID: <1402914383-20471-4-git-send-email-k.chander@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chander Kashyap <chander.kashyap@linaro.org>

Add support to select generic big-little cpuidle driver for Samsung Exynos
series SoC's. This is required for Exynos big-llittle SoC's eg, Exynos5420.

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
Signed-off-by: Chander Kashyap <k.chander@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
Changes in v4:
	1. Typo fixed from SOC_EXYNOS5420 to ARCH_EXYNOS
	2. Commit message updated
Changes in v3: None
Changes in v2:
	1. Changed config macro from SOC_EXYNOS5420 to ARCH_EXYNOS
 drivers/cpuidle/Kconfig.arm |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index b6d69e8..2f6b33e 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -9,7 +9,7 @@ config ARM_ARMADA_370_XP_CPUIDLE
 
 config ARM_BIG_LITTLE_CPUIDLE
 	bool "Support for ARM big.LITTLE processors"
-	depends on ARCH_VEXPRESS_TC2_PM
+	depends on ARCH_VEXPRESS_TC2_PM || ARCH_EXYNOS
 	select ARM_CPU_SUSPEND
 	select CPU_IDLE_MULTIPLE_DRIVERS
 	help
-- 
1.7.9.5

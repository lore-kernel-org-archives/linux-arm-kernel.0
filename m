From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sun, 17 May 2015 17:09:44 +0900
Subject: [PATCH 1/4] ARM: multi_v7_defconfig: Enable CPU idle for Exynos
In-Reply-To: <1431850195-9558-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1431850195-9558-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1431850195-9558-3-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Current Exynos CPU idle driver supports entering AFTR (Arm Off, Top
Running) mode on Exynos3250, Exynos4210 (coupled), Exynos4x12 and
Exynos5250. Enable it in default configuration to reduce energy
consumption.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 76cbb81cbaa3..d524d2e9633c 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -117,6 +117,7 @@ CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_STAT_DETAILS=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
 CONFIG_CPU_IDLE=y
+CONFIG_ARM_EXYNOS_CPUIDLE=y
 CONFIG_NEON=y
 CONFIG_KERNEL_MODE_NEON=y
 CONFIG_ARM_ZYNQ_CPUIDLE=y
-- 
2.1.4

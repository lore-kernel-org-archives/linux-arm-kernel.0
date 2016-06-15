From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 15 Jun 2016 19:43:38 +0530
Subject: [PATCH 5/5] ARM: config: Get rid of config COMMON_CLK_MAX77802
In-Reply-To: <1466000018-16784-1-git-send-email-ldewangan@nvidia.com>
References: <1466000018-16784-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1466000018-16784-6-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock driver used by Maxim PMIC MAX77802 is clk-max77686
which can be enabled with config CONFIG_COMMON_CLK_MAX77686.

Hence the config CONFIG_COMMON_CLK_MAX77802 is not required.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
CC: Javier Martinez Canillas <javier@dowhile0.org>
---
 arch/arm/configs/exynos_defconfig   | 1 -
 arch/arm/configs/multi_v7_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index daf9762..cfd75c7 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -216,7 +216,6 @@ CONFIG_DMADEVICES=y
 CONFIG_PL330_DMA=y
 CONFIG_CROS_EC_CHARDEV=y
 CONFIG_COMMON_CLK_MAX77686=y
-CONFIG_COMMON_CLK_MAX77802=y
 CONFIG_COMMON_CLK_S2MPS11=y
 CONFIG_EXTCON=y
 CONFIG_EXTCON_MAX14577=y
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index ee7c884..7cbf389 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -787,7 +787,6 @@ CONFIG_CHROME_PLATFORMS=y
 CONFIG_STAGING_BOARD=y
 CONFIG_CROS_EC_CHARDEV=m
 CONFIG_COMMON_CLK_MAX77686=y
-CONFIG_COMMON_CLK_MAX77802=m
 CONFIG_COMMON_CLK_RK808=m
 CONFIG_COMMON_CLK_S2MPS11=m
 CONFIG_APQ_MMCC_8084=y
-- 
2.1.4

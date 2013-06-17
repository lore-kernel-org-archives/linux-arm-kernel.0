From: tushar.behera@linaro.org (Tushar Behera)
Date: Mon, 17 Jun 2013 09:48:06 +0530
Subject: [PATCH 2/2] ARM: exynos_defconfig: Enable RTC driver
In-Reply-To: <1371442686-24999-1-git-send-email-tushar.behera@linaro.org>
References: <1371442686-24999-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1371442686-24999-3-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The issues reported in commit 522ccdb6fd0e ("ARM: dts: Disable the RTC
by default on exynos5") are no longer reproduced on EXYNOS5250 based
systems.

Hence it would be better to re-enable RTC support for EXYNOS5250.

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 arch/arm/configs/exynos_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 9ab979a..ad7dfbb 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -105,6 +105,8 @@ CONFIG_MMC_SDHCI_S3C=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_IDMAC=y
 CONFIG_MMC_DW_EXYNOS=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_S3C=y
 CONFIG_COMMON_CLK_MAX77686=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-- 
1.7.9.5

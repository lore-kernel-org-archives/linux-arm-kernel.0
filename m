From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 18 Jul 2017 06:59:03 +0200
Subject: [PATCH v2 1/5] ARM: multi_v7_defconfig: Cleanup from non-existing
 options
In-Reply-To: <1500353947-26122-1-git-send-email-krzk@kernel.org>
References: <1500353947-26122-1-git-send-email-krzk@kernel.org>
Message-ID: <1500353947-26122-2-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove options which do not exist anymore:
 - TEGRA_EMC_SCALING_ENABLE is gone since commit cab4d50389c6 ("ARM:
   tegra: remove TEGRA_EMC_SCALING_ENABLE");

 - ARCH_VEXPRESS_CA9X4 is gone since commit 81cc3f868d30
   ("ARM: vexpress: Remove non-DT code");

 - OMAP_USB3 was replaced by TI_PIPE3 in commit a70143bbef6b ("drivers:
   phy: usb3/pipe3: Adapt pipe3 driver to Generic PHY Framework");

 - MMC_DW_IDMAC is gone since commit 3fc7eaef44db ("mmc: dw_mmc: Add
   external dma interface support");

 - QCOM_SMD since commit 395a48053af6 ("soc: qcom: smd: Remove
   standalone driver");

 - COMMON_CLK_MAX77802 was merged into COMMON_CLK_MAX77686 in commit
   8ad313fe4e00 ("clk: max77686: Combine Maxim max77686 and max77802
   driver");

 - CRYPTO_DEV_TEGRA_AES is gone since commit 645af2e43705 ("crypto:
   tegra - remove driver");

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Rebased on top of latest Simon Horman's work (drops RCAR changes).
---
 arch/arm/configs/multi_v7_defconfig | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 072a455008df..6cfd6137db88 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -104,13 +104,11 @@ CONFIG_ARCH_TEGRA_2x_SOC=y
 CONFIG_ARCH_TEGRA_3x_SOC=y
 CONFIG_ARCH_TEGRA_114_SOC=y
 CONFIG_ARCH_TEGRA_124_SOC=y
-CONFIG_TEGRA_EMC_SCALING_ENABLE=y
 CONFIG_ARCH_UNIPHIER=y
 CONFIG_ARCH_U8500=y
 CONFIG_MACH_HREFV60=y
 CONFIG_MACH_SNOWBALL=y
 CONFIG_ARCH_VEXPRESS=y
-CONFIG_ARCH_VEXPRESS_CA9X4=y
 CONFIG_ARCH_VEXPRESS_TC2_PM=y
 CONFIG_ARCH_WM8850=y
 CONFIG_ARCH_ZYNQ=y
@@ -696,7 +694,6 @@ CONFIG_USB_CHIPIDEA_UDC=y
 CONFIG_USB_CHIPIDEA_HOST=y
 CONFIG_AB8500_USB=y
 CONFIG_KEYSTONE_USB_PHY=y
-CONFIG_OMAP_USB3=y
 CONFIG_USB_GPIO_VBUS=y
 CONFIG_USB_ISP1301=y
 CONFIG_USB_MSM_OTG=m
@@ -729,7 +726,6 @@ CONFIG_MMC_SDHCI_MSM=y
 CONFIG_MMC_MVSDIO=y
 CONFIG_MMC_SDHI=y
 CONFIG_MMC_DW=y
-CONFIG_MMC_DW_IDMAC=y
 CONFIG_MMC_DW_PLTFM=y
 CONFIG_MMC_DW_EXYNOS=y
 CONFIG_MMC_DW_ROCKCHIP=y
@@ -826,7 +822,6 @@ CONFIG_BCMA_DRIVER_GPIO=y
 CONFIG_QCOM_GSBI=y
 CONFIG_QCOM_PM=y
 CONFIG_QCOM_SMEM=y
-CONFIG_QCOM_SMD=y
 CONFIG_QCOM_SMD_RPM=y
 CONFIG_QCOM_SMP2P=y
 CONFIG_QCOM_SMSM=y
@@ -838,7 +833,6 @@ CONFIG_CHROME_PLATFORMS=y
 CONFIG_STAGING_BOARD=y
 CONFIG_CROS_EC_CHARDEV=m
 CONFIG_COMMON_CLK_MAX77686=y
-CONFIG_COMMON_CLK_MAX77802=m
 CONFIG_COMMON_CLK_RK808=m
 CONFIG_COMMON_CLK_S2MPS11=m
 CONFIG_APQ_MMCC_8084=y
@@ -934,7 +928,6 @@ CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_LOCKUP_DETECTOR=y
-CONFIG_CRYPTO_DEV_TEGRA_AES=y
 CONFIG_CPUFREQ_DT=y
 CONFIG_KEYSTONE_IRQ=y
 CONFIG_HW_RANDOM=y
-- 
2.7.4

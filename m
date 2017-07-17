From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 17 Jul 2017 07:49:51 +0200
Subject: [PATCH 1/6] ARM: multi_v7_defconfig: Cleanup from non-existing options
Message-ID: <1500270596-22384-1-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove options which do not exist anymore:
 - TEGRA_EMC_SCALING_ENABLE is gone since commit cab4d50389c6 ("ARM:
   tegra: remove TEGRA_EMC_SCALING_ENABLE");

 - ARCH_VEXPRESS_CA9X4 is gone since commit 81cc3f868d30
   ("ARM: vexpress: Remove non-DT code");

 - DRM_RCAR_HDMI was merged to generic DRM bridge and is obsolete since
   commit 5c602531feb3 ("drm: rcar-du: Replace manual bridge
   implementation with DRM bridge");

 - SND_SOC_RSRC_CARD was replaced by SND_SIMPLE_SCU_CARD in commit
   d12c6216c4a5 ("ASoC: rsrc-card: rename rsrc-card to simple-scu-card
   phase3");

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
 arch/arm/configs/multi_v7_defconfig | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 4d19c1b4b8e7..75c227600298 100644
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
@@ -603,7 +601,6 @@ CONFIG_ROCKCHIP_DW_MIPI_DSI=y
 CONFIG_ROCKCHIP_INNO_HDMI=y
 CONFIG_DRM_ATMEL_HLCDC=m
 CONFIG_DRM_RCAR_DU=m
-CONFIG_DRM_RCAR_HDMI=y
 CONFIG_DRM_RCAR_LVDS=y
 CONFIG_DRM_SUN4I=m
 CONFIG_DRM_TEGRA=y
@@ -650,7 +647,6 @@ CONFIG_SND_SOC_SMDK_WM8994_PCM=m
 CONFIG_SND_SOC_SNOW=m
 CONFIG_SND_SOC_SH4_FSI=m
 CONFIG_SND_SOC_RCAR=m
-CONFIG_SND_SOC_RSRC_CARD=m
 CONFIG_SND_SUN4I_CODEC=m
 CONFIG_SND_SOC_TEGRA=m
 CONFIG_SND_SOC_TEGRA_RT5640=m
@@ -667,6 +663,7 @@ CONFIG_SND_SOC_WM8978=m
 CONFIG_SND_SOC_STI=m
 CONFIG_SND_SOC_STI_SAS=m
 CONFIG_SND_SIMPLE_CARD=m
+CONFIG_SND_SIMPLE_SCU_CARD=m
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_MVEBU=y
@@ -695,7 +692,6 @@ CONFIG_USB_CHIPIDEA_UDC=y
 CONFIG_USB_CHIPIDEA_HOST=y
 CONFIG_AB8500_USB=y
 CONFIG_KEYSTONE_USB_PHY=y
-CONFIG_OMAP_USB3=y
 CONFIG_USB_GPIO_VBUS=y
 CONFIG_USB_ISP1301=y
 CONFIG_USB_MSM_OTG=m
@@ -728,7 +724,6 @@ CONFIG_MMC_SDHCI_MSM=y
 CONFIG_MMC_MVSDIO=y
 CONFIG_MMC_SDHI=y
 CONFIG_MMC_DW=y
-CONFIG_MMC_DW_IDMAC=y
 CONFIG_MMC_DW_PLTFM=y
 CONFIG_MMC_DW_EXYNOS=y
 CONFIG_MMC_DW_ROCKCHIP=y
@@ -825,7 +820,6 @@ CONFIG_BCMA_DRIVER_GPIO=y
 CONFIG_QCOM_GSBI=y
 CONFIG_QCOM_PM=y
 CONFIG_QCOM_SMEM=y
-CONFIG_QCOM_SMD=y
 CONFIG_QCOM_SMD_RPM=y
 CONFIG_QCOM_SMP2P=y
 CONFIG_QCOM_SMSM=y
@@ -837,7 +831,6 @@ CONFIG_CHROME_PLATFORMS=y
 CONFIG_STAGING_BOARD=y
 CONFIG_CROS_EC_CHARDEV=m
 CONFIG_COMMON_CLK_MAX77686=y
-CONFIG_COMMON_CLK_MAX77802=m
 CONFIG_COMMON_CLK_RK808=m
 CONFIG_COMMON_CLK_S2MPS11=m
 CONFIG_APQ_MMCC_8084=y
@@ -933,7 +926,6 @@ CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_LOCKUP_DETECTOR=y
-CONFIG_CRYPTO_DEV_TEGRA_AES=y
 CONFIG_CPUFREQ_DT=y
 CONFIG_KEYSTONE_IRQ=y
 CONFIG_HW_RANDOM=y
-- 
2.7.4

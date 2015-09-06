From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Sun,  6 Sep 2015 22:16:05 +0200
Subject: [PATCH 3/4] ARM: multi_v7_defconfig: Enable Rockchip display support
In-Reply-To: <1441570566-14001-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1441570566-14001-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <1441570566-14001-4-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable options needed for HDMI out on rockchip: DRM driver, Rockchip
DesignWare HDMI glue and the rockchip IOMMU (dependency of the DRM
driver).

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
---

 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 7058fef..fb673e2 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -453,6 +453,8 @@ CONFIG_DRM_EXYNOS=m
 CONFIG_DRM_EXYNOS_DSI=y
 CONFIG_DRM_EXYNOS_FIMD=y
 CONFIG_DRM_EXYNOS_HDMI=y
+CONFIG_DRM_ROCKCHIP=m
+CONFIG_ROCKCHIP_DW_HDMI=m
 CONFIG_DRM_RCAR_DU=m
 CONFIG_DRM_TEGRA=y
 CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
@@ -630,6 +632,7 @@ CONFIG_APQ_MMCC_8084=y
 CONFIG_MSM_GCC_8660=y
 CONFIG_MSM_MMCC_8960=y
 CONFIG_MSM_MMCC_8974=y
+CONFIG_ROCKCHIP_IOMMU=y
 CONFIG_TEGRA_IOMMU_GART=y
 CONFIG_TEGRA_IOMMU_SMMU=y
 CONFIG_PM_DEVFREQ=y
-- 
2.5.1

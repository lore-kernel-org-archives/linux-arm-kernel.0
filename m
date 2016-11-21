From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 22 Nov 2016 10:19:08 +1100
Subject: linux-next: manual merge of the rockchip tree with the arm-soc tree
Message-ID: <20161122101908.2e967e42@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

Today's linux-next merge of the rockchip tree got a conflict in:

  arch/arm64/configs/defconfig

between commit:

  a59294b2f7c7 ("ARM64: defconfig: Enable MMC related configs")

from the arm-soc tree and commit:

  5295a3157348 ("arm64: defconfig: enable RK808 components")

from the rockchip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc arch/arm64/configs/defconfig
index 2640e193a8c4,731cc6ade789..000000000000
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@@ -297,23 -293,10 +299,24 @@@ CONFIG_REGULATOR_MAX77620=
  CONFIG_REGULATOR_PWM=y
  CONFIG_REGULATOR_QCOM_SMD_RPM=y
  CONFIG_REGULATOR_QCOM_SPMI=y
+ CONFIG_REGULATOR_RK808=y
  CONFIG_REGULATOR_S2MPS11=y
 +CONFIG_MEDIA_SUPPORT=m
 +CONFIG_MEDIA_CAMERA_SUPPORT=y
 +CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
 +CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
 +CONFIG_MEDIA_CONTROLLER=y
 +CONFIG_VIDEO_V4L2_SUBDEV_API=y
 +# CONFIG_DVB_NET is not set
 +CONFIG_V4L_MEM2MEM_DRIVERS=y
 +CONFIG_VIDEO_RENESAS_FCP=m
 +CONFIG_VIDEO_RENESAS_VSP1=m
  CONFIG_DRM=m
  CONFIG_DRM_NOUVEAU=m
 +CONFIG_DRM_RCAR_DU=m
 +CONFIG_DRM_RCAR_HDMI=y
 +CONFIG_DRM_RCAR_LVDS=y
 +CONFIG_DRM_RCAR_VSP=y
  CONFIG_DRM_TEGRA=m
  CONFIG_DRM_PANEL_SIMPLE=m
  CONFIG_DRM_I2C_ADV7511=m
@@@ -408,7 -393,7 +414,8 @@@ CONFIG_XEN_GRANT_DEV_ALLOC=
  CONFIG_COMMON_CLK_SCPI=y
  CONFIG_COMMON_CLK_CS2000_CP=y
  CONFIG_COMMON_CLK_S2MPS11=y
 +CONFIG_COMMON_CLK_PWM=y
+ CONFIG_COMMON_CLK_RK808=y
  CONFIG_CLK_QORIQ=y
  CONFIG_COMMON_CLK_QCOM=y
  CONFIG_MSM_GCC_8916=y
@@@ -423,13 -406,13 +430,15 @@@ CONFIG_ARM_SMMU=
  CONFIG_QCOM_SMEM=y
  CONFIG_QCOM_SMD=y
  CONFIG_QCOM_SMD_RPM=y
+ CONFIG_ROCKCHIP_PM_DOMAINS=y
  CONFIG_ARCH_TEGRA_132_SOC=y
  CONFIG_ARCH_TEGRA_210_SOC=y
 +CONFIG_ARCH_TEGRA_186_SOC=y
  CONFIG_EXTCON_USB_GPIO=y
  CONFIG_PWM=y
+ CONFIG_PWM_ROCKCHIP=y
  CONFIG_PWM_TEGRA=m
 +CONFIG_PWM_MESON=m
  CONFIG_COMMON_RESET_HI6220=y
  CONFIG_PHY_RCAR_GEN3_USB2=y
  CONFIG_PHY_HI6220_USB=y

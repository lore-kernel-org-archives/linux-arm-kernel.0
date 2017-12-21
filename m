From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 21 Dec 2017 09:11:34 +0100
Subject: [GIT PULL 3/3] ARM: defconfig: exynos: config for v4.16
In-Reply-To: <20171220173643.5840-2-krzk@kernel.org>
References: <20171220173643.5840-1-krzk@kernel.org>
 <20171220173643.5840-2-krzk@kernel.org>
Message-ID: <CAJKOXPc+VNh_djbJCNmX8iA=rzJjfVL4PTJSKKcpex8f+K5y+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 20, 2017 at 6:36 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:
>
>   Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)
>
> are available in the git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-defconfig-4.16
>
> for you to fetch changes up to 6b732dfb698991b5f518be1ddf329c1c2eb3d7cb:
>
>   ARM: exynos_defconfig: Enable CONFIG_EXYNOS_IOMMU (2017-12-14 18:57:38 +0100)
>
> ----------------------------------------------------------------
> Samsung defconfig changes for v4.16
>
> 1. Enable missing drivers for supported Exynos boards (PMU, CEC, MHL
>    bridge, ASoC for Odroid XU3/XU4).
> 2. Enable Exynos IOMMU driver on exynos_defconfig.
>
> ----------------------------------------------------------------
> Marek Szyprowski (2):
>       ARM: exynos_defconfig: Enable missing drivers for supported Exynos boards
>       ARM: multi_v7_defconfig: Enable missing drivers for supported Exynos boards
>
> Shuah Khan (1):
>       ARM: exynos_defconfig: Enable CONFIG_EXYNOS_IOMMU
>
>  arch/arm/configs/exynos_defconfig   | 7 +++++++
>  arch/arm/configs/multi_v7_defconfig | 5 +++++
>  2 files changed, 12 insertions(+)

I forgot to mention possible conflict for multi_v7_defconfig (with
changes coming from keystone tree). The resolution is to take
everything from both branches. Something like:

@@@ -558,7 -583,8 +559,9 @@@ CONFIG_VIDEO_STI_DELTA=
  CONFIG_VIDEO_RENESAS_JPU=m
  CONFIG_VIDEO_RENESAS_VSP1=m
  CONFIG_V4L_TEST_DRIVERS=y
 +CONFIG_VIDEO_VIVID=m
+ CONFIG_CEC_PLATFORM_DRIVERS=y
+ CONFIG_VIDEO_SAMSUNG_S5P_CEC=m
  # CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
  CONFIG_VIDEO_ADV7180=m
  CONFIG_VIDEO_ML86V7667=m
@@@ -582,16 -613,12 +585,17 @@@ CONFIG_DRM_RCAR_DU=
  CONFIG_DRM_RCAR_LVDS=y
  CONFIG_DRM_SUN4I=m
  CONFIG_DRM_TEGRA=y
 +CONFIG_DRM_PANEL_SIMPLE=y
  CONFIG_DRM_PANEL_SAMSUNG_LD9040=m
  CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
 -CONFIG_DRM_PANEL_SIMPLE=y
 +CONFIG_DRM_DUMB_VGA_DAC=m
 +CONFIG_DRM_NXP_PTN3460=m
 +CONFIG_DRM_PARADE_PS8622=m
 +CONFIG_DRM_I2C_ADV7511=m
 +CONFIG_DRM_I2C_ADV7511_AUDIO=y
+ CONFIG_DRM_SII9234=m
  CONFIG_DRM_STI=m
 -CONFIG_DRM_VC4=y
 +CONFIG_DRM_VC4=m
  CONFIG_FB_ARMCLCD=y
  CONFIG_FB_EFI=y
  CONFIG_FB_WM8505=y
@@@ -626,9 -655,10 +630,10 @@@ CONFIG_SND_SOC_SAMSUNG=
  CONFIG_SND_SOC_SAMSUNG_SMDK_WM8994=m
  CONFIG_SND_SOC_SMDK_WM8994_PCM=m
  CONFIG_SND_SOC_SNOW=m
+ CONFIG_SND_SOC_ODROID=m
  CONFIG_SND_SOC_SH4_FSI=m
  CONFIG_SND_SOC_RCAR=m
 -CONFIG_SND_SIMPLE_SCU_CARD=m
 +CONFIG_SND_SOC_STI=m
  CONFIG_SND_SUN4I_CODEC=m
  CONFIG_SND_SOC_TEGRA=m
  CONFIG_SND_SOC_TEGRA20_I2S=m

Best regards,
Krzysztof

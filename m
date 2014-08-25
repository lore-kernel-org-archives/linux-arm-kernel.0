From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 25 Aug 2014 13:43:30 +0200
Subject: [PATCH v2 1/1] ARM: exynos_defconfig: Enable options for display
 panel support
In-Reply-To: <1408956336-17376-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1408956336-17376-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <5825205.70RuHaSG5p@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Monday, August 25, 2014 10:45:36 AM Javier Martinez Canillas wrote:
> Many Exynos devices have a display panel. Most of them just have
> a simple panel while others have more complex configurations that
> requires an embedded DisplayPort (eDP) to LVDS bridges.
> 
> This patch enables the following features to be built in the kernel
> image to suport both setups:
> 
> - Direct Rendering Manager (DRM)
> - DRM bridge registration and lookup framework
> - Parade ps8622/ps8625 eDP/LVDS bridge
> - NXP ptn3460 eDP/LVDS bridge
> - Exynos Fully Interactive Mobile Display controller (FIMD)
> - Panel registration and lookup framework
> - Simple panels
> - Backlight & LCD device support
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Tested-by: Kevin Hilman <khilman@linaro.org>

Could you please also do corresponding update to multi_v7_defconfig?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
> 
> Changes since v1:
>  - Forgot to enable ptn3460 eDP/LVDS bridge config option
>    which is used for some boards (e.g: Exynos5250 Snow).
> 
>  arch/arm/configs/exynos_defconfig | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index 676c744..d6d1f7c 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -101,11 +101,26 @@ CONFIG_REGULATOR_S2MPA01=y
>  CONFIG_REGULATOR_S2MPS11=y
>  CONFIG_REGULATOR_S5M8767=y
>  CONFIG_REGULATOR_TPS65090=y
> +CONFIG_DRM=y
> +CONFIG_DRM_BRIDGE=y
> +CONFIG_DRM_PTN3460=y
> +CONFIG_DRM_PS8622=y
> +CONFIG_DRM_EXYNOS=y
> +CONFIG_DRM_EXYNOS_FIMD=y
> +CONFIG_DRM_EXYNOS_DP=y
> +CONFIG_DRM_PANEL=y
> +CONFIG_DRM_PANEL_SIMPLE=y
>  CONFIG_FB=y
>  CONFIG_FB_MODE_HELPERS=y
>  CONFIG_FB_SIMPLE=y
>  CONFIG_EXYNOS_VIDEO=y
>  CONFIG_EXYNOS_MIPI_DSI=y
> +CONFIG_BACKLIGHT_LCD_SUPPORT=y
> +CONFIG_LCD_CLASS_DEVICE=y
> +CONFIG_LCD_PLATFORM=y
> +CONFIG_BACKLIGHT_CLASS_DEVICE=y
> +CONFIG_BACKLIGHT_GENERIC=y
> +CONFIG_BACKLIGHT_PWM=y
>  CONFIG_FRAMEBUFFER_CONSOLE=y
>  CONFIG_FONTS=y
>  CONFIG_FONT_7x14=y

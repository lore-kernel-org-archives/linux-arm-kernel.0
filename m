From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 04 Sep 2014 01:26:37 +0900
Subject: [PATCH 1/1] ARM: exynos_defconfig: Enable options for display
 panel support
In-Reply-To: <1408749185-14133-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1408749185-14133-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <041101cfc793$d5cdd4b0$81697e10$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier Martinez Canillas wrote:
> 
> Many Exynos devices have a display panel, most of them just have
> a simple panel while others have more complex configurations that
> requires an embedded DisplayPort (eDP) to LVDS display bridge.
> 
> This patch enables the following features to support both setups:
> 
> - Direct Rendering Manager (DRM)
> - DRM bridge registration and lookup framework
> - Parade ps8622/ps8625 eDP/LVDS bridge
> - NXP ptn3460 eDP/LVDS bridge
> - Exynos Fully Interactive Mobile Display controller (FIMD)
> - Panel registration and lookup framework
> - Simple panels
> - Backlight and LCD device support
> 
Thanks a lot.


> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
> 
> Some of the options enabled here (e.g: the eDP/LVDS bridges)
> are still not merged in mainline so this patch depends on
> the following posted patches that were still not merged:
> 
> "drm/bridge: Modify drm_bridge core to support driver model" [0]
> "drm/bridge: Add i2c based driver for ptn3460 bridge" [1]
> "drm/bridge: Add i2c based driver for ps8622/ps8625 bridge" [2]
> 
BTW, I can't find its re-spin...how was going on?

> But I wanted to post anyways to make easier for others to
> figure out what are the needed options to have the display
> working on their Exynos machines.
> 
> In order to test the display panel on the Peach machines,
> the following patches are also needed:
> 
> "ARM: dts: Add DT changes for display on peach_pit" [3]
> "ARM: dts: Add DT changes for display on peach_pi" [4]
> 
I'll have a look them soon.

- Kukjin

> Best regards,
> Javier
> 
> [0]: http://patchwork.ozlabs.org/patch/373792/
> [1]: http://patchwork.ozlabs.org/patch/373793/
> [2]: http://patchwork.ozlabs.org/patch/373794/
> [3]: http://www.spinics.net/lists/arm-kernel/msg350568.html
> [4]: http://www.spinics.net/lists/arm-kernel/msg350569.html
> 
>  arch/arm/configs/exynos_defconfig | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index 676c744..f69d57e 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -101,11 +101,25 @@ CONFIG_REGULATOR_S2MPA01=y
>  CONFIG_REGULATOR_S2MPS11=y
>  CONFIG_REGULATOR_S5M8767=y
>  CONFIG_REGULATOR_TPS65090=y
> +CONFIG_DRM=y
> +CONFIG_DRM_BRIDGE=y
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
> --
> 2.0.1

From: mark.yao@rock-chips.com (Mark yao)
Date: Tue, 17 Oct 2017 09:47:24 +0800
Subject: [PATCH v3 3/4] drm/rockchip: Add support for Rockchip Soc RGB
 output interface
In-Reply-To: <1507536416-110807-1-git-send-email-hjc@rock-chips.com>
References: <1507536396-106827-1-git-send-email-hjc@rock-chips.com>
 <1507536416-110807-1-git-send-email-hjc@rock-chips.com>
Message-ID: <02a599df-c866-92dc-3aa0-f63c6bc67257@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017?10?09? 16:06, Sandy Huang wrote:
> Some Rockchip CRTCs, like rv1108, can directly output parallel and
> serial RGB data to panel or conversion chip, so we add this driver to
> probe encoder and connector.
>
> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
> ---
> Changes in v3:
>    update for rgb-mode move to panel node.
> Changes in v2:
>    1. add error log when probe failed;
>    2. update name_to_output_mode() according to sean's suggest;
>    3. Fix uninitialized use of ret.
>
>   drivers/gpu/drm/rockchip/Kconfig            |   9 +
>   drivers/gpu/drm/rockchip/Makefile           |   1 +
>   drivers/gpu/drm/rockchip/rockchip_drm_drv.c |   2 +
>   drivers/gpu/drm/rockchip/rockchip_drm_drv.h |   1 +
>   drivers/gpu/drm/rockchip/rockchip_rgb.c     | 343 ++++++++++++++++++++++++++++
>   5 files changed, 356 insertions(+)
>   create mode 100644 drivers/gpu/drm/rockchip/rockchip_rgb.c
>
> diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
> index 0c31f0a..85c7cc5 100644
> --- a/drivers/gpu/drm/rockchip/Kconfig
> +++ b/drivers/gpu/drm/rockchip/Kconfig
> @@ -8,6 +8,7 @@ config DRM_ROCKCHIP
>   	select DRM_ANALOGIX_DP if ROCKCHIP_ANALOGIX_DP
>   	select DRM_DW_HDMI if ROCKCHIP_DW_HDMI
>   	select DRM_MIPI_DSI if ROCKCHIP_DW_MIPI_DSI
> +	select DRM_RGB if ROCKCHIP_RGB
>   	select SND_SOC_HDMI_CODEC if ROCKCHIP_CDN_DP && SND_SOC
>   	help
>   	  Choose this option if you have a Rockchip soc chipset.
> @@ -65,4 +66,12 @@ config ROCKCHIP_LVDS
>   	  Rockchip rk3288 SoC has LVDS TX Controller can be used, and it
>   	  support LVDS, rgb, dual LVDS output mode. say Y to enable its
>   	  driver.
> +
> +config ROCKCHIP_RGB
> +	bool "Rockchip RGB support"

See the fix[0] for lvds,  RGB driver using pinctl also need "depends on PINCTRL".

[0]https://patchwork.kernel.org/patch/9987017/

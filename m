From: seanpaul@chromium.org (Sean Paul)
Date: Mon, 6 Nov 2017 10:36:32 -0500
Subject: [PATCH] drm/rockchip: add CONFIG_OF dependency for lvds
In-Reply-To: <20171106135852.1355487-1-arnd@arndb.de>
References: <20171106135852.1355487-1-arnd@arndb.de>
Message-ID: <20171106153632.nl5av3wnoq632f3o@art_vandelay>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 06, 2017 at 02:58:43PM +0100, Arnd Bergmann wrote:
> Build-testing on randconfig kernels revealed a dependency in the
> newly added lvds sub-driver:
> 
> drivers/gpu/drm/rockchip/rockchip_lvds.c: In function 'rockchip_lvds_bind':
> drivers/gpu/drm/rockchip/rockchip_lvds.c:380:24: error: 'struct drm_bridge' has no member named 'of_node'
>    remote = lvds->bridge->of_node;
> 
> We could work around that in the code, adding a Kconfig dependency
> seems easier.
> 
> Fixes: 34cc0aa25456 ("drm/rockchip: Add support for Rockchip Soc LVDS")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the patch Arnd, I've pushed to drm-misc-next-fixes.

Sean

> ---
>  drivers/gpu/drm/rockchip/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
> index 3c70c6224bd2..0ccc76217ee4 100644
> --- a/drivers/gpu/drm/rockchip/Kconfig
> +++ b/drivers/gpu/drm/rockchip/Kconfig
> @@ -60,7 +60,7 @@ config ROCKCHIP_INNO_HDMI
>  config ROCKCHIP_LVDS
>  	bool "Rockchip LVDS support"
>  	depends on DRM_ROCKCHIP
> -	depends on PINCTRL
> +	depends on PINCTRL && OF
>  	help
>  	  Choose this option to enable support for Rockchip LVDS controllers.
>  	  Rockchip rk3288 SoC has LVDS TX Controller can be used, and it
> -- 
> 2.9.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS

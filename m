From: a.hajda@samsung.com (Andrzej Hajda)
Date: Fri, 13 Jun 2014 07:54:45 +0200
Subject: [PATCH v2 1/2] drm/panel: remove unnecessary dependencies
In-Reply-To: <E1Wv7ZP-0004Wb-3J@rmk-PC.arm.linux.org.uk>
References: <E1Wv7ZP-0004Wb-3J@rmk-PC.arm.linux.org.uk>
Message-ID: <539A9225.90304@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russel,

Thanks for both fixes. Just one nitpick.

On 06/12/2014 06:09 PM, Russell King wrote:
> DRM_PANEL_LD9040 and DRM_PANEL_S6E8AA0 both explicitly depended on
> DRM_PANEL && DRM.  This is nonsense for two reasons:
> 
> (a) DRM_PANEL already depends on DRM, so DRM_PANEL can not be enabled
> without DRM first being enabled.  Hence the && DRM is useless.

This reason is invalid and do not describe the patch anymore.

Regards
Andrzej

> 
> (b) These two configs are already beneath a menu which depends on
> DRM_PANEL being enabled; these options will not be visible without
> DRM_PANEL already being enabled.
> 
> Let's just remove this unnecessary verbosity.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/gpu/drm/panel/Kconfig | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 4ec874da5668..d83958d39f43 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -5,7 +5,7 @@ config DRM_PANEL
>  	  Panel registration and lookup framework.
>  
>  menu "Display Panels"
> -	depends on DRM_PANEL
> +	depends on DRM && DRM_PANEL
>  
>  config DRM_PANEL_SIMPLE
>  	tristate "support for simple panels"
> @@ -18,14 +18,12 @@ config DRM_PANEL_SIMPLE
>  
>  config DRM_PANEL_LD9040
>  	tristate "LD9040 RGB/SPI panel"
> -	depends on DRM && DRM_PANEL
>  	depends on OF
>  	select SPI
>  	select VIDEOMODE_HELPERS
>  
>  config DRM_PANEL_S6E8AA0
>  	tristate "S6E8AA0 DSI video mode panel"
> -	depends on DRM && DRM_PANEL
>  	depends on OF
>  	select DRM_MIPI_DSI
>  	select VIDEOMODE_HELPERS
> 

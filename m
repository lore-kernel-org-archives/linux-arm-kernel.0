From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 26 Apr 2013 07:28:50 +0200
Subject: [PATCH V2] video: imx: Select VIDEOMODE_HELPERS for parallel
 display
In-Reply-To: <1366829039-12452-1-git-send-email-marex@denx.de>
References: <1366829039-12452-1-git-send-email-marex@denx.de>
Message-ID: <20130426052850.GP32299@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 24, 2013 at 08:43:59PM +0200, Marek Vasut wrote:
> Without this, I get the following problem when building kernel:
> 
> drivers/built-in.o: In function `imx_pd_connector_get_modes':
> /linux-2.6/drivers/staging/imx-drm/parallel-display.c:78: undefined reference to `of_get_drm_display_mode'
> make: *** [vmlinux] Error 1
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

> ---
>  drivers/staging/imx-drm/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> V2: Select VIDEOMODE_HELPERS only for parallel display
> 
> diff --git a/drivers/staging/imx-drm/Kconfig b/drivers/staging/imx-drm/Kconfig
> index 8c9e403..0550f01 100644
> --- a/drivers/staging/imx-drm/Kconfig
> +++ b/drivers/staging/imx-drm/Kconfig
> @@ -19,6 +19,7 @@ config DRM_IMX_FB_HELPER
>  config DRM_IMX_PARALLEL_DISPLAY
>  	tristate "Support for parallel displays"
>  	depends on DRM_IMX
> +	select VIDEOMODE_HELPERS
>  
>  config DRM_IMX_TVE
>  	tristate "Support for TV and VGA displays"
> -- 
> 1.7.10.4
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

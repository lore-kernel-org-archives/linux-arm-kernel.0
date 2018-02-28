From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 28 Feb 2018 15:11:32 +0200
Subject: [PATCH v2] bridge: Elaborate a bit on dumb VGA bridges in Kconfig
In-Reply-To: <20180228130249.22533-1-linus.walleij@linaro.org>
References: <20180228130249.22533-1-linus.walleij@linaro.org>
Message-ID: <2696282.6cDKLY6rL2@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Thank you for the patch.

On Wednesday, 28 February 2018 15:02:49 EET Linus Walleij wrote:
> It's better if we explain a bit that this pertains to
> passive VGA DAC bridges.

s/passive/non-programmable/ ?

> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Write that these bridges are non-programmable rather than
>   discrete, as that reflects the name of the bridge being
>   "dumb". Discrete is wrong as it has a specific electronic
>   meaning, as in "non-integrated" and this is integrated.

s/discrete/passive/ :-)

> ---
>  drivers/gpu/drm/bridge/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 3b99d5a06c16..e1ab948707a0 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -30,7 +30,8 @@ config DRM_DUMB_VGA_DAC
>  	depends on OF
>  	select DRM_KMS_HELPER
>  	help
> -	  Support for RGB to VGA DAC based bridges
> +	  Support for non-programmable RGB to VGA DAC based bridges
> +	  such as ADI ADV7123 or TI THS8134 and THS8135.

How about

"Support for non-programmable RGB to VGA DAC bridges, such as ADI ADV7123, TI 
THS8134 and THS8135 or passive resistor ladder DACs."

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  config DRM_LVDS_ENCODER
>  	tristate "Transparent parallel to LVDS encoder support"

-- 
Regards,

Laurent Pinchart

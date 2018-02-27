From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 27 Feb 2018 12:29:56 +0200
Subject: [PATCH] bridge: Elaborate a bit on dumb VGA bridges in Kconfig
In-Reply-To: <20180227101200.6173-1-linus.walleij@linaro.org>
References: <20180227101200.6173-1-linus.walleij@linaro.org>
Message-ID: <3059596.rN0KS1vdqv@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Thank you for the patch.

On Tuesday, 27 February 2018 12:12:00 EET Linus Walleij wrote:
> It's better if we explain a bit that this pertains to
> passive VGA DAC bridges.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/gpu/drm/bridge/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 3b99d5a06c16..7cee8f291e7f 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -30,7 +30,8 @@ config DRM_DUMB_VGA_DAC
>  	depends on OF
>  	select DRM_KMS_HELPER
>  	help
> -	  Support for RGB to VGA DAC based bridges
> +	  Support for passive RGB to VGA DAC based bridges such
> +	  as ADI ADV7123 or TI THS8134 and THS8135.

Strictly speaking none of those components are passive: https://
en.wikipedia.org/wiki/Electronic_component#Passive_components. Only the VGA 
DACs based on resistor ladders (such as the one Maxime initially developed 
this driver for, see https://en.wikipedia.org/wiki/Resistor_ladder#R
%E2%80%932R_resistor_ladder_network_(digital_to_analog_conversion)) can be 
considered passive devices.

>  config DRM_LVDS_ENCODER
>  	tristate "Transparent parallel to LVDS encoder support"

-- 
Regards,

Laurent Pinchart

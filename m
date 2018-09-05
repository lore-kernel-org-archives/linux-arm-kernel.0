From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 5 Sep 2018 09:07:48 +0200
Subject: [PATCH v4 3/4] drm/sun4i: Enable DE2 Mixer for SUN8I and SUN50I
In-Reply-To: <20180904163609.10171-3-jagan@amarulasolutions.com>
References: <20180904163609.10171-1-jagan@amarulasolutions.com>
 <20180904163609.10171-3-jagan@amarulasolutions.com>
Message-ID: <20180905070748.g43lfdqdhmoci6pk@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 04, 2018 at 10:06:08PM +0530, Jagan Teki wrote:
> Allwinner SoC like SUN8I and SUN50I are now using DE2 Mixer
> so enable them as default.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v4, v3:
> - none
> Changes for v2:
> - Enable for SUN8I
> 
>  drivers/gpu/drm/sun4i/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kconfig
> index c2c042287c19..cfa8b96273fb 100644
> --- a/drivers/gpu/drm/sun4i/Kconfig
> +++ b/drivers/gpu/drm/sun4i/Kconfig
> @@ -61,7 +61,7 @@ config DRM_SUN8I_DW_HDMI
>  
>  config DRM_SUN8I_MIXER
>  	tristate "Support for Allwinner Display Engine 2.0 Mixer"
> -	default MACH_SUN8I
> +	default MACH_SUN8I || (ARM64 && ARCH_SUNXI)

I'm not really sure we should put it as a default. We should just
enable it in the defconfig.

Maxime

>  	help
>  	  Choose this option if you have an Allwinner SoC with the
>  	  Allwinner Display Engine 2.0, which has a mixer to do some
> -- 
> 2.18.0.321.gffc6fa0e3
> 

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180905/35e79b46/attachment.sig>

From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 31 Aug 2018 10:32:31 +0200
Subject: [PATCH v3 04/30] iio: adc: Kconfig: Update Kconfig to new build
 options
In-Reply-To: <20180830154518.29507-5-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-5-embed3d@gmail.com>
Message-ID: <20180831083231.gnxoxadfy4fwubyy@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2018 at 05:44:52PM +0200, Philipp Rossak wrote:
> Since we are merging the mfd driver into the iio adc driver we need to
> update the Kconfig build options.

Most of your commit logs a pretty short, and this is an issue for
people lacking context. This would be the reviewers, but also users
bisecting to see where there's a bug, or you in a couple of years from
now :)

Every commit log should be as complete as possible. In this case, you
are saying what you are doing, but this is actually redundant with the
patch, I can already tell what you are doing by reading the rest of
the mail. However, what is really important is *why* you are doing it.

> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  drivers/iio/adc/Kconfig | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 9da79070357c..5d0cffd6d2e4 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -713,13 +713,16 @@ config STX104
>  	  array module parameter.
>  
>  config SUN4I_GPADC
> -	tristate "Support for the Allwinner SoCs GPADC"
> +	tristate "Allwinner sunxi platforms' GPADC/Thermal driver"

I'm really not sure this is worth updating

> +	select REGMAP_MMIO
> +	select REGMAP_IRQ
>  	depends on IIO
> -	depends on MFD_SUN4I_GPADC || MACH_SUN8I
> -	depends on THERMAL || !THERMAL_OF
> +	depends on ARCH_SUNXI || MACH_SUN8I
> +	depends on THERMAL && THERMAL_OF

For example, why you are changing the thermal dependency is not really
obvious to anyone.

>  	help
>  	  Say yes here to build support for Allwinner (A10, A13 and A31) SoCs
> -	  GPADC. This ADC provides 4 channels which can be used as an ADC or as
> +	  GPADC or newer SOCs (A33, H3, A83T, ...) Thermal sensor driver.
> +	  This ADC provides 4 channels which can be used as an ADC or as

I'm not sure this is worth updating either, especially when there's
information that has been dropped.

Maxime

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180831/bfa77abd/attachment.sig>

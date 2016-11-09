From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Tue, 8 Nov 2016 16:20:32 -0800
Subject: [PATCH v7 1/3] input: touchscreen: TOUCHSCREEN_SUN4I depends on
 !SUN4I_GPADC
In-Reply-To: <20161103101601.24529-2-quentin.schulz@free-electrons.com>
References: <20161103101601.24529-1-quentin.schulz@free-electrons.com>
 <20161103101601.24529-2-quentin.schulz@free-electrons.com>
Message-ID: <20161109002032.GD8719@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 03, 2016 at 11:15:59AM +0100, Quentin Schulz wrote:
> SUN4I_GPADC and TOUCHSCREEN_SUN4I are incompatible (both are drivers
> for Allwinner SoCs' ADC). This makes sure TOUCHSCREEN_SUN4I isn't
> enabled while SUN4I_GPADC is enabled.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Please merge with SUN4I_GPADC driver patch.

> ---
> 
> added in v7
> 
>  drivers/input/touchscreen/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index efca013..c618cb9 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -1120,6 +1120,7 @@ config TOUCHSCREEN_SUN4I
>  	depends on ARCH_SUNXI || COMPILE_TEST
>  	depends on HWMON
>  	depends on THERMAL || !THERMAL_OF
> +	depends on !SUN4I_GPADC
>  	help
>  	  This selects support for the resistive touchscreen controller
>  	  found on Allwinner sunxi SoCs.
> -- 
> 2.9.3
> 

-- 
Dmitry

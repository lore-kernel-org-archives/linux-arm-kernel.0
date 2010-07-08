From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 8 Jul 2010 22:02:25 +0200
Subject: [PATCH 4/5] colibri-pxa3xx: add i2c support
In-Reply-To: <201007081904.12397.pieterg@gmx.com>
References: <201007081904.12397.pieterg@gmx.com>
Message-ID: <201007082202.25708.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 8. ?ervence 2010 19:04:12 pieterg napsal(a):
> Signed-off-by: pieter <p.grimmerink@inepro.com>
> ---
>  arch/arm/mach-pxa/colibri-pxa300.c |   17 +++++++++++++++++
>  arch/arm/mach-pxa/colibri-pxa320.c |   17 +++++++++++++++++
>  2 files changed, 34 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/colibri-pxa300.c
> b/arch/arm/mach-pxa/colibri-pxa300.c
> index 381857d..27f403d 100644
> --- a/arch/arm/mach-pxa/colibri-pxa300.c
> +++ b/arch/arm/mach-pxa/colibri-pxa300.c
> @@ -27,6 +27,7 @@
>  #include <mach/ohci.h>
>  #include <mach/pxafb.h>
>  #include <mach/audio.h>
> +#include <plat/i2c.h>
> 
>  #include "generic.h"
>  #include "devices.h"
> @@ -197,6 +198,21 @@ static void __init colibri_pxa300_init_uart(void)
>  	pxa3xx_mfp_config(ARRAY_AND_SIZE(colibri_pxa300_uart_pin_config));
>  }
> 
> +#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
> +static mfp_cfg_t colibri_pxa300_i2c_pin_config[] __initdata = {
> +	GPIO21_I2C_SCL,
> +	GPIO22_I2C_SDA,
> +};
> +
> +static void __init colibri_pxa300_init_i2c(void)
> +{
> +	pxa3xx_mfp_config(ARRAY_AND_SIZE(colibri_pxa300_i2c_pin_config));
> +	pxa_set_i2c_info(NULL);
> +}
> +#else
> +static inline void colibri_pxa300_init_i2c(void) {}
> +#endif
> +
>  void __init colibri_pxa300_init(void)
>  {
>  	pxa_set_ffuart_info(NULL);
> @@ -212,6 +228,7 @@ void __init colibri_pxa300_init(void)
>  	colibri_pxa3xx_init_mmc(ARRAY_AND_SIZE(colibri_pxa300_mmc_pin_config),
>  				mfp_to_gpio(MFP_PIN_GPIO13));
>  	colibri_pxa300_init_uart();
> +	colibri_pxa300_init_i2c();
>  }
> 
>  MACHINE_START(COLIBRI300, "Toradex Colibri PXA300")
> diff --git a/arch/arm/mach-pxa/colibri-pxa320.c
> b/arch/arm/mach-pxa/colibri-pxa320.c
> index ae835fa..0755087 100644
> --- a/arch/arm/mach-pxa/colibri-pxa320.c
> +++ b/arch/arm/mach-pxa/colibri-pxa320.c
> @@ -28,6 +28,7 @@
>  #include <mach/pxafb.h>
>  #include <mach/ohci.h>
>  #include <mach/audio.h>
> +#include <plat/i2c.h>
> 
>  #include "generic.h"
>  #include "devices.h"
> @@ -197,6 +198,21 @@ static void __init colibri_pxa320_init_uart(void)
>  	pxa3xx_mfp_config(ARRAY_AND_SIZE(colibri_pxa320_uart_pin_config));
>  }
> 
> +#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
> +static mfp_cfg_t colibri_pxa320_i2c_pin_config[] __initdata = {
> +	GPIO32_I2C_SCL,
> +	GPIO33_I2C_SDA,
> +};
> +
> +static void __init colibri_pxa320_init_i2c(void)
> +{
> +	pxa3xx_mfp_config(ARRAY_AND_SIZE(colibri_pxa320_i2c_pin_config));
> +	pxa_set_i2c_info(NULL);
> +}
> +#else
> +static inline void colibri_pxa320_init_i2c(void) {}
> +#endif
> +
>  void __init colibri_pxa320_init(void)
>  {
>  	pxa_set_ffuart_info(NULL);
> @@ -212,6 +228,7 @@ void __init colibri_pxa320_init(void)
>  	colibri_pxa3xx_init_mmc(ARRAY_AND_SIZE(colibri_pxa320_mmc_pin_config),
>  				mfp_to_gpio(MFP_PIN_GPIO28));
>  	colibri_pxa320_init_uart();
> +	colibri_pxa320_init_i2c();
>  }
> 
>  MACHINE_START(COLIBRI320, "Toradex Colibri PXA320")

It looks correct ...

Acked-by: Marek Vasut <marek.vasut@gmail.com>

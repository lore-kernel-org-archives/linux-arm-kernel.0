From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 4 Feb 2013 09:54:52 +0100
Subject: [PATCH] ARM:omap2: using strlcpy instead of strncpy
In-Reply-To: <51090829.1010109@asianux.com>
References: <51090829.1010109@asianux.com>
Message-ID: <510F775C.6010404@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/30/2013 12:46 PM, Chen Gang wrote:
> 
>   the fields must be null-terminated:
>   the caller may use it as null-terminted string, next.
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> ---
>  arch/arm/mach-omap2/twl-common.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
> index e49b40b..6a7aec6 100644
> --- a/arch/arm/mach-omap2/twl-common.c
> +++ b/arch/arm/mach-omap2/twl-common.c
> @@ -23,6 +23,7 @@
>  #include <linux/i2c.h>
>  #include <linux/i2c/twl.h>
>  #include <linux/gpio.h>
> +#include <linux/string.h>
>  #include <linux/regulator/machine.h>
>  #include <linux/regulator/fixed.h>
>  
> @@ -56,7 +57,7 @@ void __init omap_pmic_init(int bus, u32 clkrate,
>  			   struct twl4030_platform_data *pmic_data)
>  {
>  	omap_mux_init_signal("sys_nirq", OMAP_PIN_INPUT_PULLUP | OMAP_PIN_OFF_WAKEUPENABLE);
> -	strncpy(pmic_i2c_board_info.type, pmic_type,
> +	strlcpy(pmic_i2c_board_info.type, pmic_type,
>  		sizeof(pmic_i2c_board_info.type));
>  	pmic_i2c_board_info.irq = pmic_irq;
>  	pmic_i2c_board_info.platform_data = pmic_data;
> 


-- 
P?ter

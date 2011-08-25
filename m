From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 25 Aug 2011 11:50:12 +0200
Subject: [PATCH 6/6] mx31moboard: Add MC13783 power button support
In-Reply-To: <1311344232-29902-7-git-send-email-philippe.retornaz@epfl.ch>
References: <1311344232-29902-1-git-send-email-philippe.retornaz@epfl.ch>
	<1311344232-29902-2-git-send-email-philippe.retornaz@epfl.ch>
	<1311344232-29902-3-git-send-email-philippe.retornaz@epfl.ch>
	<1311344232-29902-4-git-send-email-philippe.retornaz@epfl.ch>
	<1311344232-29902-5-git-send-email-philippe.retornaz@epfl.ch>
	<1311344232-29902-6-git-send-email-philippe.retornaz@epfl.ch>
	<1311344232-29902-7-git-send-email-philippe.retornaz@epfl.ch>
Message-ID: <20110825095012.GR31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 22, 2011 at 04:17:12PM +0200, Philippe R?tornaz wrote:
> Add the power-on button on mx31moboard using MC13783 PMIC.
> 
> Signed-off-by: Philippe R?tornaz <philippe.retornaz@epfl.ch>

Please ping once the rest is merged.

Sascha

> ---
>  arch/arm/mach-imx/mach-mx31moboard.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
> index 579ca1f..2a43492 100644
> --- a/arch/arm/mach-imx/mach-mx31moboard.c
> +++ b/arch/arm/mach-imx/mach-mx31moboard.c
> @@ -28,6 +28,7 @@
>  #include <linux/spi/spi.h>
>  #include <linux/types.h>
>  #include <linux/memblock.h>
> +#include <linux/input.h>
>  
>  #include <linux/usb/otg.h>
>  #include <linux/usb/ulpi.h>
> @@ -264,12 +265,19 @@ static struct mc13783_leds_platform_data moboard_leds = {
>  	.tc2_period = MC13783_LED_PERIOD_10MS,
>  };
>  
> +static struct mc13783_buttons_platform_data moboard_buttons = {
> +	.b1on_flags = MC13783_BUTTON_DBNC_750MS | MC13783_BUTTON_ENABLE |
> +			MC13783_BUTTON_POL_INVERT,
> +	.b1on_key = KEY_POWER,
> +};
> +
>  static struct mc13xxx_platform_data moboard_pmic = {
>  	.regulators = {
>  		.regulators = moboard_regulators,
>  		.num_regulators = ARRAY_SIZE(moboard_regulators),
>  	},
>  	.leds = &moboard_leds,
> +	.buttons = &moboard_buttons,
>  	.flags = MC13XXX_USE_RTC | MC13XXX_USE_ADC,
>  };
>  
> -- 
> 1.6.3.3
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

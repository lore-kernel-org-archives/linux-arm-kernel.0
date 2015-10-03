From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Sat, 03 Oct 2015 14:19:24 +0200
Subject: [PATCH v4 02/26] ARM: pxa: magician: Change comments to be more
 informative
In-Reply-To: <5609ACBA.6080503@tul.cz>
References: <cover.1443472089.git.petr.cvek@tul.cz> <5609ACBA.6080503@tul.cz>
Message-ID: <1443874764.4186.8.camel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 28.09.2015, 23:10 +0200 schrieb Petr Cvek:
> This patch changes the comments in the HTC Magician machine source
> code
> to better describe used devices and interfaces.
> 
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>

This is mostly fine, some comments below.

[...]
>  static struct resource egpio_resources[] = {
> @@ -197,7 +199,10 @@ static struct htc_egpio_chip egpio_chips[] = {
>  		.gpio_base	= MAGICIAN_EGPIO(0, 0),
>  		.num_gpios	= 24,
>  		.direction	= HTC_EGPIO_OUTPUT,
> -		.initial_values	= 0x40, /*
> EGPIO_MAGICIAN_GSM_RESET */
> +		/*
> +		 * Depends on modules configuration
> +		 */
> +		.initial_values	= 0x40,
>  	},
>  	[1] = {
>  		.reg_start	= 4,

Why drop the info that this is the GSM reset while improving comments
in every other place with more information?

[...]
> +/*
> + * LCD PWM backlight (main)
> + *
> + * MP1521 frequency should be:
> + *	100-400 Hz = 2?.5*10^6 - 10?*10^6 ns

What is MP1521?

[...]
> @@ -459,7 +475,7 @@ static struct pasic3_leds_machinfo
> pasic3_leds_info = {
>  };
>  
>  /*
> - * PASIC3 with DS1WM
> + * PASIC3 DS1WM
>   */

This is indeed an mfd chip that contains a DS1WM IP core. I think the
older comment is better.

> @@ -492,7 +508,7 @@ static struct platform_device pasic3 = {
>  };
>  
>  /*
> - * USB "Transceiver"
> + * PXA UDC
>   */
>  
>  static struct resource gpio_vbus_resource = {

You fix this in a later commit, but here the change is incorrect.

regards
Philipp

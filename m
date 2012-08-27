From: ludovic.desroches@atmel.com (ludovic.desroches)
Date: Mon, 27 Aug 2012 12:24:38 +0200
Subject: [PATCH v11 4/4] G45 TWI: remove open drain setting for twi
 function gpios
In-Reply-To: <6acdbd0f06cb9902efc510346564e10b07fa0b91.1345618760.git.n.voss@weinmann.de>
References: <cover.1345618760.git.n.voss@weinmann.de>
 <6acdbd0f06cb9902efc510346564e10b07fa0b91.1345618760.git.n.voss@weinmann.de>
Message-ID: <503B4AE6.4090107@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nikolaus,

Le 11/08/2011 12:11 PM, Nikolaus Voss a ?crit :
> The G45 datasheets explicitly states that setting the open drain property
> on peripheral function gpios is not allowed. (How about other A91 chips?)
>


Did you remove open drain because you had some issues or because you had 
seen it into datasheet?

I tried with and without open drain. The behavior was the same. Looking 
to the G45 datasheet, I didn't see that the open drain property is not 
allowed on peripheral function gpios:

'The Multi Drive can be selected whether the I/O line
is controlled by the PIO controller or assigned to a peripheral function.'

The datasheet should have been updated or there is another place where 
it is mentioned that open drain property is not allowed in this case.


Regards

Ludovic

> Signed-off-by: Nikolaus Voss <n.voss@weinmann.de>
> ---
>   arch/arm/mach-at91/at91sam9g45_devices.c |    6 ------
>   1 file changed, 6 deletions(-)
>
> diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
> index eec5eb6..2134663 100644
> --- a/arch/arm/mach-at91/at91sam9g45_devices.c
> +++ b/arch/arm/mach-at91/at91sam9g45_devices.c
> @@ -686,18 +686,12 @@ void __init at91_add_device_i2c(short i2c_id, struct i2c_board_info *devices, in
>   	/* pins used for TWI interface */
>   	if (i2c_id == 0) {
>   		at91_set_A_periph(AT91_PIN_PA20, 0);		/* TWD */
> -		at91_set_multi_drive(AT91_PIN_PA20, 1);
> -
>   		at91_set_A_periph(AT91_PIN_PA21, 0);		/* TWCK */
> -		at91_set_multi_drive(AT91_PIN_PA21, 1);
>
>   		platform_device_register(&at91sam9g45_twi0_device);
>   	} else {
>   		at91_set_A_periph(AT91_PIN_PB10, 0);		/* TWD */
> -		at91_set_multi_drive(AT91_PIN_PB10, 1);
> -
>   		at91_set_A_periph(AT91_PIN_PB11, 0);		/* TWCK */
> -		at91_set_multi_drive(AT91_PIN_PB11, 1);
>
>   		platform_device_register(&at91sam9g45_twi1_device);
>   	}
>

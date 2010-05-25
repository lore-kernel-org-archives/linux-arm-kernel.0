From: tbm@cyrius.com (Martin Michlmayr)
Date: Tue, 25 May 2010 20:04:46 +0100
Subject: [PATCH] orion5x: Set links to solid on D-Link DNS-323
In-Reply-To: <20100326112030.GA29585@jirafa.cyrius.com>
References: <20100326112030.GA29585@jirafa.cyrius.com>
Message-ID: <20100525190446.GA27367@jirafa.cyrius.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Martin Michlmayr <tbm@cyrius.com> [2010-03-26 11:20]:
> Among other changes, commit b2a731aa ("D-link DNS-323 revision A1 power
> LED") changed the default behaviour of the power LED from solid to
> blinking.  This was done to match the original DNS-323 firmware which
> blinks during the boot process and sets the LED to solid when booting
> has completed.  However, the downside of this behaviour is that it
> requires userland code to change the LED, even for those who don't
> care about the behaviour of the original firmware.  Therefore, change
> it to solid again and let those who care about the original behaviour
> change the behaviour from userland.

*ping*

> Signed-off-by: Martin Michlmayr <tbm@cyrius.com>
> 
> --- a/arch/arm/mach-orion5x/dns323-setup.c
> +++ b/arch/arm/mach-orion5x/dns323-setup.c
> @@ -262,7 +262,7 @@ static struct gpio_led dns323_leds[] = {
>  	{
>  		.name = "power:blue",
>  		.gpio = DNS323_GPIO_LED_POWER2,
> -		.default_trigger = "timer",
> +		.default_trigger = "default-on",
>  	}, {
>  		.name = "right:amber",
>  		.gpio = DNS323_GPIO_LED_RIGHT_AMBER,
> 
> -- 
> Martin Michlmayr
> http://www.cyrius.com/
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Martin Michlmayr
http://www.cyrius.com/

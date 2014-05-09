From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 9 May 2014 12:03:54 +0200
Subject: [PATCH] misc: atmel_pwm: only build for supported platforms
In-Reply-To: <1399560990-1402858-17-git-send-email-arnd@arndb.de>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-17-git-send-email-arnd@arndb.de>
Message-ID: <536CA80A.60201@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/2014 16:56, Arnd Bergmann :
> There is architecture code in mach-at91 that depends on the
> CONFIG_ATMEL_PWM symbol in order to call the soc-specific
> at91_add_device_pwm function. While all of this is about code
> that will be removed in the future, using DT probing and
> the PWM framework, we currently get a build failure:
> 
> arch/arm/mach-at91/built-in.o: In function `at91_pwm_leds':
> arch/arm/mach-at91/leds.c:88: undefined reference to `at91_add_device_pwm'
> 
> This patch ensures we only try to build this driver on
> platforms on which it will build and work.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks,

> ---
>  drivers/misc/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index fe2230c..ce29342 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -53,7 +53,8 @@ config AD525X_DPOT_SPI
>  
>  config ATMEL_PWM
>  	tristate "Atmel AT32/AT91 PWM support"
> -	depends on HAVE_CLK && (AVR32 || ARCH_AT91 || COMPILE_TEST)
> +	depends on HAVE_CLK
> +	depends on AVR32 || AT91SAM9263 || AT91SAM9RL || AT91SAM9G45
>  	help
>  	  This option enables device driver support for the PWM channels
>  	  on certain Atmel processors.  Pulse Width Modulation is used for
> 


-- 
Nicolas Ferre

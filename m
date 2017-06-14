From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Wed, 14 Jun 2017 11:29:42 +0200
Subject: [PATCH] tty/serial: Kconfig: remove AVR32
In-Reply-To: <20170613203509.32026-1-alexandre.belloni@free-electrons.com>
References: <20170613203509.32026-1-alexandre.belloni@free-electrons.com>
Message-ID: <7700c2bd-9a54-af44-28a1-693b704bec91@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 13/06/2017 ? 22:35, Alexandre Belloni a ?crit :
> AVR32 is now removed from the kernel, removed the config symbol that
> doesn't exist anymore. Also take the opportunity to reword the help to
> include sama5.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/tty/serial/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 5c8850f7a2a0..063c71e8de41 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -114,14 +114,14 @@ config SERIAL_SB1250_DUART_CONSOLE
>  	  If unsure, say Y.
>  
>  config SERIAL_ATMEL
> -	bool "AT91 / AT32 on-chip serial port support"
> +	bool "Atmel on-chip serial port support"

Now, I would add something like "Microchip/Atmel", it's more future-proof.

>  	depends on HAS_DMA
> -	depends on ARCH_AT91 || AVR32 || COMPILE_TEST
> +	depends on ARCH_AT91 || COMPILE_TEST
>  	select SERIAL_CORE
>  	select SERIAL_MCTRL_GPIO if GPIOLIB
>  	help
>  	  This enables the driver for the on-chip UARTs of the Atmel

Here as well...

> -	  AT91 and AT32 processors.
> +	  ARM processors.
>  
>  config SERIAL_ATMEL_CONSOLE
>  	bool "Support for console on AT91 / AT32 serial port"

What about removing AT32 here as well ^ ?

> 


-- 
Nicolas Ferre

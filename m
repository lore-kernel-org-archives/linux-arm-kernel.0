From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 27 Nov 2013 10:48:19 +0100
Subject: [PATCH] tty: atmel_serial: include <mach/hardware.h> explicitly
In-Reply-To: <1385545111-1256-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1385545111-1256-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <5295BFE3.5070700@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/11/2013 10:38, Uwe Kleine-K?nig :
> When compiled for at91rm9200 (i.e. ARM) the driver needs among others
> the symbol AT91RM9200_BASE_US0 which is defined in
> arch/arm/mach-at91/include/mach/at91rm9200.h. This file is included
> implicitly via several steps. As ARM's <asm/timex.h> will stop including
> <mach/hardware.h> later in this series explicitly include
> <mach/hardware.h>
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Uwe, this AT91RM9200_BASE_US0 value is supposed to disappear in 3.14 
tanks to a patch from Linus W. ([PATCH v4] ARM/serial: at91: switch 
atmel serial to use gpiolib) (not in linux-next yet).

So I think that this patch is not needed for 3.14.

Bye,

> ---
>
> Notes:
>      Hello,
>
>      I want to send this patch as part of a series dropping <mach/timex.h>
>      altogether. So please don't take this patch but only give your Ack if
>      you're OK with me sending this patch via arm-soc.
>
>      Thanks
>      Uwe
>
>   drivers/tty/serial/atmel_serial.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index c7d99af..de51964 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -47,6 +47,7 @@
>
>   #ifdef CONFIG_ARM
>   #include <mach/cpu.h>
> +#include <mach/hardware.h>
>   #include <asm/gpio.h>
>   #endif
>
>


-- 
Nicolas Ferre

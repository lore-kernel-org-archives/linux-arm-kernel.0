From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Fri, 4 May 2018 14:16:19 +0200
Subject: [PATCH REPOST] mfd: syscon: atmel-smc: include string.h
In-Reply-To: <20180504103446.20104-1-bigeasy@linutronix.de>
References: <20180504103446.20104-1-bigeasy@linutronix.de>
Message-ID: <20180504121619.GJ10960@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/2018 12:34:46+0200, Sebastian Andrzej Siewior wrote:
> The string.h header file is needed for the memset() definition. The RT
> build fails because it is not pulled in via other header files.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/mfd/atmel-smc.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- a/drivers/mfd/atmel-smc.c
> +++ b/drivers/mfd/atmel-smc.c
> @@ -12,6 +12,7 @@
>   */
>  
>  #include <linux/mfd/syscon/atmel-smc.h>
> +#include <linux/string.h>
>  
>  /**
>   * atmel_smc_cs_conf_init - initialize a SMC CS conf

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

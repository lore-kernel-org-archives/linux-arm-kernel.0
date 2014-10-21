From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 21 Oct 2014 16:18:34 +0200
Subject: [PATCH] power: reset: at91-reset: fix power down register
In-Reply-To: <1413829629-8705-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1413829629-8705-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <54466B3A.5030005@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/10/2014 20:27, Alexandre Belloni :
> In the case of at91sam9g45_restart(), the driver is writing
> AT91_DDRSDRC_LPCB_POWER_DOWN to AT91_DDRSDRC_RTR, this should actually be
> AT91_DDRSDRC_LPR.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Absolutely:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

If you don't mind Dmitry, I'll take this patch through the at91/arm-soc
git trees in my next at91-3.18-fixes branch.

Thanks Alex, bye,

> ---
>  drivers/power/reset/at91-reset.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
> index 3611806c9cfd..3cb36693343a 100644
> --- a/drivers/power/reset/at91-reset.c
> +++ b/drivers/power/reset/at91-reset.c
> @@ -100,11 +100,11 @@ static void at91sam9g45_restart(enum reboot_mode mode, const char *cmd)
>  		/* Disable SDRAM0 accesses */
>  		"1:	str	%3, [%0, #" __stringify(AT91_DDRSDRC_RTR) "]\n\t"
>  		/* Power down SDRAM0 */
> -		"	str	%4, [%0, #" __stringify(AT91_DDRSDRC_RTR) "]\n\t"
> +		"	str	%4, [%0, #" __stringify(AT91_DDRSDRC_LPR) "]\n\t"
>  		/* Disable SDRAM1 accesses */
>  		"	strne	%3, [%1, #" __stringify(AT91_DDRSDRC_RTR) "]\n\t"
>  		/* Power down SDRAM1 */
> -		"	strne	%4, [%1, #" __stringify(AT91_DDRSDRC_RTR) "]\n\t"
> +		"	strne	%4, [%1, #" __stringify(AT91_DDRSDRC_LPR) "]\n\t"
>  		/* Reset CPU */
>  		"	str	%5, [%2, #" __stringify(AT91_RSTC_CR) "]\n\t"
>  
> 


-- 
Nicolas Ferre

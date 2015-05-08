From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 07 May 2015 17:04:05 -0700
Subject: [PATCH 05/12] watchdog: st_wdt: Update IP layout information
 to include Clocksource
In-Reply-To: <1431005924-21777-6-git-send-email-lee.jones@linaro.org>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
 <1431005924-21777-6-git-send-email-lee.jones@linaro.org>
Message-ID: <554BFD75.1070601@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/2015 06:38 AM, Lee Jones wrote:
> Initial submission adding support for this IP only included Watchdog and
> the Real-Time Clock.  Now the third (and final) device is enabled this
> trivial patch is required to update the comment in the Watchdog driver
> to encompass Clocksource.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/st_lpc_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/st_lpc_wdt.c b/drivers/watchdog/st_lpc_wdt.c
> index f32be15..6785afd 100644
> --- a/drivers/watchdog/st_lpc_wdt.c
> +++ b/drivers/watchdog/st_lpc_wdt.c
> @@ -197,7 +197,7 @@ static int st_wdog_probe(struct platform_device *pdev)
>   		return -EINVAL;
>   	}
>
> -	/* LPC can either run in RTC or WDT mode */
> +	/* LPC can either run as a Clocksource or in RTC or WDT mode */
>   	if (mode != ST_LPC_MODE_WDT)
>   		return -ENODEV;
>
>

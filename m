From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 9 May 2015 15:58:54 +0200
Subject: [rtc-linux] [PATCH 07/12] rtc: st: Update IP layout information
 to include Clocksource
In-Reply-To: <1431005924-21777-8-git-send-email-lee.jones@linaro.org>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
 <1431005924-21777-8-git-send-email-lee.jones@linaro.org>
Message-ID: <20150509135854.GE3338@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/2015 at 14:38:39 +0100, Lee Jones wrote :
> Initial submission adding support for this IP only included Watchdog and
> the Real-Time Clock.  Now the third (and final) device is enabled this
> trivial patch is required to update the comment in the RTC driver to
> encompass Clocksource.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

I'm guessing this will go through the mfd tree along with the driver?

> ---
>  drivers/rtc/rtc-st-lpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-st-lpc.c b/drivers/rtc/rtc-st-lpc.c
> index 3f9d0ac..74c0a33 100644
> --- a/drivers/rtc/rtc-st-lpc.c
> +++ b/drivers/rtc/rtc-st-lpc.c
> @@ -208,7 +208,7 @@ static int st_rtc_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	/* LPC can either run in RTC or WDT mode */
> +	/* LPC can either run as a Clocksource or in RTC or WDT mode */
>  	if (mode != ST_LPC_MODE_RTC)
>  		return -ENODEV;
>  
> -- 
> 1.9.1
> 
> -- 
> -- 
> You received this message because you are subscribed to "rtc-linux".
> Membership options at http://groups.google.com/group/rtc-linux .
> Please read http://groups.google.com/group/rtc-linux/web/checklist
> before submitting a driver.
> --- 
> You received this message because you are subscribed to the Google Groups "rtc-linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

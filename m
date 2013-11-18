From: akpm@linux-foundation.org (Andrew Morton)
Date: Mon, 18 Nov 2013 14:37:40 -0800
Subject: [PATCH] rtc: rtc-at91rm9200: Corrected alarm over day/month wrap:
In-Reply-To: <1384795254-11996-1-git-send-email-nicolas.ferre@atmel.com>
References: <1384795254-11996-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20131118143740.cdb5c0ee72b3d68e443afd66@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 18 Nov 2013 18:20:54 +0100 Nicolas Ferre <nicolas.ferre@atmel.com> wrote:

> From: Linus Pizunski <linus@narrativeteam.com>
> 
> Update month and day of month to the alarm month/day instead
> of current day/month when setting the RTC alarm mask.
> 
> Signed-off-by: Linus Pizunski <linus@narrativeteam.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

I changed this to signed-off-by, as you were on the patch delivery path.

> --- a/drivers/rtc/rtc-at91rm9200.c
> +++ b/drivers/rtc/rtc-at91rm9200.c
> @@ -220,6 +220,8 @@ static int at91_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
>  
>  	at91_alarm_year = tm.tm_year;
>  
> +	tm.tm_mon = alrm->time.tm_mon;
> +	tm.tm_mday = alrm->time.tm_mday;
>  	tm.tm_hour = alrm->time.tm_hour;
>  	tm.tm_min = alrm->time.tm_min;
>  	tm.tm_sec = alrm->time.tm_sec;

I queued this for 3.13.  Do we think it warrants a -stable backport?

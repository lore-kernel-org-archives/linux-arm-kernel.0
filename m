From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 7 Jun 2016 19:42:21 +0300
Subject: [PATCH] clocksource/drivers/digicolor: fix warning of non-static
 function
In-Reply-To: <1465308710-18297-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465308710-18297-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20160607164221.GI2425@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

On Tue, Jun 07, 2016 at 03:11:50PM +0100, Ben Dooks wrote:
> Change the dc_timer function to be static as it is not used outside
> this driver. This fixes the following warning:
> 
> drivers/clocksource/timer-digicolor.c:66:24: warning: symbol 'dc_timer' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Acked-by: Baruch Siach <baruch@tkos.co.il>

Thanks,
baruch

> ---
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Baruch Siach <baruch@tkos.co.il>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  drivers/clocksource/timer-digicolor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/timer-digicolor.c b/drivers/clocksource/timer-digicolor.c
> index a536eeb..96bb222 100644
> --- a/drivers/clocksource/timer-digicolor.c
> +++ b/drivers/clocksource/timer-digicolor.c
> @@ -63,7 +63,7 @@ struct digicolor_timer {
>  	int timer_id; /* one of TIMER_* */
>  };
>  
> -struct digicolor_timer *dc_timer(struct clock_event_device *ce)
> +static struct digicolor_timer *dc_timer(struct clock_event_device *ce)
>  {
>  	return container_of(ce, struct digicolor_timer, ce);
>  }

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -

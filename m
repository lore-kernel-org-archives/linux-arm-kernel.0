From: baolin.wang@linaro.org (Baolin Wang)
Date: Fri, 16 Nov 2018 11:24:42 +0800
Subject: [PATCH 1/2] clocksource: Demote dbx500 PRCMU clocksource
In-Reply-To: <20181115133203.28567-1-linus.walleij@linaro.org>
References: <20181115133203.28567-1-linus.walleij@linaro.org>
Message-ID: <CAMz4kuKvqX7B1tundeLTHvttTvE7kv3unLiu-G5z9w5zpQpf8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 November 2018 at 21:32, Linus Walleij <linus.walleij@linaro.org> wrote:
> Demote the DBx500 PRCMU clocksource to quality 100 and
> mark it as NONSTOP so it will still be used for
> timekeeping across suspend/resume.
>
> The Nomadik MTU timer which has higher precision will
> be used when the system is up and running, thanks to
> the recent changes properly utilizing the suspend
> clocksources.
>
> This was discussed back in 2011 when the driver was
> written, but the infrastructure was not available
> upstream to use this timer properly. Now the
> infrastructure is there, so let's finalize the work.
>
> Cc: Baolin Wang <baolin.wang@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Glad to see new driver uses the suspend clocksource.
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>

>  drivers/clocksource/clksrc-dbx500-prcmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clocksource/clksrc-dbx500-prcmu.c b/drivers/clocksource/clksrc-dbx500-prcmu.c
> index c1b96dc5f444..4054539fe066 100644
> --- a/drivers/clocksource/clksrc-dbx500-prcmu.c
> +++ b/drivers/clocksource/clksrc-dbx500-prcmu.c
> @@ -46,10 +46,10 @@ static u64 notrace clksrc_dbx500_prcmu_read(struct clocksource *cs)
>
>  static struct clocksource clocksource_dbx500_prcmu = {
>         .name           = "dbx500-prcmu-timer",
> -       .rating         = 300,
> +       .rating         = 100,
>         .read           = clksrc_dbx500_prcmu_read,
>         .mask           = CLOCKSOURCE_MASK(32),
> -       .flags          = CLOCK_SOURCE_IS_CONTINUOUS,
> +       .flags          = CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SUSPEND_NONSTOP,
>  };
>
>  #ifdef CONFIG_CLKSRC_DBX500_PRCMU_SCHED_CLOCK
> --
> 2.17.2
>



-- 
Baolin Wang
Best Regards

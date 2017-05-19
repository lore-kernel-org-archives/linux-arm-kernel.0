From: joel@jms.id.au (Joel Stanley)
Date: Fri, 19 May 2017 13:14:20 +0800
Subject: [PATCH 7/8 v2] clocksource/drivers/fttmr010: Merge Moxa into
 FTTMR010
In-Reply-To: <20170518201705.28790-7-linus.walleij@linaro.org>
References: <20170518201705.28790-1-linus.walleij@linaro.org>
 <20170518201705.28790-7-linus.walleij@linaro.org>
Message-ID: <CACPK8XeRo0-PEWmGERJuKUpC41fRT6TwAiuDEABrNiEPVZBWwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 4:17 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> This merges the Moxa Art timer driver into the Faraday FTTMR010
> driver and replaces all Kconfig symbols to use the Faraday
> driver instead. We are now so similar that the drivers can
> be merged by just adding a few lines to the Faraday timer.
>
> Differences:
>
> - The Faraday driver explicitly sets the counter to count
>   upwards for the clocksource, removing the need for the
>   clocksource core to invert the value.
>
> - The Faraday driver also handles sched_clock()
>
> On the Aspeed, the counter can only count downwards, so support
> the timers in downward-counting mode as well, and flag the
> Aspeed to use this mode. This mode was tested on the Gemini so
> I have high hopes that it'll work fine on the Aspeed as well.
>
> After this we have one driver for all three SoCs and a generic
> Faraday FTTMR010 timer driver, which is nice.
>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Jonas Jensen <jonas.jensen@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - As it appears that the Aspeed timers can only count downwards,
>   augment the code to deal with downward counting clockevent,
>   clock source and sched_clock(), and flag the Aspeed for this
>   mode.
>
> ARM SoC folks: please ACK this so it can be merged with in the
> clocksource subsystem once it works.
>
> Joel: it would be super if you can test this. If you have some
> vendor tree or similar that actually indicates where the
> up/down counter bits are it's even better, but I'm hoping that
> this half-assed guesswork will JustWork(TM) (yeah, famous
> last words, sorry...)

I gave it a spin on the ast2500-evb and it worked for me.

I also gave it a read through and it looks good. I'd lowercase the
shouty FTTMR010-TIMER message that pops up during boot, but it's no
biggie.

Reviewed-by: Joel Stanley <joel@jms.id.au>
Tested-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel

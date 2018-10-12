From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 12 Oct 2018 17:03:41 +0800
Subject: [linux-sunxi] [PATCH v2 04/29] clk: sunxi-ng: h6: Set video PLLs
 limits
In-Reply-To: <a303145c-b123-d912-91d7-9830dec3244e@openedev.com>
References: <20181007093905.11253-1-jernej.skrabec@siol.net>
 <20181007093905.11253-5-jernej.skrabec@siol.net>
 <a303145c-b123-d912-91d7-9830dec3244e@openedev.com>
Message-ID: <CAGb2v64GM4JBx4SqjpWgAw3kEKA9m2-7trwiok8fy+xOQGV7Eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 12, 2018 at 4:14 PM Jagan Teki <jagan@openedev.com> wrote:
>
> On Sunday 07 October 2018 03:08 PM, Jernej Skrabec wrote:
> > Video PLL factors can be set in a way that final PLL rate is outside
> > stable range. H6 user manual specifically says that N factor should not
> > be below 12. While it doesn't says anything about maximum stable rate, it
>
> Manual says "In application, PLL_FACTOR_N should be more than or equal
> to 11" can't it be 11?

PLL_FACTOR_N is the raw value, which starts from 0.
That translates to an actual factor of 12 used in the calculations.

> > is clear that PLL doesn't work at 6.096 GHz (254 * 24 MHz).
> >
> > Set minimum allowed PLL video rate to 288 MHz (12 * 24 MHz) and maximum
> > to 2.4 GHz, which is maximum in BSP driver.
>
> Is this max freq from here [1]
>
> [1]
> https://github.com/Allwinner-Homlet/H6-BSP4.9-linux/blob/master/drivers/clk/sunxi/clk-sun50iw6.c#L164
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.

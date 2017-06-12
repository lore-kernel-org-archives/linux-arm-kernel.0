From: tony@atomide.com (Tony Lindgren)
Date: Mon, 12 Jun 2017 00:32:27 -0700
Subject: [PATCH RFC 2/5] ARM: dts: am335x-baltos: use IRQ_TYPE_* to
 specify irq flags
In-Reply-To: <CAGm1_kuKxVOetzMLdnVO+xQ7egX+paqOHLS+ckz6nFwKD5QBuQ@mail.gmail.com>
References: <20170526180609.2699-1-uwe@kleine-koenig.org>
 <20170526180609.2699-2-uwe@kleine-koenig.org>
 <20170531171932.GH3730@atomide.com>
 <CAGm1_ktJp+3t9ExuFJhKTmbM63yt-82PGP26KkEHGqK-tnfWRg@mail.gmail.com>
 <CAGm1_kuKxVOetzMLdnVO+xQ7egX+paqOHLS+ckz6nFwKD5QBuQ@mail.gmail.com>
Message-ID: <20170612073227.GS3730@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Yegor Yefremov <yegorslists@googlemail.com> [170606 07:37]:
> On Wed, May 31, 2017 at 7:22 PM, Yegor Yefremov
> <yegorslists@googlemail.com> wrote:
> > Hi Uwe, Tony,
> >
> > On Wed, May 31, 2017 at 7:19 PM, Tony Lindgren <tony@atomide.com> wrote:
> >> * Uwe Kleine-K?nig <uwe@kleine-koenig.org> [170526 11:09]:
> >>> According to the binding documentation and the source code the omap-gpio
> >>> controller takes IRQ_TYPE_* as its flags values, not GPIO_ACTIVE_*.
> >>>
> >>> This patch uses the right variable type which yields the same result
> >>> when compiled. Note that this might be wrong and actually
> >>> IRQ_TYPE_LEVEL_LOW is intended by the dt author.
> >>>
> >>> Signed-off-by: Uwe Kleine-K?nig <uwe@kleine-koenig.org>
> >>> ---
> >>> Hello,
> >>>
> >>> can somebody with the hardware or it's documentation please check which
> >>> flag is the right one?
> >>
> >> I'll wait on this one until we have somebody test it.
> >
> > I'll look at it this week.
> 
> This is what works for me (at least it doesn't produce "irq 88: nobody
> cared (try booting with the "irqpoll" option)").
> 
> As for tca6416 it is working with all possible settings (from
> IRQ_TYPE_EDGE_RISING till IRQ_TYPE_LEVEL_LOW). "cat /proc/interrupts"
> always shows Level type:
> 
> 47:          5  44e07000.gpio  20 Level     1-0020

OK, can you please send a proper patch with description
and Signed-off-by? That is unless Uwe cares to update his
patch. Otherwise add Reported-by for Uwe :)

Regards,

Tony

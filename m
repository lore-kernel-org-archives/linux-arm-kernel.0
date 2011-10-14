From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Oct 2011 17:34:21 +0200
Subject: [PATCH v4 8/8] ARM: pxa: move macros into gpio-pxa.c
In-Reply-To: <CAMPhdO9ig99=w0TOEEw1gnp7x-WRy1N4Fsu3A3_YiEjX+_BbhQ@mail.gmail.com>
References: <1318478825-17187-1-git-send-email-haojian.zhuang@marvell.com>
	<CAN1soZxCnZjDw14WZ7vprkTQWjki5Zd47pQf2zzoJQ1O9qSKog@mail.gmail.com>
	<CAMPhdO9ig99=w0TOEEw1gnp7x-WRy1N4Fsu3A3_YiEjX+_BbhQ@mail.gmail.com>
Message-ID: <201110141734.22115.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 October 2011, Eric Miao wrote:
> On Fri, Oct 14, 2011 at 5:13 PM, Haojian Zhuang
> <haojian.zhuang@gmail.com> wrote:
> > On Fri, Oct 14, 2011 at 2:17 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> >>>
> >>>> +enum pxa_gpios {
> >>>> +     PXA_GPLR = 0x00,        /* GPIO Pin Level Registers */
> >>>> +     PXA_GPDR = 0x0C,        /* GPIO Pin Direction Registers */
> >>>> +     PXA_GPSR = 0x18,        /* GPIO Pin Output Set Registers */
> >>>> +     PXA_GPCR = 0x24,        /* GPIO Pin Output Clear Registers */
> >>>> +     PXA_GRER = 0x30,        /* GPIO Rising Edge Detect Registers */
> >>>> +     PXA_GFER = 0x3C,        /* GPIO Falling Edge Detect Registers */
> >>>> +     PXA_GEDR = 0x48,        /* GPIO Edge Detect Status Registers */
> >>>> +     PXA_GAFR = 0x54,        /* GPIO Alternate Function Select Registers */
> >>>> +     PXA_ED_MASK = 0x9C,     /* GPIO edge detection for AP side */
> >>>> +};
> >>
> >> And Haojian,
> >>
> >> Is this is completely for the GPIO driver's internal use, I'd prefer to
> >> use GPxR names directly, instead of prefixing it with PXA_, that's a
> >> bit ugly from my picky point of view.

It's not entirely internal to the driver, but internal to pxa specific code
including a few of the board files.

> > OK, I'll GPxR directly. And I'll keep PXA_GPIO_bit() to avoid
> > potential name issue.
> >
> 
> I think GPIO_bit() is just fine if it's only used in gpio-pxa.c. I do
> prefer to have PXA_* prefixes as less as possible unless absolutely
> necessary.

I think I would prefer the PXA_* prefix (or even PXA_GPIO_*) as long as
the constants are used outside of the driver implementation, as a
reminder that these uses should eventually disappear, at least after
all the pxa board files have been converted into device tree descriptions
and the pxa_gpio driver itself knows how to set up the gpio lines for
a given board.

	Arnd

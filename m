From: cavokz@gmail.com (Domenico Andreoli)
Date: Thu, 25 Jul 2013 01:11:06 +0200
Subject: [PATCH] bcm53xx: initial support for the BCM5301/BCM470X SoC
 with ARM CPU
In-Reply-To: <CAGVrzcYnoN9NnJGvubS7=bVJDk37xSt4BimtvDWghe7OHEWALQ@mail.gmail.com>
References: <1373982727-5492-1-git-send-email-hauke@hauke-m.de>
 <20130716151435.GB3871@linaro.org> <2043662.BcW19XTTMG@lenovo>
 <20130719020611.GA4941@glitch> <20130723185733.GB6811@ohporter.com>
 <CAGVrzcYnoN9NnJGvubS7=bVJDk37xSt4BimtvDWghe7OHEWALQ@mail.gmail.com>
Message-ID: <20130724231106.GB29801@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 23, 2013 at 08:05:28PM +0100, Florian Fainelli wrote:
> 2013/7/23 Matt Porter <matt.porter@linaro.org>:
> > On Fri, Jul 19, 2013 at 04:06:11AM +0200, Domenico Andreoli wrote:
> >> On Wed, Jul 17, 2013 at 12:08:30AM +0100, Florian Fainelli wrote:
> >> > Hello,
> >> >
> >> > Le mardi 16 juillet 2013 11:14:36 Matt Porter a ?crit :
> >> > > > +       compatible = "brcm,bcm5301x";
> >> > >
> >> > > Ok, this was nagging at me before I went on my very long vacation. I see
> >> > > the "brcm" vendor prefix as a real consistency problem. I noticed on the
> >> > > bcm281xx/kona family, we have been using "bcm" which is not logged in
> >> > > vendor-prefixes.txt as a legitimate prefix. I see that bcm2835 had
> >> > > already established use of "brcm" before any of the bcm281xx support
> >> > > came in. Ideally, the vendor prefix should change to "bcm" since every
> >> > > reference in the family names is BCM. However, if others want the least
> >> > > amount of churn in making this consistent, we might have to go with
> >> > > "brcm" across the board.
> >> >
> >> > I would like to keep "brcm" here because that is what has been defined as a
> >> > vendor prefix, and is used beyond the scope of the ARM Linux kernel support
> >> > even within Broadcom. Maybe it was an oversight, or rather a mistake to let
> >>
> >> brcm is the stock ticker. As far as I can search, this is the convention
> >> for the vendor prefixes.
> >
> > No, correlation does not equal causation. The fact that some vendor
> > prefixes in DT match the stock symbol is by chance of 3-4 character name
> > being the same...nothing more.
> 
> That was a bad argument as was later explained to me, I won't use that
> reason again.

I cited the stock ticker only because IIRC it's the reason my initial
proposal for bcm has been ditched in favour of brcm when bcm2835 was
initially proposed.

> > It's pretty easy to see that the "ti" vendor prefix has no relation at
> > all to their TXN symbol so that blows that convention out of the water.
> > Rather, the prefix is based on somebody's notion of how that vendor's
> > part are normally referred to. In TI-land, it's TI AM335x or TI OMAP,
> > never TXN OMAP. :)
> >
> > For Broadcom, every part is BCMxxxxx so "bcm" is appropriate.
> 
> It was appropriate before being the "wrong" vendor prefix was
> allocated, now that "brcm" has been allocated we should stick to it
> because otherwise we will break existing and on-going DT work.

I still prefer bcm to brcm and I find enough evidence that bcm would be
better in the long term.

So if Broadcomers can agree on bcm, now it's still the cheapest time to
fix in that direction, later will not be better.

my 2c
dom

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Sep 2013 15:33:40 +0100
Subject: [PATCH 3/4] Add physical count arch timer support for
 clocksource in ARMv7.
In-Reply-To: <20130912112452.GA22013@e106331-lin.cambridge.arm.com>
References: <1378968687-8200-1-git-send-email-cinifr@gmail.com>
 <1378968687-8200-4-git-send-email-cinifr@gmail.com>
 <20130912112452.GA22013@e106331-lin.cambridge.arm.com>
Message-ID: <20130912143340.GL12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 12, 2013 at 12:24:52PM +0100, Mark Rutland wrote:
> On Thu, Sep 12, 2013 at 07:51:26AM +0100, Fan Rong wrote:
> > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > index 41c6946..a4981d2 100644
> > --- a/drivers/clocksource/Kconfig
> > +++ b/drivers/clocksource/Kconfig
> > @@ -109,3 +109,11 @@ config VF_PIT_TIMER
> >  	bool
> >  	help
> >  	  Support for Period Interrupt Timer on Freescale Vybrid Family SoCs.
> > +menu "Clock Source"
> > +
> > +config ARM_ARCH_TIMER_USE_PHYCNT
> > +	bool "Use Physical Count Timer"
> > +	depends on ARM_ARCH_TIMER
> > +	help
> > +          If bootloader dont set Virtual Offset register,Physical Count Timer is needed to replace Virtual Count Timer.
> > +endmenu
> 
> This cannot be a compile-time option as above in a multiplatform build.
> Other paltforms (e.g. KVM guests) *must* use the virtual counters to get
> any semblance of a consistent view of time.

Also, for future reference:

1. Use a single blank lines to separate thing like 'menu' and 'endmenu'.
2. Wrap your the help sensibly, don't put it all on one line.
3. It's conventional to use tabs up to below "help" and then two spaces
   to indent the help text.
4. "," always has one space after it.

Thanks.

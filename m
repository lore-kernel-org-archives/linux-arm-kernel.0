From: tony@atomide.com (Tony Lindgren)
Date: Fri, 15 Apr 2011 09:26:43 +0300
Subject: Status of arch/arm in linux-next
In-Reply-To: <BANLkTikVfdVQuR_nJZnra7Bo=CQgOfS5Zg@mail.gmail.com>
References: <20110414094447.GA1611@n2100.arm.linux.org.uk>
	<BANLkTikVfdVQuR_nJZnra7Bo=CQgOfS5Zg@mail.gmail.com>
Message-ID: <20110415062643.GB12272@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Linus Walleij <linus.walleij@linaro.org> [110415 04:14]:
> 2011/4/14 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> 
> > This morning, I looked at linux-next to find out how arch/arm is doing
> > for the next merge window.
> >
> > $ git diff -C --cumulative v2.6.39-rc1... arch/arm
> > (...)
> > ? 7.6% arch/arm/mach-ux500/include/mach/
> > ?46.1% arch/arm/mach-ux500/
> > (...)
> > Please take a moment to consider how Linus will react to this at the
> > next merge window.
> 
> This instance of Linus feels guilty for that...
> 
> Since ~50% of it is ux500 that I usually merge through your tree,
> I suspect you're simply not going to pull it so then half of the problem
> is gone already :-D
> 
> Anyway, the bulk of that is a PRCMU driver, similar to the stuff
> in arch/arm/mach-omap2/prcm*. So let's think about what we can
> do about it.

Yeah OK.
 
> Since this is a one-off kind of thing, a singleton driver that controls
> power, reset and some GPIO on the chip. I contemplate moving the
> stuff to either:
> 
> drivers/misc/ux500/*
> include/linux/misc/ux500/*
> 
> or:
> 
> drivers/platform/arm/ux500/*
> include/linux/platform/arm/ux500/*
> 
> Are any of these generally speaking good ideas?

Or maybe drivers/arm?

Anyways, whatever can be done as loadable modules should be done
that way. That makes the life for distros much easier ;)
 
> Either place outside arch/arm/* is fine with me, creating something like
> drivers/prcmu/* would be a bit thick since the hardware basically does
> not look like anything else.
> 
> The basic problem it's reflecting is that ARM does not have something
> like ACPI, that's basically what the driver is doing, and since every
> vendor does their own HW thingy it's not like it's easily consolidated.

Yeah and that's going to take time.
 
> In the meantime I'm working on migrating GPIO drivers from mach-u300
> and plat-nomadik into drivers/gpio so I will hopefully provide some negative
> stats.

We too can move the omap gpio code there too..

Regards,

Tony

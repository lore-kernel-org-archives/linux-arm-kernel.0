From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 10 Feb 2014 18:55:39 +0100
Subject: [PATCH 07/11] ARM: mvebu: add initial support for the Armada
 380/385 SOCs
In-Reply-To: <20140210174404.GC9995@lunn.ch>
References: <1392053002-19831-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1392053002-19831-8-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140210174404.GC9995@lunn.ch>
Message-ID: <20140210185539.55d19a82@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Mon, 10 Feb 2014 18:44:04 +0100, Andrew Lunn wrote:

> > +config MACH_ARMADA_380
> 
> Should this maybe be MACH_ARMADA_38X. You have PINCTRL_ARMADA_38X, so
> it seems a bit inconsistent.

True, will fix this in v2.

> > +static void __init armada_380_timer_and_clk_init(void)
> > +{
> > +	of_clk_init(NULL);
> > +	clocksource_of_init();
> > +	BUG_ON(mvebu_mbus_dt_init());
> > +	l2x0_of_init(0, ~0UL);
> > +}
> > +
> > +static const char * const armada_380_dt_compat[] = {
> > +	"marvell,armada380",
> > +	"marvell,armada385",
> > +	NULL,
> > +};
> > +
> > +DT_MACHINE_START(ARMADA_XP_DT, "Marvell Armada 380/385 (Device Tree)")
> > +	.init_time	= armada_380_timer_and_clk_init,
> > +	.restart	= mvebu_restart,
> > +	.dt_compat	= armada_380_dt_compat,
> > +MACHINE_END
> 
> This looks very similar to the 375 code. Could they be combined?

It is not entirely clear at this point how different they will be. For
now, the external abort workaround applies only to Armada 375, but that
can easily be checked by looking at the DT compatible string. Maybe we
can decide to have a common file for now, and split it later on if we
realize that the differences are too complex?

Only problem with that (but a problem that is often difficult to
solve) : what should be the same of this file? armada-375-38x.c ?

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

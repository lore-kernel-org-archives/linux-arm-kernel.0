From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 17 May 2013 14:31:15 +0200
Subject: [PATCH v3 2/4] ARM: imx: add initial support for MVF600
In-Reply-To: <201305171429.52646.arnd@arndb.de>
References: <1368684648-20826-1-git-send-email-b35083@freescale.com>
 <20130517085714.GG8607@S2101-09.ap.freescale.net>
 <201305171429.52646.arnd@arndb.de>
Message-ID: <201305171431.15701.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 17 May 2013, Arnd Bergmann wrote:
> > > > +static const char *mvf600_dt_compat[] __initdata = {
> > > > + "fsl,mvf600",
> > > > + NULL,
> > > > +};
> > > > +
> > > > +DT_MACHINE_START(VYBRID_VF6XX, "Freescale Vybrid MVF600 (Device Tree)")
> > > > + .init_irq       = mvf600_init_irq,
> > > > + .init_time      = mvf600_init_time,
> > > > + .init_machine   = mvf600_init_machine,
> > > > + .dt_compat      = mvf600_dt_compat,
> > > > + .restart        = mxc_restart,
> > > > +MACHINE_END
> > > 
> > > If we can do all of the above, we can actually remove the entire machine
> > > descriptor here, since all its members are NULL.
> > > 
> > Yeah, we understand the goal, and this will be the goal of mach-imx
> > cleanup.
> 
> Ok. I guess we just won't be there for 3.11 then.

To clarify: what I mean is we should try to remove all the callbacks 
we can here, but merge the MVF600 port anyway, even if we still need a
couple of them.

	Arnd

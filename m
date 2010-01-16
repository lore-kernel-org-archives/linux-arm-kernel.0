From: tony@atomide.com (Tony Lindgren)
Date: Sat, 16 Jan 2010 11:25:38 -0800
Subject: [PATCH 1/4] omap: Clean the serial port defines
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C06F9005@dbde02.ent.ti.com>
References: <20100116013205.10065.95921.stgit@baageli.muru.com>
	<20100116013510.10065.59461.stgit@baageli.muru.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C06F9005@dbde02.ent.ti.com>
Message-ID: <20100116192538.GK10318@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [100115 23:46]:
> Thanks for the nice cleanup.

Thanks for testing :)

> <snip>
> > --- a/arch/arm/plat-omap/include/plat/common.h
> > +++ b/arch/arm/plat-omap/include/plat/common.h
> > @@ -47,6 +47,10 @@ struct omap_globals {
> >  	void __iomem	*prm;		/* Power and Reset Management */
> >  	void __iomem	*cm;		/* Clock Management */
> >  	void __iomem	*cm2;
> > +	unsigned long	uart1_phys;
> > +	unsigned long	uart2_phys;
> > +	unsigned long	uart3_phys;
> > +	unsigned long	uart4_phys;
> Considering they are register base address, can
> these be declared as "void __iomem" instead of "unsigned long"

These are physical addresses instead of virtual addresses.
They get ioremapped in mach-omap[12]/serial.c. So they should
not be void __iomem * in omap_globals.

BTW, we should eventually change everything in omap_globals
to be physical addresses.

Regards,

Tony

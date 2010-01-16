From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Sun, 17 Jan 2010 01:03:18 +0530
Subject: [PATCH 1/4] omap: Clean the serial port defines
In-Reply-To: <20100116192538.GK10318@atomide.com>
References: <20100116013205.10065.95921.stgit@baageli.muru.com>
	<20100116013510.10065.59461.stgit@baageli.muru.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C06F9005@dbde02.ent.ti.com>
	<20100116192538.GK10318@atomide.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C06F906A@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Tony Lindgren [mailto:tony at atomide.com] 
> Sent: Sunday, January 17, 2010 12:56 AM
> To: Shilimkar, Santosh
> Cc: linux-arm-kernel at lists.infradead.org; linux-omap at vger.kernel.org
> Subject: Re: [PATCH 1/4] omap: Clean the serial port defines
> 
> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [100115 23:46]:
> > Thanks for the nice cleanup.
> 
> Thanks for testing :)
> 
> > <snip>
> > > --- a/arch/arm/plat-omap/include/plat/common.h
> > > +++ b/arch/arm/plat-omap/include/plat/common.h
> > > @@ -47,6 +47,10 @@ struct omap_globals {
> > >  	void __iomem	*prm;		/* Power and Reset Management */
> > >  	void __iomem	*cm;		/* Clock Management */
> > >  	void __iomem	*cm2;
> > > +	unsigned long	uart1_phys;
> > > +	unsigned long	uart2_phys;
> > > +	unsigned long	uart3_phys;
> > > +	unsigned long	uart4_phys;
> > Considering they are register base address, can
> > these be declared as "void __iomem" instead of "unsigned long"
> 
> These are physical addresses instead of virtual addresses.
> They get ioremapped in mach-omap[12]/serial.c. So they should
> not be void __iomem * in omap_globals.
Yep. I see your point.  
> BTW, we should eventually change everything in omap_globals
> to be physical addresses.
We did some work for OMAP4 to move most of the things to ioremap
istead of those hardcoded macros. 
Let me know when you want to do this clean up. We can do this together.

Regards
Santosh

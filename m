From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Apr 2011 16:24:43 +0100
Subject: [RFC PATCH] Consolidate SRAM support
In-Reply-To: <20110415135237.GA9513@zarco>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
	<20110415135237.GA9513@zarco>
Message-ID: <20110415152443.GB4423@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2011 at 04:52:38PM +0300, Eduardo Valentin wrote:
> Hi Russel,
> 
> Just small comment,
> 
> On Fri, Apr 15, 2011 at 08:06:07AM -0500, Russell King wrote:
> 
> > diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
> > index a3f50b3..3588749 100644
> > --- a/arch/arm/plat-omap/sram.c
> > +++ b/arch/arm/plat-omap/sram.c
> > @@ -75,7 +75,6 @@
> >  static unsigned long omap_sram_start;
> >  static unsigned long omap_sram_base;
> >  static unsigned long omap_sram_size;
> > -static unsigned long omap_sram_ceil;
> 
> I think you missed one occurrence of omap_sram_ceil at omap3_sram_restore_context.
> Probably you have compile-tested w/o CONFIG_PM?

I built OMAP2 only, which did have CONFIG_PM=y.  Welcome to the problems
of ifdef'ing code.

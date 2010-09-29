From: s-ghorai@ti.com (Ghorai, Sukumar)
Date: Wed, 29 Sep 2010 11:32:23 +0530
Subject: [PATCH v5 2/5] omap3: nand: prefetch in irq mode support
In-Reply-To: <20100928222933.GT3117@atomide.com>
References: <1285594634-19277-1-git-send-email-s-ghorai@ti.com>
	<1285594634-19277-3-git-send-email-s-ghorai@ti.com>
	<20100928222933.GT3117@atomide.com>
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B03564763D3@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Tony Lindgren [mailto:tony at atomide.com]
> Sent: Wednesday, September 29, 2010 4:00 AM
> To: Ghorai, Sukumar
> Cc: linux-omap at vger.kernel.org; linux-mtd at lists.infradead.org; linux-arm-
> kernel at lists.infradead.org; Vimal Singh
> Subject: Re: [PATCH v5 2/5] omap3: nand: prefetch in irq mode support
> 
> * Sukumar Ghorai <s-ghorai@ti.com> [100927 06:30]:
> >  This patch enable prefetch-irq mode for NAND.
> 
> > --- a/drivers/mtd/nand/Kconfig
> > +++ b/drivers/mtd/nand/Kconfig
> > @@ -112,6 +112,9 @@ config MTD_NAND_OMAP_PREFETCH
> >  	help
> >  	 The NAND device can be accessed for Read/Write using GPMC PREFETCH
> engine
> >  	 to improve the performance.
> > +	 GPMC PREFETCH can be configured eigther in MPU interrupt mode or in
> DMA
> > +	 interrupt mode. If not selected any of them prefetch will be used
> in
> > +	 polling mode.
> >
> >  config MTD_NAND_OMAP_PREFETCH_DMA
> >  	depends on MTD_NAND_OMAP_PREFETCH
> > @@ -120,7 +123,16 @@ config MTD_NAND_OMAP_PREFETCH_DMA
> >  	help
> >  	 The GPMC PREFETCH engine can be configured eigther in MPU interrupt
> mode
> >  	 or in DMA interrupt mode.
> > -	 Say y for DMA mode or MPU mode will be used
> > +	 Say y for DMA mode
> > +
> > +config MTD_NAND_OMAP_PREFETCH_IRQ
> > +	depends on MTD_NAND_OMAP_PREFETCH && !MTD_NAND_OMAP_PREFETCH_DMA
> > +	bool "IRQ mode"
> > +	default n
> > +	help
> > +	 The GPMC PREFETCH engine can be configured eigther in MPU interrupt
> mode
> > +	 or in DMA interrupt mode.
> > +	 Say y for IRQ mode
> >
> >  config MTD_NAND_IDS
> >  	tristate
> 
> The configuration to use the prefetch IRQ should be passed in the
> platform_data
> from the board-*.c files. What if you want to to boot a distro kernel on
> omap2, 3 and 4 and only some of the boards can use the prefetch interrupt?
[Ghorai] thanks.. we will provide the interface to select the io mode and ecc mode from board file.

> 
> Tony

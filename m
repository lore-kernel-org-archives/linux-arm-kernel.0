From: tony@atomide.com (Tony Lindgren)
Date: Thu, 7 Jan 2010 11:15:03 -0800
Subject: [PATCH 05/12] omap1: Add 7xx clocks and pin muxes for SPI
In-Reply-To: <6ed0b2681001070146x4dbf52d9h406d128ccea826cf@mail.gmail.com>
References: <20100107001728.21352.38471.stgit@baageli.muru.com>
	<20100107001934.21352.83656.stgit@baageli.muru.com>
	<6ed0b2681001070146x4dbf52d9h406d128ccea826cf@mail.gmail.com>
Message-ID: <20100107191502.GH11511@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grazvydas Ignotas <notasas@gmail.com> [100107 01:44]:
> <snip>
> 
> > --- a/arch/arm/mach-omap1/devices.c
> > +++ b/arch/arm/mach-omap1/devices.c
> > @@ -196,6 +198,38 @@ void __init omap1_init_mmc(struct omap_mmc_platform_data **mmc_data,
> >
> > ?/*-------------------------------------------------------------------------*/
> >
> > +/* OMAP7xx SPI support */
> > +#if defined(CONFIG_SPI_OMAP_100K) || defined(CONFIG_SPI_OMAP_100K_MODULE)
> > +
> > +struct platform_device omap_spi1 = {
> > + ? ? ? .name ? ? ? ? ? = "omap1_spi100k",
> > + ? ? ? .id ? ? ? ? ? ? = 1,
> > +};
> > +
> > +struct platform_device omap_spi2 = {
> > + ? ? ? .name ? ? ? ? ? = "omap1_spi100k",
> > + ? ? ? .id ? ? ? ? ? ? = 2,
> > +};
> > +
> > +static void omap_init_spi100k(void)
> > +{
> > + ? ? ? omap_spi1.dev.platform_data = ioremap(OMAP7XX_SPI1_BASE, 0x7ff);
> > + ? ? ? if (omap_spi1.dev.platform_data)
> > + ? ? ? ? ? ? ? platform_device_register(&omap_spi1);
> > +
> > + ? ? ? omap_spi2.dev.platform_data = ioremap(OMAP7XX_SPI2_BASE, 0x7ff);
> > + ? ? ? ifi (omap_spi2.dev.platform_data)
> 
> a typo here?

Thanks, for pointing that out, my fault for editing the patch.. Fixed below
and now compile tested with omap1_spi100k enabled :)

Regards,

Tony

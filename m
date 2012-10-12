From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 12 Oct 2012 09:26:17 +0200
Subject: [PATCH 1/6] ARM: bcm476x: Add infrastructure
In-Reply-To: <20121012070651.GA17511@glitch>
References: <20121007015300.828366635@gmail.com>
 <20121007015405.958959522@gmail.com>
 <20121012070651.GA17511@glitch>
Message-ID: <20121012092617.37e82610@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Fri, 12 Oct 2012 09:06:51 +0200, Domenico Andreoli wrote:

> > +#define BCM476X_PERIPH_PHYS   0x00080000
> > +#define BCM476X_PERIPH_VIRT   0xd0080000
> 
> Are you sure I should use IOMEM() here? The only place I use these
> macros is here below, for which I should add a cast to silent the
> compiler. All the other accesses go throught ioremap/readl/writel, if
> not I want to fix it.
> 
> > +
> > +static struct map_desc io_map __initdata = {
> > +	.virtual = BCM476X_PERIPH_VIRT,
> > +	.pfn = __phys_to_pfn(BCM476X_PERIPH_PHYS),
> > +	.length = BCM476X_PERIPH_SIZE,
> > +	.type = MT_DEVICE,
> > +};

My understanding is that all virtual address constants should now be
defined to have the void __iomem * type (i.e, using IOMEM). In the
future, the idea is that map_desc.virtual might be switched to the void
__iomem * type as well.

But others (Arnd?) will confirm (or not) this.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

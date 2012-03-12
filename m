From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 12 Mar 2012 11:45:03 -0600
Subject: [PATCH] gpio/omap: Fix section warning for omap_mpuio_alloc_gc()
In-Reply-To: <87pqcpb7y4.fsf@ti.com>
References: <20120306212605.GY12083@atomide.com> <87pqcpb7y4.fsf@ti.com>
Message-ID: <20120312174503.E06123E07B0@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 06 Mar 2012 15:55:47 -0800, Kevin Hilman <khilman@ti.com> wrote:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > From: Tony Lindgren <tony@atomide.com>
> > Date: Mon, 5 Mar 2012 15:32:38 -0800
> > Subject: [PATCH] gpio/omap: Fix section warning for omap_mpuio_alloc_gc()
> >
> > Make omap_mpuio_alloc_gc() __devinit as omap_gpio_chip_init()
> > is __devinit. Otherwise we get:
> >
> > WARNING: vmlinux.o(.devinit.text+0xa10): Section mismatch in reference
> > from the function omap_gpio_chip_init() to the function .init.text:omap_mpuio_alloc_gc()
> > The function __devinit omap_gpio_chip_init() references
> > a function __init omap_mpuio_alloc_gc().
> > If omap_mpuio_alloc_gc is only used by omap_gpio_chip_init then
> > annotate omap_mpuio_alloc_gc with a matching annotation.
> >
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Acked-by: Kevin Hilman <khilman@ti.com>

applied, thx.

g.

From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Sat, 28 May 2011 13:33:05 +0300
Subject: [PATCH 1/5] dmaengine: add ep93xx DMA support
In-Reply-To: <0D753D10438DA54287A00B027084269764D331A4B2@AUSP01VMBX24.collaborationhost.net>
References: <cover.1306082097.git.mika.westerberg@iki.fi>
	<e6777eb9f7228ee1dadec1f0c9f16c3afc44c307.1306082097.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B027084269764D331A4B2@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20110528103305.GB15220@acer>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 26, 2011 at 08:38:41PM -0500, H Hartley Sweeten wrote:
> >  
> > +config EP93XX_DMA
> > +	bool "Cirrus Logic EP93xx DMA support"
> > +	depends on ARCH_EP93XX
> > +	select DMA_ENGINE
> > +	help
> > +	  Enable support for the Cirrus Logic EP93xx M2P/M2M DMA controller.
> > +
> >  config DMA_ENGINE
> >  	bool
> 
> The old dma-m2p support was always builtin.  Should ARCH_EP93XX select
> EP93XX_DMA to keep this, or should it be added to the ep93xx_defconfig?

There are no users for the DMA in ep93xx_defconfig so I think that it
shouldn't be selected by default. I was planning to change platform code to be
conditionally compiled, like:

arch/arm/mach-ep93xx/Makefile:

+obj-$(CONFIG_EP93XX_DMA)       += dma.o

Any objections?

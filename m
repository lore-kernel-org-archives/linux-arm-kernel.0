From: tony@atomide.com (Tony Lindgren)
Date: Mon, 24 Jun 2013 03:17:56 -0700
Subject: [PATCH v12 04/11] dmaengine: edma: enable build for AM33XX
In-Reply-To: <51C427AA.6080601@ti.com>
References: <1371762407-24544-1-git-send-email-joelagnel@ti.com>
 <1371762407-24544-5-git-send-email-joelagnel@ti.com>
 <51C427AA.6080601@ti.com>
Message-ID: <20130624101756.GU5523@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sekhar Nori <nsekhar@ti.com> [130621 03:21]:
> On 6/21/2013 2:36 AM, Joel A Fernandes wrote:
> > From: Matt Porter <mporter@ti.com>
> > 
> > Enable TI EDMA option on OMAP and TI_PRIV_EDMA
> > 
> > Signed-off-by: Matt Porter <mporter@ti.com>
> > Signed-off-by: Joel A Fernandes <joelagnel@ti.com>
> 
> This will have to be taken by Tony.

Sekhar, please go ahead and take this one. I'll reply
to the header email of this series how it should be
queued.

For the mach-omap2/Kconfig change:

Acked-by: Tony Lindgren <tony@atomide.com>
 
> > ---
> >  arch/arm/mach-omap2/Kconfig |    1 +
> >  drivers/dma/Kconfig         |    2 +-
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> > index f49cd51..f91b07f 100644
> > --- a/arch/arm/mach-omap2/Kconfig
> > +++ b/arch/arm/mach-omap2/Kconfig
> > @@ -17,6 +17,7 @@ config ARCH_OMAP2PLUS
> >  	select PROC_DEVICETREE if PROC_FS
> >  	select SOC_BUS
> >  	select SPARSE_IRQ
> > +	select TI_PRIV_EDMA
> >  	select USE_OF
> >  	help
> >  	  Systems based on OMAP2, OMAP3, OMAP4 or OMAP5
> > diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> > index e992489..3215a3c 100644
> > --- a/drivers/dma/Kconfig
> > +++ b/drivers/dma/Kconfig
> > @@ -213,7 +213,7 @@ config SIRF_DMA
> >  
> >  config TI_EDMA
> >  	tristate "TI EDMA support"
> > -	depends on ARCH_DAVINCI
> > +	depends on ARCH_DAVINCI || ARCH_OMAP
> >  	select DMA_ENGINE
> >  	select DMA_VIRTUAL_CHANNELS
> >  	default n
> > 

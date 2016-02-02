From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 2 Feb 2016 14:23:16 +0800
Subject: [PATCH 1/6] dma: enable mxs-dma for imx6ul
In-Reply-To: <20160125121043.GJ11130@localhost>
References: <1453294626-17608-1-git-send-email-LW@KARO-electronics.de>
 <1453294626-17608-2-git-send-email-LW@KARO-electronics.de>
 <20160125121043.GJ11130@localhost>
Message-ID: <20160202062314.GD8307@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 05:40:43PM +0530, Vinod Koul wrote:
> On Wed, Jan 20, 2016 at 01:57:01PM +0100, Lothar Wa?mann wrote:
> > The mxs-dma unit is also available on i.MX6UL. Make it possible to
> > select it in Kconfig.
> 
> It should be dmaengine:xxx
> 
> With that
> 
> Acked-by: Vinod Koul <vinod.koul@intel.com>

I think this can go separately via dma tree.

Shawn

> 
> > 
> > Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> > ---
> >  drivers/dma/Kconfig | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> > index 79b1390..2516524 100644
> > --- a/drivers/dma/Kconfig
> > +++ b/drivers/dma/Kconfig
> > @@ -341,12 +341,13 @@ config MV_XOR
> >  
> >  config MXS_DMA
> >  	bool "MXS DMA support"
> > -	depends on SOC_IMX23 || SOC_IMX28 || SOC_IMX6Q
> > +	depends on SOC_IMX23 || SOC_IMX28 || SOC_IMX6Q || SOC_MX6UL
> >  	select STMP_DEVICE
> >  	select DMA_ENGINE
> >  	help
> >  	  Support the MXS DMA engine. This engine including APBH-DMA
> > -	  and APBX-DMA is integrated into Freescale i.MX23/28/MX6Q/MX6DL chips.
> > +	  and APBX-DMA is integrated into Freescale
> > +	  i.MX23/28/MX6Q/MX6DL/MX6UL chips.
> >  
> >  config MX3_IPU
> >  	bool "MX3x Image Processing Unit support"
> > -- 
> > 2.1.4
> > 
> 
> -- 
> ~Vinod
> 

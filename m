From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 08 Nov 2011 21:40:33 +0530
Subject: [PATCH 2/5] dma i.MX: remove individual SOC dependency
In-Reply-To: <20111108152239.GA9641@pengutronix.de>
References: <1314168072-13822-1-git-send-email-s.hauer@pengutronix.de>
 <1314168072-13822-3-git-send-email-s.hauer@pengutronix.de>
 <20111108152239.GA9641@pengutronix.de>
Message-ID: <1320768633.32205.147.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-11-08 at 16:22 +0100, Sascha Hauer wrote:
> Vinod,
> 
> Ping. Can you please queue this one?
Sorry Sascha, looks like I have missed this one :(

Nevertheless, this seems to be part of a series, but I couldn't locate
the rest.
Do you want me to apply only this individual patch, seems little odd if
thats the case...

> 
> Thanks
>   Sascha
> 
> On Wed, Aug 24, 2011 at 08:41:09AM +0200, Sascha Hauer wrote:
> > The individual SoC dependency in Kconfig hardly scales anymore.
> > Instead of having such a fine grained dependency just depend
> > on ARCH_MXC and risk that the uninformed user has to look in
> > the help text to figure out which driver is the correct one.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Vinod Koul <vinod.koul@intel.com>
> > ---
> >  drivers/dma/Kconfig |    6 +++---
> >  1 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> > index 2e3b3d3..eda9e34 100644
> > --- a/drivers/dma/Kconfig
> > +++ b/drivers/dma/Kconfig
> > @@ -124,7 +124,7 @@ config MV_XOR
> >  
> >  config MX3_IPU
> >  	bool "MX3x Image Processing Unit support"
> > -	depends on ARCH_MX3
> > +	depends on ARCH_MXC
> >  	select DMA_ENGINE
> >  	default y
> >  	help
> > @@ -215,11 +215,11 @@ config PCH_DMA
> >  
> >  config IMX_SDMA
> >  	tristate "i.MX SDMA support"
> > -	depends on ARCH_MX25 || ARCH_MX3 || ARCH_MX5
> > +	depends on ARCH_MXC
> >  	select DMA_ENGINE
> >  	help
> >  	  Support the i.MX SDMA engine. This engine is integrated into
> > -	  Freescale i.MX25/31/35/51 chips.
> > +	  Freescale i.MX25/31/35/51/53 chips.
> >  
> >  config IMX_DMA
> >  	tristate "i.MX DMA support"
> > -- 
> > 1.7.5.4
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > 
> 


-- 
~Vinod

From: andriy.shevchenko@intel.com (Shevchenko, Andriy)
Date: Tue, 20 May 2014 12:52:34 +0000
Subject: [linux-sunxi] [PATCH v7] DMA: sun6i: Add driver for the
 Allwinner A31 DMA controller
In-Reply-To: <537B4D55.5040804@elopez.com.ar>
References: <1398349364-10726-1-git-send-email-maxime.ripard@free-electrons.com>
 <1398349364-10726-2-git-send-email-maxime.ripard@free-electrons.com>
 <537B4D55.5040804@elopez.com.ar>
Message-ID: <1400590354.28000.14.camel@smile.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-05-20 at 09:40 -0300, Emilio L?pez wrote:
> El 24/04/14 11:22, Maxime Ripard escribi?:
> > The Allwinner A31 has a 16 channels DMA controller that it shares with the
> > newer A23. Although sharing some similarities with the DMA controller of the
> > older Allwinner SoCs, it's significantly different, I don't expect it to be
> > possible to share the driver for these two.
> >
> > The A31 Controller is able to memory-to-memory or memory-to-device transfers on
> > the 16 channels in parallel.

...

> > diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> > index 5c5863842de9..360a10c71388 100644
> > --- a/drivers/dma/Kconfig
> > +++ b/drivers/dma/Kconfig
> > @@ -361,6 +361,14 @@ config FSL_EDMA
> >   	  multiplexing capability for DMA request sources(slot).
> >   	  This module can be found on Freescale Vybrid and LS-1 SoCs.
> >
> > +config DMA_SUN6I
> > +	tristate "Allwinner A31 SoCs DMA support"
> > +	depends on ARCH_SUNXI
> > +	select DMA_ENGINE
> > +	select DMA_VIRTUAL_CHANNELS
> 
> I think you also need to select DMA_OF here as you are using 
> of_dma_controller_register

of_dma_controller_register should have a stub (which it does).
No need to have such a dependency.

-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy
---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki 
Business Identity Code: 0357606 - 4 
Domiciled in Helsinki 

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

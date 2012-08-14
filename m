From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 14 Aug 2012 19:44:25 +0200
Subject: [PATCH 00/23] work in progress: SPI controller w/DMA SAM9X5
In-Reply-To: <502A6EEC.2010807@atmel.com>
References: <1344952177-18385-1-git-send-email-richard.genoud@gmail.com>
 <502A6EEC.2010807@atmel.com>
Message-ID: <20120814174425.GD8836@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:29 Tue 14 Aug     , Nicolas Ferre wrote:
> On 08/14/2012 03:49 PM, Richard Genoud :
> > Nicolas,
> > I said that I had some work done on sam9g35-ek, here is the spi part, based
> > on your and Jean-Christophe work.
> > You have to enable CONFIG_ARCH_AT91SAM9X5 to get it work.
> > 
> > The goal of this patchset is to share the work I've done, it's not ready
> > for upstream, but it may save some time.
> > 
> > It's based on 3.6-rc1 + Jean-Christophe's pinctrl patchset.
> > 
> > Best Regards,
> 
> Richard,
> 
> Thanks a lot for updating this material: We really appreciate.
> 
> We will try to review this material together with Jean-Christophe and
> colleagues @ Atmel. I hope that we will go forward with this collected
> material in the near future.
> 
> Maybe DMA OF part will not be upstreamed as-is because of an ongoing
> initiative to build a generic dmaengine OF support.
> 
> > Jean-Christophe PLAGNIOL-VILLARD (3):
> >   of: add dma-mask binding
> >   of_spi: add generic binding support to specify cs gpio
> 
> I know that Jean-Christophe has had difficulties to have feedback on
> there parts...
yes I need to re-write it as suggest by Grant

will take a look later next week on this
> 
> >   spi/atmel: add DT support
> > 
> > Nicolas Ferre (6):
> >   spi/atmel_spi: trivial: change some comments
> >   spi/atmel_spi: add physical base address
> >   spi/atmel_spi: call unmapping on transfers buffers
> >   spi/atmel_spi: status information passed through controller data
> >   spi/atmel_spi: add flag to controller data for lock operations
> >   spi/atmel_spi: add dmaengine support
> > 
> > Richard Genoud (14):
> >   spi-atmel: update with dmaengine interface
> 
> This will certainly be squashed in previous path.
> 
> >   spi-atmel: fix __init/__devinit sections mismatch
> 
> This one also: but it is good to have them separated at fist.
> 
> >   spi-atmel: Fix spi-atmel driver to adapt to slave_config changes
> >   AT91 DMA OF support
> >   add at91sam9x5 Kconfig ARCH/SOC link
> 
> Is it fixup for a bug? Jean-Christophe, a though about this one?
no the ARCH_xxx is old style can not be used on DT only soc

this patch need to be droped

Best Regards,
J.

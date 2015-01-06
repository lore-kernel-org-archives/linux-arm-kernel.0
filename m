From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Tue, 6 Jan 2015 20:24:56 +0200
Subject: [PATCH] irqchip: omap-intc: fix legacy DMA regression
In-Reply-To: <20150106180532.GO11502@n2100.arm.linux.org.uk>
References: <20150106123830.GD30544@fuloong-minipc.musicnaut.iki.fi>
 <1420563093-26026-1-git-send-email-balbi@ti.com>
 <20150106180532.GO11502@n2100.arm.linux.org.uk>
Message-ID: <20150106182456.GG30544@fuloong-minipc.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 06, 2015 at 06:05:32PM +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 06, 2015 at 10:51:33AM -0600, Felipe Balbi wrote:
> > +	 * FIXME legacy OMAP DMA driver sitting under arch/arm/plat-omap/dma.c
> > +	 * depends is still not ready for linear IRQ domains; because of that
> > +	 * we need to temporarily "blacklist" OMAP2 and OMAP3 devices from using
> > +	 * linear IRQ Domain until that driver is finally fixed.
> 
> "finally fixed" or finally killed off like it really needs to be, once
> all users of it are killed.
> 
> We've been trying to do this for, what, three years now... I finally
> pushed a WARN_ON() into that code to make it obvious to anyone who
> uses omap_request_dma() that they really need to update their code.

> Here's the list of references to that symbol which *still* need to be
> fixed so that we can kill the legacy DMA driver:
> 
> drivers/usb/gadget/udc/omap_udc.c:              status = omap_request_dma(dma_channel,
> drivers/usb/gadget/udc/omap_udc.c:              status = omap_request_dma(dma_channel,

I only learned about this after the WARN_ON() appeared in 3.17
(just couple months ago), and it's on my TODO list...

A.

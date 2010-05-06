From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 6 May 2010 18:59:07 +0100
Subject: arm926_dma_flush_range undefined!
In-Reply-To: <1273154831.2094.11.camel@e102109-lin.cambridge.arm.com>
References: <4BE2C013.4040009@atmel.com>
	<1273154831.2094.11.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100506175907.GA15797@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 06, 2010 at 03:07:11PM +0100, Catalin Marinas wrote:
> On Thu, 2010-05-06 at 15:11 +0200, Nicolas Ferre wrote:
> > I am trying to compile a recent kernel 
> > (v2.6.34-rc6-201-g722154e) and I am 
> > having this kind of error:
> > 
> > ERROR: "arm926_dma_flush_range" [drivers/mmc/host/at91_mci.ko] undefined!
> 
> The driver seems to use dmac_flush_range() directly. That's not part of
> the DMA API. Could you not use one of the supported DMA API functions?

Indeed; I've always said that I don't care about drivers directly using
the internals of the DMA API, and drivers doing this will be constantly
subjected to breakage.

I really do not regard the above to be a regression; it's a latent
programming error.  AT91 folk need to fix their driver(s) to use the
proper interfaces rather than using internal functionality.

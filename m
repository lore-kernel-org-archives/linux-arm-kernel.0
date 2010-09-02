From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Sep 2010 15:06:30 +0100
Subject: [PATCH 3/3] dmaengine: Add Freescale i.MX SDMA support
In-Reply-To: <AANLkTi=pO-ZJ33FrL=4bVRYa2o9HA0_h5tBYG7wdMuwz@mail.gmail.com>
References: <1281956870-12463-1-git-send-email-s.hauer@pengutronix.de>
	<1281956870-12463-4-git-send-email-s.hauer@pengutronix.de>
	<AANLkTi=pO-ZJ33FrL=4bVRYa2o9HA0_h5tBYG7wdMuwz@mail.gmail.com>
Message-ID: <20100902140630.GM26319@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 16, 2010 at 02:21:06PM +0200, Linus Walleij wrote:
> > +/*
> > + * Buffer descriptor
> > + */
> > +struct sdma_buffer_descriptor {
> > + ? ? ? struct sdma_mode_count ?mode;
> > + ? ? ? u32 buffer_addr; ? ?/* address of the buffer described */
> > + ? ? ? u32 ext_buffer_addr; /* extended buffer address */
> 
> Shouldn't these be dma_addr_t? OK that's probably u32
> anyway but just to make a marker...

If this is describing hardware, then it makes sense to use uNN rather
than dma_addr_t.  dma_addr_t may be subject to change in the future.

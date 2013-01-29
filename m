From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 Jan 2013 11:18:50 +0000
Subject: [PATCH 1/5] dmaengine: dw_dmac: move to generic DMA binding
In-Reply-To: <201301291050.23743.arnd@arndb.de>
References: <1359395857-1235-1-git-send-email-arnd@arndb.de>
 <1359410300-26113-2-git-send-email-arnd@arndb.de>
 <1359445171.31148.30.camel@smile> <201301291050.23743.arnd@arndb.de>
Message-ID: <20130129111850.GR23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 10:50:23AM +0000, Arnd Bergmann wrote:
> (putting back the Cc list, I assumed you dropped them accidentally)

That'll be why I don't have a copy of Andy's email to reply to.

> On Tuesday 29 January 2013, Andy Shevchenko wrote:
> > On Mon, 2013-01-28 at 21:58 +0000, Arnd Bergmann wrote: 
> > > -	if ((last_dw == dw) && (last_bus_id == param))
> > > +	/* both the driver and the device must match */
> > > +        if (chan->device->dev->driver != &dw_driver.driver)
> > 
> > Could we somehow pass the &.driver to the generic filter function (via
> > *_dma_controller_register() ? ) and do this to each DMA driver?

How, and what driver gets passed?

> My hope is still that we can avoid using filter functions entirely
> when we use xlate() logic, and instead just go through the channels
> of the dma engine we know we are looking at.

Has anyone yet determined whether any of these new DMA engine slave APIs
are usable for implementations which have a separate MUX between the
DMA engine and the DMA peripheral?

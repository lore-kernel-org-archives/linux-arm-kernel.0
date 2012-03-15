From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Mar 2012 10:09:23 +0000
Subject: [PATCH] of: Add generic device tree DMA helpers
In-Reply-To: <20120315092652.GA16389@n2100.arm.linux.org.uk>
References: <4F22DEF2.5000807@ti.com> <201203150922.06379.arnd@arndb.de>
 <20120315092652.GA16389@n2100.arm.linux.org.uk>
Message-ID: <201203151009.24161.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 March 2012, Russell King - ARM Linux wrote:
> On Thu, Mar 15, 2012 at 09:22:06AM +0000, Arnd Bergmann wrote:
> > On Thursday 15 March 2012, Nicolas Ferre wrote:
> > > Add some basic helpers to retrieve a DMA controller device_node and the
> > > DMA request specifications. By making DMA controllers register a generic
> > > translation function, we allow the management of any type of DMA requests
> > > specification.
> > > The void * output of an of_dma_xlate() function that will be implemented
> > > by the DMA controller can carry any type of "dma-request" argument.
> > > 
> > > The DMA client will search its associated DMA controller in the list and
> > > call the registered of_dam_xlate() function to retrieve the request values.
> > > 
> > > One simple xlate function is provided for the "single number" type of
> > > request binding.
> > > 
> > > This implementation is independent from dmaengine so it can also be used
> > > by legacy drivers.
> > > 
> > > For legacy reason another API will export the DMA request number into a
> > > Linux resource of type IORESOURCE_DMA.
> > 
> > This looks very good. I missed the first version of this patch, but was
> > thinking of very similar bindings.
> 
> There's one issue which is concerning me - when we switch OMAP to use
> DMA engine, it won't use numeric stuff anymore but the DMA engine way
> of requesting a channel (match function + data).
> 
> How does that fit into this scheme?

I haven't looked at the omap dma driver much, but if it just uses a
channel number, then I'd assume the data would be a single u32 cell
with that number, and the match function would be trivial.

Is that what you are asking about or am I missing the point?

	Arnd

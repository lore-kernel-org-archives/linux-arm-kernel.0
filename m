From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 29 May 2011 22:58:05 +0100
Subject: IrDA driver fails on PXA255
In-Reply-To: <alpine.DEB.2.00.1105291417090.9658@chino.kir.corp.google.com>
References: <20110528205701.GA1788@doriath.ww600.siemens.net>
	<alpine.DEB.2.00.1105281628480.9934@chino.kir.corp.google.com>
	<20110528234614.GV24876@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1105281913490.15709@chino.kir.corp.google.com>
	<20110529072516.GW24876@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1105291417090.9658@chino.kir.corp.google.com>
Message-ID: <20110529215805.GB5576@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 29, 2011 at 02:19:40PM -0700, David Rientjes wrote:
> On Sun, 29 May 2011, Russell King - ARM Linux wrote:
> 
> > > arm, pxa2xx: enable DMA support for pxa2xx IRDA interface
> > > 
> > > The pxa2xx-ir driver allocates with GFP_DMA, so it must always have 
> > > ZONE_DMA.
> > 
> > Wrong way.  If there's no restrictions, drivers shouldn't be using
> > GFP_DMA.  For the majority of SoCs, that's the case.
> > 
> 
> That's great, but before you can actually determine what requires DMA for 
> this driver and what doesn't, we need something for this merge window (and 
> backported to -stable) so that users aren't forced to go through and 
> enable CONFIG_ZONE_DMA on their own .config.
> 
> Is there a downside to enabling CONFIG_ZONE_DMA for all configs that 
> compile this driver until a better solution can be found?

We might as well enable CONFIG_ZONE_DMA for everything if that's what
you're proposing, because it's not just this driver which will be affected.
And as soon as we do that, we completely lose the warnings that stuff
needs fixing.

This is not the way to sort this problem out.

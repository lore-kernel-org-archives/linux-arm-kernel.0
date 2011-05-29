From: rientjes@google.com (David Rientjes)
Date: Sun, 29 May 2011 14:19:40 -0700 (PDT)
Subject: IrDA driver fails on PXA255
In-Reply-To: <20110529072516.GW24876@n2100.arm.linux.org.uk>
References: <20110528205701.GA1788@doriath.ww600.siemens.net>
	<alpine.DEB.2.00.1105281628480.9934@chino.kir.corp.google.com>
	<20110528234614.GV24876@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1105281913490.15709@chino.kir.corp.google.com>
	<20110529072516.GW24876@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.00.1105291417090.9658@chino.kir.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 29 May 2011, Russell King - ARM Linux wrote:

> > arm, pxa2xx: enable DMA support for pxa2xx IRDA interface
> > 
> > The pxa2xx-ir driver allocates with GFP_DMA, so it must always have 
> > ZONE_DMA.
> 
> Wrong way.  If there's no restrictions, drivers shouldn't be using
> GFP_DMA.  For the majority of SoCs, that's the case.
> 

That's great, but before you can actually determine what requires DMA for 
this driver and what doesn't, we need something for this merge window (and 
backported to -stable) so that users aren't forced to go through and 
enable CONFIG_ZONE_DMA on their own .config.

Is there a downside to enabling CONFIG_ZONE_DMA for all configs that 
compile this driver until a better solution can be found?

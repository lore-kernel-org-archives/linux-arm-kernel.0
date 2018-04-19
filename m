From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Thu, 19 Apr 2018 15:32:33 +0200
Subject: [PATCH 2/3] dt-bindings: add binding for at91-usart in spi mode
In-Reply-To: <20180417110358.GD8973@sirena.org.uk>
References: <20180413161117.20274-1-radu.pirea@microchip.com>
 <20180413161117.20274-3-radu.pirea@microchip.com>
 <20180413162327.GE22187@piout.net>
 <8e6c447d-dce5-f9af-e5b2-8d1d863159d6@microchip.com>
 <20180413181251.GG22187@piout.net>
 <20180417110358.GD8973@sirena.org.uk>
Message-ID: <20180419133233.GE7369@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/04/2018 12:03:58+0100, Mark Brown wrote:
> On Fri, Apr 13, 2018 at 08:12:51PM +0200, Alexandre Belloni wrote:
> > On 13/04/2018 19:12:54+0200, Nicolas Ferre wrote:
> 
> > > This layout of the hardware is completely different from the USART one and
> > > it seems to makes sense to address it with a different hardware description
> > > and so a different compatible string.
> 
> > But then, you can end up with two drivers trying to use the same IP
> > because nothing prevents you from writing a DT with both a usart and an
> > spi node enabled for the same IP. request_mem_region() will not help
> > here because then the working driver will depend on the probing order.
> 
> We don't really have too much in the way of better ideas for how to
> handle this though.  Take a look at how the PXA SSP stuff handles this,
> though that's not really doing too much different it at least layers a
> mechanism on top to avoid collisions.

My suggestion was to add an MFD driver that would match the current
compatible and either have an atmel,usart-mode property or maybe more
risky, check whether there are children nodes. Based on that, the
correct platform device can be added, either an usart or an spi master
device can be registered.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

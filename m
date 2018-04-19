From: radu.pirea@microchip.com (Radu Pirea)
Date: Thu, 19 Apr 2018 13:04:16 +0300
Subject: [PATCH 2/3] dt-bindings: add binding for at91-usart in spi mode
In-Reply-To: <20180417110358.GD8973@sirena.org.uk>
References: <20180413161117.20274-1-radu.pirea@microchip.com>
 <20180413161117.20274-3-radu.pirea@microchip.com>
 <20180413162327.GE22187@piout.net>
 <8e6c447d-dce5-f9af-e5b2-8d1d863159d6@microchip.com>
 <20180413181251.GG22187@piout.net> <20180417110358.GD8973@sirena.org.uk>
Message-ID: <68cdbb8b60c32980caa7b130409d05d28788edd9.camel@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-04-17 at 12:03 +0100, Mark Brown wrote:
> On Fri, Apr 13, 2018 at 08:12:51PM +0200, Alexandre Belloni wrote:
> > On 13/04/2018 19:12:54+0200, Nicolas Ferre wrote:
> > > This layout of the hardware is completely different from the
> > > USART one and
> > > it seems to makes sense to address it with a different hardware
> > > description
> > > and so a different compatible string.
> > But then, you can end up with two drivers trying to use the same IP
> > because nothing prevents you from writing a DT with both a usart
> > and an
> > spi node enabled for the same IP. request_mem_region() will not
> > help
> > here because then the working driver will depend on the probing
> > order.
> 
> We don't really have too much in the way of better ideas for how to
> handle this though.  Take a look at how the PXA SSP stuff handles
> this,
> though that's not really doing too much different it at least layers
> a
> mechanism on top to avoid collisions.
Hi Mark,

Thank you for suggestions. I followed your advice and looked at PXA SSP
driver. In my opinion it is a layer that avoids collsions and
unfortunately complicates things a bit. My ideea is to keep the things
as simple as possible. For example, I can enhance usart-serial and
usart-spi drivers to print detailed messages if probe fails because one
driver tries to request a memory region already used by another driver.
What do you think? Is this approach a good way to move forward?

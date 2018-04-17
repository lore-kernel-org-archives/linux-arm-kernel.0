From: broonie@kernel.org (Mark Brown)
Date: Tue, 17 Apr 2018 12:03:58 +0100
Subject: [PATCH 2/3] dt-bindings: add binding for at91-usart in spi mode
In-Reply-To: <20180413181251.GG22187@piout.net>
References: <20180413161117.20274-1-radu.pirea@microchip.com>
 <20180413161117.20274-3-radu.pirea@microchip.com>
 <20180413162327.GE22187@piout.net>
 <8e6c447d-dce5-f9af-e5b2-8d1d863159d6@microchip.com>
 <20180413181251.GG22187@piout.net>
Message-ID: <20180417110358.GD8973@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 13, 2018 at 08:12:51PM +0200, Alexandre Belloni wrote:
> On 13/04/2018 19:12:54+0200, Nicolas Ferre wrote:

> > This layout of the hardware is completely different from the USART one and
> > it seems to makes sense to address it with a different hardware description
> > and so a different compatible string.

> But then, you can end up with two drivers trying to use the same IP
> because nothing prevents you from writing a DT with both a usart and an
> spi node enabled for the same IP. request_mem_region() will not help
> here because then the working driver will depend on the probing order.

We don't really have too much in the way of better ideas for how to
handle this though.  Take a look at how the PXA SSP stuff handles this,
though that's not really doing too much different it at least layers a
mechanism on top to avoid collisions.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180417/26668ad7/attachment.sig>

From: broonie@kernel.org (Mark Brown)
Date: Mon, 15 Jun 2015 16:49:35 +0100
Subject: [PATCH v3 2/3] spi: atmel: update DT bindings documentation
In-Reply-To: <5579B95F.9060307@atmel.com>
References: <cover.1433850255.git.cyrille.pitchen@atmel.com>
 <ce7c16faafaa24f5bb711115c0eea1f8992d08c3.1433850255.git.cyrille.pitchen@atmel.com>
 <20150609172531.GM14071@sirena.org.uk> <5579B95F.9060307@atmel.com>
Message-ID: <20150615154935.GT18309@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 11, 2015 at 06:37:51PM +0200, Cyrille Pitchen wrote:
> Le 09/06/2015 19:25, Mark Brown a ?crit :
> > On Tue, Jun 09, 2015 at 01:53:53PM +0200, Cyrille Pitchen wrote:
> >> - add new property "atmel,fifo-size"

> > Why is this a property and not something we know from the IP version?

> Please be aware that the VERSION register can not be used to guess the
> size of FIFOs. Indeed, for a given hardware version, the SPI controller
> can be integrated on Atmel SoCs with different FIFO sizes. Also the
> "atmel,fifo-size" property is optional as older SPI controllers don't
> embed FIFO at all.

...

> Finally, on a given SoC, there can be several instances of the SPI
> controller with different FIFO sizes. This explain why we'd rather use a
> dedicated DT property than use the "compatible" property.

> I hope these pieces of information will help to clarify this point.
> Of course, we are open to other suggestions.

Ugh, what a wonderfully consistent hardware design :(  Please make it
clear in the documentation what is going on here, this looks like an
obvious bug in the DT binding - a very common pattern for bugs is to do
version quirks like this as properties.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150615/9adc5a69/attachment.sig>

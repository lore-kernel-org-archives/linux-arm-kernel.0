From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Thu, 11 Jun 2015 18:37:51 +0200
Subject: [PATCH v3 2/3] spi: atmel: update DT bindings documentation
In-Reply-To: <20150609172531.GM14071@sirena.org.uk>
References: <cover.1433850255.git.cyrille.pitchen@atmel.com>
 <ce7c16faafaa24f5bb711115c0eea1f8992d08c3.1433850255.git.cyrille.pitchen@atmel.com>
 <20150609172531.GM14071@sirena.org.uk>
Message-ID: <5579B95F.9060307@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 09/06/2015 19:25, Mark Brown a ?crit :
> On Tue, Jun 09, 2015 at 01:53:53PM +0200, Cyrille Pitchen wrote:
>> - add new property "atmel,fifo-size"
> 
> Why is this a property and not something we know from the IP version?
>
Hi Mark,
 
Please be aware that the VERSION register can not be used to guess the
size of FIFOs. Indeed, for a given hardware version, the SPI controller
can be integrated on Atmel SoCs with different FIFO sizes. Also the
"atmel,fifo-size" property is optional as older SPI controllers don't
embed FIFO at all.

Besides, the FIFO size can not be read or guessed from other registers:
When designing the FIFO feature, no dedicated registers were added to
store this size. Unused spaces in the I/O register range are limited and
better reserved for future usages. Instead, the FIFO size of each
peripheral is documented in the programmer datasheet.

Finally, on a given SoC, there can be several instances of the SPI
controller with different FIFO sizes. This explain why we'd rather use a
dedicated DT property than use the "compatible" property.

I hope these pieces of information will help to clarify this point.
Of course, we are open to other suggestions.

Best Regards,

Cyrille

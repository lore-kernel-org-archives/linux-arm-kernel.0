From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Jan 2010 15:16:16 +0000
Subject: Uncompressing broken with commit e7db7b4270
In-Reply-To: <20100129150345.GA5876@laptop>
References: <1264698229.7064.93.camel@pc1117.cambridge.arm.com>
	<20100129144601.GA27577@pengutronix.de>
	<20100129150345.GA5876@laptop>
Message-ID: <20100129151616.GA17299@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 29, 2010 at 04:04:15PM +0100, Albin Tonnerre wrote:
> If so, the decompressor would exit with an error message stating that it can't
> allocate enough memory, so I doubt this is the cause.
> 
> However, I have to admit I have no clue as to why Catalin is experiencing this.
> Maybe you could check if your kernel is compiled with CONFIG_ALIGNMENT_TRAP, and
> try setting it if it's unset, just to make sure it does not try to read
> something unaligned?

Alignment faults can't be handled in the decompressor; we have no
reliable way to setup the machine vectors at such an early stage to
trap any exceptions.

> Anyway... Russell, would you have any hint?

Absolutely none.

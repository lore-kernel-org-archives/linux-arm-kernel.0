From: marex@denx.de (Marek Vasut)
Date: Mon, 24 Aug 2015 15:15:44 +0200
Subject: [PATCH linux-next v4 5/5] mtd: atmel-quadspi: add driver for
 Atmel QSPI controller
In-Reply-To: <20150824124924.GZ7557@n2100.arm.linux.org.uk>
References: <cover.1440410236.git.cyrille.pitchen@atmel.com>
 <201508241303.52066.marex@denx.de>
 <20150824124924.GZ7557@n2100.arm.linux.org.uk>
Message-ID: <201508241515.45036.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, August 24, 2015 at 02:49:24 PM, Russell King - ARM Linux wrote:

Hi Russell,

> On Mon, Aug 24, 2015 at 01:03:51PM +0200, Marek Vasut wrote:
> > These are functions, not macros :)
> > 
> > btw is there any reason for these ? I'd say, just put the read*() and
> > write*() functions directly into the code and be done with it, it is
> > much less confusing.
> > 
> > Also, why do you use the _relaxed() versions of the functions ?
> 
> Now that the _relaxed() accessors are available throughout the kernel,
> everyone should be using the _relaxed() versions unless they need the
> properties of the non-relaxed versions.

You mean the memory barrier, right ?

> Remember that the non-relaxed
> versions are rather expensive on ARM due to the need to go all the way
> out to the L2 cache - it at least doubles the number of accesses for
> every read*/write*().

I think in case of this driver, we don't need the non-relaxed version
anywhere, right ? Thanks for the educational writeup :)

btw. is [1] still the current study material on the I/O accessor best
practices please ?

[1] http://permalink.gmane.org/gmane.linux.ports.arm.kernel/117644

Best regards,
Marek Vasut

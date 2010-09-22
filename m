From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 22 Sep 2010 15:31:21 +1000
Subject: Regarding hw irq to Linux irq mapping on ARM
In-Reply-To: <AANLkTinrfJkK85v2epOY95YWaVyMBcxSF2xakHqsM7vh@mail.gmail.com>
References: <AANLkTi=6nCJnfLB1uc0uLGOvOm0CX_R=j-8GQWTzmmep@mail.gmail.com>
	<AANLkTimp7+BLNBwZyBiPS0JgB_mno+gp8+mK=VdOd3+_@mail.gmail.com>
	<alpine.LFD.2.00.1009212342580.2416@localhost6.localdomain6>
	<AANLkTinrfJkK85v2epOY95YWaVyMBcxSF2xakHqsM7vh@mail.gmail.com>
Message-ID: <1285133481.30449.170.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-09-22 at 00:08 -0300, Grant Likely wrote:
> > Add all the I2C, SPI based irq extenders to that list. They seem to
> > pop up all over the place in rapid speed even in x86. We are happy
> > citizens of the embedded horror^Wuniverse now.
> 
> *shudder*
> 
> What's the irq handling latency on those?  Glad I haven't had to deal
> with any of them yet.

And i2c in many cases want to be called from sleep'able context... might
be a good idea to restrict some of these to threaded interrupts. A whole
different discussion I suppose.

Cheers,
Ben.

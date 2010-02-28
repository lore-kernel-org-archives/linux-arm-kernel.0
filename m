From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun, 28 Feb 2010 23:20:22 +0000
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <20100226220351.GE23933@n2100.arm.linux.org.uk>
References: <1266445892.16346.306.camel@pasglop>
	<1266599755.32546.38.camel@e102109-lin.cambridge.arm.com>
	<1266979170.23523.1660.camel@pasglop>
	<1267202674.14703.70.camel@e102109-lin.cambridge.arm.com>
	<1267220980.23523.1820.camel@pasglop>
	<20100226220351.GE23933@n2100.arm.linux.org.uk>
Message-ID: <1267399222.4485.26.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-02-26 at 22:03 +0000, Russell King - ARM Linux wrote:
> On Sat, Feb 27, 2010 at 08:49:40AM +1100, Benjamin Herrenschmidt wrote:
> > It will deadlock if you use normal IRQs. I don't see a good way around
> > that other than using a higher-level type of IRQs. I though ARM has
> > something like that (FIQs ?). Can you use those guys for IPIs ?
[...]
> The other problem we'd encounter using FIQs for IPIs is that some IPIs
> need to take locks - and in order to make that safe, we'd either need
> another class of locks which disable IRQs and FIQs together, or we'd
> need to disable FIQs everywhere we disable IRQs - at which point FIQs
> become utterly pointless.

You could use the FIQ only for the DMA cache maintenance operations and
not as a generic IPI mechanism. But the hardware needs to be modified.


-- 
Catalin

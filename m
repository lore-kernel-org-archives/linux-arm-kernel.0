From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Jan 2011 16:43:44 +0000
Subject: mmci: U300 "sync with blockend" broken for multi-block?
In-Reply-To: <AANLkTi=4SrxX-oCx-XXd+oib64j8RhMLdsQD1oWGxgU1@mail.gmail.com>
References: <AANLkTimYb6TxLj4SamxRwUgykf9JyW5y9gbejOUXqZ7K@mail.gmail.com>
	<20110101121048.GB25924@n2100.arm.linux.org.uk>
	<AANLkTi=4SrxX-oCx-XXd+oib64j8RhMLdsQD1oWGxgU1@mail.gmail.com>
Message-ID: <20110105164344.GD8638@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 05, 2011 at 05:15:04PM +0100, Linus Walleij wrote:
> 2011/1/1 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> 
> > It would be good to characterize what's actually going on with U300 some
> > more, especially the timing between these signals and the FIFO interrupts,
> > rather than just stating that they occur "out of order".
> 
> I will try to document more closely. OTOMH it was like
> for reads they would come in one order first one then
> another and for writes the other way around. That was
> why the older quirk for U300 was working, wiring the
> DATAEND high, though it was no good in modeling
> what was actually happening.

Any chance of pr_debug'ing the complete status register each time you
service an interrupt?  You'll probably need to set the kernel log
buffer fairly large to ensure that you capture everything.

I wouldn't recommend dumping the messages through the serial port
directly as that'd put far too much latency on the servicing of them,
but using dmesg after the accesses to retrieve them.  (IOW, don't
pass 'debug' to the kernel...)

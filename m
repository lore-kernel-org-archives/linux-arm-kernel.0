From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Jan 2011 16:14:53 +0000
Subject: [PATCH v2] arm: Configure reference clock for Versatile Express
	timers
In-Reply-To: <F01D8B85CFF58440B2A13965FBA90CA45911F4328E@GEORGE.Emea.Arm.com>
References: <1295373883-21513-1-git-send-email-pawel.moll@arm.com>
	<20110124144753.GB22949@n2100.arm.linux.org.uk>
	<F01D8B85CFF58440B2A13965FBA90CA45911F4328E@GEORGE.Emea.Arm.com>
Message-ID: <20110124161453.GB24104@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 24, 2011 at 04:12:16PM +0000, Pawel Moll wrote:
> > > -   writel(0, MMIO_P2V(V2M_TIMER0) + TIMER_CTRL);
> > > -   writel(0, MMIO_P2V(V2M_TIMER1) + TIMER_CTRL);
> > BTW, why are you removing the initialization of TIMER_CTRL ?  You
> > don't
> > describe why you do this in the commit log so I suspect it's a
> > mistake.
> 
> Uh, apologies. The explanation got lost while moving the patch between
> one tree and another...
> 
> I've removed them, because the sp804 driver is initializing these
> registers in sp804_clocksource_init() and sp804_set_mode(), just a
> jiffy later.

What if we have some other more preferable clock events which
rules in set_mode not being called?  How do we ensure that these
timers won't create some spurious interrupts?

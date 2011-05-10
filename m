From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 May 2011 09:07:52 +0100
Subject: [PATCH 08/13] clocksource: convert ARM 32-bit down counting
	clocksources
In-Reply-To: <20110510073930.GA19558@mail.gnudd.com>
References: <E1QJhPM-0000yq-ED@rmk-PC.arm.linux.org.uk>
	<20110510072700.GA29869@n2100.arm.linux.org.uk>
	<20110510073930.GA19558@mail.gnudd.com>
Message-ID: <20110510080752.GA29977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 10, 2011 at 09:39:30AM +0200, Alessandro Rubini wrote:
> > Convert MXC, Nomadik and Orion 32-bit down-counting clocksources to
> > generic mmio clocksource infrastructure.
> 
> Ok, but I think Linusw should ack this as there is the issue of
> dummy-read used initially, that I really didn't understand.

It was introduced for sched_clock() support - see 2a84751 (ARM: 6107/1:
plat-nomadik: use the MTU clocksrc for sched_clock).  That has already
been revised so it doesn't use nmdk_clksrc.read - see 8fbb97a (ARM:
6488/1: nomadik: prevent sched_clock() wraparound).

The clocksource isn't registered, and there are no users of
nmdk_clksrc.read, so nothing is going to call the dummy read function.

> > +	if (clocksource_mmio_init(mti_base + MTU_VAL(0), "mtu_0",
> 
> Typo. That's "mtu_base", not "mti".

Fixed.

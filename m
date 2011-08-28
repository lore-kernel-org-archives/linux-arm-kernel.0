From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 29 Aug 2011 00:43:03 +0100
Subject: How to handle named resources with DT?
In-Reply-To: <alpine.DEB.2.00.1108281100150.23968@utopia.booyaka.com>
References: <20110809205723.GE11568@ponder.secretlab.ca>
	<201108261741.29850.arnd@arndb.de>
	<20110827143736.GA10182@yookeroo.fritz.box>
	<5595208.OB5dBohxQP@wuerfel>
	<20110828083934.GA4254@yookeroo.fritz.box>
	<alpine.DEB.2.00.1108281100150.23968@utopia.booyaka.com>
Message-ID: <20110828234303.GB14560@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 28, 2011 at 05:06:43PM -0600, Paul Walmsley wrote:
> DMA resource data are usually DMA request line ID numbers.

Not always.  On ARMs development platforms, we ended up using strings -
because we've ended up with a DMA controller with N request signals,
where the first three request signals come from a MUX which assigns
them to other devices in the system.

An opaque number doesn't hack it because you start having to define
arbitary ranges for such things, and that very quickly starts getting
you into sticky problems when you have to work out that request
signal S1 is routed through mux M1 which is connected to DMA request
signal D1, and if M1 is in use, then maybe M2 can be used instead
which routes to DMA request signal D2.

The idea that DMA should be small integers is very limiting.

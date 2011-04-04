From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Apr 2011 14:31:04 +0100
Subject: [GIT PULL] omap changes for v2.6.39 merge window
In-Reply-To: <1301923457.417.34.camel@e102391-lin.cambridge.arm.com>
References: <alpine.LFD.2.00.1103310145390.28032@xanadu.home>
	<201104031726.37420.arnd@arndb.de>
	<20110403160324.GA8050@n2100.arm.linux.org.uk>
	<201104040259.26601.arnd@arndb.de>
	<1301915022.15819.28.camel@e102109-lin.cambridge.arm.com>
	<20110404112104.GB19854@n2100.arm.linux.org.uk>
	<1301923457.417.34.camel@e102391-lin.cambridge.arm.com>
Message-ID: <20110404133104.GA23266@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 04, 2011 at 02:24:17PM +0100, Marc Zyngier wrote:
> On Mon, 2011-04-04 at 12:21 +0100, Russell King - ARM Linux wrote:
> > Whether its worth it or not is questionable - the above is more lines
> > of code than many of the existing implementations, and we're not going
> > to shrink the existing implementations by much (maybe one to three
> > lines.)  The only thing we gain is the ability to select an implementation
> > at runtime.
> 
> I believe this last point to be rather important if we plan to have this
> mythical single kernel covering several architectures. It's also nice
> for the A15 to be able to use some default sched_clock() implementation
> as a fallback if the generic timers are not available for some reason.

If ARM are going to architect a set of timers into the hardware, let's
make sure that all such hardware has them so we can dig ourselves out
of this crappy mess that we find ourselves in today.

I do hope they're not missing functionality like the GIC is - otherwise
they're just going to make the situation worse than it already is.

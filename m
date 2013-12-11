From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Dec 2013 04:07:27 +0100
Subject: [Linaro-acpi] [RFC part1 PATCH 1/7] ACPI: Make ACPI core running
 without PCI on ARM64
In-Reply-To: <20131210202323.GJ11468@sirena.org.uk>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
 <201312102100.20570.arnd@arndb.de> <20131210202323.GJ11468@sirena.org.uk>
Message-ID: <201312110407.27848.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 December 2013, Mark Brown wrote:
> On Tue, Dec 10, 2013 at 09:00:20PM +0100, Arnd Bergmann wrote:
> > On Tuesday 10 December 2013, Mark Brown wrote:
> 
> > > It's not just the SoC, it's also the rest of the board.  The patches the
> > > Intel guys are submitting at the minute are mainly for the off-SoC
> > > devices at least as far as I noticed.  This'll impact anyone who ends up
> > > using ACPI, we need to at least pay attention to what's going on there.
> 
> > Yes, but I'm not that worried about off-soc stuff, which tends to be
> > off the much simpler variety: a few MMIO or PIO registers, IRQs,
> > GPIOs or (with ACPI-5.0) devices on i2c and spi buses.
> 
> That's not my experience especially once you get into phone type
> hardware - there's not much complexity difference when gluing things
> into the system and the fact that it's connected by the board increases
> the amount of flexibility that has to be coped with.

Yes, that is probably right. The only argument that one can make about
the mobile phone case is that these devices are so complex that nobody
even bothers any more running upstream kernels on them on any CPU
architecture. If the kernel code is kept out of the mainline tree,
it doesn't matter to us what they use, and the developers don't gain
much by following any of the available firmware models either.

	Arnd

From: broonie@kernel.org (Mark Brown)
Date: Tue, 10 Dec 2013 20:23:23 +0000
Subject: [Linaro-acpi] [RFC part1 PATCH 1/7] ACPI: Make ACPI core running
 without PCI on ARM64
In-Reply-To: <201312102100.20570.arnd@arndb.de>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
 <201312100428.52588.arnd@arndb.de>
 <20131210192217.GI11468@sirena.org.uk>
 <201312102100.20570.arnd@arndb.de>
Message-ID: <20131210202323.GJ11468@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 10, 2013 at 09:00:20PM +0100, Arnd Bergmann wrote:
> On Tuesday 10 December 2013, Mark Brown wrote:

> > It's not just the SoC, it's also the rest of the board.  The patches the
> > Intel guys are submitting at the minute are mainly for the off-SoC
> > devices at least as far as I noticed.  This'll impact anyone who ends up
> > using ACPI, we need to at least pay attention to what's going on there.

> Yes, but I'm not that worried about off-soc stuff, which tends to be
> off the much simpler variety: a few MMIO or PIO registers, IRQs,
> GPIOs or (with ACPI-5.0) devices on i2c and spi buses.

That's not my experience especially once you get into phone type
hardware - there's not much complexity difference when gluing things
into the system and the fact that it's connected by the board increases
the amount of flexibility that has to be coped with.  I don't see a
substantial difference between the two cases.  To be honest I'm a bit
concerned about what we're going to see given where ACPI's at as a spec.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131210/afc23f81/attachment.sig>

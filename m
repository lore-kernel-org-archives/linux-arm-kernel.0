From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 12 Jan 2010 22:48:34 +0000
Subject: Samsung SoC clock updates
In-Reply-To: <20100112220351.GG18532@trinity.fluff.org>
References: <1262917822-26004-1-git-send-email-ben-linux@fluff.org>
	<20100112091608.GD26435@n2100.arm.linux.org.uk>
	<20100112220351.GG18532@trinity.fluff.org>
Message-ID: <20100112224833.GA19957@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2010 at 10:03:51PM +0000, Ben Dooks wrote:

> I'm not sure that clkdev will do what we need, we have a situatio where
> our platform-device names change depending on the system and thus we
> would have to either change the clk array at init time or do our own
> thing.

Surely this is exactly the sort of use case that clkdev is designed to
handle?  Essentially all it does is provide a remapping layer so that
the data associated with the struct clk doesn't have to bear any direct
relationship to the device and name used to look it up.  This means that
the SoC specific code can just define its clock tree in some way that
looks good for the hardware and then easily layer a mapping to what the
drivers expect without the two jobs having to interfere with each other.

> I will certainly eliminate the driver's use of clk_get(dev, "name") to get
> their default bus clock.

I don't understand what the problem is with that?  That's exactly what
I'd expect to see a driver doing (possibly with NULL instead of a
specific name).

From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 12 Jan 2010 22:03:51 +0000
Subject: Samsung SoC clock updates
In-Reply-To: <20100112091608.GD26435@n2100.arm.linux.org.uk>
References: <1262917822-26004-1-git-send-email-ben-linux@fluff.org>
	<20100112091608.GD26435@n2100.arm.linux.org.uk>
Message-ID: <20100112220351.GG18532@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2010 at 09:16:08AM +0000, Russell King - ARM Linux wrote:
> On Fri, Jan 08, 2010 at 02:30:08AM +0000, Ben Dooks wrote:
> > This is a new set of lcokc updates currently in my next-samsung-clock
> > branch, this has a few updates from the previous releases, including
> > updating of the clock registration code.
> 
> When is the Samsung code going to move over to clkdev?

I'm not sure that clkdev will do what we need, we have a situatio where
our platform-device names change depending on the system and thus we
would have to either change the clk array at init time or do our own
thing.

My aim is to try and look at this once the move to try and ensure that the
Samsung SoC range is using common code for things like clksrc_clk and
various things like gpiolib and then try and sort out updating the handling
of clocks.

I will certainly eliminate the driver's use of clk_get(dev, "name") to get
their default bus clock.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

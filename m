From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 10 May 2012 22:37:26 +0800
Subject: [PATCH 0/4] MXS: I2C improvements
In-Reply-To: <201205101317.25786.marex@denx.de>
References: <1335837621-14816-1-git-send-email-marex@denx.de>
 <201205092033.46812.marex@denx.de>
 <20120510073518.GE17875@S2101-09.ap.freescale.net>
 <201205101317.25786.marex@denx.de>
Message-ID: <20120510143723.GP17875@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 01:17:25PM +0200, Marek Vasut wrote:
> > Sorry, Marek.  Since we are moving over to device tree, I'm not going
> > to ack the arch/arm/mach-mxs changes, which are introducing more use
> > of platform data.
> 
> Can you please tell me what _exactly_ is the formal reason for
> NAKing these changes?

I said I'm not going to ack the changes, not I'm NAKing the changes.
But since you have put me on that position, ok, I'm now NAKing the
changes.  The reason is obvious, you are adding something we are trying
hard to remove.

> As far as I can see, they do not introduce
> new aspects of platform data but rather fix the usage in the
> current context, so I do not quite understand the reasoning.
> 
The i2c-mxs driver currently does not use platform_data at all, the
first patch creates a new file include/linux/i2c/mxs-i2c.h to introduce
it.

> I consider your current approach of NAKing these changes very
> harmful to MXS.

I take it in the opposite way.  It's helpful for MXS, especially
in the long run.

> If it wasn't for your NAKing every patch for MXS
> that doesn't use device tree, the platform would currently be in
> much better shape. By now, you'd already have good SPI driver,
> this I2C driver and maybe others. I wonder if others agree with
> me on this one?
> 
All the examples you put here are submitted in this development cycle,
how can they make the MXS support much better already without waiting
v3.5-rc1 to hit the mainline?

> But now we're waiting for the device tree support, which will
> take some more time to fully arrive. Maybe 3.5, but I doubt full
> DT support will hit mainline before 3.6. I'd understand you
> NAKing patches that don't use DT support if DT support for MXS
> was already in place, but there is not a trace of it in mainline.
> 
I would expect the support will hit mainline in a few weeks with
v3.5-rc1, so none of the examples you put here, neither SPI driver
nor I2C changes, can really hit the mainline earlier than DT.

> Finally, consider people who write patches for MXS (remember
> fixes for mxs-spi,

This is a new driver.

> or this fix for mxs-i2c for example
> again). They will easily be demotivated by this approach and give
> up on MXS, probably not reposting these changes.

That's a bit unfortunate.  Let me put an interesting story here.
When Huang Shijie adds DT support for gpmi-nand driver, he chooses to
not maintain the compatibility of non-DT support to make the code
a lot clean and simple.  When I asked how he can do this before all
those non-DT board files are converted to DT, I was reminded that
is not a problem because I rejected his board file changes coming along
with the driver, there is no in-tree board files are users of gpmi-nand
driver.  What I put here is it's much easier and cleaner to create a DT
only driver from the beginning than having a non-DT driver and then
converting it to DT.

> What is the plan
> on saving all the precious efforts that are currently NAKed by
> you?  How do we ensure this work does not get lost?
> 
If they do not get reposted to have DT support from the beginning,
I believe other people will do when the need of the patches are seen.

-- 
Regards,
Shawn

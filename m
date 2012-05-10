From: marex@denx.de (Marek Vasut)
Date: Thu, 10 May 2012 13:17:25 +0200
Subject: [PATCH 0/4] MXS: I2C improvements
In-Reply-To: <20120510073518.GE17875@S2101-09.ap.freescale.net>
References: <1335837621-14816-1-git-send-email-marex@denx.de>
 <201205092033.46812.marex@denx.de>
 <20120510073518.GE17875@S2101-09.ap.freescale.net>
Message-ID: <201205101317.25786.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Wed, May 09, 2012 at 08:33:46PM +0200, Marek Vasut wrote:
> > > This patchset implements support for adjustment of I2C bus speed via
> > > platform data. Further, it implements support for DMA transfers into
> > > the mxs-i2c driver. Lastly, there is a fix for GCC4.7 warning
> > > included.
> > > 
> > > Marek Vasut (4):
> > >   MXS: Allow passing i2c bus speed via platform data
> > >   MXS: Set I2C timing registers for mxs-i2c
> > >   MXS: Implement DMA support into mxs-i2c
> > >   MXS: Fix GCC4.7 complaint in mxs-i2c
> > 
> > Bump?
> 
> Sorry, Marek.  Since we are moving over to device tree, I'm not going
> to ack the arch/arm/mach-mxs changes, which are introducing more use
> of platform data.

Can you please tell me what _exactly_ is the formal reason for
NAKing these changes?  As far as I can see, they do not introduce
new aspects of platform data but rather fix the usage in the
current context, so I do not quite understand the reasoning.

I consider your current approach of NAKing these changes very
harmful to MXS. If it wasn't for your NAKing every patch for MXS
that doesn't use device tree, the platform would currently be in
much better shape. By now, you'd already have good SPI driver,
this I2C driver and maybe others. I wonder if others agree with
me on this one?

But now we're waiting for the device tree support, which will
take some more time to fully arrive. Maybe 3.5, but I doubt full
DT support will hit mainline before 3.6. I'd understand you
NAKing patches that don't use DT support if DT support for MXS
was already in place, but there is not a trace of it in mainline.

Finally, consider people who write patches for MXS (remember
fixes for mxs-spi, or this fix for mxs-i2c for example
again). They will easily be demotivated by this approach and give
up on MXS, probably not reposting these changes. What is the plan
on saving all the precious efforts that are currently NAKed by
you?  How do we ensure this work does not get lost?

Thank you.

Best regards,
Marek Vasut

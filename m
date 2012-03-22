From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 22 Mar 2012 11:33:56 +0000
Subject: [PATCH 4/4] clk: wm831x: Add initial WM831x clock driver
In-Reply-To: <20120322112613.GA3852@pengutronix.de>
References: <1332360082-25092-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1332360082-25092-4-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20120321222622.GG29317@pengutronix.de>
 <20120322111531.GA3091@opensource.wolfsonmicro.com>
 <20120322112613.GA3852@pengutronix.de>
Message-ID: <20120322113356.GC3091@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 22, 2012 at 12:26:13PM +0100, Sascha Hauer wrote:
> On Thu, Mar 22, 2012 at 11:15:31AM +0000, Mark Brown wrote:

> > No, that's not sensible.  We shouldn't be open coding this into each
> > individual driver that provides clocks, and we shouldn't have clock
> > users having to guess at what scheme the driver author used to dedupe
> > the clocks.  As a driver author you would assume that the reason we're

> It seems they got dropped. Currently the clock framework does nothing
> with the device argument. But right, it could use this argument to
> generate a suitable name.

Indeed, and as with adding the stub clk_unregister() it seems like it's
better at this point to just code the drivers as we'd expect them to
work and fill out the framework to handle this rather than introducing
workarounds in the drivers.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120322/5d75411a/attachment.sig>

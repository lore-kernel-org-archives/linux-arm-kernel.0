From: tpiepho@impinj.com (Trent Piepho)
Date: Tue, 31 Oct 2017 16:57:42 +0000
Subject: [PATCH v2 1/4] spi: imx: GPIO based chip selects should not be
 required
In-Reply-To: <20171031111919.gocl7wwrhkwnxrya@sirena.co.uk>
References: <20171027010841.28624-1-tpiepho@impinj.com>
 <20171027010841.28624-2-tpiepho@impinj.com>
 <20171031111919.gocl7wwrhkwnxrya@sirena.co.uk>
Message-ID: <1509469061.5473.16.camel@impinj.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-10-31 at 11:19 +0000, Mark Brown wrote:
> On Thu, Oct 26, 2017 at 06:08:38PM -0700, Trent Piepho wrote:
> > The driver will fail to load if no gpio chip selects are specified,
> > this patch changes this so that it no longer fails.
> > 
> > It's possible to use all native chip selects, in which case there is
> > no reason to have a gpio chip select array.  This is what happens if
> > the *optional* device tree property "cs-gpios" is omitted.
> 
> Do the native chip selects actually work usefully on this hardware?
> There used to be problems with it wanting to do things like bounce the
> chip select on every word which made it extremely difficult to use with
> Linux.

Still are annoying, but on the device we have connected to it, it ends
up working as desired.

I've not thoroughly investigated this hardware to find the details. 
IIRC, the designware SPI on Altera SoCFPGA had the same issue, but it
was a flaw in the driver and I was able to fix it.  I've come to expect
it, as every new SPI master I use doesn't work properly in some
different way.

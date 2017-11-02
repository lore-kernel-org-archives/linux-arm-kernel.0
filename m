From: broonie@kernel.org (Mark Brown)
Date: Thu, 2 Nov 2017 15:14:39 +0000
Subject: [PATCH v2 1/4] spi: imx: GPIO based chip selects should not be
 required
In-Reply-To: <1509469061.5473.16.camel@impinj.com>
References: <20171027010841.28624-1-tpiepho@impinj.com>
 <20171027010841.28624-2-tpiepho@impinj.com>
 <20171031111919.gocl7wwrhkwnxrya@sirena.co.uk>
 <1509469061.5473.16.camel@impinj.com>
Message-ID: <20171102151439.6dpfud7a5vtc27dy@sirena.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 31, 2017 at 04:57:42PM +0000, Trent Piepho wrote:
> On Tue, 2017-10-31 at 11:19 +0000, Mark Brown wrote:

> > Do the native chip selects actually work usefully on this hardware?
> > There used to be problems with it wanting to do things like bounce the
> > chip select on every word which made it extremely difficult to use with
> > Linux.

> Still are annoying, but on the device we have connected to it, it ends
> up working as desired.

> I've not thoroughly investigated this hardware to find the details. 
> IIRC, the designware SPI on Altera SoCFPGA had the same issue, but it
> was a flaw in the driver and I was able to fix it.  I've come to expect
> it, as every new SPI master I use doesn't work properly in some
> different way.

It's one of the reasons why I'm suspicous of making the GPIO optional,
lots of chips use GPIO chipselects because a lot of the breakage is
confined to chip select handling and I remember the i.MX as being
especially far from useful.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171102/07e88703/attachment.sig>

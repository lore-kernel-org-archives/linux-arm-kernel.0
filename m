From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 15 Feb 2016 13:03:08 -0800
Subject: arm qemu test failures due to 'driver-core: platform: probe
 of-devices only using list of compatibles'
In-Reply-To: <20160215171201.GK12289@pengutronix.de>
References: <20160214165010.GA3189@roeck-us.net>
 <20160215105909.GH12289@pengutronix.de> <56C1CE95.6020206@arm.com>
 <20160215144344.GF10826@n2100.arm.linux.org.uk>
 <20160215162753.GI12289@pengutronix.de>
 <20160215164937.GC25556@kroah.com>
 <20160215171201.GK12289@pengutronix.de>
Message-ID: <20160215210308.GA12095@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 06:12:01PM +0100, Uwe Kleine-K?nig wrote:
> Hello Greg,
> 
> On Mon, Feb 15, 2016 at 08:49:37AM -0800, Greg Kroah-Hartman wrote:
> > On Mon, Feb 15, 2016 at 05:27:53PM +0100, Uwe Kleine-K?nig wrote:
> > > Greg, can you drop this patch, or do you need a proper changelog for a
> > > revert? On top of that I'd then create a new patch which is more
> > > conservative.
> > 
> > A hint as to what the git commit id was would be helpful, I can just
> > revert it based on that.
> 
> This is 67d02a1bbb33 ("driver-core: platform: probe of-devices only
> using list of compatibles")
> 
> If you need a log, something like:
> 
> 	Reallow binding of of-devices by name
> 
> 	It turned out that there are valid reasons (e.g. step by step
> 	conversion to device tree probing using auxdata) to bind
> 	of-instantiated devices to drivers by name. So revert to the
> 	original logic.

Now reverted, thanks for the text.

greg k-h

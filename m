From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Feb 2012 20:19:38 +0000
Subject: [PATCH 1/2] ARM: Add Kconfig option to use mkimage -T
 kernel_noload
In-Reply-To: <4F4E86A1.8010506@bluewatersys.com>
References: <1330473804-23348-1-git-send-email-swarren@nvidia.com>
 <20120229122942.GF3318@game.jcrosoft.org>
 <74CDBE0F657A3D45AFBB94109FB122FF17BDDF206A@HQMAIL01.nvidia.com>
 <20120229181430.GI3318@game.jcrosoft.org> <4F4E6F96.8080907@am.sony.com>
 <20120229191209.GN14173@pengutronix.de>
 <74CDBE0F657A3D45AFBB94109FB122FF17BDDF2122@HQMAIL01.nvidia.com>
 <20120229194409.GO14173@pengutronix.de>
 <74CDBE0F657A3D45AFBB94109FB122FF17BDDF2155@HQMAIL01.nvidia.com>
 <4F4E86A1.8010506@bluewatersys.com>
Message-ID: <20120229201938.GB16999@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2012 at 09:12:17AM +1300, Andre Renaud wrote:
> On 01/03/12 08:59, Stephen Warren wrote:
> > Uwe Kleine-K?nig wrote at Wednesday, February 29, 2012 12:44 PM:
> > ...
> >> If you want to give incentive for U-Boot to improve, drop the target
> >> today. And note that at least people caring about boot time must not use
> >> the kernel's uImage target anyhow.
> > 
> > If you enable the new config option in this patch, then the performance
> > issue is solved; U-Boot doesn't copy the kernel image any more, and the
> > kernel decompressor can write directly to the appropriate location without
> > moving the image first (assuming your board boot script loads the uImage
> > to a non-conflicting address).
> 
> I may have missed part of this, but isn't one of the points regarding
> this that the zImage decompressor always runs with data cache disabled,

Most certainly not.  We've had the data cache enabled for years and
years.  And I mean 10+ years.  We may have been lacking support on
some CPUs, but that was because of lack of contributions.

> resulting in a slow decompress, where as if the U-Boot decompressor is
> used (ie, gzipping the Image, and telling U-Boot to decompress), then it
> can run with caches enabled, improving boot speed?

That's pure FUD.

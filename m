From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 29 Feb 2012 12:16:06 -0800
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
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17BDDF2162@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andre Renaud wrote at Wednesday, February 29, 2012 1:12 PM:
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
> resulting in a slow decompress, where as if the U-Boot decompressor is
> used (ie, gzipping the Image, and telling U-Boot to decompress), then it
> can run with caches enabled, improving boot speed?
> 
> Thus the relocation issue is not really the speed hit, rather it is the
> image decompression.

OK, there probably are multiple different issues affecting the performance,
and this patch only affects the one that applies once you've decided to use
uImage to wrap a zImage in the first place.

-- 
nvpublic

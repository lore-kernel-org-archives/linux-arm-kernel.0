From: andre@bluewatersys.com (Andre Renaud)
Date: Thu, 01 Mar 2012 09:25:12 +1300
Subject: [PATCH 1/2] ARM: Add Kconfig option to use mkimage -T
 kernel_noload
In-Reply-To: <20120229201938.GB16999@n2100.arm.linux.org.uk>
References: <1330473804-23348-1-git-send-email-swarren@nvidia.com>
 <20120229122942.GF3318@game.jcrosoft.org>
 <74CDBE0F657A3D45AFBB94109FB122FF17BDDF206A@HQMAIL01.nvidia.com>
 <20120229181430.GI3318@game.jcrosoft.org> <4F4E6F96.8080907@am.sony.com>
 <20120229191209.GN14173@pengutronix.de>
 <74CDBE0F657A3D45AFBB94109FB122FF17BDDF2122@HQMAIL01.nvidia.com>
 <20120229194409.GO14173@pengutronix.de>
 <74CDBE0F657A3D45AFBB94109FB122FF17BDDF2155@HQMAIL01.nvidia.com>
 <4F4E86A1.8010506@bluewatersys.com>
 <20120229201938.GB16999@n2100.arm.linux.org.uk>
Message-ID: <4F4E89A8.4080909@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,
>> I may have missed part of this, but isn't one of the points regarding
>> this that the zImage decompressor always runs with data cache disabled,
> 
> Most certainly not.  We've had the data cache enabled for years and
> years.  And I mean 10+ years.  We may have been lacking support on
> some CPUs, but that was because of lack of contributions.
> 
>> resulting in a slow decompress, where as if the U-Boot decompressor is
>> used (ie, gzipping the Image, and telling U-Boot to decompress), then it
>> can run with caches enabled, improving boot speed?
> 
> That's pure FUD.

I don't want to open a can of worms on this, and I certainly haven't
looked into the image decompressor within the Linux kernel, but from a
boot speed point of view we certainly see a significant speed
improvement switching from zImage to gzipped-Image. Do you know which
platforms include the data-cache support in the decompressor?

Regards,
Andre

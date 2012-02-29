From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 29 Feb 2012 13:27:31 -0800
Subject: [PATCH 1/2] ARM: Add Kconfig option to use mkimage -T
 kernel_noload
In-Reply-To: <20120229204527.GD16999@n2100.arm.linux.org.uk>
References: <20120229181430.GI3318@game.jcrosoft.org>
 <4F4E6F96.8080907@am.sony.com> <20120229191209.GN14173@pengutronix.de>
 <74CDBE0F657A3D45AFBB94109FB122FF17BDDF2122@HQMAIL01.nvidia.com>
 <20120229194409.GO14173@pengutronix.de>
 <74CDBE0F657A3D45AFBB94109FB122FF17BDDF2155@HQMAIL01.nvidia.com>
 <4F4E86A1.8010506@bluewatersys.com>
 <20120229201938.GB16999@n2100.arm.linux.org.uk>
 <4F4E89A8.4080909@bluewatersys.com> <20120229203958.GQ14173@pengutronix.de>
 <20120229204527.GD16999@n2100.arm.linux.org.uk>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17BDDF21A1@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King wrote at Wednesday, February 29, 2012 1:45 PM:
...
> So, really, comparing a standard uImage produced by the standard kernel
> with gzipped Image is far from a fair comparison.  And that's actually
> another argument for getting rid of the uImage target... it may make
> people think a bit about what they're doing rather than accepting
> whatever default location someone else chose for their kernel.

That seems like more of an argument for making the uImage target use
-T kernel_noload unconditionally, rather than removing the target.
Since doing so would solve the issue about the kernel picking a load
address.

That is, ignoring any arguments about breaking existing workflows at
least...

-- 
nvpublic

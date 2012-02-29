From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 29 Feb 2012 11:59:42 -0800
Subject: [PATCH 1/2] ARM: Add Kconfig option to use mkimage -T
 kernel_noload
In-Reply-To: <20120229194409.GO14173@pengutronix.de>
References: <1330473804-23348-1-git-send-email-swarren@nvidia.com>
 <20120229122942.GF3318@game.jcrosoft.org>
 <74CDBE0F657A3D45AFBB94109FB122FF17BDDF206A@HQMAIL01.nvidia.com>
 <20120229181430.GI3318@game.jcrosoft.org> <4F4E6F96.8080907@am.sony.com>
 <20120229191209.GN14173@pengutronix.de>
 <74CDBE0F657A3D45AFBB94109FB122FF17BDDF2122@HQMAIL01.nvidia.com>
 <20120229194409.GO14173@pengutronix.de>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17BDDF2155@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe Kleine-K?nig wrote at Wednesday, February 29, 2012 12:44 PM:
...
> If you want to give incentive for U-Boot to improve, drop the target
> today. And note that at least people caring about boot time must not use
> the kernel's uImage target anyhow.

If you enable the new config option in this patch, then the performance
issue is solved; U-Boot doesn't copy the kernel image any more, and the
kernel decompressor can write directly to the appropriate location without
moving the image first (assuming your board boot script loads the uImage
to a non-conflicting address).

--
nvpublic

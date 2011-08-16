From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 16 Aug 2011 08:46:14 +0200
Subject: [PATCH] detect conflicting zreladdrs
In-Reply-To: <1312980298-28035-1-git-send-email-s.hauer@pengutronix.de>
References: <1312980298-28035-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20110816064614.GF17990@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2011 at 02:44:55PM +0200, Sascha Hauer wrote:
> With CONFIG_ARM_PATCH_PHYS_VIRT and CONFIG_AUTO_ZRELADDR the kernel
> is ready to calculate zreladdr at runtime. Currently the boards specify
> zreladdr using := in their Makefile.boot. This means the value maybe
> overwritten silently if multiple zreladdr-y exist. This series changes
> the := into += so that we have multiple words in zreladdr instead.
> This makes it possible to catch conflicting zreladdrs during build.
> 
> Without CONFIG_AUTO_ZRELADDR=y multiple zreladdrs are not allowed for
> zImages, so we bail out if we detect it.
> 
> uImages are generally incompatible with multiple zreladdrs, so we
> bail out if we detect it. In this case an uImage can still be built
> by specifying LOADADDR= on the command line.
> 
> Sascha
> 
> Sascha Hauer (3):
>       ARM: Check for multiple zreladdrs
>       ARM: Check for multiple load addresses before building a uImage
>       ARM: allow to detect conflicting zreladdrs

Russell, any comments to this series? Ok to check into the patch system?

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

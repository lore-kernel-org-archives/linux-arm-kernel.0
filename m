From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Aug 2011 10:02:39 +0100
Subject: [PATCH] detect conflicting zreladdrs
In-Reply-To: <20110816064614.GF17990@pengutronix.de>
References: <1312980298-28035-1-git-send-email-s.hauer@pengutronix.de>
	<20110816064614.GF17990@pengutronix.de>
Message-ID: <20110817090239.GE1006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2011 at 08:46:14AM +0200, Sascha Hauer wrote:
> On Wed, Aug 10, 2011 at 02:44:55PM +0200, Sascha Hauer wrote:
> > With CONFIG_ARM_PATCH_PHYS_VIRT and CONFIG_AUTO_ZRELADDR the kernel
> > is ready to calculate zreladdr at runtime. Currently the boards specify
> > zreladdr using := in their Makefile.boot. This means the value maybe
> > overwritten silently if multiple zreladdr-y exist. This series changes
> > the := into += so that we have multiple words in zreladdr instead.
> > This makes it possible to catch conflicting zreladdrs during build.
> > 
> > Without CONFIG_AUTO_ZRELADDR=y multiple zreladdrs are not allowed for
> > zImages, so we bail out if we detect it.
> > 
> > uImages are generally incompatible with multiple zreladdrs, so we
> > bail out if we detect it. In this case an uImage can still be built
> > by specifying LOADADDR= on the command line.
> > 
> > Sascha
> > 
> > Sascha Hauer (3):
> >       ARM: Check for multiple zreladdrs
> >       ARM: Check for multiple load addresses before building a uImage
> >       ARM: allow to detect conflicting zreladdrs
> 
> Russell, any comments to this series? Ok to check into the patch system?

No, and yes.

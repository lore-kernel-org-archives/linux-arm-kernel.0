From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 3 Feb 2010 15:02:36 +0000
Subject: [PATCH 05/13] ARM: LPC32XX: arch Kconfig, plat Kconfig, and
	makefiles
In-Reply-To: <20100203135741.GA20113@pengutronix.de>
References: <1264643011-17390-1-git-send-email-wellsk40@gmail.com>
	<1264643011-17390-6-git-send-email-wellsk40@gmail.com>
	<20100203105152.GF11354@pengutronix.de>
	<20100203112645.GF22275@n2100.arm.linux.org.uk>
	<20100203135741.GA20113@pengutronix.de>
Message-ID: <20100203150236.GK22275@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2010 at 02:57:41PM +0100, Uwe Kleine-K?nig wrote:
> Hello Russell,
> 
> On Wed, Feb 03, 2010 at 11:26:46AM +0000, Russell King - ARM Linux wrote:
> > On Wed, Feb 03, 2010 at 11:51:52AM +0100, Uwe Kleine-K?nig wrote:
> > > > diff --git a/arch/arm/mach-lpc32xx/Makefile.boot b/arch/arm/mach-lpc32xx/Makefile.boot
> > > > new file mode 100644
> > > > index 0000000..b796b41
> > > > --- /dev/null
> > > > +++ b/arch/arm/mach-lpc32xx/Makefile.boot
> > > > @@ -0,0 +1,4 @@
> > > > +   zreladdr-y	:= 0x80008000
> > > > +params_phys-y	:= 0x80000100
> > > I hope your bootloader passes the atag list via r2.  If so there is no
> > > need to define params_phys-y.
> > 
> > Wrong - that's your expectation that nothing uses this, rather than
> > reality.  While the decompressor doesn't use it, it's required for
> > the 'bootp' add-on, which allows an initrd/initramfs image and kernel
> > to be combined together, and the initrd/ramfs to be split away from
> > the kernel - without encountering the PC24 relocation error problem.
> Obviously you're right.  Is bootp still used?

I've no idea - it's there for two reasons:

1. proof of concept for wrapping a zImage
2. to allow kernel+initrd to be loaded on systems which can only do
   bootp+tftp of a single file.

I know that my mini EBSA110 bootp loader (which is around 4K total) can
only accept an initrd this way, and I suspect there's some uclinux type
platforms which have similar restrictions.

From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 1 Oct 2013 07:12:57 -0400
Subject: [PATCH RESEND] ARM: add dtbImage.<dt> and dtbuImage.<dt> rules
In-Reply-To: <20131001104115.GA1384@sakura.staff.proxad.net>
References: <20120927082955.GR17667@game.jcrosoft.org>
 <CACQ1gAgwv4pBFZBrVZiWM2_=OneUO-s16LufSENx27gMC3DUig@mail.gmail.com>
 <52416F97.802@keymile.com>
 <20130924120152.GI11119@titan.lakedaemon.net>
 <20130924121939.GD12758@n2100.arm.linux.org.uk>
 <1380572483.31472.51.camel@sakura.staff.proxad.net>
 <20130930204223.GJ31178@titan.lakedaemon.net>
 <1380575265.23932.11.camel@sakura.staff.proxad.net>
 <alpine.LFD.2.03.1309302241400.6331@syhkavp.arg>
 <20131001104115.GA1384@sakura.staff.proxad.net>
Message-ID: <20131001111257.GN31178@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 12:41:15PM +0200, Maxime Bizon wrote:
> On Monday 30 Sep 2013 ? 23:14:49 (-0400), Nicolas Pitre wrote:
> 
> > > That "kind of hacky" ATAG thing was actually the only supported way to
> > > boot a platform not so long ago :)
> > 
> > Strictly speaking, this was never supported in mainline.

I was referring to the non-approved atags many vendors arbitrarily added
to their bootloaders and kernels.  Ethernet mac addresses, etc.  It's
not proper to go cluttering the kernel with every hair-brained, one-off
tag a board vendor came up with to ship a product.

> > The ultimate idea with the impedance matcher was to augment existing 
> > bootloaders with sort of a semi second stage bootloader that would be 
> > separate from zImage and installed permanently, and then only the zImage 
> > itself would be updateable.  This way you'd get a DT capable environment 
> > without replacing the actual bootloader.
> 
> That's true if you have access to the bootloader in some way (serial,
> flash env).
> 
> But for devices in the field for which upgrading the booloader is not
> an option, neither is changing anything else in the boot process
> (anything before linux starts). The risk of bricking the device is
> just too high.

This is the exact scenario we are solving with the impedance matcher.
It's a wrapper around a kernel and a series of dtbs.  To the bootloader,
it looks _exactly_ like the kernel, but it translates the info passed to
it into terms newer kernels can understand.  No need for a separate
binary.

hth,

Jason.

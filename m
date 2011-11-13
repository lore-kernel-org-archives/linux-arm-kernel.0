From: marek.vasut@gmail.com (Marek Vasut)
Date: Sun, 13 Nov 2011 17:20:22 +0100
Subject: [PATCH] ARM: Add lsxhl machine type to mach-types
In-Reply-To: <20111113082810.GF27746@n2100.arm.linux.org.uk>
References: <1320699251-26115-1-git-send-email-michael@walle.cc>
 <201111130129.57123.marek.vasut@gmail.com>
 <20111113082810.GF27746@n2100.arm.linux.org.uk>
Message-ID: <201111131720.22562.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Sun, Nov 13, 2011 at 01:29:56AM +0100, Marek Vasut wrote:
> > > On Sun, Nov 13, 2011 at 12:40:42AM +0100, Michael Walle wrote:
> > > > then, i guess, the problem is on the uboot side, at least if they
> > > > want to support both device tree based and old-fashioned setup code
> > > > (eg. backported device support.)
> > > 
> > > If uboot wants to carry the full list, rather than copying it from
> > > the kernel source, they should be going straight to the main source
> > > of the file (which is given inside the file itself.)
> > > 
> > > Otherwise, if they want to be purely dependent on the version shipped
> > > with the kernel, which will have entries for platforms not merged into
> > > the kernel source deleted from it once they're older than 12 months -
> > > but which may be in u-boot, they can continue taking it out of the
> > > kernel tree.  I think that's sub-optimal as they'll see regressions
> > > from time to time when platforms have been merged into u-boot but not
> > > the kernel.
> > 
> > Hey,
> > 
> > U-Boot follows the in-kernel mach-types file. We had a few issues with
> > boards not building due to the removal of old mach types.
> 
> As the kernel version of the file is now specifically customised for
> the kernel, u-boot should _not_ follow the kernel version anymore, as
> I pointed out.  u-boot need to change this policy of theirs.

Why would that be so? If the users want to support the boards and the boards are 
broken/removed from linux, they just define the mach id by hand. That also makes 
it easier to detect such boards. It is also a warning that noone gives a crap 
about such boards and they might as well soon be removed from uboot too.
> 
> The file has always been and remains available on the web.  There's
> absolutely no need for u-boot to take the customised version from the
> kernel source.

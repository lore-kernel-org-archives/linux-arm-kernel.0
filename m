From: shawn.guo@freescale.com (Shawn Guo)
Date: Sun, 12 Jun 2011 17:38:23 +0800
Subject: [PATCH 0/3] patches to allow DTB to be appended to the ARM zImage
In-Reply-To: <20110612092131.GC10283@n2100.arm.linux.org.uk>
References: <1307858800-16712-1-git-send-email-nicolas.pitre@linaro.org>
	<20110612081541.GA10283@n2100.arm.linux.org.uk>
	<20110612083414.GA29516@S2100-06.ap.freescale.net>
	<20110612092131.GC10283@n2100.arm.linux.org.uk>
Message-ID: <20110612093822.GB29516@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 12, 2011 at 10:21:31AM +0100, Russell King - ARM Linux wrote:
> On Sun, Jun 12, 2011 at 04:34:15PM +0800, Shawn Guo wrote:
> > On Sun, Jun 12, 2011 at 09:15:41AM +0100, Russell King - ARM Linux wrote:
> > > On Sun, Jun 12, 2011 at 02:06:37AM -0400, Nicolas Pitre wrote:
> > > > This is a resend of those patches with fixups after the latest changes
> > > > in mainline.
> > > > 
> > > > [PATCH 1/3] ARM: zImage: ensure it is always a multiple of 64 bits in size
> > > > This one is new and trivial.
> > > > 
> > > > [PATCH 2/3] ARM: zImage: Allow the appending of a device tree binary
> > > > Mostly John Bonesio's version with some adjustments and cleanups.
> > > > 
> > > > [PATCH 3/3] ARM: zImage: make sure appended DTB doesn't get overwritten by kernel .bss
> > > > New, simpler alternative to Tony Lindgren's version.
> > > 
> > > One thing which has been bugging me for some time is that the DT stuff
> > > completely overrides the ATAGs.  This is wrong with solutions like this.
> > > 
> > > We have a set of perfectly good boot loaders which provide correct
> > > information to the kernel via ATAGs.  If we start moving everything
> > > over to DT, then we run into a problem because the ATAGs are ignored -
> > > stuff such as the RAM size and command line passed from the boot loader
> > > will be entirely ignored, instead these having to be encoded into the
> > > kernel at build time.
> > > 
> > What u-boot does right now is replacing the parameters in dtb with
> > its for those it's interested in, for example command line is one,
> > before it passes dtb to kernel.
> 
> What if your platform doesn't use uboot?
> 
Add dtb parsing support with the help from libfdt, I guess.  It is
some amount of work, but it's not a rewrite of bootloader, IMHO.

-- 
Regards,
Shawn

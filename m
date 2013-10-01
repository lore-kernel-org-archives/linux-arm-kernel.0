From: mbizon@freebox.fr (Maxime Bizon)
Date: Tue, 1 Oct 2013 12:41:15 +0200
Subject: [PATCH RESEND] ARM: add dtbImage.<dt> and dtbuImage.<dt> rules
In-Reply-To: <alpine.LFD.2.03.1309302241400.6331@syhkavp.arg>
References: <1348733441-11626-1-git-send-email-richard.genoud@gmail.com>
 <20120927082955.GR17667@game.jcrosoft.org>
 <CACQ1gAgwv4pBFZBrVZiWM2_=OneUO-s16LufSENx27gMC3DUig@mail.gmail.com>
 <52416F97.802@keymile.com>
 <20130924120152.GI11119@titan.lakedaemon.net>
 <20130924121939.GD12758@n2100.arm.linux.org.uk>
 <1380572483.31472.51.camel@sakura.staff.proxad.net>
 <20130930204223.GJ31178@titan.lakedaemon.net>
 <1380575265.23932.11.camel@sakura.staff.proxad.net>
 <alpine.LFD.2.03.1309302241400.6331@syhkavp.arg>
Message-ID: <20131001104115.GA1384@sakura.staff.proxad.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Monday 30 Sep 2013 ? 23:14:49 (-0400), Nicolas Pitre wrote:

> > That "kind of hacky" ATAG thing was actually the only supported way to
> > boot a platform not so long ago :)
> 
> Strictly speaking, this was never supported in mainline.

I meant mach-type, which was ofc documented

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/Documentation/arm/Booting?id=1da177e4c3f41524e886b7f1b8a0c1fc7321cac2

> The ultimate idea with the impedance matcher was to augment existing 
> bootloaders with sort of a semi second stage bootloader that would be 
> separate from zImage and installed permanently, and then only the zImage 
> itself would be updateable.  This way you'd get a DT capable environment 
> without replacing the actual bootloader.

That's true if you have access to the bootloader in some way (serial,
flash env).

But for devices in the field for which upgrading the booloader is not
an option, neither is changing anything else in the boot process
(anything before linux starts). The risk of bricking the device is
just too high.

Now of course we have the capability to support these devices
ourselves, I just find it harsh that having "designed" that boot
process in 2010, we are told 3 years later that it is obsolete and
won't be able to boot a recent kernel (we support two machines with
one kernel image, appended DTB cannot handle that).

If I were redesigning that product now, would I use a DT aware
bootloader ? you'd tell me "yes go for it", but hey, you broke my
build, can I trust you ? :)

-- 
Maxime

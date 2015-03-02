From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 Mar 2015 23:08:15 +0000
Subject: [PATCH 0/5] ARM: orion5k/mv78xx0/dove multiplatform support
In-Reply-To: <2171351.v0ZP8NQ0Dy@wuerfel>
References: <1425328618-894030-1-git-send-email-arnd@arndb.de>
 <20150302213058.GB2375@lunn.ch> <2171351.v0ZP8NQ0Dy@wuerfel>
Message-ID: <20150302230815.GW8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 02, 2015 at 10:39:21PM +0100, Arnd Bergmann wrote:
> On Monday 02 March 2015 22:30:58 Andrew Lunn wrote:
> > On Mon, Mar 02, 2015 at 09:36:53PM +0100, Arnd Bergmann wrote:
> > > Hi everyone,
> > 
> > Hi Arnd
> > 
> > Dove already is multi-platform, when you use it in mach-mvebu.  The
> > old mach-dove is there to slowly bit rot, because there is one user
> > who has a lot of out of tree patches which are apparently not easy to
> > make work with DT mach-mvebu Dove code.
> 
> I understand that, but I really want to finalize this chapter
> of the multiplatform work, it's been going for too long. It's
> not the only platform that has ATAG-based board files remaining,
> and I don't see how keeping it the remaining dove board files
> out of multiplatform is going to speed up their removal.

I believe all the boards are already converted.  The _boards_ can be
removed from mach-dove, as the one I care about is not in mainline,
but that one I care about depends on the core mach-dove support.

As I've said in the past, if this gets ripped out, you will only give
me even _more_ patches to deal with, you will only increase my workload
still further.  I wonder whether you really intend to increase my
workload doing stuff which isn't productive for the kernel community.
That seems to be rather idiotic.

Once I've got to the bottom of why the DT stuff sucks, then maybe I can
switch to DT.  However, even when I'm boot testing DT mode, I need much
of mach-dove right now (since I still need platform support code to fix
a few bits, eg, support dynamic switching between GPU drivers to
facilitate testing.)

Let me put this a different way: if this support is removed, I'll end
up spending this kernel cycle ignoring bug reports etc, and I'll instead
spend my time resurecting this support in my own tree so that I can
continue to support and test the Armada DRM driver.

And remember, when you commit a change to delete files, the files get
deleted in all git trees derived from the mainline kernel, including
*mine* and which has to be patched back together via reverts and the
probable other fixes.

Since my Dove is the most useful and fully featured ARM platform I've
ever had, screwing me in this way will _really_ piss me off.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

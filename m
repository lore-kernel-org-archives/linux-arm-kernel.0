From: vincent.weaver@maine.edu (Vince Weaver)
Date: Mon, 17 Mar 2014 17:16:43 -0400 (EDT)
Subject: CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS and bcm2835_defconfig
In-Reply-To: <alpine.DEB.2.10.1403121512370.2805@vincent-weaver-1.um.maine.edu>
References: <alpine.DEB.2.10.1403101717050.31525@vincent-weaver-1.um.maine.edu>
 <531FE40C.1060709@wwwdotorg.org>
 <20140312113346.GA9347@mudshark.cambridge.arm.com>
 <alpine.DEB.2.10.1403120740100.2268@vincent-weaver-1.um.maine.edu>
 <alpine.DEB.2.10.1403121512370.2805@vincent-weaver-1.um.maine.edu>
Message-ID: <alpine.DEB.2.10.1403171713500.12761@vincent-weaver-1.um.maine.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Mar 2014, Vince Weaver wrote:

> On Wed, 12 Mar 2014, Vince Weaver wrote:
> 
> > On Wed, 12 Mar 2014, Will Deacon wrote:
> > > 
> > > I just took the tree you mentioned above, merged together 3.14-rc6,
> > > for-3.15/soc and for-3.15/dt. Using the defconfig (+ appended dtb options)
> > > and cross-compiling with a dated linaro toolchain, it booted fine on my rpi:
> > > 
> > >   Uncompressing Linux... done, booting the kernel.
> > >   [    0.000000] Booting Linux on physical CPU 0x0
> > >   [    0.000000] Initializing cgroup subsys cpuset
> > >   [    0.000000] Initializing cgroup subsys cpu
> > >   [    0.000000] Initializing cgroup subsys cpuacct
> > >   [    0.000000] Linux version 3.14.0-rc6+ (will at tiny-lites) (gcc version 4.8.2 20130603 (prerelease) (crosstool-NG linaro-1.13.1-4.8-2013.06 - Linaro GCC 2013.06) ) #8 Wed Mar 12 10:51:44 GMT 2014
> > >   [    0.000000] CPU: ARMv6-compatible processor [410fb767] revision 7 (ARMv7), cr=00c5387d
> > >   [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
> > >   [    0.000000] Machine model: Raspberry Pi Model B
> > >   [    0.000000] bootconsole [earlycon0] enabled
> > >   [    0.000000] Memory policy: Data cache writeback
> > >   [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 97536
> > >   [...]
> > > 
> > > Which compiler are you using?
> > 
> > it's the gcc 4.6.3 that comes with the version of raspian on the rasp-pi 
> > (I'm compiling natively).  Let me try again and double check there weren't 
> > any other changes.
> 
> I re-built from scratch using the bcm2835_defconfig and again it hangs at 
> boot, actually it looks like it hangs just after
> 
> 	Uncompressing Linux...
> 
> on the serial console.
> 
> The only difference in .config between a working config and the hanging 
> one are
> 	CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> 	CONFIG_ARCH_USE_BUILTIN_BSWAP
> 
> Unfortunately my machine is remote and I won't be able to get in and 
> reboot it and do more testing until probably Friday.

I re-ran the tests and it looks like there is no bug.

My rap-pi apparently just seems to lock up on boot sometimes and 
originally it seemed to do ao consistently with the 
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
kernel, but after hard power cycling it a few times I manage to get both
ALIGNED and UNALIGNED kernels to boot.

Sorry for the mistaken report,

Vince

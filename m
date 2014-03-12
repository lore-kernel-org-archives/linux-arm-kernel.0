From: vincent.weaver@maine.edu (Vince Weaver)
Date: Wed, 12 Mar 2014 07:41:54 -0400 (EDT)
Subject: CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS and bcm2835_defconfig
In-Reply-To: <20140312113346.GA9347@mudshark.cambridge.arm.com>
References: <alpine.DEB.2.10.1403101717050.31525@vincent-weaver-1.um.maine.edu>
 <531FE40C.1060709@wwwdotorg.org>
 <20140312113346.GA9347@mudshark.cambridge.arm.com>
Message-ID: <alpine.DEB.2.10.1403120740100.2268@vincent-weaver-1.um.maine.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Mar 2014, Will Deacon wrote:

> Hi guys,
> 
> On Wed, Mar 12, 2014 at 04:35:24AM +0000, Stephen Warren wrote:
> > On 03/10/2014 03:21 PM, Vince Weaver wrote:
> > > I buit the current
> > > 	git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-rpi.git
> > > kernel on a Raspberry Pi.
> > > 
> > > I used 
> > > 	make bcm2835_defconfig
> > > 	make zImage
> > > but the results zImage hung at boot.
> > > 
> > > It turned out that for some reason 
> > > 	CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
> > > and
> > > 	CONFIG_ARCH_USE_BUILTIN_BSWAP=y
> > 
> > Hmm. I thought that ARMv6 didn't have efficient unaligned accesses, but
> > I suppose it must; ARM selects HAVE_EFFICIENT_UNALIGNED_ACCESS for
> > v6/v6k/v7. BUILTIN_BSWAP seems innocuous. Can you verify which of those
> > two options actually causes problems for you?
> 
> So just to confirm: enabling those options in the kernel you are compiling
> results in an image that you can't boot? We're not talking about the host
> kernel here.
> 
> I just took the tree you mentioned above, merged together 3.14-rc6,
> for-3.15/soc and for-3.15/dt. Using the defconfig (+ appended dtb options)
> and cross-compiling with a dated linaro toolchain, it booted fine on my rpi:
> 
>   Uncompressing Linux... done, booting the kernel.
>   [    0.000000] Booting Linux on physical CPU 0x0
>   [    0.000000] Initializing cgroup subsys cpuset
>   [    0.000000] Initializing cgroup subsys cpu
>   [    0.000000] Initializing cgroup subsys cpuacct
>   [    0.000000] Linux version 3.14.0-rc6+ (will at tiny-lites) (gcc version 4.8.2 20130603 (prerelease) (crosstool-NG linaro-1.13.1-4.8-2013.06 - Linaro GCC 2013.06) ) #8 Wed Mar 12 10:51:44 GMT 2014
>   [    0.000000] CPU: ARMv6-compatible processor [410fb767] revision 7 (ARMv7), cr=00c5387d
>   [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
>   [    0.000000] Machine model: Raspberry Pi Model B
>   [    0.000000] bootconsole [earlycon0] enabled
>   [    0.000000] Memory policy: Data cache writeback
>   [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 97536
>   [...]
> 
> Which compiler are you using?

it's the gcc 4.6.3 that comes with the version of raspian on the rasp-pi 
(I'm compiling natively).  Let me try again and double check there weren't 
any other changes.

Vince

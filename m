From: tony@atomide.com (Tony Lindgren)
Date: Fri, 4 Jun 2010 13:42:47 +0300
Subject: Heads up: Linus plans to kill ARM defconfigs
In-Reply-To: <AANLkTikrK-RkDntgrpptBaG6TvnesNFncOw3DW4Jt-TY@mail.gmail.com>
References: <20100603192459.GA9169@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1006031829020.24526@xanadu.home>
	<4C083BCF.2060500@bluewatersys.com>
	<201006040310.15019.marek.vasut@gmail.com>
	<4C0853E1.1080005@bluewatersys.com>
	<AANLkTinEq99_8UyVNnmzNEreDoyHKEnxpuJmaAo_kpPN@mail.gmail.com>
	<20100604061034.GI6499@atomide.com>
	<AANLkTikrK-RkDntgrpptBaG6TvnesNFncOw3DW4Jt-TY@mail.gmail.com>
Message-ID: <20100604104246.GD11111@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Eric Miao <eric.y.miao@gmail.com> [100604 10:07]:
> On Fri, Jun 4, 2010 at 2:10 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Eric Miao <eric.y.miao@gmail.com> [100604 04:35]:
> >>
> >> Also, we are now working on a single kernel for multiple sub-arch (at least
> >> what Nicolas and I am doing now, and welcome to join us). It's tough (the
> >> way to handle different phys_offset is only the tip of the iceberg) and seems
> >> now more and more necessary. so hopefully by the end of the day, we may
> >> possible end up with only very few defconfig.
> >
> > Great, do you have some git branch for that somewhere?
> >
> 
> All the currently done work I've posted to the mailing list:
> 
> 1. SPARSEIRQ
> 2. MULTI_IRQ_HANDLER
> 3. Makefile.boot move to arch/arm/boot/bootp _only_
> 4. RUNTIME_PHYS_OFFSET (not really my work, but Uwe's)
> 
> Nico and I have setup a blueprint and wiki spec for this, I hope more
> can join us with the effort.
> 
> https://blueprints.launchpad.net/ubuntu/+spec/kernel-maverick-arm-single-zimage
> https://wiki.ubuntu.com/Specs/ARMSingleKernel
> 
> I'll push what I did to
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git
> unified-kernel
> 
> But it's a mess now.

OK thanks.
 
> > Parallel to dealing with different phys_offset we can also try combining
> > some two ARM platforms that have the same phy_offset. That already exposes
> > tons of conflicting defines that need to be sorted out..
> >
> 
> A first step to take might be looking at all those machine specific header
> files that will be included into generic <asm/*.h> and in turn included by
> other code. The PHYS_OFFSET is only a small tip of the iceberg I'm afraid.
> A very rough grep and analysis as below:

Nice analysis :) First I need to finish my earlier TLS patch for ARMv6 and 7
binaries, then I'll try to find some time to help on this stuff too.

Tony

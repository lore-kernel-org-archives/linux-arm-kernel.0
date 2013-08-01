From: cavokz@gmail.com (Domenico Andreoli)
Date: Thu, 1 Aug 2013 16:15:59 +0200
Subject: [PATCH v2 1/5] ARM: Broadcom: Unconditionally build
 arch/arm/mach-bcm
In-Reply-To: <CAGVrzcbvHbWp2_P2_tHGbKMm6wyZ3cBSZRibEQNcAjiaB4NjZA@mail.gmail.com>
References: <20130726145639.116237136@gmail.com>
 <20130726151223.045835540@gmail.com>
 <20130726152918.GL29916@titan.lakedaemon.net>
 <20130726215859.GA19469@glitch>
 <CAGVrzcbvHbWp2_P2_tHGbKMm6wyZ3cBSZRibEQNcAjiaB4NjZA@mail.gmail.com>
Message-ID: <20130801141559.GA1904@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 01, 2013 at 10:23:48AM +0100, Florian Fainelli wrote:
> Hello,
> 
> 2013/7/26 Domenico Andreoli <cavokz@gmail.com>:
> > On Fri, Jul 26, 2013 at 11:29:18AM -0400, Jason Cooper wrote:
> >> On Fri, Jul 26, 2013 at 04:56:40PM +0200, Domenico Andreoli wrote:
> >> > From: Domenico Andreoli <domenico.andreoli@linux.com>
> >> >
> >> > arch/arm/mach-bcm contains a plurality of Broadcom SoCs, each configured
> >> > separately. As a matter of flexibility and maintenance, it needs to be
> >> > always included in the build.
> >>
> >> So if I'm building mach-kirkwood, I _have_ to build Broadcom?  What is
> >> the *specific* problem you're encountering that this solves?
> >
> > In mach-bcm we (or I, it's not very clear to me) want to have support for
> > multiple SoCs.
> >
> > In trying the approach
> >
> > machine-$(CONFIG_ARCH_BCM)              += bcm
> > machine-$(CONFIG_ARCH_BCM4760)          += bcm
> >
> > I got linker complains about multiple symbol definitiion in case both the
> > config options are selected.
> >
> > The first thought was to use a common option which purpose was only to
> > include the subdir but then, given my allergy to the tons of config options
> > with usually not straghtforward purpose, I opted for something more simple.
> 
> I do not understand why are you trying so hard to put your SoC support
> in mach-bcm. I was one of the only people to complain that mach-bcm
> was both confusing and not generic enough to cover all Broadcom SoCs.
> I still think it should have been specified to mach-bcmmobile or
> something like mach-bcm28xxx. Back in the days where ARM drivers were
> mostly living in arch/arm/*, it *might* have made some sense but now,
> I really think that you should go with your own mach-bcm470x
> directory.
> 
> BCM47060, BCM53xx and BCM28xx all have both different CPU backends and
> different on-chip peripherals, which are even connected differently,
> put clearly, they share very little but the ARM architecture.

I've already explained my point elsewhere in this thread. It's not technical,
it's social. I don't see any technical disproportion to go either way.

thanks,
Domenico

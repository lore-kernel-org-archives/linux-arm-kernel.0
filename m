From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 30 Nov 2011 22:36:51 -0500 (EST)
Subject: [PATCH v3 4/5] ARM: vexpress: Initial RS1 memory map support
In-Reply-To: <20111130215000.GU9581@n2100.arm.linux.org.uk>
References: <1322579473-8804-1-git-send-email-pawel.moll@arm.com>
 <1322579473-8804-5-git-send-email-pawel.moll@arm.com>
 <20111130153749.GE2045@localhost.localdomain>
 <1322673302.3180.25.camel@hornet.cambridge.arm.com>
 <20111130175410.GJ2045@localhost.localdomain>
 <alpine.LFD.2.02.1111301522340.2357@xanadu.home>
 <20111130204805.GA5698@sirena.org.uk>
 <alpine.LFD.2.02.1111301604230.2357@xanadu.home>
 <20111130215000.GU9581@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1111302220450.2357@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Nov 2011, Russell King - ARM Linux wrote:

> On Wed, Nov 30, 2011 at 04:38:26PM -0500, Nicolas Pitre wrote:
> > On Wed, 30 Nov 2011, Mark Brown wrote:
> > 
> > > On Wed, Nov 30, 2011 at 03:43:50PM -0500, Nicolas Pitre wrote:
> > > 
> > > > annoying.  If nothing moves I might just go ahead with those changes and 
> > > > simply rip the uImage make target out of the kernel as well.  Maybe the 
> > > > inconvenience will be a sufficient incentive for people to lobby proper 
> > > > u-Boot support.  And it is not like if the u-Boot patches didn't exist 
> > > 
> > > Oh, dear.  Any pointers to the discussions on the u-boot side?
> > 
> > Certainly.  Many different threads actually.  Here's a few:
> > 
> > http://news.gmane.org/group/gmane.comp.boot-loaders.u-boot/thread=114981
> > 
> > http://news.gmane.org/group/gmane.comp.boot-loaders.u-boot/thread=115774
> > 
> > And this is not the first time this issue has come up:
> > 
> > http://news.gmane.org/group/gmane.comp.boot-loaders.u-boot/thread=83824
> > 
> > http://news.gmane.org/group/gmane.linux.ports.arm.kernel/thread=81546/force_load=t/focus=84138
> > 
> > Yet more u-Boot woes:
> > 
> > http://news.gmane.org/group/gmane.linux.ports.arm.kernel/thread=53973
> > 
> > I'm sure there are others, but that's what I've quickly dug out.
> 
> So why are we still supporting uboot in the mainline kernel on ARM?

As a demonstration of good will I'd say.

I still believe that the uImage wrapping is _not_ ARM specific, and that 
someone should step up to be the maintainer of a generic u-Boot Kconfig 
menu and makefile target(s) common to all architectures.

But until Stephen's u-Boot patches are merged, and the corresponding 
mkimage and u-Boot binaries are deployed, there is little point keeping 
a uImage makefile target for a kernel which is meant to be run on 
multiple SOCs.

This is already affecting i.MX which could already have a single kernel 
image for the whole SOC family despite different RAM addresses if this 
wasn't for this uImage format limitation.  So at the moment the mkimage 
step makes sense only at kernel install time when you know the exact 
machine where the installation will take place, not at kernel build 
time.



Nicolas

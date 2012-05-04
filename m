From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 4 May 2012 12:34:48 +0000
Subject: Making ARM multiplatform kernels DT-only?
In-Reply-To: <87fwbg8fm8.fsf@lebrac.rtp-net.org>
References: <201205031350.35476.arnd@arndb.de>
 <20120503141853.GC897@n2100.arm.linux.org.uk>
 <87fwbg8fm8.fsf@lebrac.rtp-net.org>
Message-ID: <201205041234.48892.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 May 2012, Arnaud Patard wrote:
> > On Thu, May 03, 2012 at 01:50:35PM +0000, Arnd Bergmann wrote:
> >> My feeling is that we should just mandate DT booting for multiplatform
> >> kernels, because it significantly reduces the combinatorial space
> >> at compile time, avoids a lot of legacy board files that we cannot
> >> test anyway, reduces the total kernel size and gives an incentive
> >> for people to move forward to DT with their existing boards.
> >
> > On this point, I strongly object, especially as I'm one who uses the
> > existing non-DT multiplatform support extensively.  It's really not
> > a problem for what you're trying to achieve.
> >
> 
> Please, don't do this. afaik, the idea was to reduce the numbers of
> kernel to deal with. Unfortunately, this kind of restriction would
> increase it. Consider orion platforms. This would mean having to deal
> with 4 kernels (1 for DT, 1 for orion5x, 1 for kirkwood, 1 for mv78xx0).

Ok, point taken. 

My hope for Orion is that we can actually proceed quicker there than
on other platforms because the hardware is relatively simple, especially
its clock and pinctrl aspects, so we would be able to boot almost anything
with just supplying the right .dts file before we get to the point
where we can boot the first multiplatform kernel on orion.

> Dropping HW support because one wants to encourage people to convert
> their board file into DT seems weird. Doing this, imho, should even be
> called a regression. The DT conversion won't happen in an eye blink so
> non-DT kernels are still something we should take care of.

It's not dropping support for anything and not a regression in that
sense. We will have other restrictions with multiplatform kernels
for some time, with a lot of drivers breaking at first, and this question
is basically about which tradeoffs and priorities we make with the
new multiplatform enablement. 

> > I think what you're proposing is a totally artificial restriction.
> > There's no problem with a kernel supporting DT and non-DT together.
> > We've proven that many many times.  I prove it every night that my
> > build and boot system runs - the OMAP LDP boots a multiplatform kernel
> > just fine without DT.
> 
> I think it's true for imx too. iirc, one can build a single image for
> armv4/armv5 and one other for armv6/armv7 without having to use DT.

Yes, it's true for most platforms, and with my proposal, you would
still be able to build an i.mx kernel that runs on all boards it
runs on today, dt or not, nothing changed. The only question is
when you want to build a combined kernel for orion+imx+omap+...
whether that should allow the same options or just a subset.

	Arnd

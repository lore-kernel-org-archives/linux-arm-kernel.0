From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 18 Jul 2012 09:42:42 -0400 (EDT)
Subject: Device tree.
In-Reply-To: <50066AE6.6000002@codethink.co.uk>
References: <500552C9.4090107@codethink.co.uk> <50056E22.5040308@gmail.com>
 <5b5e32ecde7b96d3af217054150eb43c@codethink.co.uk> <13863985.aH2icoQzEI@flexo>
 <50057CD2.2060001@codethink.co.uk>
 <alpine.LFD.2.02.1207171712070.9293@xanadu.home>
 <50066AE6.6000002@codethink.co.uk>
Message-ID: <alpine.LFD.2.02.1207180929230.9293@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Jul 2012, Ian Molton wrote:

> On 17/07/12 22:18, Nicolas Pitre wrote:
> 
> > That pain is the only leverage  we have to have you fix the bootloader
> > somehow.
> 
> Yes, because this tactic has worked just great historically...

It certainly did.  Look at the latest u-Boot which 1) has support for 
device tree on ARM, and 2) has support to boot a zImage directly.  And 
some people were able to modify their old u-Boot as well because of this 
policy.

> Other than chainbooting /another/ bootloader, how do you propose people fix
> this issue? Not everyone has a co-operative vendor.

Ask your vendor harder.  They would care even less if the kernel was 
more accommodating.

> > If you prefer or have to bodge  around it then you keep the
> > hack for yourself.
> 
> And for those of us where this is not an option?

This is always an option to you.  You have the patch already, it doesn't 
necessarily have to live in mainline.

> > We want people to get into the  habit of building and distributing a
> > generic kernel image.
> 
> Which is all lovely, but sometimes simply not appropriate.

Please deal with it.  Going the other way isn't appropriate for mainline 
either.

> > Appending a dtb to zImage  and/or wrapping it
> > into a uImage should be considered installation steps which are best
> > done outside of the kernel build system. And they are quite trivial
> > to do as well.
> 
> Then perhaps the 'hack' to allow appending should be removed from the kernel,
> too, by the same logic - after all, its only 'enabling' people to cling to
> ancient bootloaders...

Absolutely.  But it is there now and that's the extent of what mainline 
is providing in terms of accommodation.

> Honestly, all the fuss about "R2 + ATAGS must be the only way", and now we can
> pass in data in non-ATAG form, via appending to the kernel image, at whatever
> random location that might wind up being.
> 
> Either ATAGs the only way, or they aren't. If appending to zImage is 'way 2'
> then it should be possible to choose what gets appended at build time. If not,
> the option has no business being in the kernel at all. Do it properly or not
> at all.

The "proper" way is to remove the DTB append option and force everyone 
to use a DT aware bootloader.  Are you ready for that?

Instead, we made a compromise which is to let you append a DTB to 
zImage.

> Whats the point in make uImage if you cant use it?

I advocated its removal for quite a long time now.  But it is still 
there which is also a compromise.  This way, people with ancient target 
which are not DT enabled aren't affected.


Nicolas

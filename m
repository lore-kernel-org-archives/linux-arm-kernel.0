From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Dec 2011 22:21:57 +0000
Subject: arm and patch phys offset
In-Reply-To: <201112122309.00075.michael@walle.cc>
References: <201112112255.32534.michael@walle.cc>
 <201112122255.40092.michael@walle.cc>
 <20111212220247.GF20178@n2100.arm.linux.org.uk>
 <201112122309.00075.michael@walle.cc>
Message-ID: <20111212222157.GG20178@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2011 at 11:09:00PM +0100, Michael Walle wrote:
> Am Montag 12 Dezember 2011, 23:02:47 schrieb Russell King - ARM Linux:
> > > > Are you running a Thumb-2 kernel?  Which kernel are you running?
> > > 
> > > what do you mean by which kernel?
> > > linus' master from yesterday, ARCH_KIRKWOOD=y
> > > CONFIG_THUMB2_KERNEL is not set
> > 
> > Yes, that's what I mean.
> > 
> > Right, so the problem you're describing is _impossible_ - there is no way
> > the fixup function can fix only some instructions and skip over others in
> > a properly functioning system.
> > 
> > The only options are that either the CPU is not executing the instructions
> > we're giving it (unlikely as - I assume - your hardware executes older
> > kernels fine), or for some reason your kernel is being called with caches
> > still enabled, violating the long-standing kernel's calling requirements.
> > 
> > So, some more questions to try to narrow this down:
> > 
> > 1. What boot loader are you using?
> u-boot 2011.09 with own bsp support.
> 
> > 2. What file are you taking from the kernel build in order to boot?
> generated uImage

Okay, so this should mean that the kernel's own decompressor has run,
which should turn on/off the mmu and caches, cleaning and invalidating
them, which will take the boot loader completely out of the picture at
this stage.

I think I'll leave this in the hands of Nicolas - from what I remember,
kirkwood is a feroceon based system, and I have little working knowledge
of that ARM derivative.

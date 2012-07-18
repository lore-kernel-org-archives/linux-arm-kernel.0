From: ian.molton@codethink.co.uk (Ian Molton)
Date: Wed, 18 Jul 2012 08:51:02 +0100
Subject: Device tree.
In-Reply-To: <alpine.LFD.2.02.1207171712070.9293@xanadu.home>
References: <500552C9.4090107@codethink.co.uk> <50056E22.5040308@gmail.com>
 <5b5e32ecde7b96d3af217054150eb43c@codethink.co.uk>
 <13863985.aH2icoQzEI@flexo> <50057CD2.2060001@codethink.co.uk>
 <alpine.LFD.2.02.1207171712070.9293@xanadu.home>
Message-ID: <50066AE6.6000002@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/07/12 22:18, Nicolas Pitre wrote:

> That pain is the only leverage  we have to have you fix the bootloader
 > somehow.

Yes, because this tactic has worked just great historically...

Other than chainbooting /another/ bootloader, how do you propose people 
fix this issue? Not everyone has a co-operative vendor.

> If you prefer or have to bodge  around it then you keep the
 > hack for yourself.

And for those of us where this is not an option?

> We want people to get into the  habit of building and distributing a
 > generic kernel image.

Which is all lovely, but sometimes simply not appropriate.

> Appending a dtb to zImage  and/or wrapping it
 > into a uImage should be considered installation steps which are best
 > done outside of the kernel build system. And they are quite trivial
 > to do as well.

Then perhaps the 'hack' to allow appending should be removed from the 
kernel, too, by the same logic - after all, its only 'enabling' people 
to cling to ancient bootloaders...

Honestly, all the fuss about "R2 + ATAGS must be the only way", and now 
we can pass in data in non-ATAG form, via appending to the kernel image, 
at whatever random location that might wind up being.

Either ATAGs the only way, or they aren't. If appending to zImage is 
'way 2' then it should be possible to choose what gets appended at build 
time. If not, the option has no business being in the kernel at all. Do 
it properly or not at all.

Whats the point in make uImage if you cant use it?

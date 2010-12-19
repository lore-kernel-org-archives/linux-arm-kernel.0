From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 19 Dec 2010 10:52:09 +0000
Subject: [PATCH 0/40] Complete set of clocksource/sched_clock patches
In-Reply-To: <19725.57447.256528.883703@pilspetsen.it.uu.se>
References: <20101217113223.GC9937@n2100.arm.linux.org.uk>
	<19725.57447.256528.883703@pilspetsen.it.uu.se>
Message-ID: <20101219105209.GN9937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 19, 2010 at 11:37:27AM +0100, Mikael Pettersson wrote:
> Russell King - ARM Linux writes:
>  > Here is the entire set of clocksource and sched_clock patches which
>  > have been previously posted.  There's a couple of small tweaks in a
>  > few of the patches (such as adding notrace to OMAP clocksource read
>  > functions), and this also shows the proper ordering of these patches.
>  > 
>  > Still looking for acks or tested-by's for these patches.
> 
> Which tree is this based on? Is this scheduled for 2.6.37 or .38?

It's based on the point where the ftrace updates were merged into my
tree.  I can't produce all the patches that lead up to this set because
there's just too many.

However, it probably applies cleanly on top of the devel-stable stuff.

It's scheduled for the next merge window.

> On n2100 (plat-iop) a missing #include <asm/sched_clock.h> in
> plat-iop/time.c caused a compile error. With that added the kernel
> built w/o warnings but hung immediately after being decompressed.

Will add the missing include.

Normally, this is because sched_clock() is called prior to the mapping
for reading the counter being available, but this is no different from
what was already there.  So, I suspect that n2100 doesn't boot without
these patches applied either.

Any chance of an boot log using the early printk or debug_ll stuff?

> On mach-ixp4xx the kernel built and booted fine, and the interactivity
> problems were gone.
> 
> Tested-by: Mikael Pettersson <mikpe@it.uu.se> (IXP4xx only)

Thanks - will add that to the IXP4xx specific parts.

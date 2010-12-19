From: mikpe@it.uu.se (Mikael Pettersson)
Date: Sun, 19 Dec 2010 11:37:27 +0100
Subject: [PATCH 0/40] Complete set of clocksource/sched_clock patches
In-Reply-To: <20101217113223.GC9937@n2100.arm.linux.org.uk>
References: <20101217113223.GC9937@n2100.arm.linux.org.uk>
Message-ID: <19725.57447.256528.883703@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux writes:
 > Here is the entire set of clocksource and sched_clock patches which
 > have been previously posted.  There's a couple of small tweaks in a
 > few of the patches (such as adding notrace to OMAP clocksource read
 > functions), and this also shows the proper ordering of these patches.
 > 
 > Still looking for acks or tested-by's for these patches.

Which tree is this based on? Is this scheduled for 2.6.37 or .38?

Since the problem affects 2.6.37-rc I tried it on top of 2.6.37-rc6.

First there were patch rejects in two sub-archs, but they were easily
fixed.

On n2100 (plat-iop) a missing #include <asm/sched_clock.h> in
plat-iop/time.c caused a compile error. With that added the kernel
built w/o warnings but hung immediately after being decompressed.

On mach-ixp4xx the kernel built and booted fine, and the interactivity
problems were gone.

Tested-by: Mikael Pettersson <mikpe@it.uu.se> (IXP4xx only)

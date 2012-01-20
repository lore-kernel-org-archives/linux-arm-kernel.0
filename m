From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 11:56:06 +0000
Subject: Building of arch/arm/plat-mxc/ssi-fiq.S failed w/ THUMB2 enabled?
In-Reply-To: <20111202133911.GC2892@localhost.localdomain>
References: <CAMPhdO_4NQUFB14eecTb3N4oQJa86ojSk8FUveqg+Lye5_jY+A@mail.gmail.com>
 <20111202102418.GT26618@pengutronix.de>
 <20111202133911.GC2892@localhost.localdomain>
Message-ID: <20120120115606.GL1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 02, 2011 at 01:39:11PM +0000, Dave Martin wrote:
> Is this code still used on ARMv7 and above?  FIQ is not normally
> available for Linux interrupts on hardware which makes use of the
> TrustZone security extensions.  Plus, on modern hardware with a deep
> memory hierarchy, FIQ is may not be all that "fast" either, due to
> cache/TLB effects.

It's worth pointing out that people end up using FIQs for certain things
because the hardware requires you to do it.  So if a platform is using
them, they're probably not doing it out of choice, but are doing it
because it's a baseline requirement to get something working.

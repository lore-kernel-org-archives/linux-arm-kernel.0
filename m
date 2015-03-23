From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 23 Mar 2015 16:04:44 +0100
Subject: [PATCH 0/5] Driver for pxa architectures
In-Reply-To: <87h9tc6pd8.fsf@free.fr>
References: <1426977868-5414-1-git-send-email-robert.jarzmik@free.fr>
 <201503220320.52675.arnd@arndb.de> <87h9tc6pd8.fsf@free.fr>
Message-ID: <201503231604.44551.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 23 March 2015, Robert Jarzmik wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> > On Saturday 21 March 2015, Robert Jarzmik wrote:
> > as much as I like this series, I think you still have a long way to go before
> > PXA can really be multiplatform. Other parts that would need to be solved
> > include the various cpu_is_pxa*() checks in drivers, the per-board header
> > files, the way that the I/O space is mapped in the PCMCIA drivers and
> > the XIP support.
> Ah yes, now you mention it ...  And still that doesn't frighten me that much,
> and certainly much less than clocks or dma stuff. Only the headers might be
> troublesome, and pxafb will certainly be a big rework, but that's for the next
> step :)

Ok.

> As for the per-board header files, as long as they're used only within mach-pxa
> and not outside (ie. not in drivers) I must admit I don't see what might be a
> problem.

No, headers that are used only in mach-pxa (or even plat-pxa) are unproblematic.

> As for XIP support, I don't have a clear view if it's a requirement for
> multiplatform nor if it works in these builds.

It would be nice to not have to support both options: if we put pxa into
ARCH_MULTIPLATFORM, I'd like to remove the existing entry from the choice
statement at the same time.

> > I think all of them are theoretically doable, but I wasn't expecting
> > to ever get there.
> Well, that makes me a goal to reach, doesn't it ? I'll stick to optimism here,
> and we'll see within a year how far I manage to go :)

Fair enough. Any work you do on this is highly appreciated anyway,
regardless of whether you complete it or not. BTW, one thought I had
a while ago was that we can move support for any PXA machines that are
DT enabled into mach-mmp, which hopefully will be fully DT-only and
multiplatform enabled at some point, and we can keep mach-pxa for the
legacy board files if you don't succeed in converting them all.

	Arnd

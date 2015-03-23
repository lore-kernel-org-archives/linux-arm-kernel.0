From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 23 Mar 2015 10:21:23 +0100
Subject: [PATCH 0/5] Driver for pxa architectures
In-Reply-To: <201503220320.52675.arnd@arndb.de> (Arnd Bergmann's message of
 "Sun, 22 Mar 2015 03:20:52 +0100")
References: <1426977868-5414-1-git-send-email-robert.jarzmik@free.fr>
 <201503220320.52675.arnd@arndb.de>
Message-ID: <87h9tc6pd8.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Saturday 21 March 2015, Robert Jarzmik wrote:
>> It is as well one of the last steps (or so I hope) for pxa architure to be part
>> of the multiplatform ARM architecture, and at the same time keep its legacy
>> platforms operational. It will kill arch/arm/plat-pxa/dma.c in the long term.
>> 
>
> Hi Robert,
>
> as much as I like this series, I think you still have a long way to go before
> PXA can really be multiplatform. Other parts that would need to be solved
> include the various cpu_is_pxa*() checks in drivers, the per-board header
> files, the way that the I/O space is mapped in the PCMCIA drivers and
> the XIP support.
Ah yes, now you mention it ...  And still that doesn't frighten me that much,
and certainly much less than clocks or dma stuff. Only the headers might be
troublesome, and pxafb will certainly be a big rework, but that's for the next
step :)

As for the per-board header files, as long as they're used only within mach-pxa
and not outside (ie. not in drivers) I must admit I don't see what might be a
problem.

As for XIP support, I don't have a clear view if it's a requirement for
multiplatform nor if it works in these builds.

> I think all of them are theoretically doable, but I wasn't expecting
> to ever get there.
Well, that makes me a goal to reach, doesn't it ? I'll stick to optimism here,
and we'll see within a year how far I manage to go :)

Cheers.

-- 
Robert

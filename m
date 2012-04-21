From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 21 Apr 2012 12:11:35 +0000
Subject: [PATCH 02/17] ARM clps711x: Added Cirrus Logic EP7312 CPU variant
In-Reply-To: <20120421114803.GE24211@n2100.arm.linux.org.uk>
References: <1334999490-27177-1-git-send-email-shc_work@mail.ru>
 <201204211121.49610.arnd@arndb.de>
 <20120421114803.GE24211@n2100.arm.linux.org.uk>
Message-ID: <201204211211.36273.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 21 April 2012, Russell King - ARM Linux wrote:
> That's where we used to put truely hardware dependent stuff, rather than
> machine type stuff when the structure was first implemented.  At that time
> we had a number of different mach-* directories wanting to share things
> like the acorn IOC/IOMD stuff, and there's also sharing of definitions
> between CLPS711x and EP93xx.
> 
> That was long before we invented the plat-* stuff - but even that doesn't
> actually cover what asm/hardware does - eg, the SA1111 stuff shared
> between SA11x0 and PXA.

Ah, thanks for the explanation.

Since the clps7111 based asm/hardware/*.h files are not shared with ep93xx,
I guess it makes sense to move them to mach-clps711x/include/mach/*.h as part of
this cleanup series, right?

I found these clps711x specific files:

 asm/hardware/clps7111.h
 asm/hardware/cs89712.h
 asm/hardware/ep7211.h
 asm/hardware/ep7212.h

Out of these, only the first one is used in two places outside of
arch/arm/mach-clps711x, the serial and the fb driver, which could
be changed to use mach/hardware.h instead.

	Arnd

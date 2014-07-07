From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 7 Jul 2014 23:26:38 +0200
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <20140707143545.GD32276@arm.com>
References: <20140701234800.GA23577@sirena.org.uk>
 <201407061739.22152.arnd@arndb.de> <20140707143545.GD32276@arm.com>
Message-ID: <201407072326.38975.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 07 July 2014, Catalin Marinas wrote:
> > - running an old arm7tdmi rtos build that you lost the source code for
> >   but that would be cheaper to run on a new cortex-a7 emulating the
> >   peripherals than to rewrite and revalidate
> 
> That's a too rare case to justify the additional CPU gates.

For trapping just a few extra instructions? That doesn't sound too
expensive.

> > - running OABI binaries in a 32-bit guest on an armv8 (or future version)
> 
> But you can already run an ARMv7 kernel now with OABI enabled on an
> ARMv8 (either native or guest).
> 
> > - testing armv4 kernel builds in a kvm guest using qemu models
> 
> Again, this would require pre-ARMv6 MMU to be carried over for little
> benefit (well, just to developers but hard to justify ARMv4 hardware
> compatibility to marketing).

I don't think anybody was talking about emulating the MMU in hardware.
It doesn't have to be fast, so you'd just do shadow page tables.



	Arnd

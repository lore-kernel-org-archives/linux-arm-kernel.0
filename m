From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 11 Dec 2012 13:01:34 +0000
Subject: linker problem with xip kernel and recent toolchains
In-Reply-To: <50BE0CDB.5000704@pengutronix.de>
References: <50BE0CDB.5000704@pengutronix.de>
Message-ID: <1355230894.19818.1.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Tue, 2012-12-04 at 14:46 +0000, Marc Kleine-Budde wrote:
> we've just discovered a linker problem with newer toolchains, that
> support --build-id and xip kernels. The resulting vmlinux is about 13
> MiB big, but the xipimage ~2GiB.
> 
> A look at the vmlinux's objdump shows that the .notes section is around
> 2 GiB and it's placed by the linker script into the RAM. With the ROM
> starting at 0x0 this results into a ~2 GiB big image.
> 
> >   [16] .data             PROGBITS        88008000 0a0000 012aa0 00  WA  0   0 256
> >   [17] .notes            NOTE            8801aaa0 0b2aa0 000024 00  AX  0   0  4
> >   [18] .bss              NOBITS          8801aae0 0b2ac4 005414 00  WA  0   0 32
> 
> After discarding the .notes section in the objcopy (see patch below) the
> resulting binary images has a proper size again.

Could you please send me the configuration you're using to get the XIP
kernel? I'll try to get my head around this problem and check how other
architectures are dealing with the problem.

Thanks!

Pawe?

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 8 Nov 2010 10:14:52 +0000
Subject: linux-next: omap2plus_defconfig not building
In-Reply-To: <1289209693.3538.5.camel@e102109-lin.cambridge.arm.com>
References: <4CBD707F.6050204@ti.com>
	<1287488255.18646.110.camel@e102109-lin.cambridge.arm.com>
	<eace9c309e371630528bc9f8fa208705@mail.gmail.com>
	<1289209693.3538.5.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20101108101452.GA14138@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 08, 2010 at 09:48:13AM +0000, Catalin Marinas wrote:
> Russell had a better idea for handling this, not sure whether it went
> into -next. It was basically adding -march=armv7-a to
> CFLAGS_swp_emulate.o in arch/arm/kernel/Makefile since we can't trigger
> an undef fault for SWP on ARMv6 anyway.

It's probably not a good idea to override the compiler architecture,
but just allow the assembler to accept the instruction.  -Wa,-march=armv7-a
should be good enough.

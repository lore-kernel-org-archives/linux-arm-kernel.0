From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 5 Nov 2014 16:14:54 +0000
Subject: [PATCHv3 2/5] arm64: Add AArch32 instruction set condition code
 checks
In-Reply-To: <20141029152148.GM27405@n2100.arm.linux.org.uk>
References: <1414435207-30240-1-git-send-email-punit.agrawal@arm.com>
 <1414435207-30240-4-git-send-email-punit.agrawal@arm.com>
 <20141029152148.GM27405@n2100.arm.linux.org.uk>
Message-ID: <20141105161454.GM32700@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 29, 2014 at 03:21:48PM +0000, Russell King - ARM Linux wrote:
> On Mon, Oct 27, 2014 at 06:40:04PM +0000, Punit Agrawal wrote:
> >  arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o 	\
> > -					   sys_compat.o
> > +					   sys_compat.o 			\
> > +					   $(addprefix ../../arm/kernel/,	\
> > +						opcodes.o)
> 
> This is not particularly nice.

Not that bad, you can look at it as a decoding library.

> While it means that this file gets built on both arm64 and arm, it
> means that it routinely won't get tested on arm64 when changes to it
> happen.

Low risk, it's a small file unlikely to change in the future.

Anyway, since you mention testing, I wonder how regularly SWP emulation
gets tested on arm32 (and in future arm64). If Punit has some tests
already, it may be good to add them somewhere like
tools/testing/selftests/arm/ (probably separately from this series).

-- 
Catalin

From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 23 Apr 2010 16:37:46 +0100
Subject: [PATCH 06/10] ARM: ftrace: add Thumb-2 support
In-Reply-To: <20100331182518.GA30522@debian>
References: <20100331182518.GA30522@debian>
Message-ID: <1272037066.15107.58.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-03-31 at 19:25 +0100, Rabin Vincent wrote:
> From bf828a0c069b1bb3f6bf4e68f1dceecab396c286 Mon Sep 17 00:00:00 2001
> From: Rabin Vincent <rabin@rab.in>
> Date: Sun, 14 Feb 2010 01:18:34 +0530
> Subject: [PATCH 06/10] ARM: ftrace: add Thumb-2 support
> 
> Fix the mcount routines to build and run on a kernel built with the
> Thumb-2 instruction set by correcting the following errors using the
> fixes suggested by Catalin Marinas:
> 
>  - Problem: The following assembler errors appear at the "adr r0,
>    ftrace_stub" instruction:
> 
>    entry-common.S: Assembler messages:
>    entry-common.S:179: Error: invalid immediate for address calculation (value = 0x00000004)
> 
>    Fix: The errors don't occur with a non-global symbol, so use one.
> 
>  - Problem: The "mov lr, pc" does not set the lsb when storing the pc in
>    lr.  The called function returns with "bx lr", and the mode changes
>    to ARM.
> 
>    Fix: Add a label on the return address and use "adr lr, BSYM(label)".
> 
> We don't modify the old mcount because it won't be built when using
> Thumb-2.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Rabin Vincent <rabin@rab.in>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin

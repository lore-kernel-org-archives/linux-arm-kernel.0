From: htejun@gmail.com (Tejun Heo)
Date: Wed, 07 Oct 2009 19:41:50 +0900
Subject: [PATCH] arm: use unified discard definition in linker script
In-Reply-To: <4ACC6D74.7010001@tuffmail.co.uk>
References: <4ACC6D74.7010001@tuffmail.co.uk>
Message-ID: <4ACC706E.5000002@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alan Jenkins wrote:
> I selfishly request an Acked-by for the following. My aim is to submit it as
> part of a larger series ("module: Speed up symbol resolution during module
> loading") which would not go through the ARM tree.
> 
> ------------------------------------------------------------------->
> From 52c4a00b22fecf3ecb352618356bb61f7f4b261b Mon Sep 17 00:00:00 2001
> From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
> Date: Wed, 7 Oct 2009 11:08:34 +0100
> Subject: [PATCH] arm: use unified discard definition in linker script
> 
> Commit 023bf6f "linker script: unify usage of discard definition"
> changed the linker scripts for all architectures except for ARM.
> I can find no discussion about this exception, so here are the changes
> for ARM.
> 
> These changes are exactly parallel to the ia64 case.
> 
> "ia64 is notable because it first throws away some ia64 specific
>  subsections and then include the rest of the sections into the final
>  image, so those sections must be discarded before the inclusion."
> 
> Not boot-tested.  In build testing, the modified linker script generated
> an identical vmlinux file.
> 
> 
> [I would like to be able to rely on this unified discard definition.
>  I want to sort the kernel symbol tables to allow faster symbol
>  resolution during module loading. The simplest way appears to be
>  to generate sorted versions from vmlinux.o, link them in to vmlinux,
>  _and discard the original unsorted tables_.
> 
>  This work is driven by my x86 netbook, but it is implemented at a
>  generic level. It is possible it will benefit some ARM systems also.]
> 
> 
> Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
> CC: Tejun Heo <tj@kernel.org>

Most likely omission by simple mistake.  The change looks fine to me
but I don't have any arm machine to test it.

Acked-by-without-testing: Tejun Heo <tj@kernel.org>

-- 
tejun

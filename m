From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 11 Jul 2014 14:59:38 -0700
Subject: [PATCH v2 1/3] asm-generic/io.h: Implement generic {read,
 write}s*()
In-Reply-To: <1405092672-18549-1-git-send-email-thierry.reding@gmail.com>
References: <1405092672-18549-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <53C05E4A.2030708@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11/14 08:31, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> This patch implements generic versions of readsb(), readsw(), readsl(),
> readsq(), writesb(), writesw(), writesl() and writesq(). Variants of
> these string functions for I/O accesses (ins*() and outs*() as well as
> ioread*_rep() and iowrite*_rep()) are now implemented in terms of the
> new functions.
>
> While at it, also make sure that any of the functions provided as
> fallback for architectures that don't override them can't be overridden
> subsequently.
>
> This is compile- and runtime-tested on 32-bit and 64-bit ARM and compile
> tested on Microblaze, s390, SPARC and Xtensa. For ARC, Blackfin, Metag,
> OpenRISC, Score and Unicore32 which also use asm-generic/io.h I couldn't
> find or build a cross-compiler that would run on my system. But by code
> inspection they shouldn't break with this patch.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

There isn't any mention of why we're doing this in the commit text. It
looks like patch 2 and 3 sort of mention why.

I also wonder if it could be explained how this about turn is desired,
given that patch b2656a138ab7 (asm-generic: io: remove {read,write}
string functions, 2012-10-17) did the complete opposite. Can you please
explain?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

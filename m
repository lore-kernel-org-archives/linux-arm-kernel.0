From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 21 Aug 2012 13:12:56 +0100
Subject: [PATCH] ARM: relax conditions required for enabling Contiguous
 Memory Allocator
In-Reply-To: <201208202001.23443.arnd@arndb.de>
References: <1345443372-3824-1-git-send-email-m.szyprowski@samsung.com>
 <201208202001.23443.arnd@arndb.de>
Message-ID: <20120821121256.GT18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 20, 2012 at 08:01:23PM +0000, Arnd Bergmann wrote:
> The patch looks simple, but I want a better explanation for it.
> When we went through all possible cases, we decided that:
> 
> * ARMv6+ need CMA to avoid the double mapping problem.
> * ARMv4/v5 cannot generally use CMA because it doesn't work
>   together with DMABOUNCE. I don't remember if it was the
>   only problem, but I definitely remember this was intentional.
> * We want a common kernel for all ARMv6+ eventually, and a
>   separate kernel for all ARMv4/v5 ones.
> 
> If the reasoning has changed, please try to explain the full
> situation.

Indeed.

> On a related topic, what happened to the idea that
> ARMv6+ is broken without CMA? I noticed that it's optional
> now.

With Marek's patch, it's always selected for MMU-based builds (it can't
be disabled).  Before the patch, it was always selected for V6 and later
CPUs.

And the description doesn't make sense:

"Contiguous Memory Allocator requires only paging and MMU enabled not
particular CPU architectures,"

what does "only paging and MMU enabled" mean?  Are you trying to say that
CMA only requires a kernel with MMU support?

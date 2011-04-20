From: will.deacon@arm.com (Will Deacon)
Date: Wed, 20 Apr 2011 16:29:07 +0100
Subject: [PATCH] ARM: futex: add SMP futex support when !CPU_USE_DOMAINS
In-Reply-To: <1302267519-18156-1-git-send-email-will.deacon@arm.com>
References: <1302267519-18156-1-git-send-email-will.deacon@arm.com>
Message-ID: <1303313347.11314.4.camel@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-04-08 at 13:58 +0100, Will Deacon wrote:
> This patch uses the load/store exclusive instructions to add SMP futex
> support for ARM.
> 
> Since the ARM architecture does not provide instructions for
> unprivileged exclusive memory accesses, we can only provide SMP futexes
> when CPU domain support is disabled.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/include/asm/futex.h |  137 +++++++++++++++++++++++++++--------------
>  1 files changed, 90 insertions(+), 47 deletions(-)

Any comments on this patch? The LTP tests for {get,set}_robust_list seem
happy enough but any review would be welcome.

Will

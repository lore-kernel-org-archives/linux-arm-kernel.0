From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Dec 2013 17:16:25 +0000
Subject: [PATCH v3 [resend] 05/18] smp, ARM64: kill SMP single function
 call interrupt
In-Reply-To: <1387125400-28849-6-git-send-email-liuj97@gmail.com>
References: <1387125400-28849-1-git-send-email-liuj97@gmail.com>
 <1387125400-28849-6-git-send-email-liuj97@gmail.com>
Message-ID: <20131217171625.GE349@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 15, 2013 at 04:36:27PM +0000, Jiang Liu wrote:
> Commit 9a46ad6d6df3b54 "smp: make smp_call_function_many() use logic
> similar to smp_call_function_single()" has unified the way to handle
> single and multiple cross-CPU function calls. Now only one interrupt
> is needed for architecture specific code to support generic SMP function
> call interfaces, so kill the redundant single function call interrupt.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Shaohua Li <shli@kernel.org>
> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Jiri Kosina <trivial@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Jiang Liu <liuj97@gmail.com>
> ---
>  arch/arm64/include/asm/hardirq.h |  2 +-
>  arch/arm64/kernel/smp.c          | 10 +---------
>  2 files changed, 2 insertions(+), 10 deletions(-)

  Acked-by: Will Deacon <will.deacon@arm.com>

I assume you're taking this series via some other route (than the arch/
trees) in order to deal with any core dependencies?

Will

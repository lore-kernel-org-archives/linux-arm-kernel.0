From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 12 Mar 2014 17:15:34 +0000
Subject: [RFC PATCH V3 3/6] arm: mm: implement get_user_pages_fast
In-Reply-To: <1394631623-17883-4-git-send-email-steve.capper@linaro.org>
References: <1394631623-17883-1-git-send-email-steve.capper@linaro.org>
 <1394631623-17883-4-git-send-email-steve.capper@linaro.org>
Message-ID: <20140312171534.GQ17083@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 12, 2014 at 01:40:20PM +0000, Steve Capper wrote:
> An implementation of get_user_pages_fast for ARM. It is based loosely
> on the PowerPC implementation. We disable interrupts in the walker to
> prevent the call_rcu_sched pagetable freeing code from running under
> us.
> 
> We also explicitly fire an IPI in the Transparent HugePage splitting
> case to prevent splits from interfering with the fast_gup walker.
> As THP splits are relatively rare, this should not have a noticable
> overhead.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>
> ---
>  arch/arm/include/asm/pgtable-3level.h |   6 +
>  arch/arm/mm/Makefile                  |   1 +
>  arch/arm/mm/gup.c                     | 299 ++++++++++++++++++++++++++++++++++
>  3 files changed, 306 insertions(+)
>  create mode 100644 arch/arm/mm/gup.c

Is there anything specific to ARM in this gup.c file? Could we make it
more generic like mm/gup.c?

-- 
Catalin

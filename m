From: will.deacon@arm.com (Will Deacon)
Date: Thu, 1 Dec 2011 14:10:07 +0000
Subject: [V2 3/3] ARM: support syscall tracing
In-Reply-To: <1322664382-21793-4-git-send-email-stevenrwalter@gmail.com>
References: <1322664382-21793-1-git-send-email-stevenrwalter@gmail.com>
 <1322664382-21793-4-git-send-email-stevenrwalter@gmail.com>
Message-ID: <20111201141007.GC27656@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steven,

Just a minor comment:

On Wed, Nov 30, 2011 at 02:46:22PM +0000, Steven Walter wrote:
> diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
> index b2a27b6..439f274 100644
> --- a/arch/arm/kernel/entry-common.S
> +++ b/arch/arm/kernel/entry-common.S
> @@ -79,6 +79,11 @@ no_work_pending:
>  ENDPROC(ret_to_user_from_irq)
>  ENDPROC(ret_to_user)
>  
> +.macro test_syscall_tracing reg
> +	tst	\reg, #_TIF_SYSCALL_TRACE
> +	tsteq	\reg, #_TIF_SYSCALL_TRACEPOINT
> +.endm
> +

You could put this macro in entry-header.S instead.

Will

From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 9 Dec 2015 10:55:01 +0000
Subject: [PATCH] arm64: annotate irq off before schedule
In-Reply-To: <1449645829-1070-1-git-send-email-ming.lei@canonical.com>
References: <1449645829-1070-1-git-send-email-ming.lei@canonical.com>
Message-ID: <20151209105501.GC26759@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 09, 2015 at 03:23:49PM +0800, Ming Lei wrote:
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 7ed3d75..4769190 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -634,6 +634,9 @@ work_pending:
>  	bl	do_notify_resume
>  	b	ret_to_user
>  work_resched:
> +#ifdef CONFIG_TRACE_IRQFLAGS
> +	bl	trace_hardirqs_off
> +#endif
>  	bl	schedule

I think Will already queued a similar patch, though he hasn't pushed it
out yet.

-- 
Catalin

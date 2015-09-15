From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 15 Sep 2015 17:43:01 +0100
Subject: [PATCH] arm64: hw_breakpoint: use target state to determine ABI
 behaviour
In-Reply-To: <1442333773-16446-1-git-send-email-will.deacon@arm.com>
References: <1442333773-16446-1-git-send-email-will.deacon@arm.com>
Message-ID: <20150915164301.GI14287@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2015 at 05:16:13PM +0100, Will Deacon wrote:
> diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
> index bba85c8f8037..2926c3dd6479 100644
> --- a/arch/arm64/kernel/hw_breakpoint.c
> +++ b/arch/arm64/kernel/hw_breakpoint.c
> @@ -163,6 +163,12 @@ enum hw_breakpoint_ops {
>  	HW_BREAKPOINT_RESTORE
>  };
>  
> +static int is_compat_bp(struct perf_event *bp)
> +{
> +	struct task_struct *tsk = bp->hw.target;
> +	return tsk && is_compat_thread(task_thread_info(tsk));
> +}

What are the conditions for tsk == NULL?

-- 
Catalin

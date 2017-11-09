From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 9 Nov 2017 10:07:06 +0100
Subject: [PATCH v10 1/8] perf: Export perf_event_update_userpage
In-Reply-To: <20171103175105.23546-2-suzuki.poulose@arm.com>
References: <20171103175105.23546-1-suzuki.poulose@arm.com>
 <20171103175105.23546-2-suzuki.poulose@arm.com>
Message-ID: <20171109090706.oangi7qebju5mvmu@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 03, 2017 at 05:50:58PM +0000, Suzuki K Poulose wrote:
> Export perf_event_update_userpage() so that PMU driver using them,
> can be built as modules.
> 
> Cc: Peter Zilstra <peterz@infradead.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  kernel/events/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 9d93db81fa36..550015829db8 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4982,6 +4982,7 @@ void perf_event_update_userpage(struct perf_event *event)
>  unlock:
>  	rcu_read_unlock();
>  }
> +EXPORT_SYMBOL_GPL(perf_event_update_userpage);
>  
>  static int perf_mmap_fault(struct vm_fault *vmf)
>  {
> -- 
> 2.13.6
> 

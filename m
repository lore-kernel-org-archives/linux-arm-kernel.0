From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 3 Nov 2017 11:16:10 +0000
Subject: [PATCH v9 1/8] perf: Export perf_event_update_userpage
In-Reply-To: <20171031172318.11823-2-suzuki.poulose@arm.com>
References: <20171031172318.11823-1-suzuki.poulose@arm.com>
 <20171031172318.11823-2-suzuki.poulose@arm.com>
Message-ID: <20171103111610.zksofse7w55qu34u@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[+ Ingo]

On Tue, Oct 31, 2017 at 05:23:11PM +0000, Suzuki K Poulose wrote:
> Export perf_event_update_userpage() so that PMU driver using them,
> can be built as modules.

Peter, Ingo, are you happy with this?

It would be useful if we could take this via the arm64 tree with the
rest of the series.

Thanks,
Mark.

> Cc: Peter Zilstra <peterz@infradead.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
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

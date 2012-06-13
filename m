From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 13 Jun 2012 14:50:19 +0200
Subject: [RFC 4/4] sched: cpu_power: enable ARCH_POWER
In-Reply-To: <1339502524-10265-5-git-send-email-vincent.guittot@linaro.org>
References: <1339502524-10265-1-git-send-email-vincent.guittot@linaro.org>
 <1339502524-10265-5-git-send-email-vincent.guittot@linaro.org>
Message-ID: <1339591819.8980.28.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-06-12 at 14:02 +0200, Vincent Guittot wrote:
> Heteregeneous ARM platform uses arch_scale_freq_power function
> to reflect the relative capacity of each core

I think I've pointed out before that this breaks x86.. you need a patch
killing at that stuff before this.

> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/features.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index de00a48..d98ae90 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -42,7 +42,7 @@ SCHED_FEAT(CACHE_HOT_BUDDY, true)
>  /*
>   * Use arch dependent cpu power functions
>   */
> -SCHED_FEAT(ARCH_POWER, false)
> +SCHED_FEAT(ARCH_POWER, true)
>  
>  SCHED_FEAT(HRTICK, false)
>  SCHED_FEAT(DOUBLE_TICK, false)

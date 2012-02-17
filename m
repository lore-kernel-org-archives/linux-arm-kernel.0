From: mingo@elte.hu (Ingo Molnar)
Date: Fri, 17 Feb 2012 12:22:58 +0100
Subject: [PATCH] sched: generalize CONFIG_IRQ_TIME_ACCOUNTING for X86 and
 ARM
In-Reply-To: <1328918525-7309-1-git-send-email-dmitry.antipov@linaro.org>
References: <1328918525-7309-1-git-send-email-dmitry.antipov@linaro.org>
Message-ID: <20120217112258.GC14789@elte.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Dmitry Antipov <dmitry.antipov@linaro.org> wrote:

> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -757,18 +757,20 @@ static DEFINE_PER_CPU(u64, cpu_hardirq_time);
>  static DEFINE_PER_CPU(u64, cpu_softirq_time);
>  
>  static DEFINE_PER_CPU(u64, irq_start_time);
> -static int sched_clock_irqtime;
>  
> -void enable_sched_clock_irqtime(void)
> -{
> -	sched_clock_irqtime = 1;
> -}
> +/* -1 if not initialized, 0 if disabled with "noirqtime" kernel option
> + * or after unstable clock was detected, 1 if enabled and active.
> + */

Please use the customary (multi-line) comment style:

  /*
   * Comment .....
   * ...... goes here.
   */

specified in Documentation/CodingStyle.

> +int sched_clock_irqtime = -1;

should be turned into __read_mostly I guess.

Thanks,

	Ingo

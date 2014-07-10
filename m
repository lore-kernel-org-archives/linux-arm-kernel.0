From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 10 Jul 2014 13:18:33 +0200
Subject: [PATCH v3 08/12] sched: move cfs task on a CPU with higher
 capacity
In-Reply-To: <1404144343-18720-9-git-send-email-vincent.guittot@linaro.org>
References: <1404144343-18720-1-git-send-email-vincent.guittot@linaro.org>
 <1404144343-18720-9-git-send-email-vincent.guittot@linaro.org>
Message-ID: <20140710111833.GY3935@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 06:05:39PM +0200, Vincent Guittot wrote:
> +		/*
> +		 * If the CPUs share their cache and the src_cpu's capacity is
> +		 * reduced because of other sched_class or IRQs, we trig an
> +		 * active balance to move the task
> +		 */
> +		if ((sd->flags & SD_SHARE_PKG_RESOURCES)
> +		 && ((capacity_orig_of(src_cpu) * 100) > (capacity_of(src_cpu) *
> +							sd->imbalance_pct)))
>  			return 1;

Why is this tied to shared caches?

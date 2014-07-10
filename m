From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 10 Jul 2014 13:24:41 +0200
Subject: [PATCH v3 08/12] sched: move cfs task on a CPU with higher
 capacity
In-Reply-To: <1404144343-18720-9-git-send-email-vincent.guittot@linaro.org>
References: <1404144343-18720-1-git-send-email-vincent.guittot@linaro.org>
 <1404144343-18720-9-git-send-email-vincent.guittot@linaro.org>
Message-ID: <20140710112441.GZ3935@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 06:05:39PM +0200, Vincent Guittot wrote:
> +		if ((sd->flags & SD_SHARE_PKG_RESOURCES)
> +		 && ((capacity_orig_of(src_cpu) * 100) > (capacity_of(src_cpu) *
> +							sd->imbalance_pct)))


> +		if ((rq->cfs.h_nr_running >= 1)
> +		 && ((rq->cpu_capacity * sd->imbalance_pct) <
> +					(rq->cpu_capacity_orig * 100))) {

That's just weird indentation and operators should be at the end not at
the beginning of a line-break.

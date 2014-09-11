From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 11 Sep 2014 13:54:11 +0200
Subject: [PATCH v5 08/12] sched: move cfs task on a CPU with higher
 capacity
In-Reply-To: <1409051215-16788-9-git-send-email-vincent.guittot@linaro.org>
References: <1409051215-16788-1-git-send-email-vincent.guittot@linaro.org>
 <1409051215-16788-9-git-send-email-vincent.guittot@linaro.org>
Message-ID: <20140911115411.GX3190@worktop.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 01:06:51PM +0200, Vincent Guittot wrote:
> +		if ((capacity_orig_of(src_cpu) * 100) > (capacity_of(src_cpu) *
> +				sd->imbalance_pct))

Note that capacity_orig_of() is introduced a lot later on in the series.
Patch 10 iirc, so this will not actually compile.

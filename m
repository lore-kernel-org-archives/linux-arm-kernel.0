From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 27 May 2014 15:48:16 +0200
Subject: [PATCH v2 03/11] sched: fix avg_load computation
In-Reply-To: <1400860385-14555-4-git-send-email-vincent.guittot@linaro.org>
References: <1400860385-14555-1-git-send-email-vincent.guittot@linaro.org>
 <1400860385-14555-4-git-send-email-vincent.guittot@linaro.org>
Message-ID: <20140527134816.GC11074@laptop.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 05:52:57PM +0200, Vincent Guittot wrote:
> The computation of avg_load and avg_load_per_task should only takes into
> account the number of cfs tasks. The non cfs task are already taken into
> account by decreasing the cpu's capacity (cpu_power) and they will be tracked
> in the CPU's utilization (group_activity) of the next patches

Ah yes, very good.  I don't think we had h_nr_running back when I
frobbed this last.

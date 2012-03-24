From: a.p.zijlstra@chello.nl (Peter Zijlstra)
Date: Sat, 24 Mar 2012 13:52:54 +0100
Subject: [PATCH 10/10] oom: Make find_lock_task_mm() sparse-aware
In-Reply-To: <20120324103127.GJ29067@lizard>
References: <20120324102609.GA28356@lizard> <20120324103127.GJ29067@lizard>
Message-ID: <1332593574.16159.31.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2012-03-24 at 14:31 +0400, Anton Vorontsov wrote:
> This is needed so that callers would not get 'context imbalance'
> warnings from the sparse tool.
> 
> As a side effect, this patch fixes the following sparse warnings:
> 
>   CHECK   mm/oom_kill.c
>   mm/oom_kill.c:201:28: warning: context imbalance in 'oom_badness' -
>   unexpected unlock
>   include/linux/rcupdate.h:249:30: warning: context imbalance in
>   'dump_tasks' - unexpected unlock
>   mm/oom_kill.c:453:9: warning: context imbalance in 'oom_kill_task' -
>   unexpected unlock
>   CHECK   mm/memcontrol.c
>   ...
>   mm/memcontrol.c:1130:17: warning: context imbalance in
>   'task_in_mem_cgroup' - unexpected unlock
> 
> p.s. I know Peter Zijlstra detest the __cond_lock() stuff, but untill
>      we have anything better in sparse, let's use it. This particular
>      patch helped me to detect one bug that I myself made during
>      task->mm fixup series. So, it is useful.

Yeah, so Nacked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

Also, why didn't lockdep catch it?

Fix sparse already instead of smearing ugly all over.

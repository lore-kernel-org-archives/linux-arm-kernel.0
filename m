From: mingo@kernel.org (Ingo Molnar)
Date: Fri, 26 Oct 2012 15:07:15 +0200
Subject: [RFC PATCH 00/13] sched: Integrating Per-entity-load-tracking
 with the core scheduler
In-Reply-To: <1351254553.16863.52.camel@twins>
References: <20121025102045.21022.92489.stgit@preeti.in.ibm.com>
 <1351180603.12171.31.camel@twins>
 <50898118.1050402@linux.vnet.ibm.com>
 <1351254553.16863.52.camel@twins>
Message-ID: <20121026130715.GB9886@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> [...]
> 
> So a sane series would introduce maybe two functions: 
> cpu_load() and task_load() and use those where we now use 
> rq->load.weight and p->se.load.weight for load balancing 
> purposes. Implement these functions using those two 
> expression. So effectively this patch is a NOP.
> 
> Secondly, switch these two functions over to the per-task 
> based averages.
> 
> Tada! all done. The load balancer will then try and equalize 
> effective load instead of instant load.
> 
> It will do the 3x10% vs 100% thing correctly with just those 
> two patches. Simply because it will report a lower cpu-load 
> for the 3x10% case than it will for the 100% case, no need to 
> go fudge about in the load-balance internals.
> 
> Once you've got this correctly done, you can go change 
> balancing to better utilize the new metric, like use the 
> effective load instead of nr_running against the capacity and 
> things like that. But for every such change you want to be 
> very careful and run all the benchmarks you can find -- in 
> fact you want to do that after the 2nd patch too.

If anyone posted that simple two-patch series that switches over 
to the new load metrics I'd be happy to test the performance of 
those.

Having two parallel load metrics is really not something that we 
should tolerate for too long.

Thanks,

	Ingo

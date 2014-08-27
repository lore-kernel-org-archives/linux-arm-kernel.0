From: kamalesh@linux.vnet.ibm.com (Kamalesh Babulal)
Date: Wed, 27 Aug 2014 18:42:45 +0530
Subject: [PATCH v5 04/12] sched: Allow all archs to set the capacity_orig
In-Reply-To: <1409051215-16788-5-git-send-email-vincent.guittot@linaro.org>
References: <1409051215-16788-1-git-send-email-vincent.guittot@linaro.org>
 <1409051215-16788-5-git-send-email-vincent.guittot@linaro.org>
Message-ID: <20140827131208.GB13808@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Vincent Guittot <vincent.guittot@linaro.org> [2014-08-26 13:06:47]:

> capacity_orig is only changed for system with a SMT sched_domain level in order
> to reflect the lower capacity of CPUs. Heterogenous system also have to reflect an
> original capacity that is different from the default value.
> 
> Create a more generic function arch_scale_cpu_capacity that can be also used by
> non SMT platform to set capacity_orig.
> 
> The weak behavior of arch_scale_cpu_capacity is the previous SMT one in order to
> keep backward compatibility in the use of capacity_orig.
> 
> arch_scale_smt_capacity and default_scale_smt_capacity have been removed as
> they were not use elsewhere than in arch_scale_cpu_capacity.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

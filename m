From: morten.rasmussen@arm.com (Morten Rasmussen)
Date: Tue, 3 Jun 2014 14:22:18 +0100
Subject: [PATCH v2 04/11] sched: Allow all archs to set the power_orig
In-Reply-To: <1400860385-14555-5-git-send-email-vincent.guittot@linaro.org>
References: <1400860385-14555-1-git-send-email-vincent.guittot@linaro.org>
 <1400860385-14555-5-git-send-email-vincent.guittot@linaro.org>
Message-ID: <20140603132217.GD29593@e103034-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 04:52:58PM +0100, Vincent Guittot wrote:
> power_orig is only changed for system with a SMT sched_domain level in order to
> reflect the lower capacity of CPUs. Heterogenous system also have to reflect an
> original capacity that is different from the default value.
> 
> Create a more generic function arch_scale_cpu_power that can be also used by
> non SMT platform to set power_orig.

I did a quick test of the patch set with adjusting cpu_power on
big.LITTLE (ARM TC2) to reflect the different compute capacities of the
A15s and A7s. I ran the sysbench cpu benchmark with 5 threads with and
without the patches applied, but with non-default cpu_powers.

I didn't see any difference in the load-balance. Three tasks ended up on
the two A15s and two tasks ended up on two of the three A7s leaving one
unused in both cases.

Using default cpu_power I get one task on each of the five cpus (best
throughput). Unless I messed something up, it seems that setting
cpu_power doesn't give me the best throughput with these patches
applied.

Have you done any tests on big.LITTLE?

Morten

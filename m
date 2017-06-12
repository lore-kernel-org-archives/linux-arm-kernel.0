From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 12 Jun 2017 14:06:55 +0100
Subject: [PATCH 5/6] arm64: wire frequency-invariant accounting support
 up to the task scheduler
In-Reply-To: <20170608075513.12475-6-dietmar.eggemann@arm.com>
References: <20170608075513.12475-1-dietmar.eggemann@arm.com>
 <20170608075513.12475-6-dietmar.eggemann@arm.com>
Message-ID: <20170612130655.GD24187@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 08, 2017 at 08:55:12AM +0100, Dietmar Eggemann wrote:
> Commit dfbca41f3479 ("sched: Optimize freq invariant accounting")
> changed the wiring which now has to be done by associating
> arch_scale_freq_capacity with the actual implementation provided
> by the architecture.
> 
> Define arch_scale_freq_capacity to use the arch_topology "driver"
> function topology_get_freq_scale() for the task scheduler's
> frequency-invariant accounting instead of the default
> arch_scale_freq_capacity() in kernel/sched/sched.h.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Juri Lelli <juri.lelli@arm.com>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  arch/arm64/include/asm/topology.h | 5 +++++
>  arch/arm64/kernel/topology.c      | 1 -
>  2 files changed, 5 insertions(+), 1 deletion(-)

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

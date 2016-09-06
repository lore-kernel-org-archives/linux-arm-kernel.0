From: will.deacon@arm.com (Will Deacon)
Date: Tue, 6 Sep 2016 19:14:59 +0100
Subject: [PATCH 01/21] arm64: FP/SIMD: Convert to hotplug state machine
In-Reply-To: <20160906170457.32393-2-bigeasy@linutronix.de>
References: <20160906170457.32393-1-bigeasy@linutronix.de>
 <20160906170457.32393-2-bigeasy@linutronix.de>
Message-ID: <20160906181459.GE29382@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2016 at 07:04:37PM +0200, Sebastian Andrzej Siewior wrote:
> Install the callbacks via the state machine.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/arm64/kernel/fpsimd.c | 22 +++++-----------------
>  include/linux/cpuhotplug.h |  1 +
>  2 files changed, 6 insertions(+), 17 deletions(-)

Looks fine to me:

Acked-by: Will Deacon <will.deacon@arm.com>

> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index afd59e2ca4b3..0da071ff36d2 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -20,6 +20,7 @@ enum cpuhp_state {
>  	CPUHP_SOFTIRQ_DEAD,
>  	CPUHP_NET_MVNETA_DEAD,
>  	CPUHP_CPUIDLE_DEAD,
> +	CPUHP_ARM64_FPSIMD_DEAD,
>  	CPUHP_WORKQUEUE_PREP,
>  	CPUHP_POWER_NUMA_PREPARE,
>  	CPUHP_HRTIMERS_PREPARE,

Are you planning to take this via your tree? The arm64 queue already
touches cpuhotplug.h for the hw-breakpoint and debugmon changes, so
there's a simple conflict to address here.

Will

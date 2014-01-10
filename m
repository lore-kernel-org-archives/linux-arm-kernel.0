From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 10 Jan 2014 17:45:59 +0000
Subject: [PATCH v10 1/4] arm64: topology: Implement basic CPU topology
 support
In-Reply-To: <1389287106-29979-2-git-send-email-broonie@kernel.org>
References: <1389287106-29979-1-git-send-email-broonie@kernel.org>
 <1389287106-29979-2-git-send-email-broonie@kernel.org>
Message-ID: <20140110174558.GI925@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 09, 2014 at 05:05:03PM +0000, Mark Brown wrote:
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index dd4327f09ba4..8feef9cb65df 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -163,6 +163,30 @@ config SMP
>  
>  	  If you don't know what to do here, say N.
>  
> +config ARM_CPU_TOPOLOGY

Nitpicks: please use just CPU_TOPOLOGY.

> diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
> new file mode 100644
> index 000000000000..58b8b84adcd2
> --- /dev/null
> +++ b/arch/arm64/include/asm/topology.h
> @@ -0,0 +1,39 @@
> +#ifndef _ASM_ARM_TOPOLOGY_H
> +#define _ASM_ARM_TOPOLOGY_H

We tend to stick to __ASM_TOPOLOGY_H like guards under arch/arm64.

> +
> +#ifdef CONFIG_ARM_CPU_TOPOLOGY
> +
> +#include <linux/cpumask.h>
> +
> +struct cputopo_arm {
> +	int thread_id;
> +	int core_id;
> +	int socket_id;
> +	cpumask_t thread_sibling;
> +	cpumask_t core_sibling;
> +};

And you could rename this structure to just cpu_topology.

The patches seem fine otherwise, apart from the last one which I
won't merge until we get some real numbers.

I would like to get an ack or reviewed-by from Lorenzo (and possibly
Mark Rutland) but it is pretty late for the 3.14 merging window so it
will have to be queued for 3.15.

Thanks for putting the effort into preparing these patches.

-- 
Catalin

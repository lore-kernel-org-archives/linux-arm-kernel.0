From: alex.shi@linaro.org (Alex Shi)
Date: Mon, 16 Dec 2013 22:45:18 +0800
Subject: [PATCH 4/6] arm64: topology: Implement basic CPU topology support
In-Reply-To: <1386767606-6391-4-git-send-email-broonie@kernel.org>
References: <1386767606-6391-1-git-send-email-broonie@kernel.org>
 <1386767606-6391-4-git-send-email-broonie@kernel.org>
Message-ID: <52AF11FE.70000@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11/2013 09:13 PM, Mark Brown wrote:
> diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
> new file mode 100644
> index 000000000000..611edefaeaf1
> --- /dev/null
> +++ b/arch/arm64/include/asm/topology.h
> @@ -0,0 +1,42 @@
> +#ifndef _ASM_ARM_TOPOLOGY_H
> +#define _ASM_ARM_TOPOLOGY_H
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

Forgive me if I am stupid. :)

why we don't need a cluster_id? and does one cpu socket include few
clusters?

-- 
Thanks
    Alex

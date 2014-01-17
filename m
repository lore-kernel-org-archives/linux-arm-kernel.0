From: Sudeep.Holla@arm.com (Sudeep Holla)
Date: Fri, 17 Jan 2014 14:22:34 +0000
Subject: [PATCH 02/20] ARM64 : Add dummy asm/cpu.h
In-Reply-To: <1389961514-13562-3-git-send-email-hanjun.guo@linaro.org>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
 <1389961514-13562-3-git-send-email-hanjun.guo@linaro.org>
Message-ID: <52D93CAA.1080604@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/01/14 12:24, Hanjun Guo wrote:
> ACPI requires a cpu.h, add a dummy one copied from arm. This will need
> updated or replaced as ACPI based cpu hotplug or cpu topology for armv8
> is worked out.
> 
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  arch/arm64/include/asm/cpu.h |   25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 arch/arm64/include/asm/cpu.h
> 
> diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
> new file mode 100644
> index 0000000..8625eb1
> --- /dev/null
> +++ b/arch/arm64/include/asm/cpu.h
> @@ -0,0 +1,25 @@
> +/*
> + *  Copyright (C) 2004-2005 ARM Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#ifndef __ASM_ARM_CPU_H
> +#define __ASM_ARM_CPU_H
> +
> +#include <linux/percpu.h>
> +#include <linux/cpu.h>
> +#include <linux/topology.h>
> +
> +struct cpuinfo_arm {
> +	struct cpu	cpu;
> +	u64		cpuid;
> +#ifdef CONFIG_SMP
> +	unsigned int	loops_per_jiffy;

IIUC we don't have loop-based delay support in ARM64.
It's always timer based and in which case we don't need loops_per_jiffy

Regards,
Sudeep
